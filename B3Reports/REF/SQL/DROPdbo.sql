USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_rptGetWinningCardNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_rptGetWinningCardNumber]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_GetWinningCardNumber2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_GetWinningCardNumber2]
GO


