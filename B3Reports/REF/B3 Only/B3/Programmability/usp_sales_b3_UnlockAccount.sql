USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_sales_b3_UnlockAccount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_sales_b3_UnlockAccount]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[usp_sales_b3_UnlockAccount]
@cCreditAcctNum char(8),
@cSalesClientMac char(12),
@cSalesClientName char(11), 
@cSalesUserName char(50), 
@nSalesLoginID int,
@nAcctSessNum int OUTPUT,
@nReceiptNum int OUTPUT

-- ==========================================
-- knc|7/29/2013 - Add Input parameter to match Ver 3.1.0 @nAcctSessNum
-- ==========================================
AS
SET NOCOUNT ON

DECLARE @cClientMac char(12), @cAcctStatus varchar(8), @cIpAddress varchar(15), @cClientName char(11)
DECLARE @nCreditAmt int, @nSessNum int

DECLARE @nCreditAcctNum int
DECLARE @nWinCreditAmt int
DECLARE @nHandPayAmt int
DECLARE @nTaxableAmt int
DECLARE @nJackpotAmt int

-- US2471: Track transactions by consecutive number for each device
begin
    begin try
        begin transaction UnlockAccount

        -- Perform actions
        SET @nCreditAcctNum = CONVERT(int, @cCreditAcctNum);

        SELECT @cClientMac = entered_clientmac, @nCreditAmt = creditamt, @cClientName = entered_clientname, @nSessNum = sessnum, @nWinCreditAmt = WinCreditAmt, @nHandPayAmt = HandPayAmt, @nTaxableAmt = TaxableAmt
            FROM B3_CreditJournal WITH (UPDLOCK)
            	WHERE creditacctnum = @cCreditAcctNum AND transtatus = 'PENDING';

        SET @nAcctSessNum = @nSessNum

        IF ( @cClientMac IS NOT NULL)
    	BEGIN
    		UPDATE B3_CreditJournal 
    			SET acctstatus = 'UNLOCK'
    					, transtatus = 'UNLOCK'
    					, cashout_amt = @nCreditAmt 
    					, cashout_clientmac = @cClientMac
    					, cashout_clientname = @cClientName
    					, cashout_dt = GETDATE()
    					, handpayamt = 0
    					, taxableamt = 0
    				WHERE creditacctnum = @cCreditAcctNum AND transtatus = 'PENDING' AND sessnum = @nSessNum;

    		SELECT @cIpAddress = ipaddress
    			FROM B3_ClientMap 
    				WHERE clientmac = @cClientMac;

    		IF ( (@cIpAddress IS NOT NULL) AND (@cCreditAcctNum IS NOT NULL) AND (@nSessNum IS NOT NULL) )
    			EXECUTE master.dbo.uxp_b3com_UnlockAccount @cIpAddress, @cCreditAcctNum;
    	END
        ELSE
        	BEGIN
        		UPDATE B3_CreditJournal 
        			SET acctstatus = 'INACTIVE', transtatus = 'ERROR'
        				WHERE creditacctnum = @cCreditAcctNum;
        	END;


        EXECUTE b3.dbo.usp_sales_b3_GetReceiptNum @nReceiptNum OUTPUT;

        IF ( @nTaxableAmt > 0 OR
    	        @nHandPayAmt > 0 )
    	    BEGIN
    		    IF ( @nTaxableAmt >= @nHandPayAmt )
    			    SET @nJackpotAmt = @nTaxableAmt
    		    ELSE IF ( @nHandPayAmt >= @nTaxableAmt )
    			    SET @nJackpotAmt = @nHandPayAmt
    		    ELSE
    			    SET @nJackpotAmt = 0;
    	    END
        ELSE
    	    SET @nJackpotAmt = 0;

        -- Finally, create new journal record
        INSERT INTO B3_CashDrawerJournal(TransDate, TransType, TransDesc, SessNum, LoginID, UserName, ClientMac, ClientName, CreditAcctNum, CreditAmt, WinCreditAmt, JackpotAmt, ReceiptNum)
    	    VALUES(GETDATE(), 4, 'DRAWER UNLOCK', @nSessNum, @nSalesLoginID, @cSalesUserName, @cSalesClientMac, @cSalesClientName, @nCreditAcctNum, @nCreditAmt, @nWinCreditAmt, @nJackpotAmt, @nReceiptNum);

        -- Find the device's next transaction number
        declare @trans int;
        select @trans = dt.TransNo from B3_DeviceTransactions dt where dt.MAC = @cSalesClientMac;

        -- Finally, log these activities
        insert into B3_ActivityLog (MAC, TransType, TransNo, TransDate, MachineName, CreditAcctNum, CreditAmt, WinsAmt,  ReceiptNo, TransDesc, UserName, sessNum)
        values ( /*@cClientMac*/@cSalesClientMac , 0, @trans, getdate(), @cClientName, @cCreditAcctNum, @nCreditAmt, @nWinCreditAmt, @nReceiptNum, 'Unlock Account', @cSalesUserName, @nSessNum);

        -- Increment this device trans number for next time
        set @trans =  @trans + 1;
        update B3_DeviceTransactions set TransNo = @trans where MAC = @cSalesClientMac;

        -- Commit!
        commit transaction UnlockAccount;
    end try
    begin catch 
        select
                error_number() as errornumber,
                error_severity() as errorseverity,
                error_state() as errorstate,
                error_procedure() as errorprocedure,
                error_line() as errorline,
                error_message() as errormessage;
                            
        rollback transaction UnlockAccount;
    end catch;
end;
-- END US2471

GO


