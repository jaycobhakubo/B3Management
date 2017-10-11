USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_sales_b3_EndSession]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_sales_b3_EndSession]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_sales_b3_EndSession]
--=============================================================================
-- 2015.11.25 jkn: Adding support for tracking the login id of the staff that
--  ended the session
--=============================================================================
    @loginId int
AS
	SET NOCOUNT ON
	
	DECLARE @nSessNum int

	BEGIN TRAN

	-- Get the current session and keep an exclusive lock to prevent any other reads while we end the session.
	SELECT @nSessNum = sessnum
		FROM B3_Session WITH (XLOCK)

	UPDATE B3_Session
		SET sessactive = 'F', sessend_dt = GETDATE()

	UPDATE B3_SessionsJournal
		SET sessactive = 'F', sessend = GETDATE()
			WHERE sessnum = @nSessNum

	UPDATE B3_JackpotJournal
		SET sessactive = 'F', sessend = GETDATE()
			WHERE sessnum = @nSessNum

	COMMIT TRAN

	EXECUTE b3.dbo.usp_sales_b3_UpdateSessionTotals @nSessNum

	EXECUTE master.dbo.uxp_b3com_EndSession
	
	execute usp_sales_B3_Set_B3BallCallPerSession @loginId
GO

GRANT EXECUTE ON [dbo].[usp_sales_b3_EndSession] TO [role_Sales] AS [dbo]
GO


