USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_sales_b3_CreateCreditAcct]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_sales_b3_CreateCreditAcct]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[usp_sales_b3_CreateCreditAcct]
--=============================================================================
-- US4150 Adding support for a sequential account number if the system
--  is in North Dakota Mode (this is no longer the requirement, it was replaced
--  by US4352)
-- US4352 Adding support for not reusing an account number for the period of 
--  3 years.
-- 20160721 Replace value @cUserName from 11 to 50
--=============================================================================
    @cClientMac char(12),
    @cClientName char(11),
    @cUserName char(50),
    @nCreditAmt int,
    @nVipNum int,
    @nLoginID int,
    @pinHash varbinary(20),
    @nCreditAcctNum int OUTPUT,
    @nControlNum int OUTPUT
AS
SET NOCOUNT ON

DECLARE @nSessNum int, @nReceiptNum int, @nRetryCount int
DECLARE @cCreditAcctNum char(8), @NDMode char(1)

SET @nCreditAcctNum = 0
SET @nReceiptNum = 0
SET @nRetryCount = 0

select top 1 @NDMode = IsNorthDakota from B3_SystemConfig

if (@NDMode = 'F')
begin
    WHILE @nCreditAcctNum = 0
        BEGIN
        EXECUTE master.dbo.uxp_b3rng_GenAcctNum 10000001, 99999999, @nCreditAcctNum OUTPUT
        SET @cCreditAcctNum = CONVERT(char(8), @nCreditAcctNum)

        IF ( @nCreditAcctNum = 10000000 OR @nRetryCount >1000 )
            BEGIN
            SET @nControlNum = 0
            SET @nCreditAcctNum = 10000000
            RETURN
            END
        ELSE IF EXISTS (SELECT * FROM B3_CreditJournal WHERE creditacctnum = @cCreditAcctNum)
            BEGIN
            SET @nCreditAcctNum = 0
            SET @nRetryCount = @nRetryCount + 1
            END
        END
end
else
begin
    -- ND Requires that an account number cannot be reused for a period of 3 years
    declare @endDate smalldatetime, @startDate smalldatetime

    set @endDate = getdate()
    set @startDate = dateadd(yy, -3, @endDate)

    WHILE @nCreditAcctNum = 0
        BEGIN
        EXECUTE master.dbo.uxp_b3rng_GenAcctNum 10000001, 99999999, @nCreditAcctNum OUTPUT
        SET @cCreditAcctNum = CONVERT(char(8), @nCreditAcctNum)
        
        IF ( @nCreditAcctNum = 10000000 OR @nRetryCount > 1000 )
            BEGIN
            SET @nControlNum = 0
            SET @nCreditAcctNum = 10000000
            RETURN
            END
        ELSE IF EXISTS (SELECT * FROM B3_CreditJournal WHERE creditacctnum = @cCreditAcctNum and (sold_dt >= @startDate and sold_dt <= @endDate))
            BEGIN
            -- This account number was used during this period so it cannot be reused
            SET @nCreditAcctNum = 0
            SET @nRetryCount = @nRetryCount + 1
            END
        END
end
EXECUTE b3.dbo.usp_sales_b3_GetReceiptNum @nReceiptNum OUTPUT

SET @nControlNum = @nReceiptNum

SELECT @nSessNum = sessnum FROM B3_Session


-- US2471: Track transactions by consecutive number for each device
begin
    begin try
        begin transaction CreateAccount


        -- Record the transaction in journals
        UPDATE B3_SessionsJournal 
            SET acctssold = acctssold + 1, acctssoldamt = acctssoldamt + @nCreditAmt
                    , acctsoutstand = acctsoutstand + 1, acctsoutstandamt = acctsoutstandamt + @nCreditAmt
                WHERE sessnum = @nSessNum

        IF ( @nVipNum > 0 )
            BEGIN
            DECLARE @nMagneticCardNo varchar(32)

            SELECT @nMagneticCardNo = MagneticCardNo 
                FROM B3_VIPPlayerMagCards WHERE PlayerID = @nVipNum

            INSERT INTO B3_VIPCreditSales(EntryDate, SessNum, MagneticCardNo, PlayerID, CreditAcctNum)
                VALUES(GETDATE(), @nSessNum, @nMagneticCardNo, @nVipNum, @nCreditAcctNum)
            END


        INSERT INTO B3_CreditJournal(creditacctnum, creditamt, receiptnum, sessnum, vipnum
                                    , acctstatus, transtatus, accttype, acctgroup
                                    , entered_amt, entered_clientmac, entered_clientname, entered_dt
                                    , cashout_amt, cashout_clientmac, cashout_clientname, cashout_dt
                                    , sold_amt, sold_clientmac, sold_clientname, sold_loginid, sold_username, sold_dt
                                    , redeem_amt, redeem_clientmac, redeem_clientname, redeem_loginid, redeem_username, redeem_dt, handpayamt, taxableamt)
            VALUES(@cCreditAcctNum, @nCreditAmt, @nReceiptNum, @nSessNum, @nVipNum
                    , 'INACTIVE', 'SOLD', 'CREDIT', 0
                    , 0, 0, '', GETDATE()
                    , 0, 0, '', GETDATE()
                    , @nCreditAmt, @cClientMac, @cClientName, @nLoginID, @cUserName, GETDATE()
                    , 0, 0, '', 0, '', GETDATE(), 0, 0)

        INSERT INTO B3_CashDrawerJournal(TransDate, TransType, TransDesc, SessNum, LoginID, UserName, ClientMac, ClientName, CreditAcctNum, CreditAmt, WinCreditAmt, JackpotAmt, ReceiptNum)
            VALUES(GETDATE(), 1, 'DRAWER SALE', @nSessNum, @nLoginID, @cUserName, @cClientMac, @cClientName, @nCreditAcctNum, @nCreditAmt, 0, 0, @nReceiptNum)

        -- Find the device's next transaction number
        declare @trans int;
        select @trans = dt.TransNo from B3_DeviceTransactions dt where dt.MAC = @cClientMac;

        -- Finally, log these activities
        insert into B3_ActivityLog (MAC, TransType, TransNo, TransDate, MachineName, CreditAcctNum, CreditAmt, WinsAmt,  ReceiptNo, TransDesc, UserName, sessNum)
        values ( @cClientMac, 0, @trans, getdate(), @cClientName, @cCreditAcctNum, @nCreditAmt, 0, @nReceiptNum, 'Credit Sale', @cUserName, @nSessNum);

        -- Increment this device trans number for next time
        set @trans =  @trans + 1;
        update B3_DeviceTransactions set TransNo = @trans where MAC = @cClientMac;
        
        if (@NDMode = 'T')
        begin
            insert into B3_AccountPin (AccountNumber, PinNumber) values (@nCreditAcctNum, @pinHash)
        end

        -- Commit!
        commit transaction CreateAccount;
    end try
    begin catch 
        select
                error_number() as errornumber,
                error_severity() as errorseverity,
                error_state() as errorstate,
                error_procedure() as errorprocedure,
                error_line() as errorline,
                error_message() as errormessage;
                            
        rollback transaction CreateAccount;
    end catch;
end;
-- END US2471







GO


