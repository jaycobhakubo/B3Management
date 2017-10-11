USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_sales_b3_StartSession]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_sales_b3_StartSession]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_sales_b3_StartSession]
--=============================================================================
--  2015.11.25 jkn - Added support for tracking the user made the change
--=============================================================================
	@nOperatorID int,
	@szOperatorName varchar(18),
	@loginId int -- Track the user that started the session
AS
	SET NOCOUNT ON


	DECLARE @nSessNum int, @nPayoutLimit int, @nJackpotLimit int
	DECLARE @cSessActive char(1), @cMultiOperator char(1)

	SELECT TOP 1 @cMultiOperator = multioperator 
		FROM B3_SystemConfig
		
	BEGIN TRANSACTION

	-- Check for any current session information, maintaining an exclusive lock to ensure one execution at a time of this procedure.
	SELECT TOP 1 @nSessNum = sessnum, @cSessActive = sessactive
		, @nPayoutLimit = payoutlimit , @nJackpotLimit = jackpotlimit
		FROM B3_Session WITH (XLOCK)

	IF ( @cSessActive = 'F' )
		BEGIN
			IF ( @nSessNum >= 2000000000 )
				SET @nSessNum = 1
			ELSE
				SET @nSessNum = @nSessNum + 1

		
				UPDATE B3_Session
					SET sessnum = @nSessNum, sessactive = 'T', sessstart_dt = GETDATE()
							, payoutamt = 0, jackpot_1_amt = 0, jackpot_2_amt = 0, jackpot_3_amt = 0
				
				INSERT INTO B3_SessionsJournal(sessnum, sessactive, sessstart, sessend, operatorid, operatorname
									 , payoutlimit, payoutamt, jackpotlimit, jackpot_1_amt, jackpot_2_amt, jackpot_3_amt)
	 				VALUES(@nSessNum, 'T', GETDATE(), GETDATE(), @nOperatorID, @szOperatorName, @nPayoutLimit, 0, @nJackpotLimit, 0, 0, 0)
			
				IF ( @cMultiOperator = 'T' )
					UPDATE B3_Operators
						SET  signin = GETDATE(), totalsignins = totalsignins +1 
							WHERE operatorid  = @nOperatorID AND operatorname = @szOperatorName

			EXECUTE master.dbo.uxp_b3com_StartSession
			
			execute usp_sales_B3_Set_B3BallCallPerSession @loginId

		END
		
	COMMIT TRAN


GO

GRANT EXECUTE ON [dbo].[usp_sales_b3_StartSession] TO [role_Sales] AS [dbo]
GO


