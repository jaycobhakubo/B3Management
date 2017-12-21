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

--USE [B3]
--GO

--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_fnGetBallCallB3]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
--DROP FUNCTION [dbo].[B3_fnGetBallCallB3]
--GO

--USE [B3]
--GO

--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO







CREATE function [dbo].[B3_fnGetBallCallB3]
(
@SessionNumber int
)
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
begin
--=============================
-- Author:		Karlo Camacho
-- Date:		20150915
-- Dscription:	Get the ball call per game in B3 not Class II.
--				If B3 system session played both B3 class II and III then it will only report class II game. 
--=============================

--===========TEST==============
--declare @SessionNumber int
--set @SessionNumber = 1032
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


                    ;with BallCall_cte 
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
          UNION ALL
                    select  'Wild Ball' [Game Name] ,cbj.recdatetime [Gaming Date], clientmac, clientname ,cbj.sessnum, 
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
                          + convert (char(2), cbj.[bonusball_24]))   
                        --  + (select dbo.b3_fnGetBonusBallCallWillBall(ServerGameNumber))
                          else '' end as    BonusBall    , (select dbo.b3_fnGetStaffIDBallCallChange(cbj.recdatetime))   
                   
   
                          
                    from dbo.WildBall_GameJournal cbj
                     join dbo.B3_SessionsJournal sj
                     on sj.sessnum = cbj.sessnum
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
					









GO


