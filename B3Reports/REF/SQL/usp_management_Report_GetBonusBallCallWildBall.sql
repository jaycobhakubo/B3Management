USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_Report_GetBonusBallCallWildBall]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_Report_GetBonusBallCallWildBall]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[usp_management_Report_GetBonusBallCallWildBall]
(
@gamenum int,
@IsServerGame bit,
@Results varchar(200) OUTPUT
)
AS  BEGIN
--=======TEST==========
--declare @gamenum int set @gamenum = 529
--declare @IsServerGame bit set @IsServerGame = 1
--declare @Results varchar(200)
--BEGIN
--=====================


DECLARE @FirstBallCallN int
DECLARE @BonusBallN varchar(10)
DECLARE @command nvarchar(4000);
DECLARE @ParmDefinition nvarchar(500);
DECLARE @NCall int
DECLARE @CountBall int

SET @CountBall = 0
SET @Results = ''

if (@IsServerGame = 0)
BEGIN
	SELECT @FirstBallCallN = bonusball_1 from WildBall_GameJournal where gamenum = @gamenum
END
ELSE
BEGIN
	declare @GameNumberNotServerGame int
	SELECT  @GameNumberNotServerGame = GameNumber from Server_GameJournal where ServerGameNumber = @gamenum --What happen if duplicate servergamenumber
	SELECT @FirstBallCallN = bonusball_1 from WildBall_GameJournal where gamenum = @GameNumberNotServerGame
	set @gamenum = @GameNumberNotServerGame
END


if (LEN(@FirstBallCallN) > 1)--Get the first ball call
BEGIN
  set @BonusBallN = SUBSTRING(cast(@FirstBallCallN as varchar(10)), 2,1) 
END
ELSE
BEGIN
	set @BonusBallN = @FirstBallCallN
END

While (@CountBall != 7)
BEGIN
	DECLARE @ballcallN int set @ballcallN = 1
	while (@ballcallN != 25)
	BEGIN

		set @command = 'select  @cardNumber = bonusball_' +  CAST(@ballcallN as varchar(10)) + ' from WildBall_GameJournal where gamenum = @gamenumN' 
		set @ParmDefinition = N'@gamenumN int, @cardNumber int OUTPUT'

		EXECUTE sp_executesql @command, @ParmDefinition,  @gamenumN = @gamenum, @cardNumber = @NCall OUTPUT			
		
		declare @Exist bit set @Exist = 0		  
		if (@NCall = @BonusBallN)
		BEGIN	      
			set @Exist = 1
			break
		END
	    
		set @ballcallN += 1
	END
		
	if (@Exist = 0)
	BEGIN
		set  @Results += CAST (@BonusBallN as varchar(10))+', '
	END
	
	set @BonusBallN += 10
	set @CountBall += 1	

END

set @Results = SUBSTRING(@Results,0, LEN(@Results))
--select @Results
return 

END





GO


