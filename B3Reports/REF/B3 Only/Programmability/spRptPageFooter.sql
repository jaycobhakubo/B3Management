USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[spRptPageFooter]    Script Date: 12/22/2015 11:06:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRptPageFooter]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRptPageFooter]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[spRptPageFooter]    Script Date: 12/22/2015 11:06:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[spRptPageFooter]
AS
SET NOCOUNT ON

SELECT Version AS VersionInfo
FROM B3_VersionInfo where ID = 1;



SET NOCOUNT OFF



GO


