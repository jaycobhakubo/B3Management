USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_sales_b3_VoidSessionTickets]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_sales_b3_VoidSessionTickets]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_sales_b3_VoidSessionTickets]
	@nTransType int,
	@nLoginID int,
	@cUserName char(50),
	@cClientMac char(12),
	@cClientName char(11)
AS
	SET NOCOUNT ON

	DECLARE @nSessNum int, @nTotalAccounts int, @nTotalCreditAmt int, @nTotalWinCreditAmt int

	BEGIN TRANSACTION

	SET @nSessNum = 0
	SET @nTotalAccounts = 0
	SET @nTotalCreditAmt = 0
	SET @nTotalWinCreditAmt = 0

	SELECT TOP 1 @nSessNum = ISNULL(sessnum, 0)
		FROM B3_Session

	IF ( @nSessNum > 0 )
		BEGIN

		SELECT @nTotalCreditAmt = ISNULL(SUM(creditamt), 0), @nTotalWinCreditAmt = ISNULL(SUM(wincreditamt), 0), @nTotalAccounts = COUNT(*)
			FROM B3_CreditJournal
				WHERE sessnum = @nSessNum AND acctstatus != 'REDEEM'

		IF ( @nTotalAccounts > 0 )
			BEGIN
			UPDATE B3_CreditJournal
				SET acctstatus = 'EXPIRED'
					WHERE sessnum = @nSessNum AND acctstatus != 'REDEEM'			

			INSERT INTO B3_VoidAccountsJournal(TransDate, TransType, TransDesc, SessNum, LoginID, UserName, ClientMac, ClientName, TotalAccounts, TotalCreditAmt)
				VALUES(GETDATE(), @nTransType, 'EXPIRED ACCOUNTS', @nSessNum, @nLoginID, @cUserName, @cClientMac, @cClientName, @nTotalAccounts, @nTotalCreditAmt + @nTotalWinCreditAmt)
			END
		END

	COMMIT TRANSACTION
GO


