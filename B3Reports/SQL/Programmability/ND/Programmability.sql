--usp_management_rptGetListOfEnableGames (START)

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

-- usp_management_rptGetListOfEnableGames (END)


USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_fnGetBallCallB3]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[B3_fnGetBallCallB3]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create function [dbo].[B3_fnGetBallCallB3]
(@SessionNumber int)
returns @BallCall table
(
	ServerGameNumber int,
	DTStamp datetime, 
	GameTypeID int,  
	GameName varchar(100) ,                 
	GameBallCount int,
	GameBalls varchar(max),
	BonusBallCount int,
	BonusBalls varchar(max) ,
	StaffID int          
)
as

--declare @SessionNumber int set @SessionNumber = 1001
--declare @BallCall table
--(
--	ServerGameNumber int,
--	DTStamp datetime, 
--	GameTypeID int,  
--	GameName varchar(100) ,                 
--	GameBallCount int,
--	GameBalls varchar(max),
--	BonusBallCount int,
--	BonusBalls varchar(max) ,
--	StaffID int  )
begin
--=============================
-- Author:		Fortunet
-- Date:		20150915
-- Dscription:	Get the ball call per game in B3 not Class II.
--				If B3 system session played both B3 class II and III then it will only report class II game. 
--=============================




                    declare @BallCall_cte table
                    (
                    [Game Name] varchar(50), 
                    GamingDate smalldatetime, 
                    ClientMac varchar(50) , 
                    Player varchar(50), 
                    SessNum int, 
                    SessStart smalldatetime , 
                    SessEnd smalldatetime, 
                    OperatorID int, 
                    OperatorName varchar(100),
                    GameNum int, 
                    BallCall varchar(max),
                    BallCallCount int,
                    BonusBallCount int,
                    BonusBall varchar(max),
                    StaffID int
                    )


					;with GetNormalBonusBallCallForWildBall (GameNum, BonusBall)
					as
					(
					select
					Gamenum,
					 case when cbj.bonuswinamt != 0 then
					(convert (char(2), cbj.[bonusball_1]) +', '
                          + convert (char(2), cbj.[bonusball_2]) +', '
                          + convert (char(2), cbj.[bonusball_3]) +', '
                          + convert (char(2), cbj.[bonusball_4]) +', '
                          + convert (char(2), cbj.[bonusball_5]) +', '
                          + convert (char(2), cbj.bonusball_6) +', '
                          + convert (char(2), cbj.bonusball_7) +', '
                          + convert (char(2), cbj.[bonusball_8]) +', '
                          + convert (char(2), cbj.[bonusball_9]) +', '
                          + convert (char(2), cbj.[bonusball_10])+', '
                          + convert (char(2), cbj.[bonusball_11])+', '
                          + convert (char(2), cbj.[bonusball_12])+', '
                          + convert (char(2), cbj.[bonusball_13])+', '
                          + convert (char(2), cbj.[bonusball_14])+', '
                          + convert (char(2), cbj.[bonusball_15])+', '
                          + convert (char(2), cbj.[bonusball_16])+', '
                          + convert (char(2), cbj.[bonusball_17])+', '
                          + convert (char(2), cbj.[bonusball_18])+', '
                          + convert (char(2), cbj.[bonusball_19])+', '
                          + convert (char(2), cbj.[bonusball_20])+', '
                          + convert (char(2), cbj.[bonusball_21])+', '
                          + convert (char(2), cbj.[bonusball_22])+', '
                          + convert (char(2), cbj.[bonusball_23])+', '
                          + convert (char(2), cbj.[bonusball_24])+', ')
						 
                          else '' end 
                
                    from dbo.WildBall_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber
					)

					,GetMinimumBonusCardValue(GameNum, MinimumValue)
					as
					(
							select 
							Gamenum, 	
						case when len(cast (cbj.[bonusball_1] as varchar(2)))   > 1 then  substring (cast (cbj.[bonusball_1] as varchar(2)), 2,1)   else  substring (cast (cbj.[bonusball_1] as varchar(2)), 0,1) end 
       
					from dbo.WildBall_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber
					and cbj.bonusball_1 != 0
					)
					--select * from GetMinimumBonusCardValue

				

					, GetAdditionalBonusBallCallWildBall (GameNum, BonusBall1, BonusBall2, BonusBall3, BonusBall4, BonusBall5, BonusBall6, BonusBall7, BonusBall8, BonusCount)
					as
					(
							select 
							cbj.Gamenum,					 			
							convert (char(2), g.MinimumValue ) +', '--19
						    ,convert (char(2), g.MinimumValue + 10) +', '--19
						    , convert (char(2), g.MinimumValue + 20 ) +', '--29
							 , convert (char(2), g.MinimumValue + 30) +', '--39
							  , convert (char(2), g.MinimumValue + 40) +', '--49
							   , convert (char(2), g.MinimumValue + 50) +', '--59
							    , convert (char(2), g.MinimumValue + 60) +', '--69
								 , case when g.MinimumValue + 70  <= 75 then convert (char(2), g.MinimumValue + 70) +', '  else '' end--   
								  , case when g.MinimumValue + 70  <= 75 then 7 else 6 end                    
                    from dbo.WildBall_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
					 join GetMinimumBonusCardValue g on g.GameNum = cbj.gamenum
                     where 
                     cbj.sessnum = @SessionNumber
					)

					--select * from GetAdditionalBonusBallCallWildBall
					,FinalResultForBonusBallCallWildBall(GameNum, BonusBall, BonusBallCount)
					as
					(
					select x.GameNum,
		             (x.BonusBall + ( case when CHARINDEX(y.BonusBall1, x.BonusBall)  = 0 then y.BonusBall1 else '' end ) +					   
					   ( case when CHARINDEX(y.BonusBall2, x.BonusBall)  = 0 then y.BonusBall2 else '' end ) +
					    ( case when CHARINDEX(y.BonusBall3, x.BonusBall)  = 0 then y.BonusBall3 else '' end ) +
						 ( case when CHARINDEX(y.BonusBall4, x.BonusBall)  = 0 then y.BonusBall4 else '' end ) +
						  ( case when CHARINDEX(y.BonusBall5, x.BonusBall)  = 0 then y.BonusBall5 else '' end ) +
						   ( case when CHARINDEX(y.BonusBall6, x.BonusBall)  = 0 then y.BonusBall6 else '' end ) +
						    ( case when CHARINDEX(y.BonusBall7, x.BonusBall)  = 0 then y.BonusBall7 else '' end ) +
						  (case when LEN(y.BonusBall8) != 0 then ( case when CHARINDEX(y.BonusBall8, x.BonusBall)  = 0 then y.BonusBall8 else '' end ) else '' end)),
						 
					 ( case when CHARINDEX(y.BonusBall1, x.BonusBall)  = 0 then 1 else 0 end ) +					   
					   ( case when CHARINDEX(y.BonusBall2, x.BonusBall)  =   0 then 1 else 0 end ) +	
					    ( case when CHARINDEX(y.BonusBall3, x.BonusBall)  = 0 then 1 else 0 end ) +	
						 ( case when CHARINDEX(y.BonusBall4, x.BonusBall)  =  0 then 1 else 0 end ) +	
						  ( case when CHARINDEX(y.BonusBall5, x.BonusBall)  =  0 then 1 else 0 end ) +	
						   ( case when CHARINDEX(y.BonusBall6, x.BonusBall)  =  0 then 1 else 0 end ) +	
						    ( case when CHARINDEX(y.BonusBall7, x.BonusBall)  =  0 then 1 else 0 end ) +	
						  (case when LEN(y.BonusBall8) != 0 then ( case when CHARINDEX(y.BonusBall8, x.BonusBall)  = 0 then 1 else 0 end ) else 0 end) + 24
							
                    from GetNormalBonusBallCallForWildBall x
                     join GetAdditionalBonusBallCallWildBall  y
                     on x.GameNum = y.GameNum
					
              
		
					) 
					--select GameNum, BonusBall, BonusBallCount from FinalResultForBonusBallCallWildBall

                   ,  BallCall_cte 
                    (
                  [Game Name], GamingDate, ClientMac, Player, SessNum, SessStart, SessEnd, OperatorID, OperatorName,
                    GameNum, BallCall, BallCallCount, BonusBallCount, BonusBall, StaffID
       
                    ) 
                    as 
                    (
                    select  'Crazy Bout' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname, 
                    gamenum
                           , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])+', '
                          + convert (char(2), cbj.[ball_21])+', '
                          + convert (char(2), cbj.[ball_22])+', '
                          + convert (char(2), cbj.[ball_23])+', '
                          + convert (char(2), cbj.[ball_24] ) as BallCall   ,                    
							24,
                          case when cbj.bonuswinamt != 0 then 30
                          else NULL end as BallCallCount,
                          
                          case when cbj.bonuswinamt != 0 then
                          (convert (char(2), cbj.[bonusball_1]) +', '
                          + convert (char(2), cbj.[bonusball_2]) +', '
                          + convert (char(2), cbj.[bonusball_3]) +', '
                          + convert (char(2), cbj.[bonusball_4]) +', '
                          + convert (char(2), cbj.[bonusball_5]) +', '
                          + convert (char(2), cbj.bonusball_6) +', '
                          + convert (char(2), cbj.bonusball_7) +', '
                          + convert (char(2), cbj.[bonusball_8]) +', '
                          + convert (char(2), cbj.[bonusball_9]) +', '
                          + convert (char(2), cbj.[bonusball_10])+', '
                          + convert (char(2), cbj.[bonusball_11])+', '
                          + convert (char(2), cbj.[bonusball_12])+', '
                          + convert (char(2), cbj.[bonusball_13])+', '
                          + convert (char(2), cbj.[bonusball_14])+', '
                          + convert (char(2), cbj.[bonusball_15])+', '
                          + convert (char(2), cbj.[bonusball_16])+', '
                          + convert (char(2), cbj.[bonusball_17])+', '
                          + convert (char(2), cbj.[bonusball_18])+', '
                          + convert (char(2), cbj.[bonusball_19])+', '
                          + convert (char(2), cbj.[bonusball_20])+', '
                          + convert (char(2), cbj.[bonusball_21])+', '
                          + convert (char(2), cbj.[bonusball_22])+', '
                          + convert (char(2), cbj.[bonusball_23])+', '
                          + convert (char(2), cbj.[bonusball_24]) +', '    
                          + convert (char(2), cbj.[bonusball_25]) +', '   
                          + convert (char(2), cbj.[bonusball_26]) +', '   
                          + convert (char(2), cbj.[bonusball_27]) +', '   
                          + convert (char(2), cbj.[bonusball_28]) +', ' 
                          + convert (char(2), cbj.[bonusball_29]) +', ' 
                          + convert (char(2), cbj.[bonusball_30])) 
                          else '' end as    BonusBall  , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))                           
                    from dbo.CrazyBout_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber
                       union all
                      select  'Jailbreak' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname,
                    gamenum
                           , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])+', '
                          + convert (char(2), cbj.[ball_21])+', '
                          + convert (char(2), cbj.[ball_22])+', '
                          + convert (char(2), cbj.[ball_23])+', '
                          + convert (char(2), cbj.[ball_24] ) as BallCall   ,                    
							24,
                          case when cbj.bonuswinamt != 0 then 30
                          else NULL end as BallCallCount,
                          
                          case when cbj.bonuswinamt != 0 then
                          (convert (char(2), cbj.[bonusball_1]) +', '
                          + convert (char(2), cbj.[bonusball_2]) +', '
                          + convert (char(2), cbj.[bonusball_3]) +', '
                          + convert (char(2), cbj.[bonusball_4]) +', '
                          + convert (char(2), cbj.[bonusball_5]) +', '
                          + convert (char(2), cbj.bonusball_6) +', '
                          + convert (char(2), cbj.bonusball_7) +', '
                          + convert (char(2), cbj.[bonusball_8]) +', '
                          + convert (char(2), cbj.[bonusball_9]) +', '
                          + convert (char(2), cbj.[bonusball_10])+', '
                          + convert (char(2), cbj.[bonusball_11])+', '
                          + convert (char(2), cbj.[bonusball_12])+', '
                          + convert (char(2), cbj.[bonusball_13])+', '
                          + convert (char(2), cbj.[bonusball_14])+', '
                          + convert (char(2), cbj.[bonusball_15])+', '
                          + convert (char(2), cbj.[bonusball_16])+', '
                          + convert (char(2), cbj.[bonusball_17])+', '
                          + convert (char(2), cbj.[bonusball_18])+', '
                          + convert (char(2), cbj.[bonusball_19])+', '
                          + convert (char(2), cbj.[bonusball_20])+', '
                          + convert (char(2), cbj.[bonusball_21])+', '
                          + convert (char(2), cbj.[bonusball_22])+', '
                          + convert (char(2), cbj.[bonusball_23])+', '
                          + convert (char(2), cbj.[bonusball_24]) +', '    
                          + convert (char(2), cbj.[bonusball_25]) +', '   
                          + convert (char(2), cbj.[bonusball_26]) +', '   
                          + convert (char(2), cbj.[bonusball_27]) +', '   
                          + convert (char(2), cbj.[bonusball_28]) +', ' 
                          + convert (char(2), cbj.[bonusball_29]) +', ' 
                          + convert (char(2), cbj.[bonusball_30])) 
                          else '' end as    BonusBall     , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))  
                          
                    from dbo.JailBreak_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber
                     --CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) >= CAST(CONVERT(varchar(12), @StartDate, 101) AS SMALLDATETIME)
                     --and  CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) <= CAST(CONVERT(varchar(12), @EndDate, 101) AS SMALLDATETIME)
                       union all
                      select  'Spirit76' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname,
                    gamenum
                           , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])+', '
                          + convert (char(2), cbj.[ball_21])+', '
                          + convert (char(2), cbj.[ball_22])+', '
                          + convert (char(2), cbj.[ball_23])+', '
                          + convert (char(2), cbj.[ball_24] ) as BallCall   ,                    
							24,
                          case when cbj.bonuswinamt != 0 then 30
                          else NULL end as BallCallCount,
                          
                          case when cbj.bonuswinamt != 0 then
                          (convert (char(2), cbj.[bonusball_1]) +', '
                          + convert (char(2), cbj.[bonusball_2]) +', '
                          + convert (char(2), cbj.[bonusball_3]) +', '
                          + convert (char(2), cbj.[bonusball_4]) +', '
                          + convert (char(2), cbj.[bonusball_5]) +', '
                          + convert (char(2), cbj.bonusball_6) +', '
                          + convert (char(2), cbj.bonusball_7) +', '
                          + convert (char(2), cbj.[bonusball_8]) +', '
                          + convert (char(2), cbj.[bonusball_9]) +', '
                          + convert (char(2), cbj.[bonusball_10])+', '
                          + convert (char(2), cbj.[bonusball_11])+', '
                          + convert (char(2), cbj.[bonusball_12])+', '
                          + convert (char(2), cbj.[bonusball_13])+', '
                          + convert (char(2), cbj.[bonusball_14])+', '
                          + convert (char(2), cbj.[bonusball_15])+', '
                          + convert (char(2), cbj.[bonusball_16])+', '
                          + convert (char(2), cbj.[bonusball_17])+', '
                          + convert (char(2), cbj.[bonusball_18])+', '
                          + convert (char(2), cbj.[bonusball_19])+', '
                          + convert (char(2), cbj.[bonusball_20])+', '
                          + convert (char(2), cbj.[bonusball_21])+', '
                          + convert (char(2), cbj.[bonusball_22])+', '
                          + convert (char(2), cbj.[bonusball_23])+', '
                          + convert (char(2), cbj.[bonusball_24]) +', '    
                          + convert (char(2), cbj.[bonusball_25]) +', '   
                          + convert (char(2), cbj.[bonusball_26]) +', '   
                          + convert (char(2), cbj.[bonusball_27]) +', '   
                          + convert (char(2), cbj.[bonusball_28]) +', ' 
                          + convert (char(2), cbj.[bonusball_29]) +', ' 
                          + convert (char(2), cbj.[bonusball_30])) 
                          else '' end as    BonusBall    , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))   
                          
                    from dbo.Spirit76_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber
                     --CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) >= CAST(CONVERT(varchar(12), @StartDate, 101) AS SMALLDATETIME)
                     --and  CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) <= CAST(CONVERT(varchar(12), @EndDate, 101) AS SMALLDATETIME)
                       union all
                      select  'TimeBomb' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname,
                    gamenum
                           , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])+', '
                          + convert (char(2), cbj.[ball_21])+', '
                          + convert (char(2), cbj.[ball_22])+', '
                          + convert (char(2), cbj.[ball_23])+', '
                          + convert (char(2), cbj.[ball_24] ) as BallCall   ,                    
							24,
                        NULL  BallCallCount,                          
                          ''  as    BonusBall    , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))   
                          
                    from dbo.TimeBomb_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber
                     --CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) >= CAST(CONVERT(varchar(12), @StartDate, 101) AS SMALLDATETIME)
                     --and  CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) <= CAST(CONVERT(varchar(12), @EndDate, 101) AS SMALLDATETIME)
                     
                       union all
                      select  'UkickEm' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname,
                    gamenum
                           , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])
							 as BallCall   ,                    
							24,
							NULL  as BallCallCount,                          
                         ''   BonusBall  , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))     
                          
                    from dbo.UKickEm_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber
                     --CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) >= CAST(CONVERT(varchar(12), @StartDate, 101) AS SMALLDATETIME)
                     --and  CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) <= CAST(CONVERT(varchar(12), @EndDate, 101) AS SMALLDATETIME)
                     
                     union all
                     select  'Maya Money' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname,
                    gamenum
                            , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])+', '
                          + convert (char(2), cbj.[ball_21])+', '
                          + convert (char(2), cbj.[ball_22])+', '
                          + convert (char(2), cbj.[ball_23])+', '
                          + convert (char(2), cbj.[ball_24] ) as BallCall   ,                    
							24,
						 NULL  BallCallCount,                       
                          ''  as    BonusBall     , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))  
                          
                    from dbo.MayaMoney_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber
                     --CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) >= CAST(CONVERT(varchar(12), @StartDate, 101) AS SMALLDATETIME)
                     --and  CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) <= CAST(CONVERT(varchar(12), @EndDate, 101) AS SMALLDATETIME)
                     union all
                      select  'Wild Ball' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname, 
                    cbj.gamenum
                           , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])+', '
                          + convert (char(2), cbj.[ball_21])+', '
                          + convert (char(2), cbj.[ball_22])+', '
                          + convert (char(2), cbj.[ball_23])+', '
                          + convert (char(2), cbj.[ball_24] ) as BallCall   ,                    
							24,
                          case when cbj.bonuswinamt != 0 then f.BonusBallCount
                          else NULL end as BallCallCount,
                          
                          case when cbj.bonuswinamt != 0 then
							SUBSTRING (f.BonusBall, 0, len(f.BonusBall)) 
                          else '' end as    BonusBall    , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))   
                          
                    from dbo.WildBall_GameJournal cbj
                     join dbo.B3_SessionsJournal sj			
                     on sj.sessnum = cbj.sessnum
					 		left join FinalResultForBonusBallCallWildBall f on f.GameNum = cbj.gamenum
                     where 
                     cbj.sessnum = @SessionNumber
                     --CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) >= CAST(CONVERT(varchar(12), @StartDate, 101) AS SMALLDATETIME)
                     --and  CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) <= CAST(CONVERT(varchar(12), @EndDate, 101) AS SMALLDATETIME)
                     union all
                      select  'Wild Fire' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname,
                    gamenum
                         , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])+', '
                          + convert (char(2), cbj.[ball_21])+', '
                          + convert (char(2), cbj.[ball_22])+', '
                          + convert (char(2), cbj.[ball_23])+', '
                          + convert (char(2), cbj.[ball_24] ) as BallCall   ,                    
							24,
							NULL  BallCallCount,                          
							'' BonusBall  , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))     
                          
                    from dbo.WildFire_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber
                     --CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) >= CAST(CONVERT(varchar(12), @StartDate, 101) AS SMALLDATETIME)
                     --and  CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) <= CAST(CONVERT(varchar(12), @EndDate, 101) AS SMALLDATETIME)
                     )
                     insert into @BallCall_cte
                     select *  from BallCall_cte;
  				
                     insert into @BallCall 
                     (  
						ServerGameNumber ,
						DTStamp , 
						GameTypeID ,  
						GameName ,                 
						GameBallCount ,
						GameBalls ,
						BonusBallCount ,
						BonusBalls ,
						StaffID         											  )
                     select GameNum, GamingDate, -2, [Game Name], BallCallCount, BallCall, BonusBallCount, BonusBall, StaffID  from @BallCall_cte
 
					return 
					--select * from @BallCall
 
					end
					


--select *

--   from dbo.WildBall_GameJournal cbj
--                     join dbo.B3_SessionsJournal sj
--                     on sj.sessnum = cbj.sessnum
--                     where 
--                     cbj.sessnum = 1010


--declare @SessionNumber int set @SessionNumber = 1010
--declare @BallCall table
--(
--	ServerGameNumber int,
--	DTStamp datetime, 
--	GameTypeID int,  
--	GameName varchar(100) ,                 
--	GameBallCount int,
--	GameBalls varchar(max),
--	BonusBallCount int,
--	BonusBalls varchar(max) ,
--	StaffID int 


GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_fnGetBallCallB3_2]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[B3_fnGetBallCallB3_2]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




create function [dbo].[B3_fnGetBallCallB3_2]
(@SessionNumber int, @GameName varchar(50), @GameID int)
returns @BallCall table
(
	ServerGameNumber int,
	DTStamp datetime, 
	GameTypeID int,  
	GameName varchar(100) ,                 
	GameBallCount int,
	GameBalls varchar(max),
	BonusBallCount int,
	BonusBalls varchar(max) ,
	StaffID int          
)
as


--declare @SessionNumber int set @SessionNumber = 1001
--declare @BallCall table
--(
--	ServerGameNumber int,
--	DTStamp datetime, 
--	GameTypeID int,  
--	GameName varchar(100) ,                 
--	GameBallCount int,
--	GameBalls varchar(max),
--	BonusBallCount int,
--	BonusBalls varchar(max) ,
--	StaffID int  )
begin
--=============================
-- Author:		Fortunet
-- Date:		20150915
-- Dscription:	Get the ball call per game in B3 not Class II.
--				If B3 system session played both B3 class II and III then it will only report class II game. 
--=============================




                    declare @BallCall_cte table
                    (
                    [Game Name] varchar(50), 
                    GamingDate smalldatetime, 
                    ClientMac varchar(50) , 
                    Player varchar(50), 
                    SessNum int, 
                    SessStart smalldatetime , 
                    SessEnd smalldatetime, 
                    OperatorID int, 
                    OperatorName varchar(100),
                    GameNum int, 
                    BallCall varchar(max),
                    BallCallCount int,
                    BonusBallCount int,
                    BonusBall varchar(max),
                    StaffID int
                    )


					if (@GameName = 'Wild Ball')
					begin
					;with GetNormalBonusBallCallForWildBall (GameNum, BonusBall)
					as
					(
					select
					Gamenum,
					 case when cbj.bonuswinamt != 0 then
					(convert (char(2), cbj.[bonusball_1]) +', '
                          + convert (char(2), cbj.[bonusball_2]) +', '
                          + convert (char(2), cbj.[bonusball_3]) +', '
                          + convert (char(2), cbj.[bonusball_4]) +', '
                          + convert (char(2), cbj.[bonusball_5]) +', '
                          + convert (char(2), cbj.bonusball_6) +', '
                          + convert (char(2), cbj.bonusball_7) +', '
                          + convert (char(2), cbj.[bonusball_8]) +', '
                          + convert (char(2), cbj.[bonusball_9]) +', '
                          + convert (char(2), cbj.[bonusball_10])+', '
                          + convert (char(2), cbj.[bonusball_11])+', '
                          + convert (char(2), cbj.[bonusball_12])+', '
                          + convert (char(2), cbj.[bonusball_13])+', '
                          + convert (char(2), cbj.[bonusball_14])+', '
                          + convert (char(2), cbj.[bonusball_15])+', '
                          + convert (char(2), cbj.[bonusball_16])+', '
                          + convert (char(2), cbj.[bonusball_17])+', '
                          + convert (char(2), cbj.[bonusball_18])+', '
                          + convert (char(2), cbj.[bonusball_19])+', '
                          + convert (char(2), cbj.[bonusball_20])+', '
                          + convert (char(2), cbj.[bonusball_21])+', '
                          + convert (char(2), cbj.[bonusball_22])+', '
                          + convert (char(2), cbj.[bonusball_23])+', '
                          + convert (char(2), cbj.[bonusball_24])+', ')
						 
                          else '' end 
                
                    from dbo.WildBall_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber
					 and cbj.gamenum = @GameID
					)

					,GetMinimumBonusCardValue(GameNum, MinimumValue)
					as
					(
							select 
							Gamenum, 	
						case when len(cast (cbj.[bonusball_1] as varchar(2)))   > 1 then  substring (cast (cbj.[bonusball_1] as varchar(2)), 2,1)   else  substring (cast (cbj.[bonusball_1] as varchar(2)), 0,1) end 
       
					from dbo.WildBall_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber
					and cbj.bonusball_1 != 0
								 and cbj.gamenum = @GameID
					)
					--select * from GetMinimumBonusCardValue

				

					, GetAdditionalBonusBallCallWildBall (GameNum, BonusBall1, BonusBall2, BonusBall3, BonusBall4, BonusBall5, BonusBall6, BonusBall7, BonusBall8, BonusCount)
					as
					(
							select 
							cbj.Gamenum,					 			
							convert (char(2), g.MinimumValue ) +', '--19
						    ,convert (char(2), g.MinimumValue + 10) +', '--19
						    , convert (char(2), g.MinimumValue + 20 ) +', '--29
							 , convert (char(2), g.MinimumValue + 30) +', '--39
							  , convert (char(2), g.MinimumValue + 40) +', '--49
							   , convert (char(2), g.MinimumValue + 50) +', '--59
							    , convert (char(2), g.MinimumValue + 60) +', '--69
								 , case when g.MinimumValue + 70  <= 75 then convert (char(2), g.MinimumValue + 70) +', '  else '' end--   
								  , case when g.MinimumValue + 70  <= 75 then 7 else 6 end                    
                    from dbo.WildBall_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
					 join GetMinimumBonusCardValue g on g.GameNum = cbj.gamenum
                     where 
                     cbj.sessnum = @SessionNumber
					 			 and cbj.gamenum = @GameID
					)

					--select * from GetAdditionalBonusBallCallWildBall
					,FinalResultForBonusBallCallWildBall(GameNum, BonusBall, BonusBallCount)
					as
					(
					select x.GameNum,
		             (x.BonusBall + ( case when CHARINDEX(y.BonusBall1, x.BonusBall)  = 0 then y.BonusBall1 else '' end ) +					   
					   ( case when CHARINDEX(y.BonusBall2, x.BonusBall)  = 0 then y.BonusBall2 else '' end ) +
					    ( case when CHARINDEX(y.BonusBall3, x.BonusBall)  = 0 then y.BonusBall3 else '' end ) +
						 ( case when CHARINDEX(y.BonusBall4, x.BonusBall)  = 0 then y.BonusBall4 else '' end ) +
						  ( case when CHARINDEX(y.BonusBall5, x.BonusBall)  = 0 then y.BonusBall5 else '' end ) +
						   ( case when CHARINDEX(y.BonusBall6, x.BonusBall)  = 0 then y.BonusBall6 else '' end ) +
						    ( case when CHARINDEX(y.BonusBall7, x.BonusBall)  = 0 then y.BonusBall7 else '' end ) +
						  (case when LEN(y.BonusBall8) != 0 then ( case when CHARINDEX(y.BonusBall8, x.BonusBall)  = 0 then y.BonusBall8 else '' end ) else '' end)),
						 
					 ( case when CHARINDEX(y.BonusBall1, x.BonusBall)  = 0 then 1 else 0 end ) +					   
					   ( case when CHARINDEX(y.BonusBall2, x.BonusBall)  =   0 then 1 else 0 end ) +	
					    ( case when CHARINDEX(y.BonusBall3, x.BonusBall)  = 0 then 1 else 0 end ) +	
						 ( case when CHARINDEX(y.BonusBall4, x.BonusBall)  =  0 then 1 else 0 end ) +	
						  ( case when CHARINDEX(y.BonusBall5, x.BonusBall)  =  0 then 1 else 0 end ) +	
						   ( case when CHARINDEX(y.BonusBall6, x.BonusBall)  =  0 then 1 else 0 end ) +	
						    ( case when CHARINDEX(y.BonusBall7, x.BonusBall)  =  0 then 1 else 0 end ) +	
						  (case when LEN(y.BonusBall8) != 0 then ( case when CHARINDEX(y.BonusBall8, x.BonusBall)  = 0 then 1 else 0 end ) else 0 end) + 24
							
                    from GetNormalBonusBallCallForWildBall x
                     join GetAdditionalBonusBallCallWildBall  y
                     on x.GameNum = y.GameNum
					
              
		
					) 
					 ,  BallCall_cte 
                    (
                  [Game Name], GamingDate, ClientMac, Player, SessNum, SessStart, SessEnd, OperatorID, OperatorName,
                    GameNum, BallCall, BallCallCount, BonusBallCount, BonusBall, StaffID
       
                    ) 
                    as 
					(

					  select  'Wild Ball' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname, 
                    cbj.gamenum
                           , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])+', '
                          + convert (char(2), cbj.[ball_21])+', '
                          + convert (char(2), cbj.[ball_22])+', '
                          + convert (char(2), cbj.[ball_23])+', '
                          + convert (char(2), cbj.[ball_24] ) as BallCall   ,                    
							24,
                          case when cbj.bonuswinamt != 0 then f.BonusBallCount
                          else NULL end as BallCallCount,
                          
                          case when cbj.bonuswinamt != 0 then
							SUBSTRING (f.BonusBall, 0, len(f.BonusBall)) 
                          else '' end as    BonusBall    , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))   
                          
                    from dbo.WildBall_GameJournal cbj
                     join dbo.B3_SessionsJournal sj			
                     on sj.sessnum = cbj.sessnum
					 		left join FinalResultForBonusBallCallWildBall f on f.GameNum = cbj.gamenum
                     where 
                     cbj.sessnum = @SessionNumber
					 			 and cbj.gamenum = @GameID
                     --CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) >= CAST(CONVERT(varchar(12), @StartDate, 101) AS SMALLDATETIME)
                     --and  CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) <= CAST(CONVERT(varchar(12), @EndDate, 101) AS SMALLDATETIME)

				)    insert into @BallCall_cte
                     select *  from BallCall_cte;

                  end
				  

				  if (@GameName = 'Crazy Bout')
				  begin
				   ;with  BallCall_cte 
                    (
                  [Game Name], GamingDate, ClientMac, Player, SessNum, SessStart, SessEnd, OperatorID, OperatorName,
                    GameNum, BallCall, BallCallCount, BonusBallCount, BonusBall, StaffID
       
                    ) 
                    as 
                    (
                    select  'Crazy Bout' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname, 
                    gamenum
                           , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])+', '
                          + convert (char(2), cbj.[ball_21])+', '
                          + convert (char(2), cbj.[ball_22])+', '
                          + convert (char(2), cbj.[ball_23])+', '
                          + convert (char(2), cbj.[ball_24] ) as BallCall   ,                    
							24,
                          case when cbj.bonuswinamt != 0 then 30
                          else NULL end as BallCallCount,
                          
                          case when cbj.bonuswinamt != 0 then
                          (convert (char(2), cbj.[bonusball_1]) +', '
                          + convert (char(2), cbj.[bonusball_2]) +', '
                          + convert (char(2), cbj.[bonusball_3]) +', '
                          + convert (char(2), cbj.[bonusball_4]) +', '
                          + convert (char(2), cbj.[bonusball_5]) +', '
                          + convert (char(2), cbj.bonusball_6) +', '
                          + convert (char(2), cbj.bonusball_7) +', '
                          + convert (char(2), cbj.[bonusball_8]) +', '
                          + convert (char(2), cbj.[bonusball_9]) +', '
                          + convert (char(2), cbj.[bonusball_10])+', '
                          + convert (char(2), cbj.[bonusball_11])+', '
                          + convert (char(2), cbj.[bonusball_12])+', '
                          + convert (char(2), cbj.[bonusball_13])+', '
                          + convert (char(2), cbj.[bonusball_14])+', '
                          + convert (char(2), cbj.[bonusball_15])+', '
                          + convert (char(2), cbj.[bonusball_16])+', '
                          + convert (char(2), cbj.[bonusball_17])+', '
                          + convert (char(2), cbj.[bonusball_18])+', '
                          + convert (char(2), cbj.[bonusball_19])+', '
                          + convert (char(2), cbj.[bonusball_20])+', '
                          + convert (char(2), cbj.[bonusball_21])+', '
                          + convert (char(2), cbj.[bonusball_22])+', '
                          + convert (char(2), cbj.[bonusball_23])+', '
                          + convert (char(2), cbj.[bonusball_24]) +', '    
                          + convert (char(2), cbj.[bonusball_25]) +', '   
                          + convert (char(2), cbj.[bonusball_26]) +', '   
                          + convert (char(2), cbj.[bonusball_27]) +', '   
                          + convert (char(2), cbj.[bonusball_28]) +', ' 
                          + convert (char(2), cbj.[bonusball_29]) +', ' 
                          + convert (char(2), cbj.[bonusball_30])) 
                          else '' end as    BonusBall  , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))                           
                    from dbo.CrazyBout_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber
					 			 and cbj.gamenum = @GameID)
					  insert into @BallCall_cte
                     select *  from BallCall_cte;

					 end


              if (@GameName = 'Jailbreak')
				  begin
				   ;with  BallCall_cte 
                    (
                  [Game Name], GamingDate, ClientMac, Player, SessNum, SessStart, SessEnd, OperatorID, OperatorName,
                    GameNum, BallCall, BallCallCount, BonusBallCount, BonusBall, StaffID
       
                    ) 
                    as 
                    (
                      select  'Jailbreak' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname,
                    gamenum
                           , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])+', '
                          + convert (char(2), cbj.[ball_21])+', '
                          + convert (char(2), cbj.[ball_22])+', '
                          + convert (char(2), cbj.[ball_23])+', '
                          + convert (char(2), cbj.[ball_24] ) as BallCall   ,                    
							24,
                          case when cbj.bonuswinamt != 0 then 30
                          else NULL end as BallCallCount,
                          
                          case when cbj.bonuswinamt != 0 then
                          (convert (char(2), cbj.[bonusball_1]) +', '
                          + convert (char(2), cbj.[bonusball_2]) +', '
                          + convert (char(2), cbj.[bonusball_3]) +', '
                          + convert (char(2), cbj.[bonusball_4]) +', '
                          + convert (char(2), cbj.[bonusball_5]) +', '
                          + convert (char(2), cbj.bonusball_6) +', '
                          + convert (char(2), cbj.bonusball_7) +', '
                          + convert (char(2), cbj.[bonusball_8]) +', '
                          + convert (char(2), cbj.[bonusball_9]) +', '
                          + convert (char(2), cbj.[bonusball_10])+', '
                          + convert (char(2), cbj.[bonusball_11])+', '
                          + convert (char(2), cbj.[bonusball_12])+', '
                          + convert (char(2), cbj.[bonusball_13])+', '
                          + convert (char(2), cbj.[bonusball_14])+', '
                          + convert (char(2), cbj.[bonusball_15])+', '
                          + convert (char(2), cbj.[bonusball_16])+', '
                          + convert (char(2), cbj.[bonusball_17])+', '
                          + convert (char(2), cbj.[bonusball_18])+', '
                          + convert (char(2), cbj.[bonusball_19])+', '
                          + convert (char(2), cbj.[bonusball_20])+', '
                          + convert (char(2), cbj.[bonusball_21])+', '
                          + convert (char(2), cbj.[bonusball_22])+', '
                          + convert (char(2), cbj.[bonusball_23])+', '
                          + convert (char(2), cbj.[bonusball_24]) +', '    
                          + convert (char(2), cbj.[bonusball_25]) +', '   
                          + convert (char(2), cbj.[bonusball_26]) +', '   
                          + convert (char(2), cbj.[bonusball_27]) +', '   
                          + convert (char(2), cbj.[bonusball_28]) +', ' 
                          + convert (char(2), cbj.[bonusball_29]) +', ' 
                          + convert (char(2), cbj.[bonusball_30])) 
                          else '' end as    BonusBall     , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))  
                          
                    from dbo.JailBreak_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber
					 			 and cbj.gamenum = @GameID
                     --CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) >= CAST(CONVERT(varchar(12), @StartDate, 101) AS SMALLDATETIME)
                     --and  CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) <= CAST(CONVERT(varchar(12), @EndDate, 101) AS SMALLDATETIME)
                    )
					
					insert into @BallCall_cte
                     select *  from BallCall_cte;

					 end


					 if (@GameName = 'Spirit76')
				  begin
				   ;with  BallCall_cte 
                    (
                  [Game Name], GamingDate, ClientMac, Player, SessNum, SessStart, SessEnd, OperatorID, OperatorName,
                    GameNum, BallCall, BallCallCount, BonusBallCount, BonusBall, StaffID
       
                    ) 
                    as 
                    (

                      select  'Spirit76' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname,
                    gamenum
                           , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])+', '
                          + convert (char(2), cbj.[ball_21])+', '
                          + convert (char(2), cbj.[ball_22])+', '
                          + convert (char(2), cbj.[ball_23])+', '
                          + convert (char(2), cbj.[ball_24] ) as BallCall   ,                    
							24,
                          case when cbj.bonuswinamt != 0 then 30
                          else NULL end as BallCallCount,
                          
                          case when cbj.bonuswinamt != 0 then
                          (convert (char(2), cbj.[bonusball_1]) +', '
                          + convert (char(2), cbj.[bonusball_2]) +', '
                          + convert (char(2), cbj.[bonusball_3]) +', '
                          + convert (char(2), cbj.[bonusball_4]) +', '
                          + convert (char(2), cbj.[bonusball_5]) +', '
                          + convert (char(2), cbj.bonusball_6) +', '
                          + convert (char(2), cbj.bonusball_7) +', '
                          + convert (char(2), cbj.[bonusball_8]) +', '
                          + convert (char(2), cbj.[bonusball_9]) +', '
                          + convert (char(2), cbj.[bonusball_10])+', '
                          + convert (char(2), cbj.[bonusball_11])+', '
                          + convert (char(2), cbj.[bonusball_12])+', '
                          + convert (char(2), cbj.[bonusball_13])+', '
                          + convert (char(2), cbj.[bonusball_14])+', '
                          + convert (char(2), cbj.[bonusball_15])+', '
                          + convert (char(2), cbj.[bonusball_16])+', '
                          + convert (char(2), cbj.[bonusball_17])+', '
                          + convert (char(2), cbj.[bonusball_18])+', '
                          + convert (char(2), cbj.[bonusball_19])+', '
                          + convert (char(2), cbj.[bonusball_20])+', '
                          + convert (char(2), cbj.[bonusball_21])+', '
                          + convert (char(2), cbj.[bonusball_22])+', '
                          + convert (char(2), cbj.[bonusball_23])+', '
                          + convert (char(2), cbj.[bonusball_24]) +', '    
                          + convert (char(2), cbj.[bonusball_25]) +', '   
                          + convert (char(2), cbj.[bonusball_26]) +', '   
                          + convert (char(2), cbj.[bonusball_27]) +', '   
                          + convert (char(2), cbj.[bonusball_28]) +', ' 
                          + convert (char(2), cbj.[bonusball_29]) +', ' 
                          + convert (char(2), cbj.[bonusball_30])) 
                          else '' end as    BonusBall    , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))   
                          
                    from dbo.Spirit76_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber 			 and cbj.gamenum = @GameID
                     --CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) >= CAST(CONVERT(varchar(12), @StartDate, 101) AS SMALLDATETIME)
                     --and  CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) <= CAST(CONVERT(varchar(12), @EndDate, 101) AS SMALLDATETIME)
                   )
				    insert into @BallCall_cte
                     select *  from BallCall_cte;

					 end

					 	if (@GameName = 'TimeBomb')
				  begin
				   ;with  BallCall_cte 
                    (
                  [Game Name], GamingDate, ClientMac, Player, SessNum, SessStart, SessEnd, OperatorID, OperatorName,
                    GameNum, BallCall, BallCallCount, BonusBallCount, BonusBall, StaffID
       
                    ) 
                    as 
                    (
 

                      select  'TimeBomb' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname,
                    gamenum
                           , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])+', '
                          + convert (char(2), cbj.[ball_21])+', '
                          + convert (char(2), cbj.[ball_22])+', '
                          + convert (char(2), cbj.[ball_23])+', '
                          + convert (char(2), cbj.[ball_24] ) as BallCall   ,                    
							24,
                        NULL  BallCallCount,                          
                          ''  as    BonusBall    , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))   
                          
                    from dbo.TimeBomb_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber 			 and cbj.gamenum = @GameID
                     --CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) >= CAST(CONVERT(varchar(12), @StartDate, 101) AS SMALLDATETIME)
                     --and  CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) <= CAST(CONVERT(varchar(12), @EndDate, 101) AS SMALLDATETIME)
                                          
					 )insert into @BallCall_cte
                     select *  from BallCall_cte;

					 end
	

		if (@GameName = 'UkickEm')
					  begin
					   ;with  BallCall_cte 
						(
					  [Game Name], GamingDate, ClientMac, Player, SessNum, SessStart, SessEnd, OperatorID, OperatorName,
						GameNum, BallCall, BallCallCount, BonusBallCount, BonusBall, StaffID
       
						) 
						as 
						(

                      select  'UkickEm' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname,
                    gamenum
                           , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])
							 as BallCall   ,                    
							24,
							NULL  as BallCallCount,                          
                         ''   BonusBall  , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))     
                          
                    from dbo.UKickEm_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber 			 and cbj.gamenum = @GameID
                     --CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) >= CAST(CONVERT(varchar(12), @StartDate, 101) AS SMALLDATETIME)
                     --and  CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) <= CAST(CONVERT(varchar(12), @EndDate, 101) AS SMALLDATETIME)
                 )insert into @BallCall_cte
                     select *  from BallCall_cte;

					 end


				     
         
		 	if (@GameName =  'Maya Money')
				  begin
				   ;with  BallCall_cte 
                    (
                  [Game Name], GamingDate, ClientMac, Player, SessNum, SessStart, SessEnd, OperatorID, OperatorName,
                    GameNum, BallCall, BallCallCount, BonusBallCount, BonusBall, StaffID
       
                    ) 
                    as 
                    (

                     select  'Maya Money' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname,
                    gamenum
                            , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])+', '
                          + convert (char(2), cbj.[ball_21])+', '
                          + convert (char(2), cbj.[ball_22])+', '
                          + convert (char(2), cbj.[ball_23])+', '
                          + convert (char(2), cbj.[ball_24] ) as BallCall   ,                    
							24,
						 NULL  BallCallCount,                       
                          ''  as    BonusBall     , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))  
                          
                    from dbo.MayaMoney_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber 			 and cbj.gamenum = @GameID
                     --CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) >= CAST(CONVERT(varchar(12), @StartDate, 101) AS SMALLDATETIME)
                     --and  CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) <= CAST(CONVERT(varchar(12), @EndDate, 101) AS SMALLDATETIME)
                    )insert into @BallCall_cte
                     select *  from BallCall_cte;

					 end


                    if (@GameName = 'Wild Fire')
				  begin
				   ;with  BallCall_cte 
                    (
                  [Game Name], GamingDate, ClientMac, Player, SessNum, SessStart, SessEnd, OperatorID, OperatorName,
                    GameNum, BallCall, BallCallCount, BonusBallCount, BonusBall, StaffID
       
                    ) 
                    as 
                    (

                      select  'Wild Fire' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
                    sj.sessstart , sj.sessend, sj.operatorid, sj.operatorname,
                    gamenum
                         , convert (char(2), cbj.[ball_1]) +', '
                          + convert (char(2), cbj.[ball_2]) +', '
                          + convert (char(2), cbj.[ball_3]) +', '
                          + convert (char(2), cbj.[ball_4]) +', '
                          + convert (char(2), cbj.[ball_5]) +', '
                          + convert (char(2), cbj.[ball_6]) +', '
                          + convert (char(2), cbj.[ball_7]) +', '
                          + convert (char(2), cbj.[ball_8]) +', '
                          + convert (char(2), cbj.[ball_9]) +', '
                          + convert (char(2), cbj.[ball_10])+', '
                          + convert (char(2), cbj.[ball_11])+', '
                          + convert (char(2), cbj.[ball_12])+', '
                          + convert (char(2), cbj.[ball_13])+', '
                          + convert (char(2), cbj.[ball_14])+', '
                          + convert (char(2), cbj.[ball_15])+', '
                          + convert (char(2), cbj.[ball_16])+', '
                          + convert (char(2), cbj.[ball_17])+', '
                          + convert (char(2), cbj.[ball_18])+', '
                          + convert (char(2), cbj.[ball_19])+', '
                          + convert (char(2), cbj.[ball_20])+', '
                          + convert (char(2), cbj.[ball_21])+', '
                          + convert (char(2), cbj.[ball_22])+', '
                          + convert (char(2), cbj.[ball_23])+', '
                          + convert (char(2), cbj.[ball_24] ) as BallCall   ,                    
							24,
							NULL  BallCallCount,                          
							'' BonusBall  , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))     
                          
                    from dbo.WildFire_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
                     where 
                     cbj.sessnum = @SessionNumber 			 and cbj.gamenum = @GameID
                     --CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) >= CAST(CONVERT(varchar(12), @StartDate, 101) AS SMALLDATETIME)
                     --and  CAST(CONVERT(varchar(12), cbj.recdatetime, 101) AS SMALLDATETIME) <= CAST(CONVERT(varchar(12), @EndDate, 101) AS SMALLDATETIME)
                    )insert into @BallCall_cte
                     select *  from BallCall_cte;

					 end

  				
                     insert into @BallCall 
                     (  
						ServerGameNumber ,
						DTStamp , 
						GameTypeID ,  
						GameName ,                 
						GameBallCount ,
						GameBalls ,
						BonusBallCount ,
						BonusBalls ,
						StaffID         											  )
                     select GameNum, GamingDate, -2, [Game Name], BallCallCount, BallCall, BonusBallCount, BonusBall, StaffID  from @BallCall_cte
 
 

					return 
					--select * from @BallCall
 
					end
					


--select *

--   from dbo.WildBall_GameJournal cbj
--                     join dbo.B3_SessionsJournal sj
--                     on sj.sessnum = cbj.sessnum
--                     where 
--                     cbj.sessnum = 1010


--declare @SessionNumber int set @SessionNumber = 1010
--declare @BallCall table
--(
--	ServerGameNumber int,
--	DTStamp datetime, 
--	GameTypeID int,  
--	GameName varchar(100) ,                 
--	GameBallCount int,
--	GameBalls varchar(max),
--	BonusBallCount int,
--	BonusBalls varchar(max) ,
--	StaffID int 



GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_fnGetJackpotWinningCardNumber]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[B3_fnGetJackpotWinningCardNumber]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE function [dbo].[B3_fnGetJackpotWinningCardNumber](@SessionNumber int/*, @GameNumber int*/)
Returns @JackpotCardNumber table
(
	CardNumbers nvarchar(500),
	GameNum int
)
--==============
-- Author:			Fortunet
-- Date Created:	20150828
-- Desscription:	Get the series of card number that trigger the jackpot.

--==============
as
begin
		
		;with CrazyBoutCardNumber(GameNumber, CardNumber)as
		(select game.gamenum,
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end 
		+ case when game.bonuswinamt != 0 then 
		', ' + cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10))
		else '' end
		
		from 
		dbo.CrazyBout_GameJournal game
		inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		--and game.gamenum = @GameNumber
		)
		
		,JailBreakCardNumber (GameNumber, CardNumber) as
		(
		select game.gamenum,
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end
		+ case when game.bonuswinamt != 0 then 
		', ' + cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10))
		else '' end
		from 
		dbo.JailBreak_GameJournal game
		inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		--and game.gamenum = @GameNumber
		)
		,MayaMoneyCardNumber (GameNumber, CardNumber) as  
		(
		select game.gamenum,
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end		
		from 
		dbo.MayaMoney_GameJournal game
		inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		--and game.gamenum = @GameNumber
		)
		,Spirit76CardNumber (GameNumber, CardNumber) as  
		(
		select game.gamenum,
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end
			+ case when game.bonuswinamt != 0 then 
		', ' + cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10))
		else '' end

		from 
		dbo.Spirit76_GameJournal game
		inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		--and game.gamenum = @GameNumber
		)
		,TimeBombCardNumber (GameNumber, CardNumber) as  
		(
		select game.gamenum,
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))
		else '' end		
		from 
		dbo.TimeBomb_GameJournal game
		inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		--and game.gamenum = @GameNumber
		)
		--,UkickEmCardNumber (GameNumber, CardNumber) as  
		--(		
		--select game.gamenum,
		--cast(game.cardsn_1 as varchar(10)) +', '
		--+ cast(game.cardsn_2 as varchar(10))+', '
		--+ cast (game.cardsn_3 as varchar(10))+', '
		--+ CAST (game.cardsn_4 as varchar(10))+', '
		--+ CAST (game.cardsn_5 as varchar(10))+', '
		--+ CAST (game.cardsn_6 as varchar(10))
		--from 
		--dbo.UKickEm_GameJournal game
		--where game.sessnum = @SessionNumber
		--and game.gamenum = @GameNumber
		--)
		,WildBallCardNumber (GameNumber, CardNumber) as  
		(
		select game.gamenum,
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end
		+ case when game.bonuswinamt != 0 then 
		', ' + cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10)) +', ' + cast(game.bonuscardsn_4 AS varchar(10))
		else '' end

		from 
		dbo.WildBall_GameJournal game
		inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		--and game.gamenum = @GameNumber
		)
		,WildFireCardNumber (GameNumber, CardNumber) as  
		(
		select game.gamenum,
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end
		from 
		dbo.WildFire_GameJournal game
		inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		--and game.gamenum = @GameNumber
		)
		,ResultSet  (GameNumber, CardNumber) as
		(
		select GameNumber, CardNumber from CrazyBoutCardNumber
		union all 
		select GameNumber, CardNumber from JailBreakCardNumber
		union all 
		select GameNumber, CardNumber from MayaMoneyCardNumber
		union all 
		select GameNumber, CardNumber from Spirit76CardNumber
		union all 
		select GameNumber, CardNumber from TimeBombCardNumber
		union all 
		select GameNumber, CardNumber from WildBallCardNumber
		union all 
		select GameNumber, CardNumber from WildFireCardNumber	
		)
		insert into @JackpotCardNumber (GameNum, CardNumbers)
		select distinct GameNumber, CardNumber from ResultSet 
		--20150904(knc): Use distinct to kill duplicate record::Since we only need the rec number and card number there is no need for duplicate record.
		
		

return
end






GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[b3_fnGetStaffIDBallCallChange]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[b3_fnGetStaffIDBallCallChange]
GO

USE [B3]
GO

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

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_fnGetWinningCardNumber]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[B3_fnGetWinningCardNumber]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE function [dbo].[B3_fnGetWinningCardNumber](@SessionNumber int, @GameNumber int)
returns nvarchar(500)
--Returns @JackpotCardNumber table
--(
--	CardNumbers nvarchar(500),
--	GameNum int
--)
--==============
-- Author:			Karlo Camacho
-- Date Created:	20151125
-- Desscription:	

--==============
as
begin

declare @Result nvarchar(500)
		
		;with CrazyBoutCardNumber(GameNumber, CardNumber)as
		(select game.gamenum,
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end 
		+ case when game.bonuswinamt != 0 then 
		', ' + cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10))
		else '' end
		
		from 
		dbo.CrazyBout_GameJournal game
		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		and game.gamenum = @GameNumber
		)
		
	
		
		,JailBreakCardNumber (GameNumber, CardNumber) as
		(
		select game.gamenum,
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end
		+ case when game.bonuswinamt != 0 then 
		', ' + cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10))
		else '' end
		from 
		dbo.JailBreak_GameJournal game
		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		and game.gamenum = @GameNumber
		)
		,MayaMoneyCardNumber (GameNumber, CardNumber) as  
		(
		select game.gamenum,
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end		
		from 
		dbo.MayaMoney_GameJournal game
		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		and game.gamenum = @GameNumber
		)
		,Spirit76CardNumber (GameNumber, CardNumber) as  
		(
		select game.gamenum,
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end
			+ case when game.bonuswinamt != 0 then 
		', ' + cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10))
		else '' end

		from 
		dbo.Spirit76_GameJournal game
		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		and game.gamenum = @GameNumber
		)
		,TimeBombCardNumber (GameNumber, CardNumber) as  
		(
		select game.gamenum,
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))
		else '' end		
		from 
		dbo.TimeBomb_GameJournal game
		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		and game.gamenum = @GameNumber
		)
		--,UkickEmCardNumber (GameNumber, CardNumber) as  
		--(		
		--select game.gamenum,
		--cast(game.cardsn_1 as varchar(10)) +', '
		--+ cast(game.cardsn_2 as varchar(10))+', '
		--+ cast (game.cardsn_3 as varchar(10))+', '
		--+ CAST (game.cardsn_4 as varchar(10))+', '
		--+ CAST (game.cardsn_5 as varchar(10))+', '
		--+ CAST (game.cardsn_6 as varchar(10))
		--from 
		--dbo.UKickEm_GameJournal game
		--where game.sessnum = @SessionNumber
		--and game.gamenum = @GameNumber
		--)
		,WildBallCardNumber (GameNumber, CardNumber) as  
		(
		select game.gamenum,
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end
		+ case when game.bonuswinamt != 0 then 
		', ' + cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10)) +', ' + cast(game.bonuscardsn_4 AS varchar(10))
		else '' end

		from 
		dbo.WildBall_GameJournal game
		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		and game.gamenum = @GameNumber
		)
		,WildFireCardNumber (GameNumber, CardNumber) as  
		(
		select game.gamenum,
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end
		from 
		dbo.WildFire_GameJournal game
		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		and game.gamenum = @GameNumber
		)
		,ResultSet  (GameNumber, CardNumber) as
		(
		select GameNumber, CardNumber from CrazyBoutCardNumber
		union all 
		select GameNumber, CardNumber from JailBreakCardNumber
		union all 
		select GameNumber, CardNumber from MayaMoneyCardNumber
		union all 
		select GameNumber, CardNumber from Spirit76CardNumber
		union all 
		select GameNumber, CardNumber from TimeBombCardNumber
		union all 
		select GameNumber, CardNumber from WildBallCardNumber
		union all 
		select GameNumber, CardNumber from WildFireCardNumber	
		)
	--insert into @JackpotCardNumber (GameNum, CardNumbers)
	select @Result = CardNumber from ResultSet ;
		
		
		--20150904(knc): Use distinct to kill duplicate record::Since we only need the rec number and card number there is no need for duplicate record.
		
		

return @Result
end







GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_fnGetWinningCardNumber2]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[B3_fnGetWinningCardNumber2]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE function [dbo].[B3_fnGetWinningCardNumber2](@SessionNumber int, @GameNumber int, @PayoutType int)
returns nvarchar(500)

--==============
-- Author:			Fortunet
-- Date Created:	20151125
-- Description:		Get the winning card number -> range per game.		

--==============
as
begin

declare @Result nvarchar(500)
		
		;with CrazyBoutCardNumber(GameNumber, CardNumber)as
		(select game.gamenum,
		case when  @PayoutType = 0
		then  
			case when betplaced_card_1 = 'T' then
			cast(game.cardsn_1 as varchar(10)) +', '
			else '' end
			+ case when betplaced_card_2 = 'T' then
			 cast(game.cardsn_2 as varchar(10))+', '
			 else '' end
			+ case when betplaced_card_3 = 'T' then
			 cast (game.cardsn_3 as varchar(10))+', '
			 else '' end
			+ case when betplaced_card_4 = 'T' then 
			 CAST (game.cardsn_4 as varchar(10))+', '
			else '' end
			+ case when betplaced_card_5 = 'T' then 
			 CAST (game.cardsn_5 as varchar(10))+', '
			else '' end
			+ case when betplaced_card_6 = 'T' then 
			 CAST (game.cardsn_6 as varchar(10))
			else '' end 
		else 
		 cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10))
		end
		
		from 
		dbo.CrazyBout_GameJournal game
		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		and game.gamenum = @GameNumber
		)
		
	
		
		,JailBreakCardNumber (GameNumber, CardNumber) as
		(
		select game.gamenum,
		case when @PayoutType = 0
		then
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end
		else
		cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10)) end
		from 
		dbo.JailBreak_GameJournal game
		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		and game.gamenum = @GameNumber
		)
		,MayaMoneyCardNumber (GameNumber, CardNumber) as  
		(
		select game.gamenum,
		case when @PayoutType = 0
		then
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end		
		end
		from 
		dbo.MayaMoney_GameJournal game
		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		and game.gamenum = @GameNumber
		)
		,Spirit76CardNumber (GameNumber, CardNumber) as  
		(
		select game.gamenum,
		case when @PayoutType = 0
		then
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end
		else
		cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10))
		 end

		from 
		dbo.Spirit76_GameJournal game
		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		and game.gamenum = @GameNumber
		)
		,TimeBombCardNumber (GameNumber, CardNumber) as  
		(
		select game.gamenum, 
		case when @PayoutType = 0
		then
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))
		else '' end		
		end
		from 
		dbo.TimeBomb_GameJournal game
		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		and game.gamenum = @GameNumber
		)
		--,UkickEmCardNumber (GameNumber, CardNumber) as  
		--(		
		--select game.gamenum,
		--cast(game.cardsn_1 as varchar(10)) +', '
		--+ cast(game.cardsn_2 as varchar(10))+', '
		--+ cast (game.cardsn_3 as varchar(10))+', '
		--+ CAST (game.cardsn_4 as varchar(10))+', '
		--+ CAST (game.cardsn_5 as varchar(10))+', '
		--+ CAST (game.cardsn_6 as varchar(10))
		--from 
		--dbo.UKickEm_GameJournal game
		--where game.sessnum = @SessionNumber
		--and game.gamenum = @GameNumber
		--)
		,WildBallCardNumber (GameNumber, CardNumber) as  
		(
		select game.gamenum,
		case when @PayoutType = 0
		then
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end
		else
		 cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10)) +', ' + cast(game.bonuscardsn_4 AS varchar(10))
		 end

		from 
		dbo.WildBall_GameJournal game
		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		and game.gamenum = @GameNumber
		)
		,WildFireCardNumber (GameNumber, CardNumber) as  
		(
		select game.gamenum,
		case when @PayoutType = 0 
		then
		case when betplaced_card_1 = 'T' then
		cast(game.cardsn_1 as varchar(10)) +', '
		else '' end
	    + case when betplaced_card_2 = 'T' then
	     cast(game.cardsn_2 as varchar(10))+', '
	     else '' end
		+ case when betplaced_card_3 = 'T' then
		 cast (game.cardsn_3 as varchar(10))+', '
		 else '' end
		+ case when betplaced_card_4 = 'T' then 
		 CAST (game.cardsn_4 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_5 = 'T' then 
		 CAST (game.cardsn_5 as varchar(10))+', '
		else '' end
		+ case when betplaced_card_6 = 'T' then 
		 CAST (game.cardsn_6 as varchar(10))
		else '' end
		end
		from 
		dbo.WildFire_GameJournal game
		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
		where game.sessnum = @SessionNumber
		and game.gamenum = @GameNumber
		)
		,ResultSet  (GameNumber, CardNumber) as
		(
		select GameNumber, CardNumber from CrazyBoutCardNumber
		union all 
		select GameNumber, CardNumber from JailBreakCardNumber
		union all 
		select GameNumber, CardNumber from MayaMoneyCardNumber
		union all 
		select GameNumber, CardNumber from Spirit76CardNumber
		union all 
		select GameNumber, CardNumber from TimeBombCardNumber
		union all 
		select GameNumber, CardNumber from WildBallCardNumber
		union all 
		select GameNumber, CardNumber from WildFireCardNumber	
		)
	--insert into @JackpotCardNumber (GameNum, CardNumbers)
	select @Result = CardNumber from ResultSet ;
		
		
		--20150904(knc): Use distinct to kill duplicate record::Since we only need the rec number and card number there is no need for duplicate record.
		
		

return @Result
end









GO


USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3fn_server_BallCallwGameID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[B3fn_server_BallCallwGameID]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE function [dbo].[B3fn_server_BallCallwGameID]
    (@session int,
    @GameID int,
	@BallCallType int,
	@GameName2 varchar(50)) --0  = regular; 1 = bonus
returns  nvarchar(max)
as
begin

if (@GameName2 = 'MayaMoney') set @GameName2 = 'Maya Money'
else if (@GameName2 = 'Time Bomb') set @GameName2 = 'TimeBomb'
--else if (@GameName2 = 'CrazyBout') set @GameName2 = 'Crazy Bout'

	declare @GameBallData2 table
   (ServerGameNumber int
        , DTStamp smalldatetime
        , GameTypeId int
        , GameTableName nvarchar(32)
        , GameName nvarchar(32)
        , GameBallCount int
        , GameBalls nvarchar(max)
        , BonusBallCount int
        , BonusBalls nvarchar(max)
        ,StaffID varchar(100))

    declare @GameBallData table
        (ServerGameNumber int
        , DTStamp smalldatetime
        , GameTypeId int
        , GameTableName nvarchar(32)
        , GameName nvarchar(32)
        , GameBallCount int
        , GameBalls nvarchar(max)
        , BonusBallCount int
        , BonusBalls nvarchar(max))

    declare @gameName varchar(100)
        , @tablePrefix varchar(32)
        , @ballCount int
        , @gameNumber int
        , @bonusBallCount int
        
    -- Gather all of the base game data
    insert into @GameBallData
        (ServerGameNumber
        , DTSTamp
        , GameTypeId
        , GameTableName
        , GameName
        , GameBallCount)
    select distinct
        sg.ServerGame
        , sg.DTStamp
        , sgj.GameTypeId
        , sgt.TableName
        , sgt.DisplayName
        , case when ConsolationBallIndex is null then 24 else (ConsolationBallIndex - 1) end -- Index is 1 based
        from Server_Game sg
            join Server_GameJournal sgj on sg.ServerGame = sgj.ServerGameNumber
            join Server_GameTypes sgt on sgj.GameTypeId = sgt.GameTypeId
        where SessionNumber = @session

    -- Gather all of the bonus game data to determine if a bonus game was played and
    --  how many balls were called 
    declare @BonusGames table
        (ServerGameNumber int
        , GameTypeId int
        , BallCount int)

    -- Find all of the Crazy Bout bonus games
    insert into @BonusGames
    select s.ServerGameNumber, s.GameTypeId, cb.bonuscallcount
        from CrazyBout_GameJournal cb
            join Server_GameJournal s on cb.gameNum = s.GameNumber
    where sessnum = @session and gametypeid = 36 and bonuscardsn_1 != 0 and bonusofferaccepted != 0
    group by s.ServerGameNumber, cb.bonusCallCount, s.GameTypeId
    


    -- Find all of the Jail Break bonus games
    insert into @BonusGames
    select s.ServerGameNumber, s.GameTypeId, jb.bonuscallcount
        from JailBreak_GameJournal jb
            join Server_GameJournal s on jb.gameNum = s.GameNumber
    where sessnum = @session and gametypeid = 37 and jb.bonuscardsn_1 != 0 and jb.bonusofferaccepted != 0
    group by s.ServerGameNumber, jb.bonuscallcount, s.GameTypeId
    
    -- update the bonus ball count in the results table
    update @GameBallData
    set BonusBallCount = bg.BallCount
    from @GameBallData gbd
        join @BonusGames bg on gbd.ServerGameNumber = bg.ServerGameNumber
    where gbd.ServerGameNumber = bg.ServerGameNumber and gbd.GameTypeId = bg.GameTypeId
    
    -- Use the cursor for generating a list of balls that were called and updating the
    --  results table.  This will convert the columns to a comma separated list of
    --  balls and update the appropriate columns in the results table
    declare ballList_cursor cursor for
    select ServerGameNumber, GameBallCount, BonusBallCount
    from @GameBallData
    order by ServerGameNumber
    
    declare @gameBalls nvarchar(max)
        , @bonusBalls nvarchar(max)
        , @sqlCommand nvarchar(max)
        , @parameters nvarchar(500)
    
    open ballList_cursor
    fetch next from ballList_cursor
    into @gameNumber, @ballCount, @bonusBallCount
    while @@fetch_status = 0
    begin
        
        -- empty the strings
        select @gameBalls = ''
            , @bonusBalls = ''
    
        -- Construct an sql command that will do the conversion
        set @parameters = '@gameBalls_Out nvarchar(500) output, @bonusBalls_Out nvarchar(500) output'
        set @sqlCommand = 'select @gameBalls_Out = '
                        + coalesce ('(' + dbo.b3_fnGetBallColumnList (@ballCount) + ')', '')
                        + coalesce (', @bonusBalls_Out = (' + dbo.b3_fnGetBallColumnList (@bonusBallCount) + ')', '')
                        + ' from Server_Game where ServerGame = '
                        + cast (@gameNumber as nvarchar)
                        
        exec sp_executesql @sqlCommand, @parameters, @gameBalls_Out = @gameBalls output, @bonusBalls_Out = @bonusBalls output;
        
        -- Now that the ball list has been created update the result table
        update @GameBallData
        set GameBalls = @gameBalls
            , BonusBalls = @bonusBalls
        where ServerGameNumber = @gameNumber 

        fetch next from ballList_cursor
        into @gameNumber, @ballCount, @bonusBallCount
    end
    close ballList_cursor
    deallocate ballList_cursor

--Is either B3 class II or Class III
if (select COUNT(*) from @GameBallData) != 0 --Class II
begin   insert into @GameBallData2
		(
				ServerGameNumber 
				, DTStamp 
				, GameTypeId 
				, GameName 
				, GameBallCount 
				, GameBalls 
				, BonusBallCount 
				, BonusBalls 
				,StaffID
		)
    select ServerGameNumber
        , DTStamp
        , GameTypeId
        , GameName
        , GameBallCount
        , GameBalls
        , BonusBallCount
        , BonusBalls
        ,'' as StaffID --Just for test
        

    from @GameBallData
    where ServerGameNumber = @GameID  and GameName = @GameName2
	order by ServerGameNumber   
end

else --Class III
begin

 insert into @GameBallData2
		(
				ServerGameNumber 
				, DTStamp 
				, GameTypeId 
				, GameName 
				, GameBallCount 
				, GameBalls 
				, BonusBallCount 
				, BonusBalls 
				,StaffID
		)
    select 
    ServerGameNumber ,
	DTStamp , 
	GameTypeID ,  
	GameName  ,                 
	GameBallCount ,
	GameBalls ,
	BonusBallCount ,
	BonusBalls,
	staff.UserName from  dbo.B3_fnGetBallCallB3_2(@session, @GameName2 , @GameID) x
	left join  dbo.B3_Login staff on staff.LoginID = x.StaffID 
	where ServerGameNumber = @GameID and GameName = @GameName2
	 order by ServerGameNumber    
end  

declare @result nvarchar(max) 
set @result = (select case when @BallCallType = 0 or GameName = 'Maya Money' then GameBalls else BonusBalls end as BallCall from @GameBallData2)

return @result
end


--declare 
--    @session int,
--    @GameID int,
--	@BallCallType int,
--	@GameName2 varchar(50) --0  = regular; 1 = bonus

--	set @session = 1008
--	set @GameID = 14
--	set @BallCallType = 0
--	set @GameName2 = 'WildFire'



GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRpt_B3_SessionReport_CrazyBingo_CardSales]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRpt_B3_SessionReport_CrazyBingo_CardSales]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create proc [dbo].[spRpt_B3_SessionReport_CrazyBingo_CardSales]
@SessNum int
as
select  denom,  betlevel,  sum(numofcards) as tnumofcards, (denom * betlevel) * sum(numofcards) tsales
from b3.dbo.CrazyBout_GameJournal
where sessnum = @SessNum
group by denom,  betlevel
order by denom, betlevel




GO
--===============================
--spRpt_B3_SessionReport_CrazyBingoCardSales START
--==============================
USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRpt_B3_SessionReport_CrazyBingoCardSales]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRpt_B3_SessionReport_CrazyBingoCardSales]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create proc [dbo].[spRpt_B3_SessionReport_CrazyBingoCardSales]
@SessNum int
as
select denom,  betlevel,  sum(numofcards) as tnumofcards, (denom * betlevel) * sum(numofcards) tsales
from b3.dbo.CrazyBout_GameJournal
where sessnum = @SessNum
group by denom,  betlevel
order by denom, betlevel

GO
--===============================
--spRpt_B3_SessionReport_CrazyBingoCardSales END
--==============================


USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRpt_B3_SessionReport_JailBreak_CardSales]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRpt_B3_SessionReport_JailBreak_CardSales]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





create proc [dbo].[spRpt_B3_SessionReport_JailBreak_CardSales]
@SessNum int
as
select denom,  betlevel,  sum(numofcards) as tnumofcards, (denom * betlevel) * sum(numofcards) tsales
from b3.dbo.JailBreak_GameJournal
where sessnum = @SessNum
group by denom,  betlevel
order by denom, betlevel




GO


USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRpt_B3_SessionReport_MayaMoney_CardSales]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRpt_B3_SessionReport_MayaMoney_CardSales]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create proc [dbo].[spRpt_B3_SessionReport_MayaMoney_CardSales]
@SessNum int
as
select denom,  betlevel,  sum(numofcards) as tnumofcards, (denom * betlevel) * sum(numofcards) tsales
from b3.dbo.MayaMoney_GameJournal
where sessnum = @SessNum
group by denom,  betlevel
order by denom, betlevel




GO
USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRpt_B3_SessionReport_Spirit76_CardSales]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRpt_B3_SessionReport_Spirit76_CardSales]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create proc [dbo].[spRpt_B3_SessionReport_Spirit76_CardSales]
@SessNum int
as
select denom,  betlevel,  sum(numofcards) as tnumofcards, (denom * betlevel) * sum(numofcards) tsales
from b3.dbo.Spirit76_GameJournal
where sessnum = @SessNum
group by denom,  betlevel
order by denom, betlevel




GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRpt_B3_SessionReport_TimeBomb_CardSales]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRpt_B3_SessionReport_TimeBomb_CardSales]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




create proc [dbo].[spRpt_B3_SessionReport_TimeBomb_CardSales]
@SessNum int
as
select denom,  betlevel,  sum(numofcards) as tnumofcards, (denom * betlevel) * sum(numofcards) tsales
from b3.dbo.TimeBomb_GameJournal
where sessnum = @SessNum
group by denom,  betlevel
order by denom, betlevel




GO


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


USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRpt_B3_SessionReport_WildBall_CardSales]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRpt_B3_SessionReport_WildBall_CardSales]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




create proc [dbo].[spRpt_B3_SessionReport_WildBall_CardSales]
@SessNum int
as
select denom,  betlevel,  sum(numofcards) as tnumofcards, (denom * betlevel) * sum(numofcards) tsales
from b3.dbo.WildBall_GameJournal
where sessnum = @SessNum
group by denom,  betlevel
order by denom, betlevel





GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRpt_B3_SessionReport_WildFire_CardSales]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRpt_B3_SessionReport_WildFire_CardSales]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




create proc [dbo].[spRpt_B3_SessionReport_WildFire_CardSales]
@SessNum int
as
select denom,  betlevel,  sum(numofcards) as tnumofcards, (denom * betlevel) * sum(numofcards) tsales
from b3.dbo.WildFire_GameJournal
where sessnum = @SessNum
group by denom,  betlevel
order by denom, betlevel




GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRptBallCallSet]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRptBallCallSet]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO





                    create proc [dbo].[spRptBallCallSet]
                    (@StartDate smalldatetime, @EndDate smalldatetime)
                    as

                    -- =======================================
                    -- Author: Karlo Camacho
                    -- Date: 4/2/2013
                    -- Note: This report will report the Ball Call set every session 
					-- 20160303(knc) : Remove duplicate session.
                    -- ======================================

                    -->>>>>>>>>>>>>>>>>TEST<<<<<<<<<<<<<<<<<<<<<<
                    --declare 
                    --@StartDate smalldatetime, @EndDate smalldatetime
                    --set @StartDate = '4/4/2013 00:00:00'
                    --set @EndDate = '4/4/2013 00:00:00'
                    -->>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<

 
                      declare @BallCallSet_cte table
                     (  SessNum int, SessStart smalldatetime, SessEnd smalldatetime, OperatorID int, OperatorName varchar(100),
                     BallCallSet varchar(max) , BonusBallCallSet varchar(100), UserID int)
 
 
                    ;with BallCallSet_cte 
                    (
                     SessNum, SessStart, SessEnd, OperatorID, OperatorName,
                     BallCallSet, BonusBallCallSet, UserID
       
                    ) 
                    as 
                    (select BCLPS.SessNum, y.SessStart, y.SessEnd, y.operatorID, y.OperatorName, 
                     convert (char(2), BCLPS.[ball_1])        +'	 '
                          + convert (char(2), BCLPS.[ball_2]) +'	 '
                          + convert (char(2), BCLPS.[ball_3]) +'	 '
                          + convert (char(2), BCLPS.[ball_4]) +'	 '
                          + convert (char(2), BCLPS.[ball_5]) +'	 '
                          + convert (char(2), BCLPS.[ball_6]) +'	 '
                          + convert (char(2), BCLPS.[ball_7]) +'	 '
                          + convert (char(2), BCLPS.[ball_8]) +'	 '
                          + convert (char(2), BCLPS.[ball_9]) +'	 '
                          + convert (char(2), BCLPS.[ball_10])+'	 '
                          + convert (char(2), BCLPS.[ball_11])+'	 '
                          + convert (char(2), BCLPS.[ball_12])+'	 '
                          + convert (char(2), BCLPS.[ball_13])+'	 '
                          + convert (char(2), BCLPS.[ball_14])+'	 '
                          + convert (char(2), BCLPS.[ball_15])+'	 '
                          + convert (char(2), BCLPS.[ball_16])+'	 '
                          + convert (char(2), BCLPS.[ball_17])+'	 '
                          + convert (char(2), BCLPS.[ball_18])+'	 '
                          + convert (char(2), BCLPS.[ball_19])+'	 '
                          + convert (char(2), BCLPS.[ball_20])+'	 '
                          + convert (char(2), BCLPS.[ball_21])+'	 '
                          + convert (char(2), BCLPS.[ball_22])+'	 '
                          + convert (char(2), BCLPS.[ball_23])+'	 '
                          + convert (char(2), BCLPS.[ball_24]) [BallCallSet],
                            convert (char(2), BCLPS.[ball_25])+'	 '
                          + convert (char(2), BCLPS.[ball_26])+'	 '
                          + convert (char(2), BCLPS.[ball_27])+'	 '
                          + convert (char(2), BCLPS.[ball_28])+'	 '
                          + convert (char(2), BCLPS.[ball_29])+'	 '
                          + convert (char(2), BCLPS.[ball_30]) [BonusBallCallSet],
						  BCLPS.LoginID
                     from dbo.B3_BallCallLogPerSession BCLPS
                     join dbo.B3_SessionsJournal y on y.sessnum = BCLPS.sessnum
                     where 
                     (CAST(CONVERT(varchar(12), y.sessstart, 101) AS SMALLDATETIME) >= CAST(CONVERT(varchar(12), @StartDate, 101) AS SMALLDATETIME)
                     and  CAST(CONVERT(varchar(12), y.sessend, 101) AS SMALLDATETIME) <= CAST(CONVERT(varchar(12), @EndDate, 101) AS SMALLDATETIME) )
					 and BCLPS.sessactive = 'T'

					 )
                     insert into @BallCallSet_cte
                     select * from BallCallSet_cte;
 

                     select       SessNum, SessStart, SessEnd, OperatorID, OperatorName,
                     BallCallSet, BonusBallCallSet, staff.UserName as UserID
					 from @BallCallSet_cte left  join B3_Login staff on staff.LoginID = UserID
					 order by SessNum asc

			




GO


USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRptPayouts]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRptPayouts]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





--exec spRptPayouts 1041

CREATE proc [dbo].[spRptPayouts]

-- =======================================
-- Author:			Travis Pollock
-- Date:			8/22/2014
-- User Story:		3607
-- 20150910(knc):	Changed the final result if its North Dakota then show all account number else then masked the first 4 character.	
-- 20151129(knc): Add another actual card that won the game
-- ======================================

@SessionNum int

as


Declare @Results table
(
		SessNum int,
		GameNum	int,
		ServerGameNum int,
		GameDate DateTime,
		GameName varchar(32),
		PayoutType varchar(32),
		ClientName char(11),
		CreditAcctNum int,
		Denom money,
		BetLevel int,
		NumberWinners int,
		WinAmount money,
		PatternName varchar(32)
)


declare @GameDef table
(
GameID int,
GameName varchar(50),
GameNameDB varchar(50)
)

insert into @GameDef (GameID, GameName, GameNameDB) values (36, 'Crazy Bout', 'CrazyBout') --CRAZY BOUT
insert into @GameDef (GameID, GameName, GameNameDB) values (37, 'Jailbreak', 'Jailbreak') 
insert into @GameDef (GameID, GameName, GameNameDB) values (38, 'Maya Money', 'MayaMoney') 
insert into @GameDef (GameID, GameName, GameNameDB) values (-1, 'Spirit76', 'Spirit76') 
insert into @GameDef (GameID, GameName, GameNameDB) values (-2, 'UkickEm', 'UkickEm') 
insert into @GameDef (GameID, GameName, GameNameDB) values (-3, 'Wild Ball', 'WildBall') 
insert into @GameDef (GameID, GameName, GameNameDB) values (-4, 'Time Bomb', 'TimeBomb') 
insert into @GameDef (GameID, GameName, GameNameDB) values (-5, 'Wild Fire', 'WildFire') --Need to research on how do you win on this game.

IF OBJECT_ID('tempdb..#Results') IS not null drop table #Results
create  table #Results
(
		SessNum int,
		GameNum	int,
		ServerGameNum int,
		GameDate DateTime,
		GameName varchar(32),
		PayoutType varchar(32),
		ClientName char(11),
		CreditAcctNum int,
		Denom money,
		BetLevel int,
		NumberWinners int,
		WinAmount money,
		PatternName varchar(32)
)

declare GameDefCursor cursor for --Loop each game
select GameID, GameName, GameNameDB from @GameDef

declare @GameID int , @GameName2 varchar(50), @GameNameDB varchar(50)
open GameDefCursor fetch next from GameDefCursor into @GameID, @GameName2, @GameNameDB

while @@FETCH_STATUS = 0
begin

	declare @SqlCommand nvarchar(2000)
	declare @ColumnName varchar(20) set @ColumnName = 'patt_'-- + cast(2 as varchar(2))
	declare @Count int set @Count = 1;

	if (@GameID = -2)--UkickEm
	begin
		set @SqlCommand = 'insert into #Results
				(
						SessNum,
						GameNum,
						ServerGameNum,
						GameDate,
						GameName,
						PayoutType,
						ClientName,
						CreditAcctNum,
						Denom,
						BetLevel,
						NumberWinners,
						WinAmount,
						PatternName	
				)
			Select	
			cb.sessnum
			,cb.gamenum
			,(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = '+ cast(@GameID as varchar(10)) +') as ServerGameNum
			,cb.recdatetime
			,'''+ @GameName2 +'''
			,''Regular''
			,cb.clientname
			,cb.creditacctnum
			,(cb.denom/100.0)
			,cb.betlevel
			,1 as numofwins -- Always 1
			,cb.totalpaidamt/100.0 as winamt
			,''Catch '' + CAST (cb.numofhits as varchar(10))
			From dbo.UKickEm_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
			Where sj.sessnum = '+ cast(@SessionNum as varchar(10))  +'
			and cb.totalpaidamt <> 0'
	

		exec (@SqlCommand)
		fetch next from GameDefCursor into @GameID, @GameName2,  @GameNameDB
			continue -- Go tothe next gameID
	end

--select @GameName2

	-- Insert Extra Bonud game winners
	if (@GameID != -4 )--Skip TimeBomb
	begin
		set @SqlCommand = 'insert into #Results
				(
						SessNum,
						GameNum,
						ServerGameNum,
						GameDate,
						GameName,
						PayoutType,
						ClientName,
						CreditAcctNum,
						Denom,
						BetLevel,
						NumberWinners,
						WinAmount,
						PatternName	
				)
				Select	cb.sessnum,
			cb.gamenum,
			(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = '+ cast(@GameID as varchar(10)) +'),
			cb.recdatetime,'''+ @GameName2 +''',''Extra Bonus'',
			cb.clientname,
			cb.creditacctnum,
			(cb.Denom / 100.00),
			cb.BetLevel,
			1,
			(cb.gamewinamt / 100.00),
			''Coverall''
			From '+ @GameNameDB +'_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
			Where sj.sessnum = ' + cast(@SessionNum as varchar(10))  +'
			And cb.gamewinamt != 0
			And cb.numofwins_patt_1 = 0
			And cb.numofwins_patt_2 = 0
			And cb.numofwins_patt_3 = 0
			And cb.numofwins_patt_4 = 0
			And cb.numofwins_patt_5 = 0
			And cb.numofwins_patt_6 = 0
			And cb.numofwins_patt_7 = 0
			And cb.numofwins_patt_8 = 0
			And cb.numofwins_patt_9 = 0
			And cb.numofwins_patt_10 = 0
			And cb.numofwins_patt_11 = 0
			And cb.numofwins_patt_12 = 0'

		exec (@SqlCommand)
	end
	else
	if (@GameID = -4)
	begin
				set @SqlCommand = 'insert into #Results
				(
						SessNum,
						GameNum,
						ServerGameNum,
						GameDate,
						GameName,
						PayoutType,
						ClientName,
						CreditAcctNum,
						Denom,
						BetLevel,
						NumberWinners,
						WinAmount,
						PatternName	
				)
				Select	cb.sessnum,
			cb.gamenum,
			(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = '+ cast(@GameID as varchar(10)) +'),
			cb.recdatetime,'''+ @GameName2 +''',''Extra Bonus'',
			cb.clientname,
			cb.creditacctnum,
			(cb.Denom / 100.00),
			cb.BetLevel,
			1,
			(cb.gamewinamt / 100.00),
			''Coverall''
			From '+ @GameNameDB +'_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
			Where sj.sessnum = ' + cast(@SessionNum as varchar(10))  +'
			And cb.gamewinamt != 0
			And cb.numofwins_patt_1 = 0
			And cb.numofwins_patt_2 = 0
			And cb.numofwins_patt_3 = 0
			And cb.numofwins_patt_4 = 0
			And cb.numofwins_patt_5 = 0
			And cb.numofwins_patt_6 = 0'
	

		exec (@SqlCommand)
	end


	if (@GameID != -4 )
	begin
		while (@Count != 13)
		begin

			declare @ColumnName_ nvarchar(10)
			declare @PatterId nvarchar(10)

			set @ColumnName_  =  @ColumnName + cast(@Count as varchar(2))
			set @PatterId = cast(@Count as varchar(2))
			
				--Insert  Instant Winners
				set @SqlCommand =  
				'insert into #Results
				(
						SessNum,
						GameNum,
						ServerGameNum,
						GameDate,
						GameName,
						PayoutType,
						ClientName,
						CreditAcctNum,
						Denom,
						BetLevel,
						NumberWinners,
						WinAmount,
						PatternName
			
				)
				Select	cb.sessnum,
						cb.gamenum,
						(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = '+ cast(@GameID as varchar(10)) +'),
						cb.recdatetime,'''+ @GameName2 +'''  ,''Regular'',
						cb.clientname,
						cb.creditacctnum,
						(cb.denom / 100.0),
						cb.betlevel,
						cb.numofwins_' + @ColumnName_ + ',
						((cb.winamt_' + @ColumnName_ + ' / cb.numofwins_' + @ColumnName_ +') / 100.0),
						(Select patternname from '+ @GameNameDB +'_GamePatterns where patternid = '+ @PatterId + ')
				From '+ @GameNameDB +'_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
				Where sj.sessnum = '+ cast(@SessionNum as varchar(10))  +'
				And cb.numofwins_' +  @ColumnName_ + ' <> 0
				And cb.winamt_' + @ColumnName_ +  '  <> 0'

				exec (@SqlCommand)

				--Insert  Bonus Round Winners
				if (@GameID != 38 And @GameID != -5 )
				begin
					set @SqlCommand =	'Insert into #Results
					(
							SessNum,
							GameNum,
							ServerGameNum,
							GameDate,
							GameName,
							PayoutType,
							ClientName,
							CreditAcctNum,
							Denom,
							BetLevel,
							NumberWinners,
							WinAmount,
							PatternName
			
					)
					Select	cb.sessnum,
							cb.gamenum,
							(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = '+ cast(@GameID as varchar(10)) +'),
							cb.recdatetime,'''+ @GameName2 +''',''Bonus'',
							cb.clientname,
							cb.creditacctnum,
							(cb.denom / 100.0),
							cb.betlevel,
							cb.numofwins_bonus'+ @ColumnName_ + ',
							((cb.bonuswinamt_'+ @ColumnName_ + ' / cb.numofwins_bonus' + @ColumnName_ + ') / 100.0),
							(Select patternname from '+ @GameNameDB +'_BonusPatterns where patternid = '+ @PatterId +')
					From '+ @GameNameDB +'_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
					Where sj.sessnum = '+ cast(@SessionNum as varchar(10))  +'
					And cb.numofwins_bonus' + @ColumnName_ + ' <> 0
					And cb.bonuswinamt_' + @ColumnName_ + ' <> 0'

					exec (@SqlCommand)
				end

				set @Count = @Count + 1
			end--While
		end
		else
		if (@GameID = -4)--TimeBomb
		begin
		while (@Count != 7)
		begin

			--declare @ColumnName_ nvarchar(10)
			--declare @PatterId nvarchar(10)

			set @ColumnName_  =  @ColumnName + cast(@Count as varchar(2))
			set @PatterId = cast(@Count as varchar(2))
			
				--Insert Crazy Bout Bingo Instant Winners
				set @SqlCommand =  
				'insert into #Results
				(
						SessNum,
						GameNum,
						ServerGameNum,
						GameDate,
						GameName,
						PayoutType,
						ClientName,
						CreditAcctNum,
						Denom,
						BetLevel,
						NumberWinners,
						WinAmount,
						PatternName
			
				)
				Select	cb.sessnum,
						cb.gamenum,
						(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = '+ cast(@GameID as varchar(10)) +'),
						cb.recdatetime,'''+ @GameName2 +'''  ,''Regular'',
						cb.clientname,
						cb.creditacctnum,
						(cb.denom / 100.0),
						cb.betlevel,
						cb.numofwins_' + @ColumnName_ + ',
						((cb.winamt_' + @ColumnName_ + ' / cb.numofwins_' + @ColumnName_ +') / 100.0),
						(Select patternname from '+ @GameNameDB +'_GamePatterns where patternid = '+ @PatterId + ')
				From '+ @GameNameDB +'_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
				Where sj.sessnum = '+ cast(@SessionNum as varchar(10))  +'
				And cb.numofwins_' +  @ColumnName_ + ' <> 0
				And cb.winamt_' + @ColumnName_ +  '  <> 0'

				exec (@SqlCommand)
				--print cast(@Count as varchar(10))
				set @Count = @Count + 1
			end--While
		
		end
		
		fetch next from GameDefCursor into @GameID, @GameName2,  @GameNameDB

end


insert into @Results 
select SessNum,
		GameNum,
		ServerGameNum,
		GameDate,
		GameName,
		PayoutType,
		ClientName,
		CreditAcctNum,
		Denom,
		BetLevel,
		NumberWinners,
		WinAmount,
		PatternName from #Results

drop table #Results



---------- Insert MayaMoney Bonus Wins ------------------------------------
Insert into @Results
(
		SessNum,
		GameNum,
		ServerGameNum,
		GameDate,
		GameName,
		PayoutType,
		ClientName,
		CreditAcctNum,
		Denom,
		BetLevel,
		NumberWinners,
		WinAmount
		
)
Select	mm.sessnum,
		mm.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = mm.gamenum and sgj.GameTypeID = 38 /* MayaMoney */ ),
		mm.recdatetime,
		'Maya Money',
		'Bonus',
		mm.clientname,
		mm.creditacctnum,
		(mm.denom / 100.0),
		mm.betlevel,
		1,
		(mm.gamewinamt - (winamt_patt_1 + winamt_patt_2 + winamt_patt_3 + winamt_patt_4 + winamt_patt_5 + winamt_patt_6 + winamt_patt_7 + winamt_patt_8 + winamt_patt_9 +
                       winamt_patt_10 + winamt_patt_11 + winamt_patt_12)) / 100.0
From MayaMoney_GameJournal mm join B3_SessionsJournal sj on mm.sessnum = sj.sessnum
join MayaMoney_GamePayTable mmgp on mm.denom = mmgp.denom
Where sj.sessnum = @SessionNum
And ((gamewinamt <> winamt_patt_1 + winamt_patt_2 + winamt_patt_3 + winamt_patt_4 + winamt_patt_5 + winamt_patt_6 + winamt_patt_7 + winamt_patt_8 +
                       winamt_patt_9 + winamt_patt_10 + winamt_patt_11 + winamt_patt_12) AND (winamt_patt_1 + winamt_patt_2 + winamt_patt_3 + winamt_patt_4 + winamt_patt_5 + winamt_patt_6 + winamt_patt_7 + winamt_patt_8 + winamt_patt_9 +
                       winamt_patt_10 + winamt_patt_11 + winamt_patt_12 <> 0))


declare @Result2 table
(
	SessNum int,
		GameNum	int,
		ServerGameNum int,
		GameDate DateTime,
		GameName varchar(32),
		PayoutType varchar(32),
		ClientName char(11),
		CreditAcctNum varchar(100),
		Denom money,
		BetLevel int,
		NumberWinners int,
		WinAmount money,
		PatternName varchar(32),
		WinningCardNumber nvarchar(4000)
)


--Final result if it is North Dakota then show all the account number else mask the first 4 character.
if ((select IsNorthDakota from B3_SystemConfig ) = 'T')
begin
insert into @Result2 
(
SessNum ,
		GameNum	,
		ServerGameNum ,
		GameDate ,
		GameName ,
		PayoutType ,
		ClientName ,
		CreditAcctNum ,
		Denom ,
		BetLevel ,
		NumberWinners ,
		WinAmount ,
		PatternName 
)
Select 
		SessNum ,
		GameNum	,
		ISNULL(ServerGameNum ,Gamenum) ServerGameNum,
		GameDate ,
		GameName ,
		PayoutType ,
		ClientName ,
		case 
		when  len(CreditAcctNum) = 1 then '0000000'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 2 then '000000'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 3 then '00000'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 4 then '0000'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 5 then '000'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 6 then '00'+CAST(CreditAcctNum AS varchar(10)) 
		when  len(CreditAcctNum) = 7 then '0'+CAST(CreditAcctNum AS varchar(10)) 
		else
		CAST(CreditAcctNum AS varchar(10)) 
		end as CreditAcctNum
		 ,
		Denom ,
		BetLevel ,
		NumberWinners ,
		WinAmount, 
		PatternName 
					--(select dbo.B3_fnGetWinningCardNumber(PatternName, SessNum, 1, GameNum ))  as WinningCardNumber  
From @Results
Group By SessNum, GameNum, ServerGameNum, GameDate, GameName, PayoutType, CreditAcctNum, ClientName, Denom, BetLevel, WinAmount, NumberWinners, PatternName --, GameWinAmt, BonusWinAmt, TotalPaidAmt
Order By ServerGameNum
end
else
begin

insert into @Result2 
(
		SessNum ,
		GameNum	,
		ServerGameNum ,
		GameDate ,
		GameName ,
		PayoutType ,
		ClientName ,
		CreditAcctNum ,
		Denom ,
		BetLevel ,
		NumberWinners ,
		WinAmount ,
		PatternName 
)
Select 
		SessNum ,
		GameNum	,
		ISNULL(ServerGameNum ,Gamenum) ServerGameNum,
		GameDate ,
		GameName ,
		PayoutType ,
		ClientName ,
		case 
		when  len(CreditAcctNum) = 1 then 'xxxx000'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 2 then 'xxxx00'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 3 then 'xxxx0'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) >= 4 then 'xxxx'+ Substring(CAST(CreditAcctNum AS varchar(10)),4,8)
		end as CreditAcctNum
		 ,
		Denom ,
		BetLevel ,
		NumberWinners ,
		WinAmount, 
		PatternName
		--(select dbo.B3_fnGetWinningCardNumber(PatternName, SessNum, 1, GameNum ))  as WinningCardNumber
From @Results 
Group By SessNum, GameNum, ServerGameNum, GameDate, GameName, PayoutType, CreditAcctNum, ClientName, Denom, BetLevel, WinAmount, NumberWinners, PatternName --, GameWinAmt, BonusWinAmt, TotalPaidAmt
Order By ServerGameNum
end

select 
		SessNum,
		GameNum	,
		ServerGameNum ,
		GameDate ,
		GameName ,
		PayoutType ,
		ClientName ,
		CreditAcctNum ,
		Denom ,
		BetLevel ,
		NumberWinners ,
		WinAmount ,
		PatternName ,
		WinningCardNumber
		from @Result2

GO



			

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_rptGetWinningCardNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_rptGetWinningCardNumber]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE proc [dbo].[usp_management_rptGetWinningCardNumber]
(

@PatterName varchar(100),
@SessionNumber int, 
@BallCallType int, --0 regular; 1 = bonus
@GameID int,
@GameName varchar(50),
 @WinningCardNumber3 varchar(500) output

)
as
begin

declare @RangeWinCardNumber varchar(500)
declare @Pattern table (Design varchar(100))
declare @WinningNumber varchar(50) set @WinningNumber = ''
declare @result int 
declare @tempValue varchar(50)
DECLARE @command nvarchar(4000);
DECLARE @ParmDefinition nvarchar(500);
declare @Exists bit 
declare @BallCall varchar(1000)
declare @m_CardN int
declare @WinnerCount int set @WinnerCount = 0
declare @TempN nvarchar(10)
declare @TempWinningCardNumber int
declare @C_Card nvarchar(100)
declare @TempCardNumber varchar(10)
declare @result2 int

--For Mayamoney Bonus round
declare @PreviousCardWinner int
declare @CountPreviousCardWinner int set @CountPreviousCardWinner = 0
declare @GameName2 nvarchar(50) set @GameName2 = ''


if (@PatterName is null or @PatterName = 'NULL')
begin
	set @PatterName = ''
end

if (@GameName = 'Maya Money')
begin 
	set @GameName2 = 'MayaMoney'
end
else
if (@GameName = 'Jailbreak')
begin
	set @GameName2 = 'JailBreak'
end
else 
if (@GameName = 'Crazy Bout')
begin
	set @GameName2 = 'CrazyBout'
end
else
if (@GameName = 'Spirit76')
begin
	set @GameName2 = 'Spirit76'
end
else
if (@GameName = 'UkickEm')
begin
	set @GameName2 = 'UkickEm'
end
else
if (@GameName = 'Wild Ball')
begin
	set @GameName2 = 'WildBall'
end
else
if (@GameName = 'Time Bomb')
begin
	set @GameName2 = 'TimeBomb'
end
else
if (@GameName = 'Wild Fire')
begin
	set @GameName2 = 'WildFire'
end

set  @WinningCardNumber3 = '';
set @Exists = 1
set @WinningNumber = ''
exec dbo.usp_management_GetWinningCardNumber2 @SessionNumber, @GameID, @BallCallType, @GameName2,  @RangeWinCardNumber output	
set @BallCall = (select dbo.B3fn_server_BallCallwGameID(@SessionNumber, @GameID, @BallCallType, @GameName))
set @BallCall = ','+ @BallCall+',0,' set @BallCall = REPLACE(@BallCall,' ','')
set @C_Card = @RangeWinCardNumber 
set @C_Card = REPLACE(@C_Card,' ','')+',' 
set @result2 = (select CHARINDEX(',',@C_Card))

		while (@result2 != 0 and len(@C_Card) > 1)
		begin	
					 set @TempCardNumber = SUBSTRING(@C_Card, 0, @result2) 
					 set @m_CardN = cast(@TempCardNumber as int)
					 
		
					 
					 declare @dub1 int, @dub2 int, @dub3 int, @dub4 int, @dub5 int, @dub6 int, @dub7 int, @dub8 int, @dub9 int 		
					declare @count2 int , @count int	
					declare @TempPattern varchar(100)	
					
					 if (@PatterName = 'Explosion')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|5|7|9|11|13|15|17|19|21|25|' )
							insert into @Pattern  values ('1|3|5|7|9|13|17|19|21|23|25|' )
							insert into @Pattern  values ('1|3|7|9|11|13|15|17|19|23|25|')
							insert into @Pattern  values ('3|5|7|9|11|13|15|17|19|21|23|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output	
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))						
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
							
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						else
					 if (@PatterName = 'Bomb')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('8|9|11|12|13|14|18|19|' )
							insert into @Pattern  values ('6|8|9|12|13|14|18|19|' )
							insert into @Pattern  values ('8|9|12|13|14|16|18|19|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output	
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))						
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
							
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						else
					   if (@PatterName = 'Fuse')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('7|9|13|17|19|' )
							insert into @Pattern  values ('1|5|13|21|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output	
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))						
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
							
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
					else
					   if (@PatterName = 'Minute Hand')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|2|3|8|13|18|23|' )
							insert into @Pattern  values ('11|12|13|14|15|16|21|' )
							insert into @Pattern  values ('3|8|13|18|23|24|25|' )
							insert into @Pattern  values ('5|10|11|12|13|14|15|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output	
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))						
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
							
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						else
					    if (@PatterName = 'Second Hand')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('3|8|12|13|' )
							insert into @Pattern  values ('11|12|13|18|' )
							insert into @Pattern  values ('13|14|18|23|' )
							insert into @Pattern  values ('8|13|14|15|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output	
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))						
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
							
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
					else
					    if (@PatterName = 'Tiny Pyramid')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('3|7|8|13|' )
							insert into @Pattern  values ('8|12|13|18|' )
							insert into @Pattern  values ('13|17|18|23|' )


							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output	
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))						
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
							
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
									 
						else if (@PatterName = 'Any Line')
						begin
						    delete from @Pattern
							insert into @Pattern  values ('1|6|11|16|21|' )
							insert into @Pattern  values ('2|7|12|17|22|' )
							insert into @Pattern  values ('3|8|13|18|23|' )
							insert into @Pattern  values ('4|9|14|19|24|' )
							insert into @Pattern  values ('5|10|15|20|25|' )
							insert into @Pattern  values ('1|2|3|4|5|' )
							insert into @Pattern  values ('6|7|8|9|10|' )
							insert into @Pattern  values ('11|12|13|14|15|' )
							insert into @Pattern  values ('16|17|18|19|20|' )
							insert into @Pattern  values ('21|22|23|24|25|' )
							insert into @Pattern  values ('5|9|13|17|21|' )
							insert into @Pattern  values ('1|7|13|19|25|' )
	
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end

						else if (@PatterName = 'Crazy Stamp' Or @PatterName = 'Cellblock 4')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|2|6|7|' )
							insert into @Pattern  values ('16|17|21|22|' )
							insert into @Pattern  values ('4|5|9|10|' )
							insert into @Pattern  values ('19|20|24|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end

								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor
						end
						--	else if (@PatterName = 'Any Six Pack')
						--begin
				
						--	delete from @Pattern

						--	--insert into @Pattern  values ('3|7|8|13|' )
						--	--insert into @Pattern  values ('8|12|13|18|' )
						--	--insert into @Pattern  values ('13|17|18|23|' )


						--	declare Pattern_Cursor cursor
						--	for 
						--	select /*@tempValue =8*/ Design from @Pattern
						--	open Pattern_Cursor
						--	fetch next from Pattern_Cursor into @tempValue

						--	while @@FETCH_STATUS = 0
						--	begin

						--		set @result = (select CHARINDEX('|',@tempValue))


						--		while (@result != 0 and @Exists =1)
						--		begin

						--			set @TempN = SUBSTRING(@tempValue, 0, @result) 	
						--			exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
						--			set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
						--			set @result = (select CHARINDEX('|',@tempValue))

						--		end


						--		if (@Exists = 1)--WINNER
						--		begin
						--			 --select cast(@m_CardN as varchar(10))
						--			set @WinnerCount = @WinnerCount + 1
						--			set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
						--		end
		
						--		set @Exists = 1
						--		fetch next from Pattern_Cursor into @tempValue

						--	end 

						--	close Pattern_Cursor
						--	deallocate Pattern_Cursor

						--end
							else if (@PatterName = 'Four Corners')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|5|21|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
					 	else if (@PatterName = 'Small X')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('7|9|13|17|19|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Flower')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('8|12|13|14|18|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Star')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('3|11|13|15|23|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Pyramid')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('3|7|8|11|12|13|17|18|23' )
							insert into @Pattern  values ('4|8|9|12|13|14|18|19|24' )
							insert into @Pattern  values ('5|9|10|13|14|15|19|20|25' )


							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Steps')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|2|7|8|13|14|19|20|25|' )
							insert into @Pattern  values ('5|9|10|13|14|17|18|21|22|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Sun')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('2|4|6|7|9|10|13|16|17|19|20|22|24|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Great Pyramid')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('5|8|9|10|11|12|13|14|15|18|19|20|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Small Crazy Kite')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|2|6|7|13|19|25|' )
							insert into @Pattern  values ('5|9|13|16|17|21|22|' )
							insert into @Pattern  values ('1|7|13|19|20|24|25|' )
							insert into @Pattern  values ('4|5|9|10|13|17|21|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						else if (@PatterName = 'Block of 9')
						begin
				
							delete from @Pattern
							
							--declare @dub1 int, @dub2 int, @dub3 int, @dub4 int, @dub5 int, @dub6 int, @dub7 int, @dub8 int, @dub9 int 
							set @dub1 = 1 set @dub2 = 2 set @dub3 = 3 set @dub4 = 6 set @dub5 = 7 set @dub6 = 8 set @dub7 = 11 set @dub8 = 12 set @dub9 = 13
							
							--declare  @count int 
							set @count= 0 
							while (@count != 3)
							begin
								--declare @TempPattern varchar(100)
								set @TempPattern =  cast(@dub1 + @count  as varchar(10))+'|'
													+cast(@dub2 + @count  as varchar(10))+'|'
													+cast(@dub3 + @count  as varchar(10))+'|'
													+cast(@dub4 + @count  as varchar(10))+'|'
													+cast(@dub5 + @count  as varchar(10))+'|'
													+cast(@dub6 + @count  as varchar(10))+'|'
													+cast(@dub7 + @count  as varchar(10))+'|'
													+cast(@dub8 + @count  as varchar(10))+'|'
													+cast(@dub9 + @count  as varchar(10))+'|'
								
								insert into @Pattern  values(@TempPattern)
								--declare @count2 int 
								set @count2 = 5
								while (@count2 != 15)
								begin
								set @TempPattern =  cast(@dub1 + @count2 + @count  as varchar(10))+'|'
													+cast(@dub2 + @count2 + @count as varchar(10))+'|'
													+cast(@dub3 + @count2 + @count as varchar(10))+'|'
													+cast(@dub4 + @count2 + @count as varchar(10))+'|'
													+cast(@dub5 + @count2 + @count as varchar(10))+'|'
													+cast(@dub6 + @count2 + @count as varchar(10))+'|'
													+cast(@dub7 + @count2 + @count as varchar(10))+'|'
													+cast(@dub8 + @count2 + @count as varchar(10))+'|'
													+cast(@dub9 + @count2 + @count as varchar(10))+'|'
												
													insert into @Pattern  values(@TempPattern)
													set @count2 = @count2 + 5
								end
								set @count2 = 0
						
								set @count = @count + 1
							end
				

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Crazy T')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|6|11|12|13|14|15|16|21|' )
							insert into @Pattern  values ('3|8|13|18|21|22|23|24|25|' )
							insert into @Pattern  values ('5|10|11|12|13|14|15|20|25|' )
							insert into @Pattern  values ('1|2|3|4|5|8|13|18|23|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						else if (@PatterName = 'Letter X')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|5|7|9|13|17|19|21|25|' )
				

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end

						else if (@PatterName = 'Large Diamond')
						begin
				
							delete from @Pattern

						   insert into @Pattern  values ('3|7|9|11|15|17|19|23|' )
						   insert into @Pattern  values ('3|7|8|9|11|12|13|14|15|17|18|19|23|' )--For 76 Bingo

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Small Frame')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('7|8|9|12|14|17|18|19|' )
				

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						else if (@PatterName = 'Large Frame')
						begin
				
							delete from @Pattern
						   insert into @Pattern  values ('1|2|3|4|5|6|10|11|15|16|20|21|22|23|24|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						else if (@PatterName = 'Crazy L')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|2|3|4|5|10|15|20|25|' )
							insert into @Pattern  values ('1|2|3|4|5|6|11|16|21|' )
							insert into @Pattern  values ('1|6|11|16|21|22|23|24|25|' )
							insert into @Pattern  values ('5|10|15|20|25|21|22|23|24|' )
				

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end

						else if (@PatterName = 'Crazy Love Letter')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|2|3|4|5|10|15|20|25|21|' )
							insert into @Pattern  values ('1|2|3|4|5|6|11|16|21|25|' )
							insert into @Pattern  values ('1|6|11|16|21|22|23|24|25|5|' )
							insert into @Pattern  values ('5|10|15|20|25|21|22|23|24|1|' )
				
							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						else if (@PatterName = 'Four Brackets')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|2|4|5|6|10|16|20|21|22|24|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end

								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'The Yard')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|5|21|25|')
							insert into @Pattern  values ('3|11|15|23|')
							insert into @Pattern  values ('7|9|17|19|')
							insert into @Pattern  values ('8|12|14|18|')
						

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'File')
						begin
						    delete from @Pattern
				
							insert into @Pattern  values ('11|12|13|14|15|' )
							insert into @Pattern  values ('3|8|13|18|23|' )
							insert into @Pattern  values ('5|9|13|17|21|' )
							insert into @Pattern  values ('1|7|13|19|25|' )
	
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
					else if (@PatterName =  'Cellblock 6')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|2|3|6|7|8|' )
							insert into @Pattern  values ('16|17|18|21|22|23|' )
							insert into @Pattern  values ('3|4|5|8|9|10|' )
							insert into @Pattern  values ('18|19|20|23|24|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end

								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor
						end
						
							else if (@PatterName =  'Cellblock 8')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|2|3|4|6|7|8|9|' )
							insert into @Pattern  values ('16|17|18|19|21|22|23|24|' )
							insert into @Pattern  values ('2|3|4|5|7|8|9|10|' )
							insert into @Pattern  values ('17|18|19|20|22|23|24|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end

								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor
						end
					else if (@PatterName =  'Cellblock 9')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|2|3|6|7|8|11|12|13|' )
							insert into @Pattern  values ('11|12|13|16|17|18|21|22|23|' )
							insert into @Pattern  values ('3|4|5|8|9|10|13|14|15|' )
							insert into @Pattern  values ('13|14|15|18|19|20|23|24|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end

								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor
						end
						else if (@PatterName = 'Bars')
						begin
						    delete from @Pattern
				
							insert into @Pattern  values ('2|4|11|12|13|14|15|22|24|' )
							insert into @Pattern  values ('3|6|8|10|13|16|18|20|23|' )

	
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						
						else if (@PatterName = 'Key')
						begin
						    delete from @Pattern
				
							
							insert into @Pattern  values ('2|3|4|7|8|9|13|18|23|24|' )
							insert into @Pattern  values ('3|4|8|13|17|18|19|22|23|24' )
				
	
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						
						else if (@PatterName = 'Cot')
						begin
						    delete from @Pattern
				
							
							insert into @Pattern  values ('2|3|4|9|10|14|19|20|24|' )
							insert into @Pattern  values ('4|9|10|14|19|20|22|23|24|' )
				
	
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						
							else if (@PatterName = 'Guard')
						begin
						    delete from @Pattern
				
							
							insert into @Pattern  values ('3|4|7|10|11|17|20|23|24|' )				
	
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						else if (@PatterName = 'Tunnel')
						begin
						    delete from @Pattern
	
							insert into @Pattern  values ('2|7|12|17|22|4|9|14|19|24|' )
							insert into @Pattern  values ('6|7|8|9|10|16|17|18|19|20|' )
			
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
								else if (@PatterName = 'Dynamite')
						begin
						    delete from @Pattern
	
							insert into @Pattern  values ('1|3|4|5|11|13|14|15|21|23|24|25|' )
			
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						
					    else if (@PatterName = 'Six Pack' or @PatterName = 'Any Six Pack')
						begin
				
							delete from @Pattern
							
			
							set @dub1 = 1 set @dub2 = 2 set @dub3 = 3 set @dub4 = 6 set @dub5 = 7 set @dub6 = 8 
							
		
							set @count= 0 		
		
							while (@count != 3)
							begin
					
								set @TempPattern =  cast(@dub1 + @count  as varchar(10))+'|'
													+cast(@dub2 + @count  as varchar(10))+'|'
													+cast(@dub3 + @count  as varchar(10))+'|'
													+cast(@dub4 + @count  as varchar(10))+'|'
													+cast(@dub5 + @count  as varchar(10))+'|'
													+cast(@dub6 + @count  as varchar(10))+'|'

								--select @TempPattern
								insert into @Pattern  values(@TempPattern)
						 set @count2 = 5
								while (@count2 != 20)
								begin
								set @TempPattern =  cast(@dub1 + @count2 + @count  as varchar(10))+'|'
													+cast(@dub2 + @count2 + @count as varchar(10))+'|'
													+cast(@dub3 + @count2 + @count as varchar(10))+'|'
													+cast(@dub4 + @count2 + @count as varchar(10))+'|'
													+cast(@dub5 + @count2 + @count as varchar(10))+'|'
													+cast(@dub6 + @count2 + @count as varchar(10))+'|'

												
												--select @TempPattern
													insert into @Pattern  values(@TempPattern)
													set @count2 = @count2 + 5
								end
								set @count2 = 0
						
								set @count = @count + 1
							end
							
							set @dub1 = 1 set @dub2 = 2 set @dub3 = 6 set @dub4 = 7 set @dub5 = 11 set @dub6 = 12 
							
						 set @count= 0 
							while (@count != 4)
							begin
			
								set @TempPattern =  cast(@dub1 + @count  as varchar(10))+'|'
													+cast(@dub2 + @count  as varchar(10))+'|'
													+cast(@dub3 + @count  as varchar(10))+'|'
													+cast(@dub4 + @count  as varchar(10))+'|'
													+cast(@dub5 + @count  as varchar(10))+'|'
													+cast(@dub6 + @count  as varchar(10))+'|'

								--select @TempPattern
								insert into @Pattern  values(@TempPattern)
							    set @count2 = 5
								while (@count2 != 15)
								begin
								set @TempPattern =  cast(@dub1 + @count2 + @count  as varchar(10))+'|'
													+cast(@dub2 + @count2 + @count as varchar(10))+'|'
													+cast(@dub3 + @count2 + @count as varchar(10))+'|'
													+cast(@dub4 + @count2 + @count as varchar(10))+'|'
													+cast(@dub5 + @count2 + @count as varchar(10))+'|'
													+cast(@dub6 + @count2 + @count as varchar(10))+'|'

												
												--select @TempPattern
													insert into @Pattern  values(@TempPattern)
													set @count2 = @count2 + 5
								end
								set @count2 = 0
						
								set @count = @count + 1
							end
							
							
				

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
							
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'TNT')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|6|11|12|13|14|15|16|21|' )
							insert into @Pattern  values ('1|2|3|4|5|7|13|19|21|22|23|24|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						
							else if (@PatterName = 'Fireworks')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|5|21|25|8|12|13|14|18|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						
							else if (@PatterName = 'Candles')
						begin
						    delete from @Pattern
	
							insert into @Pattern  values ('2|4|5|11|13|14|15|22|24|25|' )
			
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						
							else if (@PatterName = 'WildFire')
						begin
						    delete from @Pattern
	
							insert into @Pattern  values ('2|3|4|10|13|14|20|22|23|24|' )
			
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						
						else if (@PatterName = 'Fire Hydrant')
						begin
						    delete from @Pattern
	
							insert into @Pattern  values ('7|8|10|11|12|13|14|15|17|18|20|' )
			
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						
								else if (@PatterName = 'Number 7')
						begin
						    delete from @Pattern
	
							insert into @Pattern  values ('11|16|21|22|23|24|25|' )
		
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						else if (@PatterName = 'Number 6')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('11|12|13|14|15|16|18|20|21|23|24|25|')

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						
								else if (@PatterName = 'Crazy Corner')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|2|6|')
							insert into @Pattern  values ('16|21|22|')
							insert into @Pattern  values ('4|5|10|')									
							insert into @Pattern  values ('20|24|25|')									

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						else if (@PatterName = 'Arrowhead')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('2|4|8|13|')
							insert into @Pattern  values ('13|18|22|24|')
							
							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						
						else if (@PatterName = 'Chichen itza')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('3|4|5|7|11|13|17|23|24|25|')
	
							
							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							--FOR MAYAMONEY BONUS ROUND
						else if (@PatterName = '' )
						begin
				
							delete from @Pattern
					
							--Crazy Corner		
							insert into @Pattern  values ('1|2|6|')
							insert into @Pattern  values ('16|21|22|')
							insert into @Pattern  values ('4|5|10|')									
							insert into @Pattern  values ('20|24|25|')

							--Tiny Pyramid
							insert into @Pattern  values ('3|7|8|13|' )
							insert into @Pattern  values ('8|12|13|18|' )
							insert into @Pattern  values ('13|17|18|23|' )	

							--ArrowHead
							insert into @Pattern  values ('2|4|8|13|')
							insert into @Pattern  values ('13|18|22|24|')

							--AnyLine
							insert into @Pattern  values ('1|6|11|16|21|' )
							insert into @Pattern  values ('2|7|12|17|22|' )
							insert into @Pattern  values ('3|8|13|18|23|' )
							insert into @Pattern  values ('4|9|14|19|24|' )
							insert into @Pattern  values ('5|10|15|20|25|' )
							insert into @Pattern  values ('1|2|3|4|5|' )
							insert into @Pattern  values ('6|7|8|9|10|' )
							insert into @Pattern  values ('11|12|13|14|15|' )
							insert into @Pattern  values ('16|17|18|19|20|' )
							insert into @Pattern  values ('21|22|23|24|25|' )
							insert into @Pattern  values ('5|9|13|17|21|' )
							insert into @Pattern  values ('1|7|13|19|25|' )
							--Crazy Stamp

							insert into @Pattern  values ('1|2|6|7|' )
							insert into @Pattern  values ('16|17|21|22|' )
							insert into @Pattern  values ('4|5|9|10|' )
							insert into @Pattern  values ('19|20|24|25|' )	
							--Four Corners

							insert into @Pattern  values ('1|5|21|25|' )

							--Small X
							insert into @Pattern  values ('7|9|13|17|19' )

							--Flower
							insert into @Pattern  values ('8|12|13|14|18|' )

							--Star
							insert into @Pattern  values ('3|11|13|15|23|' )

							--Payramid
							insert into @Pattern  values ('3|7|8|11|12|13|17|18|23' )
							insert into @Pattern  values ('4|8|9|12|13|14|18|19|24' )
							insert into @Pattern  values ('5|9|10|13|14|15|19|20|25' )

							--Steps
							insert into @Pattern  values ('1|2|7|8|13|14|19|20|25|' )
							insert into @Pattern  values ('5|9|10|13|14|17|18|21|22|' )

							--Chichen
							insert into @Pattern  values ('3|4|5|7|11|13|17|23|24|25|')
							
							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
					
									 --select cast(@m_CardN as varchar(10))
					
									set @WinnerCount = @WinnerCount + 1
									if (CHARINDEX(cast(@m_CardN as varchar(10)),  @WinningCardNumber3 ) = 0)
									begin
										--set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' ; break;
										
										if (@CountPreviousCardWinner = 0)
										begin							
											set @PreviousCardWinner = @m_CardN
											set @CountPreviousCardWinner = 1
											set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' 
										end
										else if (@PreviousCardWinner + 1= @m_CardN)
										begin								
										   set @PreviousCardWinner = @PreviousCardWinner + 1
										   set @CountPreviousCardWinner = @CountPreviousCardWinner + 1
											set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' 
										end	
																								
									end
									
									
								end 
								--else
								--begin
								--	break;
								--end 
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end



					 --NEXT CARD NUMBER
					 set @C_Card =  SUBSTRING(@C_Card, @result2 + 1, LEN(@C_Card)) 
					 set @result2 = (select CHARINDEX(',',@C_Card))
		end


		if (@WinnerCount != 0)
		begin

			set  @WinningCardNumber3 = SUBSTRING( @WinningCardNumber3, 0, len( @WinningCardNumber3))
			if (@PatterName = '')
			begin
				if (@CountPreviousCardWinner = 3)
				begin
					set  @WinningCardNumber3 = @WinningCardNumber3 +'_3X JAGUAR Level'
				end
				else
				if (@CountPreviousCardWinner = 5)
				begin
					set  @WinningCardNumber3 = @WinningCardNumber3 +'_5X SERPENT Multiplier'
				end
				else
				if (@CountPreviousCardWinner = 6)
				begin
					set  @WinningCardNumber3 = @WinningCardNumber3 +'_10X EAGLE Multiplier'
				end
				
			end
			
			--select  @WinningCardNumber3
			--select @PatterName + '. hits ' + cast(@WinnerCount as varchar(10)) ,  @WinningCardNumber3 as [Winning Card Number]
		end
		--NOTE: Number of winners is reported in payout(sp).
		return 

		--select  @WinningCardNumber3

end					

--TEST
--@PatterName varchar(100),
--@SessionNumber int, 
--@BallCallType int, --0 regular; 1 = bonus
--@GameID int,
--@GameName varchar(50),
-- @WinningCardNumber3 varchar(500) 

-- set @PatterName = 'Tiny Pyramid'
-- set @SessionNumber = 1001
-- set @BallCallType = 0
-- set @GameID = 9
-- set @GameName = 'Maya Money'
 


--declare @x varchar(500)
--exec usp_management_rptGetWinningCardNumber 'Any Line', 1001, 0, 0, 'Maya Money', @x output
--select @x


GO




USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRptPayouts2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRptPayouts2]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spRptPayouts2]
(
@SessionNum int, 
@DateRun datetime
)
as


--declare 
--@SessionNum int, 
--@DateRun datetime

--set @SessionNum = 1003
--set @DateRun = '3/11/2016 00:00:00'

Declare @Results table
(
		SessNum int,
		GameNum	int,
		ServerGameNum int,
		GameDate DateTime,
		GameName varchar(32),
		PayoutType varchar(32),
		ClientName char(11),
		CreditAcctNum int,
		Denom money,
		BetLevel int,
		NumberWinners int,
		WinAmount money,
		PatternName varchar(32)
)


declare @GameDef table
(
GameID int,
GameName varchar(50),
GameNameDB varchar(50)
)

insert into @GameDef (GameID, GameName, GameNameDB) values (36, 'Crazy Bout', 'CrazyBout') --CRAZY BOUT
insert into @GameDef (GameID, GameName, GameNameDB) values (37, 'Jailbreak', 'Jailbreak') 
insert into @GameDef (GameID, GameName, GameNameDB) values (38, 'Maya Money', 'MayaMoney') 
insert into @GameDef (GameID, GameName, GameNameDB) values (-1, 'Spirit76', 'Spirit76') 
insert into @GameDef (GameID, GameName, GameNameDB) values (-2, 'UkickEm', 'UkickEm') 
insert into @GameDef (GameID, GameName, GameNameDB) values (-3, 'Wild Ball', 'WildBall') 
insert into @GameDef (GameID, GameName, GameNameDB) values (-4, 'Time Bomb', 'TimeBomb') 
insert into @GameDef (GameID, GameName, GameNameDB) values (-5, 'Wild Fire', 'WildFire') --Need to research on how do you win on this game.

IF OBJECT_ID('tempdb..#Results') IS not null drop table #Results
create  table #Results
(
		SessNum int,
		GameNum	int,
		ServerGameNum int,
		GameDate DateTime,
		GameName varchar(32),
		PayoutType varchar(32),
		ClientName char(11),
		CreditAcctNum int,
		Denom money,
		BetLevel int,
		NumberWinners int,
		WinAmount money,
		PatternName varchar(32)
)

declare GameDefCursor cursor for --Loop each game
select GameID, GameName, GameNameDB from @GameDef

declare @GameID int , @GameName2 varchar(50), @GameNameDB varchar(50)
open GameDefCursor fetch next from GameDefCursor into @GameID, @GameName2, @GameNameDB

while @@FETCH_STATUS = 0
begin

	declare @SqlCommand nvarchar(2000)
	declare @ColumnName varchar(20) set @ColumnName = 'patt_'-- + cast(2 as varchar(2))
	declare @Count int set @Count = 1;

	if (@GameID = -2)--UkickEm
	begin
		set @SqlCommand = 'insert into #Results
				(
						SessNum,
						GameNum,
						ServerGameNum,
						GameDate,
						GameName,
						PayoutType,
						ClientName,
						CreditAcctNum,
						Denom,
						BetLevel,
						NumberWinners,
						WinAmount,
						PatternName	
				)
			Select	
			cb.sessnum
			,cb.gamenum
			,(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = '+ cast(@GameID as varchar(10)) +') as ServerGameNum
			,cb.recdatetime
			,'''+ @GameName2 +'''
			,''Regular''
			,cb.clientname
			,cb.creditacctnum
			,(cb.denom/100.0)
			,cb.betlevel
			,1 as numofwins -- Always 1
			,cb.totalpaidamt/100.0 as winamt
			,''Catch '' + CAST (cb.numofhits as varchar(10))
			From dbo.UKickEm_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
			Where sj.sessnum = '+ cast(@SessionNum as varchar(10))  +'
			and cb.totalpaidamt <> 0'
	

		exec (@SqlCommand)
		fetch next from GameDefCursor into @GameID, @GameName2,  @GameNameDB
			continue -- Go tothe next gameID
	end

--select @GameName2

	-- Insert Extra Bonud game winners
	if (@GameID != -4 )--Skip TimeBomb
	begin
		set @SqlCommand = 'insert into #Results
				(
						SessNum,
						GameNum,
						ServerGameNum,
						GameDate,
						GameName,
						PayoutType,
						ClientName,
						CreditAcctNum,
						Denom,
						BetLevel,
						NumberWinners,
						WinAmount,
						PatternName	
				)
				Select	cb.sessnum,
			cb.gamenum,
			(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = '+ cast(@GameID as varchar(10)) +'),
			cb.recdatetime,'''+ @GameName2 +''',''Extra Bonus'',
			cb.clientname,
			cb.creditacctnum,
			(cb.Denom / 100.00),
			cb.BetLevel,
			1,
			(cb.gamewinamt / 100.00),
			''Coverall''
			From '+ @GameNameDB +'_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
			Where sj.sessnum = ' + cast(@SessionNum as varchar(10))  +'
			And cb.gamewinamt != 0
			And cb.numofwins_patt_1 = 0
			And cb.numofwins_patt_2 = 0
			And cb.numofwins_patt_3 = 0
			And cb.numofwins_patt_4 = 0
			And cb.numofwins_patt_5 = 0
			And cb.numofwins_patt_6 = 0
			And cb.numofwins_patt_7 = 0
			And cb.numofwins_patt_8 = 0
			And cb.numofwins_patt_9 = 0
			And cb.numofwins_patt_10 = 0
			And cb.numofwins_patt_11 = 0
			And cb.numofwins_patt_12 = 0'

		exec (@SqlCommand)
	end
	else
	if (@GameID = -4)
	begin
				set @SqlCommand = 'insert into #Results
				(
						SessNum,
						GameNum,
						ServerGameNum,
						GameDate,
						GameName,
						PayoutType,
						ClientName,
						CreditAcctNum,
						Denom,
						BetLevel,
						NumberWinners,
						WinAmount,
						PatternName	
				)
				Select	cb.sessnum,
			cb.gamenum,
			(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = '+ cast(@GameID as varchar(10)) +'),
			cb.recdatetime,'''+ @GameName2 +''',''Extra Bonus'',
			cb.clientname,
			cb.creditacctnum,
			(cb.Denom / 100.00),
			cb.BetLevel,
			1,
			(cb.gamewinamt / 100.00),
			''Coverall''
			From '+ @GameNameDB +'_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
			Where sj.sessnum = ' + cast(@SessionNum as varchar(10))  +'
			And cb.gamewinamt != 0
			And cb.numofwins_patt_1 = 0
			And cb.numofwins_patt_2 = 0
			And cb.numofwins_patt_3 = 0
			And cb.numofwins_patt_4 = 0
			And cb.numofwins_patt_5 = 0
			And cb.numofwins_patt_6 = 0'
	

		exec (@SqlCommand)
	end


	if (@GameID != -4 )
	begin
		while (@Count != 13)
		begin

			declare @ColumnName_ nvarchar(10)
			declare @PatterId nvarchar(10)

			set @ColumnName_  =  @ColumnName + cast(@Count as varchar(2))
			set @PatterId = cast(@Count as varchar(2))
			
				--Insert  Instant Winners
				set @SqlCommand =  
				'insert into #Results
				(
						SessNum,
						GameNum,
						ServerGameNum,
						GameDate,
						GameName,
						PayoutType,
						ClientName,
						CreditAcctNum,
						Denom,
						BetLevel,
						NumberWinners,
						WinAmount,
						PatternName
			
				)
				Select	cb.sessnum,
						cb.gamenum,
						(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = '+ cast(@GameID as varchar(10)) +'),
						cb.recdatetime,'''+ @GameName2 +'''  ,''Regular'',
						cb.clientname,
						cb.creditacctnum,
						(cb.denom / 100.0),
						cb.betlevel,
						cb.numofwins_' + @ColumnName_ + ',
						((cb.winamt_' + @ColumnName_ + ' / cb.numofwins_' + @ColumnName_ +') / 100.0),
						(Select patternname from '+ @GameNameDB +'_GamePatterns where patternid = '+ @PatterId + ')
				From '+ @GameNameDB +'_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
				Where sj.sessnum = '+ cast(@SessionNum as varchar(10))  +'
				And cb.numofwins_' +  @ColumnName_ + ' <> 0
				And cb.winamt_' + @ColumnName_ +  '  <> 0'

				exec (@SqlCommand)

				--Insert  Bonus Round Winners
				if (@GameID != 38 And @GameID != -5 )
				begin
					set @SqlCommand =	'Insert into #Results
					(
							SessNum,
							GameNum,
							ServerGameNum,
							GameDate,
							GameName,
							PayoutType,
							ClientName,
							CreditAcctNum,
							Denom,
							BetLevel,
							NumberWinners,
							WinAmount,
							PatternName
			
					)
					Select	cb.sessnum,
							cb.gamenum,
							(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = '+ cast(@GameID as varchar(10)) +'),
							cb.recdatetime,'''+ @GameName2 +''',''Bonus'',
							cb.clientname,
							cb.creditacctnum,
							(cb.denom / 100.0),
							cb.betlevel,
							cb.numofwins_bonus'+ @ColumnName_ + ',
							((cb.bonuswinamt_'+ @ColumnName_ + ' / cb.numofwins_bonus' + @ColumnName_ + ') / 100.0),
							(Select patternname from '+ @GameNameDB +'_BonusPatterns where patternid = '+ @PatterId +')
					From '+ @GameNameDB +'_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
					Where sj.sessnum = '+ cast(@SessionNum as varchar(10))  +'
					And cb.numofwins_bonus' + @ColumnName_ + ' <> 0
					And cb.bonuswinamt_' + @ColumnName_ + ' <> 0'

					exec (@SqlCommand)
				end

				set @Count = @Count + 1
			end--While
		end
		else
		if (@GameID = -4)--TimeBomb
		begin
		while (@Count != 7)
		begin

			--declare @ColumnName_ nvarchar(10)
			--declare @PatterId nvarchar(10)

			set @ColumnName_  =  @ColumnName + cast(@Count as varchar(2))
			set @PatterId = cast(@Count as varchar(2))
			
				--Insert Crazy Bout Bingo Instant Winners
				set @SqlCommand =  
				'insert into #Results
				(
						SessNum,
						GameNum,
						ServerGameNum,
						GameDate,
						GameName,
						PayoutType,
						ClientName,
						CreditAcctNum,
						Denom,
						BetLevel,
						NumberWinners,
						WinAmount,
						PatternName
			
				)
				Select	cb.sessnum,
						cb.gamenum,
						(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = '+ cast(@GameID as varchar(10)) +'),
						cb.recdatetime,'''+ @GameName2 +'''  ,''Regular'',
						cb.clientname,
						cb.creditacctnum,
						(cb.denom / 100.0),
						cb.betlevel,
						cb.numofwins_' + @ColumnName_ + ',
						((cb.winamt_' + @ColumnName_ + ' / cb.numofwins_' + @ColumnName_ +') / 100.0),
						(Select patternname from '+ @GameNameDB +'_GamePatterns where patternid = '+ @PatterId + ')
				From '+ @GameNameDB +'_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
				Where sj.sessnum = '+ cast(@SessionNum as varchar(10))  +'
				And cb.numofwins_' +  @ColumnName_ + ' <> 0
				And cb.winamt_' + @ColumnName_ +  '  <> 0'

				exec (@SqlCommand)
				--print cast(@Count as varchar(10))
				set @Count = @Count + 1
			end--While
		
		end
		
		fetch next from GameDefCursor into @GameID, @GameName2,  @GameNameDB

end


insert into @Results 
select SessNum,
		GameNum,
		ServerGameNum,
		GameDate,
		GameName,
		PayoutType,
		ClientName,
		CreditAcctNum,
		Denom,
		BetLevel,
		NumberWinners,
		WinAmount,
		PatternName from #Results

drop table #Results



---------- Insert MayaMoney Bonus Wins ------------------------------------
Insert into @Results
(
		SessNum,
		GameNum,
		ServerGameNum,
		GameDate,
		GameName,
		PayoutType,
		ClientName,
		CreditAcctNum,
		Denom,
		BetLevel,
		NumberWinners,
		WinAmount
		
)
Select	mm.sessnum,
		mm.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = mm.gamenum and sgj.GameTypeID = 38 /* MayaMoney */ ),
		mm.recdatetime,
		'Maya Money',
		'Bonus',
		mm.clientname,
		mm.creditacctnum,
		(mm.denom / 100.0),
		mm.betlevel,
		1,
		(mm.gamewinamt - (winamt_patt_1 + winamt_patt_2 + winamt_patt_3 + winamt_patt_4 + winamt_patt_5 + winamt_patt_6 + winamt_patt_7 + winamt_patt_8 + winamt_patt_9 +
                       winamt_patt_10 + winamt_patt_11 + winamt_patt_12)) / 100.0
From MayaMoney_GameJournal mm join B3_SessionsJournal sj on mm.sessnum = sj.sessnum
join MayaMoney_GamePayTable mmgp on mm.denom = mmgp.denom
Where sj.sessnum = @SessionNum
And ((gamewinamt <> winamt_patt_1 + winamt_patt_2 + winamt_patt_3 + winamt_patt_4 + winamt_patt_5 + winamt_patt_6 + winamt_patt_7 + winamt_patt_8 +
                       winamt_patt_9 + winamt_patt_10 + winamt_patt_11 + winamt_patt_12) AND (winamt_patt_1 + winamt_patt_2 + winamt_patt_3 + winamt_patt_4 + winamt_patt_5 + winamt_patt_6 + winamt_patt_7 + winamt_patt_8 + winamt_patt_9 +
                       winamt_patt_10 + winamt_patt_11 + winamt_patt_12 <> 0))


declare @Result2 table
(
	SessNum int,
		GameNum	int,
		ServerGameNum int,
		GameDate DateTime,
		GameName varchar(32),
		PayoutType varchar(32),
		ClientName char(11),
		CreditAcctNum varchar(100),
		Denom money,
		BetLevel int,
		NumberWinners int,
		WinAmount money,
		PatternName varchar(32),
		WinningCardNumber nvarchar(4000)
)


--Final result if it is North Dakota then show all the account number else mask the first 4 character.
if ((select IsNorthDakota from B3_SystemConfig ) = 'T')
begin
insert into @Result2 
(
SessNum ,
		GameNum	,
		ServerGameNum ,
		GameDate ,
		GameName ,
		PayoutType ,
		ClientName ,
		CreditAcctNum ,
		Denom ,
		BetLevel ,
		NumberWinners ,
		WinAmount ,
		PatternName 
)
Select 
		SessNum ,
		GameNum	,
		ISNULL(ServerGameNum ,Gamenum) ServerGameNum,
		GameDate ,
		GameName ,
		PayoutType ,
		ClientName ,
		case 
		when  len(CreditAcctNum) = 1 then '0000000'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 2 then '000000'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 3 then '00000'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 4 then '0000'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 5 then '000'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 6 then '00'+CAST(CreditAcctNum AS varchar(10)) 
		when  len(CreditAcctNum) = 7 then '0'+CAST(CreditAcctNum AS varchar(10)) 
		else
		CAST(CreditAcctNum AS varchar(10)) 
		end as CreditAcctNum
		 ,
		Denom ,
		BetLevel ,
		NumberWinners ,
		WinAmount, 
		PatternName 
					--(select dbo.B3_fnGetWinningCardNumber(PatternName, SessNum, 1, GameNum ))  as WinningCardNumber  
From @Results
Group By SessNum, GameNum, ServerGameNum, GameDate, GameName, PayoutType, CreditAcctNum, ClientName, Denom, BetLevel, WinAmount, NumberWinners, PatternName --, GameWinAmt, BonusWinAmt, TotalPaidAmt
Order By ServerGameNum
end
else
begin

insert into @Result2 
(
		SessNum ,
		GameNum	,
		ServerGameNum ,
		GameDate ,
		GameName ,
		PayoutType ,
		ClientName ,
		CreditAcctNum ,
		Denom ,
		BetLevel ,
		NumberWinners ,
		WinAmount ,
		PatternName 
)
Select 
		SessNum ,
		GameNum	,
		ISNULL(ServerGameNum ,Gamenum) ServerGameNum,
		GameDate ,
		GameName ,
		PayoutType ,
		ClientName ,
		case 
		when  len(CreditAcctNum) = 1 then 'xxxx000'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 2 then 'xxxx00'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 3 then 'xxxx0'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) >= 4 then 'xxxx'+ Substring(CAST(CreditAcctNum AS varchar(10)),4,8)
		end as CreditAcctNum
		 ,
		Denom ,
		BetLevel ,
		NumberWinners ,
		WinAmount, 
		PatternName
		--(select dbo.B3_fnGetWinningCardNumber(PatternName, SessNum, 1, GameNum ))  as WinningCardNumber
From @Results 
Group By SessNum, GameNum, ServerGameNum, GameDate, GameName, PayoutType, CreditAcctNum, ClientName, Denom, BetLevel, WinAmount, NumberWinners, PatternName --, GameWinAmt, BonusWinAmt, TotalPaidAmt
Order By ServerGameNum
end

declare @ServerGamenum int, @PayoutType int, @Pattername varchar(50), @SessionNumber int, @GameName varchar(50)



declare GetWinningCardNumber_Cursor cursor
for 
select 
		SessNum,
		--GameNum	,
		ServerGameNum ,
		--GameDate ,
		GameName ,
		case when PayoutType = 'Regular' then 0 else 1 end,
		--ClientName ,
		--CreditAcctNum ,
		--Denom ,
		--BetLevel ,
		--NumberWinners ,
		--WinAmount ,
		PatternName 
		from @Result2 

		open GetWinningCardNumber_Cursor

		FETCH NEXT FROM GetWinningCardNumber_Cursor 
		INTO  @SessionNumber, @ServerGamenum, @GameName,  @PayoutType,  @Pattername

		
		while @@fetch_status = 0
		begin

		--select @SessionNumber, @ServerGamenum, @PayoutType,  @Pattername

			declare @WinningCardNumber varchar(100)
			if (@GameName != 'UkickEm')
			begin
			exec usp_management_rptGetWinningCardNumber @Pattername,  @SessionNumber, @PayoutType, @ServerGamenum, @GameName , @WinningCardNumber OUTPUT
			end
			else
			begin
			set @WinningCardNumber = 'N/A'
			end

				if (@Pattername is null )
				begin
				
				declare @JackpotName varchar(50)
				set @JackpotName = substring(@WinningCardNumber,charindex('_', @WinningCardNumber) + 1 , Len(@WinningCardNumber))
				set @WinningCardNumber = substring(@WinningCardNumber, 0 ,charindex('_', @WinningCardNumber)) 
					update @Result2
					set WinningCardNumber = @WinningCardNumber
					,PatternName = @JackpotName
					where ServerGameNum = @ServerGamenum and PayoutType = 'Bonus'

				end
				else
				begin	 
					update @Result2
					set WinningCardNumber = @WinningCardNumber
					where PatternName =  @Pattername and PayoutType = (case @PayoutType when 0 then 'Regular' else 'Bonus' end) and ServerGameNum = @ServerGamenum 
			and GameName = @GameName
			end

					FETCH NEXT FROM GetWinningCardNumber_Cursor 
		INTO  @SessionNumber, @ServerGamenum, @GameName,  @PayoutType,  @Pattername
		end

close GetWinningCardNumber_Cursor
deallocate GetWinningCardNumber_Cursor

select 
		SessNum,
		GameNum	,
		ServerGameNum ,
		GameDate ,
		GameName ,
		PayoutType ,
		ClientName ,
		CreditAcctNum ,
		Denom ,
		BetLevel ,
		NumberWinners ,
		WinAmount ,
		PatternName ,
		WinningCardNumber
		from @Result2 order by GameDate asc








GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_GetWinningCardNumber2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_GetWinningCardNumber2]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE  proc [dbo].[usp_management_GetWinningCardNumber2]
(
@SessionNumber int, 
@GameNumber int, 
@PayoutType int,
@GameName nvarchar(100),
@WinningCard nvarchar(500) OUTPUT
)
--==============
-- Author:			Fortunet
-- Date Created:	20151125
-- Description:		Get the winning card number -> range per game.		
-- 20160310(knc):	Fixed issue -> Card number is incorrect always returning card number from mayamoney.
----==============
as
begin


declare @ListOfGameName Table 
(
GameName varchar(50)
)
declare @NCardbet int
DECLARE @sqlCommand nvarchar(1000)
DECLARE @ParmDefinition nvarchar(500);

set @GameName = 'dbo.' + @GameName +'_GameJournal game'
insert into @ListOfGameName (GameName) values (@GameName)

			
declare @Counter int set @Counter = 0
declare @FirstCardNumber varchar(10) 
declare @GameName2 varchar(100)
--declare @GameName varchar(50) set @GameName = 'dbo.MayaMoney_GameJournal game'
declare @CardNumber varchar(10) set @CardNumber = ''
declare @ListOfCardNumber varchar(200) set @ListOfCardNumber = ''

declare  Game_cursor cursor for


select GameName from @ListOfGameName
open Game_cursor
fetch next from Game_cursor into @GameName2
while @@FETCH_STATUS = 0
begin
	--select @GameName2
	set @FirstCardNumber = '';
	set @NCardbet = 0;
	
	--select @GameName2
	
	if (@PayoutType = 0 or @GameName2 = 'dbo.MayaMoney_GameJournal game' )
	begin
		 set @sqlCommand = 'select @FirstCardNumberOUT = cardsn_1  from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
		+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
		set @ParmDefinition = N'@FirstCardNumberOUT varchar(10) OUTPUT'
		
				EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @FirstCardNumberOUT = @FirstCardNumber OUTPUT
				
	
			if (@GameName2 != 'dbo.TimeBomb_GameJournal game')
				begin
					 set @sqlCommand = '          select @NCardbetOUT =
						(case when betplaced_card_1 = ''T'' then 1 else 0 end )+
						(case when betplaced_card_2 = ''T'' then 1 else 0 end) +
						(case when betplaced_card_3 = ''T'' then 1 else 0 end) +
						(case when betplaced_card_4 = ''T'' then 1 else 0 end) +
						(case when betplaced_card_5 = ''T'' then 1 else 0 end) +
						(case when betplaced_card_6 = ''T'' then 1 else 0 end)  from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
					+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
					set @ParmDefinition = N'@NCardbetOUT varchar(10) OUTPUT'
					
					EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @NCardbetOUT = @NCardbet OUTPUT
							--print cast(@NCardbet as varchar(10))
	             end
	              else
	        if (@GameName2 = 'dbo.TimeBomb_GameJournal game')
				begin
					 set @sqlCommand = '          select @NCardbetOUT =
						(case when betplaced_card_1 = ''T'' then 1 else 0 end )+
						(case when betplaced_card_2 = ''T'' then 1 else 0 end) +
						(case when betplaced_card_3 = ''T'' then 1 else 0 end) +
						(case when betplaced_card_4 = ''T'' then 1 else 0 end) from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
					+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
					set @ParmDefinition = N'@NCardbetOUT varchar(10) OUTPUT'
					
					EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @NCardbetOUT = @NCardbet OUTPUT
				end
				 
	             
	             set @Counter = 0
	     
	             while (@Counter != @NCardbet)
		   
					begin

					 set @sqlCommand = 'select @cardOUT = cardsn_' + CAST(@Counter + 1 as varchar(10)) + ' from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
					+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
					set @ParmDefinition = N'@cardOUT varchar(10) OUTPUT'
					
					EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @cardOUT = @CardNumber OUTPUT
				
					set @ListOfCardNumber = @ListOfCardNumber + @CardNumber + ', '	
					set @Counter = @Counter + 1	
					--select @Counter
					end
		
				set @ListOfCardNumber =  SUBSTRING(@ListOfCardNumber, 0, len(@ListOfCardNumber))
				
				if (len(@ListOfCardNumber) != 0)break
	      end
	      else
	      if (@PayoutType = 1  )
	      begin
				--select 	@GameName2
	      
	       set @sqlCommand = 'select @FirstCardNumberOUT = cardsn_1  from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
		+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
		set @ParmDefinition = N'@FirstCardNumberOUT varchar(10) OUTPUT'
		
				EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @FirstCardNumberOUT = @FirstCardNumber OUTPUT
				
	
			if (@GameName2 != 'dbo.TimeBomb_GameJournal game')
				begin
				if (@GameName2 != 'dbo.WildBall_GameJournal game')
				begin
					 set @sqlCommand = 'select @NCardbetOUT =
						(case when bonuscardsn_1 != 0 then 1 else 0 end )+
						(case when bonuscardsn_2 != 0 then 1 else 0 end) +
						(case when bonuscardsn_3 != 0 then 1 else 0 end) 
						  from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
					+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
					set @ParmDefinition = N'@NCardbetOUT varchar(10) OUTPUT'
					
					EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @NCardbetOUT = @NCardbet OUTPUT

	             end
	             else
	             begin
	              set @sqlCommand = 'select @NCardbetOUT =
						(case when bonuscardsn_1 != 0 then 1 else 0 end )+
						(case when bonuscardsn_2 != 0 then 1 else 0 end) +
						(case when bonuscardsn_3 != 0 then 1 else 0 end) +
						(case when bonuscardsn_3 != 0 then 1 else 0 end) 
						  from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
					+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
					set @ParmDefinition = N'@NCardbetOUT varchar(10) OUTPUT'
					
					EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @NCardbetOUT = @NCardbet OUTPUT
	             end
	         end
	         
	             while (@Counter != @NCardbet)
		   
					begin

					 set @sqlCommand = 'select @cardOUT = bonuscardsn_' + CAST(@Counter + 1 as varchar(10)) + ' from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
					+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
					set @ParmDefinition = N'@cardOUT varchar(10) OUTPUT'
					
				--select * from dbo.CrazyBout_GameJournal
				--select @sqlCommand
				--select  bonuscardsn_1 from dbo.CrazyBout_GameJournal game where game.sessnum = 1053 and game.gamenum = 142
					
					EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @cardOUT = @CardNumber OUTPUT
				
		
					set @ListOfCardNumber = @ListOfCardNumber + @CardNumber + ', '	
					set @Counter = @Counter + 1	
					--select @Counter
					end
		
				set @ListOfCardNumber =  SUBSTRING(@ListOfCardNumber, 0, len(@ListOfCardNumber))
				
				if (len(@ListOfCardNumber) != 0)break
	      
	      end       

	
	fetch next from Game_cursor into @GameName2
end
close  Game_cursor
deallocate  Game_cursor

set @WinningCard = @ListOfCardNumber
--select @WinningCard
return 
				
	
end
		
	
--TEST
--declare 
--@SessionNumber int, 
--@GameNumber int, 
--@PayoutType int,
--@WinningCard nvarchar(500) OUTPUT
--TEST
--set @SessionNumber = 1052
--set @GameNumber = 293
--set @PayoutType = 0
--returns nvarchar(500)
--)
--	
	
		
		--while (@Counter != @NCardbet)
		   
		--begin

		-- set @sqlCommand = 'select @cardOUT = cardsn_' + CAST(@Counter + 1 as varchar(10)) + ' from ' +  @GameName + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
		--+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
		--set @ParmDefinition = N'@cardOUT varchar(10) OUTPUT'
		
		--EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @cardOUT = @CardNumber OUTPUT
	
	 --   set @ListOfCardNumber = @ListOfCardNumber + @CardNumber + ', '	
		--set @Counter = @Counter + 1	
		
		--end
		
		--set @ListOfCardNumber =  SUBSTRING(@ListOfCardNumber, 0, len(@ListOfCardNumber))
	

--declare @Result nvarchar(500)
		
--		;with CrazyBoutCardNumber(GameNumber, CardNumber)as
--		(select game.gamenum,
--		case when  @PayoutType = 0
--		then  
--			case when betplaced_card_1 = 'T' then
--			cast(game.cardsn_1 as varchar(10)) +', '
--			else '' end
--			+ case when betplaced_card_2 = 'T' then
--			 cast(game.cardsn_2 as varchar(10))+', '
--			 else '' end
--			+ case when betplaced_card_3 = 'T' then
--			 cast (game.cardsn_3 as varchar(10))+', '
--			 else '' end
--			+ case when betplaced_card_4 = 'T' then 
--			 CAST (game.cardsn_4 as varchar(10))+', '
--			else '' end
--			+ case when betplaced_card_5 = 'T' then 
--			 CAST (game.cardsn_5 as varchar(10))+', '
--			else '' end
--			+ case when betplaced_card_6 = 'T' then 
--			 CAST (game.cardsn_6 as varchar(10))
--			else '' end 
--		else 
--		 cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10))
--		end
		
--		from 
--		dbo.CrazyBout_GameJournal game
--		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
--		where game.sessnum = @SessionNumber
--		and game.gamenum = @GameNumber
--		)
		
	
		
--		,JailBreakCardNumber (GameNumber, CardNumber) as
--		(
--		select game.gamenum,
--		case when @PayoutType = 0
--		then
--		case when betplaced_card_1 = 'T' then
--		cast(game.cardsn_1 as varchar(10)) +', '
--		else '' end
--	    + case when betplaced_card_2 = 'T' then
--	     cast(game.cardsn_2 as varchar(10))+', '
--	     else '' end
--		+ case when betplaced_card_3 = 'T' then
--		 cast (game.cardsn_3 as varchar(10))+', '
--		 else '' end
--		+ case when betplaced_card_4 = 'T' then 
--		 CAST (game.cardsn_4 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_5 = 'T' then 
--		 CAST (game.cardsn_5 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_6 = 'T' then 
--		 CAST (game.cardsn_6 as varchar(10))
--		else '' end
--		else
--		cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10)) end
--		from 
--		dbo.JailBreak_GameJournal game
--		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
--		where game.sessnum = @SessionNumber
--		and game.gamenum = @GameNumber
--		)
--		,MayaMoneyCardNumber (GameNumber, CardNumber) as  
--		(
--		select game.gamenum,
--		case when @PayoutType = 0
--		then
--		case when betplaced_card_1 = 'T' then
--		cast(game.cardsn_1 as varchar(10)) +', '
--		else '' end
--	    + case when betplaced_card_2 = 'T' then
--	     cast(game.cardsn_2 as varchar(10))+', '
--	     else '' end
--		+ case when betplaced_card_3 = 'T' then
--		 cast (game.cardsn_3 as varchar(10))+', '
--		 else '' end
--		+ case when betplaced_card_4 = 'T' then 
--		 CAST (game.cardsn_4 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_5 = 'T' then 
--		 CAST (game.cardsn_5 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_6 = 'T' then 
--		 CAST (game.cardsn_6 as varchar(10))
--		else '' end		
--		end
--		from 
--		dbo.MayaMoney_GameJournal game
--		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
--		where game.sessnum = @SessionNumber
--		and game.gamenum = @GameNumber
--		)
--		,Spirit76CardNumber (GameNumber, CardNumber) as  
--		(
--		select game.gamenum,
--		case when @PayoutType = 0
--		then
--		case when betplaced_card_1 = 'T' then
--		cast(game.cardsn_1 as varchar(10)) +', '
--		else '' end
--	    + case when betplaced_card_2 = 'T' then
--	     cast(game.cardsn_2 as varchar(10))+', '
--	     else '' end
--		+ case when betplaced_card_3 = 'T' then
--		 cast (game.cardsn_3 as varchar(10))+', '
--		 else '' end
--		+ case when betplaced_card_4 = 'T' then 
--		 CAST (game.cardsn_4 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_5 = 'T' then 
--		 CAST (game.cardsn_5 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_6 = 'T' then 
--		 CAST (game.cardsn_6 as varchar(10))
--		else '' end
--		else
--		cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10))
--		 end

--		from 
--		dbo.Spirit76_GameJournal game
--		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
--		where game.sessnum = @SessionNumber
--		and game.gamenum = @GameNumber
--		)
--		,TimeBombCardNumber (GameNumber, CardNumber) as  
--		(
--		select game.gamenum, 
--		case when @PayoutType = 0
--		then
--		case when betplaced_card_1 = 'T' then
--		cast(game.cardsn_1 as varchar(10)) +', '
--		else '' end
--	    + case when betplaced_card_2 = 'T' then
--	     cast(game.cardsn_2 as varchar(10))+', '
--	     else '' end
--		+ case when betplaced_card_3 = 'T' then
--		 cast (game.cardsn_3 as varchar(10))+', '
--		 else '' end
--		+ case when betplaced_card_4 = 'T' then 
--		 CAST (game.cardsn_4 as varchar(10))
--		else '' end		
--		end
--		from 
--		dbo.TimeBomb_GameJournal game
--		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
--		where game.sessnum = @SessionNumber
--		and game.gamenum = @GameNumber
--		)
--		--,UkickEmCardNumber (GameNumber, CardNumber) as  
--		--(		
--		--select game.gamenum,
--		--cast(game.cardsn_1 as varchar(10)) +', '
--		--+ cast(game.cardsn_2 as varchar(10))+', '
--		--+ cast (game.cardsn_3 as varchar(10))+', '
--		--+ CAST (game.cardsn_4 as varchar(10))+', '
--		--+ CAST (game.cardsn_5 as varchar(10))+', '
--		--+ CAST (game.cardsn_6 as varchar(10))
--		--from 
--		--dbo.UKickEm_GameJournal game
--		--where game.sessnum = @SessionNumber
--		--and game.gamenum = @GameNumber
--		--)
--		,WildBallCardNumber (GameNumber, CardNumber) as  
--		(
--		select game.gamenum,
--		case when @PayoutType = 0
--		then
--		case when betplaced_card_1 = 'T' then
--		cast(game.cardsn_1 as varchar(10)) +', '
--		else '' end
--	    + case when betplaced_card_2 = 'T' then
--	     cast(game.cardsn_2 as varchar(10))+', '
--	     else '' end
--		+ case when betplaced_card_3 = 'T' then
--		 cast (game.cardsn_3 as varchar(10))+', '
--		 else '' end
--		+ case when betplaced_card_4 = 'T' then 
--		 CAST (game.cardsn_4 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_5 = 'T' then 
--		 CAST (game.cardsn_5 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_6 = 'T' then 
--		 CAST (game.cardsn_6 as varchar(10))
--		else '' end
--		else
--		 cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10)) +', ' + cast(game.bonuscardsn_4 AS varchar(10))
--		 end

--		from 
--		dbo.WildBall_GameJournal game
--		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
--		where game.sessnum = @SessionNumber
--		and game.gamenum = @GameNumber
--		)
--		,WildFireCardNumber (GameNumber, CardNumber) as  
--		(
--		select game.gamenum,
--		case when @PayoutType = 0 
--		then
--		case when betplaced_card_1 = 'T' then
--		cast(game.cardsn_1 as varchar(10)) +', '
--		else '' end
--	    + case when betplaced_card_2 = 'T' then
--	     cast(game.cardsn_2 as varchar(10))+', '
--	     else '' end
--		+ case when betplaced_card_3 = 'T' then
--		 cast (game.cardsn_3 as varchar(10))+', '
--		 else '' end
--		+ case when betplaced_card_4 = 'T' then 
--		 CAST (game.cardsn_4 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_5 = 'T' then 
--		 CAST (game.cardsn_5 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_6 = 'T' then 
--		 CAST (game.cardsn_6 as varchar(10))
--		else '' end
--		end
--		from 
--		dbo.WildFire_GameJournal game
--		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
--		where game.sessnum = @SessionNumber
--		and game.gamenum = @GameNumber
--		)
--		,ResultSet  (GameNumber, CardNumber) as
--		(
--		select GameNumber, CardNumber from CrazyBoutCardNumber
--		union all 
--		select GameNumber, CardNumber from JailBreakCardNumber
--		union all 
--		select GameNumber, CardNumber from MayaMoneyCardNumber
--		union all 
--		select GameNumber, CardNumber from Spirit76CardNumber
--		union all 
--		select GameNumber, CardNumber from TimeBombCardNumber
--		union all 
--		select GameNumber, CardNumber from WildBallCardNumber
--		union all 
--		select GameNumber, CardNumber from WildFireCardNumber	
--		)
--	--insert into @JackpotCardNumber (GameNum, CardNumbers)
--	select @Result = CardNumber from ResultSet ;
		
		
--		--20150904(knc): Use distinct to kill duplicate record::Since we only need the rec number and card number there is no need for duplicate record.
		
--		select @Result

--return @Result
--end














GO



USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_Report_GetAccountNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_Report_GetAccountNumber]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[usp_management_Report_GetAccountNumber]
@SessNum int 
as

select creditacctnum from dbo.B3_CreditJournal where sessnum = @SessNum

GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_rptAccountHistory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_rptAccountHistory]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[usp_management_rptAccountHistory]
(
--declare
@P_Date_ datetime,
@SessionID_ int,
@AccountNumber int
--set @P_Date_ = '03/14/2016 00:00:00'
--set @SessionID_ = 1011
--set @AccountNumber = 80308909

)

as

	declare @FinalResult table
	(


	DateTimeTransaction datetime,
	ReceiptNumber int,
	TransactionType varchar(100),
	TransactionLocation varchar(100),
	GameNumber int,
	GameName varchar(100),
	Credits int,
	BetAmount int,
	Denom int,
	NumberOfCardsWagered int,
	SerialCardNumberPlayed varchar(100),
	Win int , -- (Win + Bonus)
	WinBalance int, -- For dual Accounting
	CreditBalance int,
	GameSite varchar(50),
	OperatorName varchar(50)

	)


	declare @TransactionDetailReport table
	(
		TransType varchar(50),
		MAC varchar(50),
		TransNo varchar(50),
		ReceiptNo int,
		TransDate datetime,				
		TransDesc varchar(50),
		CreditAcctNum varchar(100),
		CreditAmt Money,
		WinsAmt money,
		UserName varchar(100),
		SessNum int,
		SessStart datetime,
		SessEnd datetime,
		operatorname varchar(100),
		sessactive varchar(2),
		TransactionLocation Varchar(100)
	)
           
				declare
				@start datetime,
				@SessionID int

				set @start = @P_Date_
				set @SessionID = @SessionID_
                      
               
                      
				;with x as
				(  select
					al.TransNo, 
					al.ReceiptNo, 
					AL.TransDesc, 
					al.CreditAcctNum,
					isnull( al.CreditAmt,0.00) CreditAmt, 
					isnull(al.WinsAmt,0.00)  WinsAmt  
					from B3_ActivityLog al 
					left join (select sessnum, sessstart, sessend, operatorname, sessactive from  [dbo].[B3_SessionsJournal]) sj
					on sj.sessnum = al.sessnum         
					where al.sessNum = @SessionID 	
					and al.CreditAcctNum = @AccountNumber 
					and CAST(CONVERT(varchar(12), al.TransDate, 101) AS SMALLDATETIME)  = CAST(CONVERT(varchar(12), @start, 101) AS SMALLDATETIME)
					and al.TransDesc not in ('Game Start')
				    and TransDesc =   case when TransDesc != 'Cash Out' then 'Unlock Account' else 'Cash Out' end
				    --and TransNo = (     select MAX(TransNo) from B3_ActivityLog where CreditAcctNum = @AccountNumber and TransDesc = case when TransDesc != 'Cash Out' then 'Unlock Account' else 'Cash Out' end)
				    and ReceiptNo = (     select MAX(ReceiptNo) from B3_ActivityLog where CreditAcctNum = @AccountNumber and TransDesc = case when TransDesc != 'Cash Out' then 'Unlock Account' else 'Cash Out' end))
				  
					
					insert into @TransactionDetailReport
					select 
					al.TransType [TransType], 
					al.MAC, 
					al.TransNo, 
					al.ReceiptNo, 
					al.TransDate, 
					AL.TransDesc, 
					case 
					when LEN(al.CreditAcctNum) = 1 then '0000000'  + cast(al.CreditAcctNum as varchar(8))
					when LEN(al.CreditAcctNum) = 2 then '000000'  + cast(al.CreditAcctNum as varchar(8))
					when LEN(al.CreditAcctNum) = 3 then '00000'   + cast(al.CreditAcctNum as varchar(8))
					when LEN(al.CreditAcctNum) = 4 then '0000'  + cast(al.CreditAcctNum as varchar(8))
					when LEN(al.CreditAcctNum) = 5 then '000'  + cast(al.CreditAcctNum as varchar(8))
					when LEN(al.CreditAcctNum) = 6 then '00'  + cast(al.CreditAcctNum as varchar(8))
					when LEN(al.CreditAcctNum) = 7 then '0'  + cast(al.CreditAcctNum as varchar(8))
					else
					cast(al.CreditAcctNum as varchar(8)) end as CreditAcctNum,      
					isnull( z.CreditAmt ,al.CreditAmt) CreditAmt,   
					isnull( z.WinsAmt, al.WinsAmt)  WinsAmt,   
					/*al.WinsAmt,*/ al.UserName
					,al.SessNum, 
					sj.sessstart SessStart,
					case sessactive
						when 'T' then null 
						else   sj.sessend end SessEnd ,			  
					sj.operatorname, sessactive --into #T_TransactionDetail  
					,MachineName        
				from B3_ActivityLog al 
				left join	(select sessnum, sessstart, sessend, operatorname, sessactive from  [dbo].[B3_SessionsJournal]) sj
							on sj.sessnum = al.sessnum
				left join (	select y.* from x y
							inner join ( select max(TransNo) TransNo, ReceiptNo from x group by ReceiptNo) x on x.TransNo = y.TransNo AND x.ReceiptNo = y.ReceiptNo ) z
				on (z.CreditAcctNum = al.CreditAcctNum and AL.TransDesc = 'Credit Redemption')
				where al.sessNum = @SessionID
				and al.CreditAcctNum = @AccountNumber  
				and   
				CAST(CONVERT(varchar(12), al.TransDate, 101) AS SMALLDATETIME)  = CAST(CONVERT(varchar(12), @start, 101) AS SMALLDATETIME)
				and al.TransDesc not in ('Game Start')
				order by al.MAC,  al.TransNo, al.TransType ;
				
				
			
				
				declare @TransactionDetailReport2 table
				(
					TransType varchar(50),
					MAC varchar(50),
					TransNo varchar(50),
					ReceiptNo int,
					TransDate datetime,				
					TransDesc varchar(50),
					CreditAcctNum varchar(100),
					CreditAmt Money,
					WinsAmt money,
					UserName varchar(100),
					SessNum int,
					SessStart datetime,
					SessEnd datetime,
					operatorname varchar(100),
					sessactive varchar(2),
					TransactionLocation varchar(100)
				)
				
				if ((select IsNorthDakota from B3_SystemConfig ) = 'T')
				begin
				insert into @TransactionDetailReport2
					select 
					TransType,
					MAC ,
					TransNo ,
					ReceiptNo ,
					TransDate ,				
					TransDesc ,
					CreditAcctNum ,
					CreditAmt ,
					WinsAmt ,
					UserName,
					SessNum ,
					SessStart ,
					SessEnd ,
					operatorname ,
					sessactive ,
					TransactionLocation
					from @TransactionDetailReport order by TransDate asc
				end
				else 
				begin
				insert into @TransactionDetailReport2
					select 
					TransType,
					MAC ,
					TransNo ,
					ReceiptNo ,
					TransDate ,				
					TransDesc ,
					'xxxx' + substring(CreditAcctNum ,5,8) as CreditAcctNum,
					CreditAmt ,
					WinsAmt ,
					UserName,
					SessNum ,
					SessStart ,
					SessEnd ,
					operatorname ,
					sessactive ,
					TransactionLocation
					from @TransactionDetailReport order by TransDate asc
				end

				delete from @TransactionDetailReport
				
	--INSERT OUR FIRST RESULT SET
				
				insert into @FinalResult 
				(
					DateTimeTransaction ,
					ReceiptNumber ,
					TransactionType, 
					TransactionLocation, 
					GameNumber ,
					GameName,
					Credits ,
					BetAmount, 
					Denom ,
					NumberOfCardsWagered, 
					SerialCardNumberPlayed, 
					Win ,
					WinBalance,
					CreditBalance
				)
				select TransDate, ReceiptNo, TransDesc, TransactionLocation, Null, Null, CreditAmt, 0.00, 0.00,0,null, WinsAmt, 0.00, 0.00  from @TransactionDetailReport2
				
				--select * from @FinalResult


declare @Result table
(
DateTimeTransaction datetime,
ReceiptNumber int,
TransactionType varchar(100),
TransactionLocation varchar(100),
GameNumber int,
GameName varchar(100),
Credits int,
BetAmount int,
Denom int,
NumberOfCardsWagered int,
SerialCardNumberPlayed varchar(100),
Win int , -- (Win + Bonus)
WinBalance int, -- For dual Accounting
CreditBalance int
)



insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'Maya Money',
a.creditamt,
a.betamt,
 a.denom,
 case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end as [NumberOfCardsWagered],

 case  (case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end) 
 when 1 then cast(a.cardsn_1 AS varchar(10)) 
 when 2 then cast(a.cardsn_1 AS varchar(10)) +' to '+ cast(a.cardsn_2 AS varchar(10))
 when 3 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '*/+ cast(a.cardsn_3 AS varchar(10))
when 4 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '*/+ cast(a.cardsn_4 AS varchar(10))
when 5  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '*/+ cast(a.cardsn_5 AS varchar(10))
when 6  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '+ cast(a.cardsn_5 AS varchar(10)) +', '*/+ cast(a.cardsn_6 AS varchar(10))
end as [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.MayaMoney_GameJournal a 
where a.creditacctnum = @AccountNumber

insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'Jail Break',
a.creditamt,
a.betamt,
 a.denom,
 case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end as [NumberOfCardsWagered],

 case  (case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end) 
 when 1 then cast(a.cardsn_1 AS varchar(10)) 
 when 2 then cast(a.cardsn_1 AS varchar(10)) +' to '+ cast(a.cardsn_2 AS varchar(10))
 when 3 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '*/+ cast(a.cardsn_3 AS varchar(10))
when 4 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '*/+ cast(a.cardsn_4 AS varchar(10))
when 5  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '*/+ cast(a.cardsn_5 AS varchar(10))
when 6  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '+ cast(a.cardsn_5 AS varchar(10)) +', '*/+ cast(a.cardsn_6 AS varchar(10))
end as [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.JailBreak_GameJournal a 
where a.creditacctnum = @AccountNumber

insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'UkickEm',
a.creditamt,
a.betamt,
 a.denom,
1 [NumberOfCardsWagered],

'NA' [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.UKickEm_GameJournal a 
where a.creditacctnum = @AccountNumber


insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'Wild Ball',
a.creditamt,
a.betamt,
 a.denom,
 case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end as [NumberOfCardsWagered],

 case  (case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end) 
 when 1 then cast(a.cardsn_1 AS varchar(10)) 
 when 2 then cast(a.cardsn_1 AS varchar(10)) +' to '+ cast(a.cardsn_2 AS varchar(10))
 when 3 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '*/+ cast(a.cardsn_3 AS varchar(10))
when 4 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '*/+ cast(a.cardsn_4 AS varchar(10))
when 5  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '*/+ cast(a.cardsn_5 AS varchar(10))
when 6  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '+ cast(a.cardsn_5 AS varchar(10)) +', '*/+ cast(a.cardsn_6 AS varchar(10))
end as [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.WildBall_GameJournal a 
where a.creditacctnum = @AccountNumber


insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'Wild Fire',
a.creditamt,
a.betamt,
 a.denom,
 case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end as [NumberOfCardsWagered],

 case  (case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end) 
 when 1 then cast(a.cardsn_1 AS varchar(10)) 
 when 2 then cast(a.cardsn_1 AS varchar(10)) +' to '+ cast(a.cardsn_2 AS varchar(10))
 when 3 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '*/+ cast(a.cardsn_3 AS varchar(10))
when 4 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '*/+ cast(a.cardsn_4 AS varchar(10))
when 5  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '*/+ cast(a.cardsn_5 AS varchar(10))
when 6  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '+ cast(a.cardsn_5 AS varchar(10)) +', '*/+ cast(a.cardsn_6 AS varchar(10))
end as [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.WildFire_GameJournal a 
where a.creditacctnum = @AccountNumber

insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'Spirit76',
a.creditamt,
a.betamt,
 a.denom,
 case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end as [NumberOfCardsWagered],

 case  (case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end) 
 when 1 then cast(a.cardsn_1 AS varchar(10)) 
 when 2 then cast(a.cardsn_1 AS varchar(10)) +' to '+ cast(a.cardsn_2 AS varchar(10))
 when 3 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '*/+ cast(a.cardsn_3 AS varchar(10))
when 4 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '*/+ cast(a.cardsn_4 AS varchar(10))
when 5  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '*/+ cast(a.cardsn_5 AS varchar(10))
when 6  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '+ cast(a.cardsn_5 AS varchar(10)) +', '*/+ cast(a.cardsn_6 AS varchar(10))
end as [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.Spirit76_GameJournal a 
where a.creditacctnum = @AccountNumber


insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'Time Bomb',
a.creditamt,
a.betamt,
 a.denom,
 case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end as [NumberOfCardsWagered],
 --case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 --case when a.betplaced_card_6 = 'T' then 1 else 0 end as [NumberOfCardsWagered],

 case  (case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end )
 --case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 --case when a.betplaced_card_6 = 'T' then 1 else 0 end) 
 when 1 then cast(a.cardsn_1 AS varchar(10)) 
 when 2 then cast(a.cardsn_1 AS varchar(10)) +' to '+ cast(a.cardsn_2 AS varchar(10))
 when 3 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '*/+ cast(a.cardsn_3 AS varchar(10))
when 4 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '*/+ cast(a.cardsn_4 AS varchar(10))
--when 5  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '*/+ cast(a.cardsn_5 AS varchar(10))
--when 6  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '+ cast(a.cardsn_5 AS varchar(10)) +', '*/+ cast(a.cardsn_6 AS varchar(10))
end as [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.TimeBomb_GameJournal a 
where a.creditacctnum = @AccountNumber


insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'Crazy Bout',
a.creditamt,
a.betamt,
 a.denom,
 case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end as [NumberOfCardsWagered],

 case  (case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end) 
 when 1 then cast(a.cardsn_1 AS varchar(10)) 
 when 2 then cast(a.cardsn_1 AS varchar(10)) +' to '+ cast(a.cardsn_2 AS varchar(10))
 when 3 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '*/+ cast(a.cardsn_3 AS varchar(10))
when 4 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '*/+ cast(a.cardsn_4 AS varchar(10))
when 5  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '*/+ cast(a.cardsn_5 AS varchar(10))
when 6  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '+ cast(a.cardsn_5 AS varchar(10)) +', '*/+ cast(a.cardsn_6 AS varchar(10))
end as [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.CrazyBout_GameJournal a 
where a.creditacctnum = @AccountNumber

declare @Result2 table
(
DateTimeTransaction datetime,
ReceiptNumber int,
TransactionType varchar(100),
TransactionLocation varchar(100),
GameNumber int,
GameName varchar(100),
Credits int,
BetAmount int,
Denom int,
NumberOfCardsWagered int,
SerialCardNumberPlayed varchar(100),
Win int , -- (Win + Bonus)
WinBalance int, -- For dual Accounting
CreditBalance int
)
insert into @Result2
select DateTimeTransaction, 
ReceiptNumber ,
TransactionType, 
TransactionLocation, 
GameNumber ,
GameName ,
Credits ,
BetAmount, 
Denom ,
NumberOfCardsWagered ,
--substring(SerialCardNumberPlayed, 0 ,len(SerialCardNumberPlayed)),
SerialCardNumberPlayed,
Win ,
 (select SUM(b.Win) from @Result b where b.DateTimeTransaction <= a.DateTimeTransaction),
 CreditBalance from @Result a 
 
 delete from @Result
 
 insert into @FinalResult 
				(
					DateTimeTransaction ,
					ReceiptNumber ,
					TransactionType, 
					TransactionLocation, 
					GameNumber ,
					GameName,
					Credits ,
					BetAmount, 
					Denom ,
					NumberOfCardsWagered, 
					SerialCardNumberPlayed, 
					Win ,
					WinBalance,
					CreditBalance
				)select * from @Result2
				
				update @FinalResult
				set GameSite = (select sitename FROM B3_SystemConfig)
				,OperatorName = (select operatorname from B3_SessionsJournal where sessnum = @SessionID_)
				,Credits = Credits + BetAmount 
				
				select 	DateTimeTransaction ,
					ReceiptNumber ,
					TransactionType, 
					TransactionLocation, 
					GameNumber ,
					GameName,
					Credits ,
					BetAmount, 
					Denom ,
					NumberOfCardsWagered, 
					SerialCardNumberPlayed, 
					Win ,
					WinBalance,
					CreditBalance,
					OperatorName,
					GameSite from @FinalResult order by DateTimeTransaction asc
				
				







GO



USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_rptCheckCardIfWin3]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_rptCheckCardIfWin3]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



--USE [B3]
--GO

--/****** Object:  StoredProcedure [dbo].[b3_fnCheckCardIfWin3]    Script Date: 11/29/2015 1:31:35 PM ******/
--DROP PROCEDURE [dbo].[b3_fnCheckCardIfWin3]
--GO

--/****** Object:  StoredProcedure [dbo].[b3_fnCheckCardIfWin3]    Script Date: 11/29/2015 1:31:35 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


CREATE PROC [dbo].[usp_management_rptCheckCardIfWin3]
--Function Variable
(
	@TempN int,
	@BallCall varchar(1000),
	@m_CardN int,
	@Exists BIT Output
)
--returns bit 
AS
begin
--Function return
	--declare @Exists bit 
	set @Exists = 1
	DECLARE @command nvarchar(4000);
	DECLARE @ParmDefinition nvarchar(500);
	declare @WinningNumber varchar(50) set @WinningNumber = ''
	declare @TempWinningCardNumber int

	select @command = 'select  @cardNumber = cardnum_' +  CAST(@TempN as varchar(10)) + ' from dbo.B3_CardPerm_GTI_250K where cardNumber = @cardN' 
	set @ParmDefinition = N'@cardN int,   @cardNumber int OUTPUT'
	EXECUTE sp_executesql @command, @ParmDefinition, @cardN = @m_CardN, @cardNumber = @TempWinningCardNumber OUTPUT	
	set @WinningNumber = @WinningNumber + cast(@TempWinningCardNumber as varchar(10)) +','
	declare @x varchar(10)	set @x = ','+ cast(@TempWinningCardNumber as varchar(10)) +',' 	

	if (CHARINDEX(@x , @BallCall )) > 0
	begin
	set @Exists = 1
	end
	else
	begin
	set @Exists = 0--No winner.
	end

	return
	 --@Exists
end




GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_rptGetJackpotSummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_rptGetJackpotSummary]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_management_rptGetJackpotSummary]
	@nDate datetime
	,@nSessNum int
AS
	SET NOCOUNT ON

--set @nDate = 	(SELECT CONVERT(VARCHAR(10), @nDate, 101)) --Date only no time

		SELECT 
	jj.recnum, 
	jj.sessnum, 
	sessactive, 
	sessstart, 
	sessend, 
	operatorname, 
	jj.clientmac, 
	jj.clientname
	, acctnum, 
	gamename, 
	jj.gamenum, 
	jackpotlimit, 
	jackpotamt, 
	jackpotevent,
	cn.CardNumbers as CardNum
	FROM b3.dbo.B3_JackpotJournal jj 
	left join b3.dbo.B3_fnGetJackpotWinningCardNumber(@nSessNum) cn on cn.GameNum = jj.gamenum
	WHERE jj.sessnum = @nSessNum
	--and  @nDate between sessstart and sessend
	ORDER BY jackpotevent DESC




GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_rptGetSessionsSummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_rptGetSessionsSummary]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[usp_management_rptGetSessionsSummary]
@DateTime datetime,
@SessionN int
AS
SET NOCOUNT ON


declare @SessEndDateTime datetime
set @SessEndDateTime =  DATEADD( ss,-1,CONVERT(VARCHAR(10), dateadd(dd, 1, @DateTime), 101))     

set @DateTime = CONVERT(VARCHAR(10),  @DateTime, 101)

declare @SessionNumber int
set @SessionNumber = (select top 1 sessnum from b3.dbo.B3_SessionsJournal where sessstart between @DateTime and @SessEndDateTime order by sessnum desc)

	DECLARE @nSessNum int, @nRecCount int
	DECLARE @Beginning_Date DateTime, @Ending_Date DateTime

	SELECT TOP 1 @nSessNum = sessnum, @Ending_Date = sessstart_dt
		FROM b3.dbo.B3_Session

	SET @Beginning_Date = @Ending_Date-1


--Will never be execute
if (@SessionNumber != (select MAX(sessnum) from b3.dbo.B3_SessionsJournal) OR @SessionNumber is null)--If its latest session, then no need to override.
	begin
	set @nSessNum = @SessionNumber
	set @Beginning_Date = @DateTime
	set @Ending_Date = @SessEndDateTime
	end
	
	
	if (select sessactive from B3_SessionsJournal where  sessnum = @SessionN) != 'T'
	begin

		set @Beginning_Date  = (select sessstart from B3_SessionsJournal where sessnum = @SessionN)
		set @Ending_Date  = (select sessend from B3_SessionsJournal where sessnum = @SessionN)
	
	end

	SELECT B3_SessionsJournal.sessnum, sessstart, sessend, operatorname
		, payoutlimit, payoutamt, jackpotlimit, jackpot_1_amt, jackpot_2_amt, jackpot_3_amt
		, acctssold, acctssoldamt, acctsredeem, acctsredeemamt
		, acctsoutstand, acctsoutstandamt, cardssold, cardssoldamt, acctsoutstandwinsamt
		,startingCreditAccountN, endingCreditAccountN
		,TransT.ToTalTransaction, TransT.TransactionStart, TransT.TransacionEnd, isnull(redeem_amt,0) redeem_amt, isnull(wincreditamt, 0) wincreditamt
		FROM b3.dbo.B3_SessionsJournal WITH (NOLOCK)
		left join (select MIN(creditacctnum) startingCreditAccountN , MAX(creditacctnum) endingCreditAccountN , sessnum 
				  from b3.dbo.B3_CreditJournal 
				  --where sessnum = @nSessNum
				  group by sessnum) creditAcctInfo on creditAcctInfo.sessnum = B3_SessionsJournal.sessnum
		left join (select  count(distinct receiptno) ToTalTransaction , x.sessNum, y.TransactionStart, z.TransacionEnd
					from dbo.B3_ActivityLog x
					join (select min(receiptno) TransactionStart , sessnum
					from dbo.B3_ActivityLog 
					where sessnum = @SessionN and receiptno is not null
					group by sessnum) y on y.sessNum = x.sessNum
					join (select max(receiptno) TransacionEnd , sessnum
					from dbo.B3_ActivityLog 
					where sessnum = @SessionN and receiptno is not null
					group by sessnum) z on z.sessNum = x.sessNum
					where x.sessNum = @SessionN and receiptno is not null
					group by x.sessnum,  y.TransactionStart, z.TransacionEnd)
					 TransT  on TransT.sessNum = b3.dbo.B3_SessionsJournal.sessnum
		left join (
				SELECT ISNULL(SUM(redeem_amt), 0) redeem_amt, ISNULL(SUM(wincreditamt), 0) wincreditamt, sessnum
					FROM B3_CreditJournal WITH (NOLOCK) 
						WHERE sessnum = @SessionN AND acctstatus = 'REDEEM'
						group by sessnum) a on a.sessnum = b3.dbo.B3_SessionsJournal.sessnum				
			WHERE
				--		CONVERT(varchar(110),sessstart , 10)	 BETWEEN 	CONVERT(varchar(110),@Beginning_Date , 10) AND 	CONVERT(varchar(110),@Ending_Date , 10) 
				--AND
				--B3_SessionsJournal.[sessnum] <= @nSessNum
				B3_SessionsJournal.[sessnum] = @SessionN
				ORDER BY B3_SessionsJournal.sessnum		










GO




USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_server_rptBallCall]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_server_rptBallCall]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE proc [dbo].[usp_server_rptBallCall]
    (@session int,
    @DateParameter datetime
    )
as
-- ============================================================================
-- Date: 2015/01/06
--  Generates a result set that contains the balls that were called for a
--  B4 session
--  20150915(knc): Include B3 class III ball call but not union with the Class II.
--  20160217(knc): Add parameter input for reporting purposes.
-- ============================================================================

    -- The table that will contain all of the game and
    --  ball call information needed for the report
    declare @GameBallData table
        (ServerGameNumber int
        , DTStamp smalldatetime
        , GameTypeId int
        , GameTableName nvarchar(32)
        , GameName nvarchar(32)
        , GameBallCount int
        , GameBalls nvarchar(max)
        , BonusBallCount int
        , BonusBalls nvarchar(max))

    declare @gameName varchar(100)
        , @tablePrefix varchar(32)
        , @ballCount int
        , @gameNumber int
        , @bonusBallCount int
        
    -- Gather all of the base game data
    insert into @GameBallData
        (ServerGameNumber
        , DTSTamp
        , GameTypeId
        , GameTableName
        , GameName
        , GameBallCount)
    select distinct
        sg.ServerGame
        , sg.DTStamp
        , sgj.GameTypeId
        , sgt.TableName
        , sgt.DisplayName
        , case when ConsolationBallIndex is null then 24 else (ConsolationBallIndex - 1) end -- Index is 1 based
        from Server_Game sg
            join Server_GameJournal sgj on sg.ServerGame = sgj.ServerGameNumber
            join Server_GameTypes sgt on sgj.GameTypeId = sgt.GameTypeId
        where SessionNumber = @session

    -- Gather all of the bonus game data to determine if a bonus game was played and
    --  how many balls were called 
    declare @BonusGames table
        (ServerGameNumber int
        , GameTypeId int
        , BallCount int)

    -- Find all of the Crazy Bout bonus games
    insert into @BonusGames
    select s.ServerGameNumber, s.GameTypeId, cb.bonuscallcount
        from CrazyBout_GameJournal cb
            join Server_GameJournal s on cb.gameNum = s.GameNumber
    where sessnum = @session and gametypeid = 36 and bonuscardsn_1 != 0 and bonusofferaccepted != 0
    group by s.ServerGameNumber, cb.bonusCallCount, s.GameTypeId
    


    -- Find all of the Jail Break bonus games
    insert into @BonusGames
    select s.ServerGameNumber, s.GameTypeId, jb.bonuscallcount
        from JailBreak_GameJournal jb
            join Server_GameJournal s on jb.gameNum = s.GameNumber
    where sessnum = @session and gametypeid = 37 and jb.bonuscardsn_1 != 0 and jb.bonusofferaccepted != 0
    group by s.ServerGameNumber, jb.bonuscallcount, s.GameTypeId
    
    -- update the bonus ball count in the results table
    update @GameBallData
    set BonusBallCount = bg.BallCount
    from @GameBallData gbd
        join @BonusGames bg on gbd.ServerGameNumber = bg.ServerGameNumber
    where gbd.ServerGameNumber = bg.ServerGameNumber and gbd.GameTypeId = bg.GameTypeId
    
    -- Use the cursor for generating a list of balls that were called and updating the
    --  results table.  This will convert the columns to a comma separated list of
    --  balls and update the appropriate columns in the results table
    declare ballList_cursor cursor for
    select ServerGameNumber, GameBallCount, BonusBallCount
    from @GameBallData
    order by ServerGameNumber
    
    declare @gameBalls nvarchar(max)
        , @bonusBalls nvarchar(max)
        , @sqlCommand nvarchar(max)
        , @parameters nvarchar(500)
    
    open ballList_cursor
    fetch next from ballList_cursor
    into @gameNumber, @ballCount, @bonusBallCount
    while @@fetch_status = 0
    begin
        
        -- empty the strings
        select @gameBalls = ''
            , @bonusBalls = ''
    
        -- Construct an sql command that will do the conversion
        set @parameters = '@gameBalls_Out nvarchar(500) output, @bonusBalls_Out nvarchar(500) output'
        set @sqlCommand = 'select @gameBalls_Out = '
                        + coalesce ('(' + dbo.b3_fnGetBallColumnList (@ballCount) + ')', '')
                        + coalesce (', @bonusBalls_Out = (' + dbo.b3_fnGetBallColumnList (@bonusBallCount) + ')', '')
                        + ' from Server_Game where ServerGame = '
                        + cast (@gameNumber as nvarchar)
                        
        exec sp_executesql @sqlCommand, @parameters, @gameBalls_Out = @gameBalls output, @bonusBalls_Out = @bonusBalls output;
        
        -- Now that the ball list has been created update the result table
        update @GameBallData
        set GameBalls = @gameBalls
            , BonusBalls = @bonusBalls
        where ServerGameNumber = @gameNumber 

        fetch next from ballList_cursor
        into @gameNumber, @ballCount, @bonusBallCount
    end
    close ballList_cursor
    deallocate ballList_cursor

--Is either B3 class II or Class III
if (select COUNT(*) from @GameBallData) != 0 --Class II
begin   
    select ServerGameNumber
        , DTStamp
        , GameTypeId
        , GameName
        , GameBallCount
        , GameBalls
        , BonusBallCount
        , BonusBalls
        ,'' as UserID --Just for test
    from @GameBallData
	order by ServerGameNumber   
end

else --Class III
begin

    select 
    ServerGameNumber ,
	DTStamp , 
	GameTypeID ,  
	GameName  ,                 
	GameBallCount ,
	GameBalls ,
	BonusBallCount ,
	BonusBalls,
	staff.UserName as UserID
	from  dbo.B3_fnGetBallCallB3(@session) x
	left join  dbo.B3_Login staff on staff.LoginID = x.StaffID 
	 order by ServerGameNumber    
end  







GO




















GO















































