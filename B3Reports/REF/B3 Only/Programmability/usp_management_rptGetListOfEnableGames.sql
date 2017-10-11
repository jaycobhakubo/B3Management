USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_rptGetListOfEnableGames]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_rptGetListOfEnableGames]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[usp_management_rptGetListOfEnableGames]
as

declare @ListGameNebale Table
(
GameName nvarchar(100) 
)

insert into @ListGameNebale values ('CRAZYBOUT')
insert into @ListGameNebale values ('SPIRIT76')
insert into @ListGameNebale values ('UKICKEM')
insert into @ListGameNebale values ('WILDBALL')
insert into @ListGameNebale values ('WILDFIRE')
insert into @ListGameNebale values ('JAILBREAK')
insert into @ListGameNebale values ('MAYAMONEY')
insert into @ListGameNebale values ('TIMEBOMB')

declare @ResultB3Games Table
(
IsCrazyBoutGameEnable int,
IsSpiritGameEnable int,
IsUkickEmGameEnable int,
IsWildBallGameEnable int,
IsWildFireGameEnable int,
IsJailBreakGameEnable int,
IsMayaMoneyGameEnable int,
IsTimeBombGameEnable int
)

insert into @ResultB3Games 
values (0,0,0,0,0,0,0,0)

declare @ColumnName varchar(50)
declare @count int 
DECLARE @sqlCommand nvarchar(1000)
DECLARE @ParmDefinition nvarchar(500);
declare @GameNameResult nvarchar(50)
declare @GameExists char(1)
declare @GameName varchar(100)

set @GameExists = 0
set @ColumnName = 'gameicon_'
set @count = 1

declare GameName_Cursor cursor for 
select GameName from @ListGameNebale
open GameName_Cursor 
fetch next from GameName_Cursor into @GameName

while @@FETCH_STATUS = 0
begin

	while (@count != 13)
	begin
		declare @ColumnName_ varchar(50)
		set @ColumnName_ = @ColumnName + cast(@count as varchar(50))
		set @sqlCommand = ' select @GameNameOut = ' + @ColumnName_ + ' from B3.dbo.B3_PlayerConfig'
		set @ParmDefinition = N'@GameNameOut nvarchar(50) OUTPUT'

		EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @GameNameOut = @GameNameResult OUTPUT
		if (@GameNameResult = @GameName )
		begin
			set @GameExists = 1
			break;
		end
		set @count += 1
	end

	if  @GameName = 'CRAZYBOUT'
	begin
	update @ResultB3Games 
	set IsCrazyBoutGameEnable = @GameExists
	end
	else 
	if  @GameName = 'SPIRIT76'
	begin
	update @ResultB3Games 
	set IsSpiritGameEnable = @GameExists
	end else
	if  @GameName = 'UKICKEM'
	begin
	update @ResultB3Games 
	set IsUkickEmGameEnable= @GameExists
	end else
	if  @GameName = 'WILDBALL'
	begin
	update @ResultB3Games 
	set IsWildBallGameEnable = @GameExists
	end else
	if  @GameName = 'WILDFIRE'
	begin
	update @ResultB3Games 
	set IsWildFireGameEnable = @GameExists
	end else
	if  @GameName = 'JAILBREAK'
	begin
	update @ResultB3Games 
	set IsJailBreakGameEnable = @GameExists
	end else
	if  @GameName = 'MAYAMONEY'
	begin
	update @ResultB3Games 
	set IsMayaMoneyGameEnable = @GameExists
	end 
	else
	if  @GameName = 'TIMEBOMB'
	begin
	update @ResultB3Games 
	set IsTimeBombGameEnable = @GameExists
	end

	set @GameExists = 0
	set @count = 1
	fetch next from GameName_Cursor into @GameName
	
end

select  
IsCrazyBoutGameEnable,
IsSpiritGameEnable ,
IsUkickEmGameEnable ,
IsWildBallGameEnable ,
IsWildFireGameEnable ,
IsJailBreakGameEnable ,
IsMayaMoneyGameEnable ,
IsTimeBombGameEnable 
from @ResultB3Games
GO


