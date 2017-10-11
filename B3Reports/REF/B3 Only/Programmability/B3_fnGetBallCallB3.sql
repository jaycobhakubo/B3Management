USE [B3]
GO

DROP FUNCTION [dbo].[B3_fnGetBallCallB3]
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
-- Author:		Karlo Camacho
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


