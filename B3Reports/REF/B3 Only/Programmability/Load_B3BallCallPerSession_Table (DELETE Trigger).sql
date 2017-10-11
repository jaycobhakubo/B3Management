USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Load_B3BallCallPerSession_Table]'))
DROP TRIGGER [dbo].[Load_B3BallCallPerSession_Table]
GO


