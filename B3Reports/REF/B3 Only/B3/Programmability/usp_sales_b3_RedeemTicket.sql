USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_sales_b3_RedeemTicket]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_sales_b3_RedeemTicket]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[usp_sales_b3_RedeemTicket]
--=============================================================================
-- US4156 Remove the pin when the account is redeemed
--=============================================================================
@cCreditAcctNum char(8),
@cClientMac char(12),
@cClientName char(11), 
@cUserName char(50), 
@nLoginID int,
@nCreditAmt int,
@nAcctSessNum int OUTPUT,
@nReceiptNum int OUTPUT
AS
SET NOCOUNT ON

DECLARE @cMacAddress char(12), @cAcctStatus varchar(8)
DECLARE @nCreditsAmt int, @nSessNum int

UPDATE B3_CreditJournal 
    SET creditamt = 0
            , acctstatus = 'REDEEM'
            , transtatus = 'REDEEM'
            , redeem_amt = @nCreditAmt 
            , redeem_clientmac = @cClientMac
            , redeem_clientname = @cClientName
            , redeem_loginid = @nLoginID
            , redeem_username = @cUserName
            , redeem_dt = GETDATE()
        WHERE creditacctnum = @cCreditAcctNum;
        
delete from B3_AccountPin where AccountNumber = cast (@cCreditAcctNum as int);

-------------------------------------------------------------
DECLARE @nCreditAcctNum int
DECLARE @nAdjustedCreditAmt int
DECLARE @nWinCreditAmt int
DECLARE @nHandPayAmt int
DECLARE @nTaxableAmt int

SET @nCreditAcctNum = CONVERT(int, @cCreditAcctNum)

EXECUTE b3.dbo.usp_sales_b3_GetReceiptNum @nReceiptNum OUTPUT
-------------------------------------------------------------

SELECT TOP 1 @nSessNum = sessnum, @nWinCreditAmt = WinCreditAmt, @nHandPayAmt = HandPayAmt, @nTaxableAmt = TaxableAmt
    FROM B3_CreditJournal 
        WHERE creditacctnum = @cCreditAcctNum;

SET @nAcctSessNum = @nSessNum

EXECUTE b3.dbo.usp_sales_b3_UpdateSessionTotals @nSessNum

IF ( @nCreditAmt >= @nWinCreditAmt ) 
    SET @nAdjustedCreditAmt = @nCreditAmt-@nWinCreditAmt
ELSE
    SET @nAdjustedCreditAmt = @nCreditAmt

-------------------------------------------------------------
--INSERT INTO B3_CashDrawerJournal(TransDate, TransType, TransDesc, SessNum, LoginID, UserName, ClientMac, ClientName, CreditAcctNum, CreditAmt, WinCreditAmt, JackpotAmt, ReceiptNum)
--    VALUES(GETDATE(), 2, 'DRAWER REDEEM', @nSessNum, @nLoginID, @cUserName, @cClientMac, @cClientName, @nCreditAcctNum, @nAdjustedCreditAmt, @nWinCreditAmt, 0, @nReceiptNum)
-------------------------------------------------------------

-- US2471: Track transactions by consecutive number for each device
begin
    begin try
        begin transaction Redeem

        -- Record the transaction
        INSERT INTO B3_CashDrawerJournal(TransDate, TransType, TransDesc, SessNum, LoginID, UserName, ClientMac, ClientName, CreditAcctNum, CreditAmt, WinCreditAmt, JackpotAmt, ReceiptNum)
            VALUES(GETDATE(), 2, 'DRAWER REDEEM', @nSessNum, @nLoginID, @cUserName, @cClientMac, @cClientName, @nCreditAcctNum, @nAdjustedCreditAmt, @nWinCreditAmt, 0, @nReceiptNum)
    
        -- Find the device's next transaction number
        declare @trans int;
        select @trans = dt.TransNo from B3_DeviceTransactions dt where dt.MAC = @cClientMac;
           
        -- Finally, log these activities
        insert into B3_ActivityLog (MAC, TransType, TransNo, TransDate, MachineName, CreditAcctNum, CreditAmt, WinsAmt, ReceiptNo, TransDesc, UserName, sessNum)
        values ( @cClientMac, 0, @trans, getdate(), @cClientName, @cCreditAcctNum, @nCreditAmt, 0, @nReceiptNum, 'Credit Redemption', @cUserName, @nSessNum);

        -- Increment this device trans number for next time
        set @trans =  @trans + 1;
        update B3_DeviceTransactions set TransNo = @trans where MAC = @cClientMac;

        -- Commit!
        commit transaction Redeem;
    end try
    begin catch 
        select
                error_number() as errornumber,
                error_severity() as errorseverity,
                error_state() as errorstate,
                error_procedure() as errorprocedure,
                error_line() as errorline,
                error_message() as errormessage;
                            
        rollback transaction Redeem;
    end catch;
end;
-- END US2471


GO


