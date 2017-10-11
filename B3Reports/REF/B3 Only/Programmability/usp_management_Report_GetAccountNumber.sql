USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_management_Report_GetAccountNumber]    Script Date: 12/11/2015 12:15:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_Report_GetAccountNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_Report_GetAccountNumber]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_management_Report_GetAccountNumber]    Script Date: 12/11/2015 12:15:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_management_Report_GetAccountNumber]
@SessNum int 
as

select creditacctnum from dbo.B3_CreditJournal where sessnum = @SessNum
GO


