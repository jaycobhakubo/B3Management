USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[spRptBallCallSet]    Script Date: 3/4/2016 12:20:55 AM ******/
DROP PROCEDURE [dbo].[spRptBallCallSet]
GO

/****** Object:  StoredProcedure [dbo].[spRptBallCallSet]    Script Date: 3/4/2016 12:20:55 AM ******/
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


