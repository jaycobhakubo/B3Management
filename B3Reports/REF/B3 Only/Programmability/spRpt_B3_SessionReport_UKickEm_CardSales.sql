USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRpt_B3_SessionReport_UKickEm_CardSales]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRpt_B3_SessionReport_UKickEm_CardSales]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




create proc [dbo].[spRpt_B3_SessionReport_UKickEm_CardSales]
@SessNum int
as
select denom,  betlevel,  count(*) as tnumofcards, (denom * betlevel) * (count(*)) tsales
from b3.dbo.UKickEm_GameJournal
where sessnum = @SessNum
group by denom,  betlevel
order by denom, betlevel




GO


