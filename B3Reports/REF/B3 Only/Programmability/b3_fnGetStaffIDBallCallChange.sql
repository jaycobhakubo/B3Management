USE [B3]
GO

/****** Object:  UserDefinedFunction [dbo].[b3_fnGetStaffIDBallCallChange]    Script Date: 12/15/2015 12:51:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[b3_fnGetStaffIDBallCallChange]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[b3_fnGetStaffIDBallCallChange]
GO

USE [B3]
GO

/****** Object:  UserDefinedFunction [dbo].[b3_fnGetStaffIDBallCallChange]    Script Date: 12/15/2015 12:51:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 create function [dbo].[b3_fnGetStaffIDBallCallChange]
(
@spDateTimePlay datetime
)
returns int
as
begin--declare @testime datetime 
--set @testime =  '2015-11-17 10:55:10.287

declare @StaffID int
--1 < 2 = true
--2015-11-17 09:36:25.230

--select  top 1 * from B3_Log_StaffForBallCallChange  where DateTimeBallChange <= @testime order by DateTimeBallChange desc

-- I need to get the closes one
set @StaffID = (select  top 1  cloginId from B3_Log_StaffForBallCallChange  where DateTimeBallChange <= @spDateTimePlay order by DateTimeBallChange desc)
return @StaffID

--select * from B3_Login
--select * from B3_Log_StaffForBallCallChange
end
GO


