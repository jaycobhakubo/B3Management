USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_report_WinningCardReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_report_WinningCardReport]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--exec usp_management_report_WinningCardReport 1005, '1/26/2018 00:00:00'


CREATE PROC [dbo].[usp_management_report_WinningCardReport]
(
	@SessionNum INT, 
	@DateRun DATETIME
)
AS BEGIN

-- ==== TEST
--DECLARE 
--	@SessionNum INT, 
--	@DateRun DATETIME

--SET @SessionNum = 1006
--set @DateRun = '1/26/2018 00:00:00'
-- ===================


--===========
-- Author:	Karlo Camacho
-- Date:	20180126
-- Desc:	Query a result SET for which card number hit a specific pattern for every game 
-- Note:	This will only works after installing B3 b3 ver. 5.1



--==========
DECLARE @sqlCommand NVARCHAR(max)	
DECLARE @GameTypeId INT 
DECLARE @GameTABLEName VARCHAR(100) 
DECLARE @IsServerGame BIT
DECLARE @GameNameAliAS VARCHAR(50)
DECLARE @SessionNumber INT
DECLARE @ListOfAvailableGames TABLE
(
	GameTypeId INT,
	GameNameAliAS VARCHAR(50),
	GameTABLEName VARCHAR(50)
)

IF OBJECT_ID('tempdb..#WinningCardReportResult') IS not null DROP TABLE #WinningCardReportResult
CREATE TABLE #WinningCardReportResult 
(
	GameDate DATETIME,
	SessNum INT,
	GameNum	INT,
	ServerGameNum INT,
	GameName VARCHAR(32),
	CreditAcctNum INT,
	CardNumber VARCHAR(1000),
	PatternName VARCHAR(max),
	WinAmount INT
)
INSERT INTO @ListOfAvailableGames (GameTypeId, GameNameAliAS, GameTABLEName) VALUES  (36, 'Crazy Bout', 'CrazyBout')
INSERT INTO @ListOfAvailableGames (GameTypeId, GameNameAliAS, GameTABLEName) VALUES  (37, 'Jailbreak', 'JailBreak')
INSERT INTO @ListOfAvailableGames (GameTypeId, GameNameAliAS, GameTABLEName) VALUES  (38, 'Maya Money', 'MayaMoney')
INSERT INTO @ListOfAvailableGames (GameTypeId, GameNameAliAS, GameTABLEName) VALUES  (41, 'Wild Ball', 'WildBall')
INSERT INTO @ListOfAvailableGames (GameTypeId, GameNameAliAS, GameTABLEName) VALUES  (42, 'Time Bomb', 'TimeBomb')
INSERT INTO @ListOfAvailableGames (GameTypeId, GameNameAliAS, GameTABLEName) VALUES  (39, 'Spirit of 76', 'Spirit76')


SET @GameTypeId = 36
SET @SessionNumber = @SessionNum
SELECT 
	@IsServerGame =
	CASE 
	WHEN  MinPlayer = 1 THEN  0 
	ELSE  1 end
FROM Server_GameSETtings


   
DECLARE	GetResultCursor	CURSOR FOR
SELECT	GameTypeId, GameNameAliAS, GameTABLEName	FROM @ListOfAvailableGames 
OPEN	GetResultCursor FETCH NEXT FROM GetResultCursor
INTO	@GameTypeId, @GameNameAliAS, @GameTABLEName

WHILE @@FETCH_STATUS = 0
BEGIN

	DECLARE @WinningPatternCount INT 
	SET @WinningPatternCount = 1
	
	DECLARE @NofPattern INT SET @NofPattern = 13
	IF (@GameTypeId = 42) 
	BEGIN
		SET @NofPattern = 7
	END
	
	WHILE (@WinningPatternCount != @NofPattern)
	BEGIN

		SET @sqlCommand = 
		' insert INTo #WinningCardReportResult
			SELECT 
			gj.recDATETIME, 
			gj.sessnum,  
			gj.gamenum, 
			sg.ServerGameNumber, 
			'''+@GameNameAliAS+''',
			gj.creditacctnum,
			gw.CardNumber, 
			gw.WinningPatternName_'+CAST(@WinningPatternCount AS VARCHAR(10))+',  
			ISNULL(gw.WinningPatternAmount_'+CAST(@WinningPatternCount AS VARCHAR(10))+', 0)	 AS WinAmnt            		 
		   FROM dbo.'+@GameTABLEName+'_GameJournal  gj    
			join  dbo.'+@GameTABLEName+'_GameWinningCards gw on gj.gamenum = gw.GameNumber  
			join dbo.Server_GameJournal sg on sg.GameNumber = gj.gamenum and sg.GameTypeId = '+CAST(@GameTypeId AS VARCHAR(10))+'
			join (SELECT patternid, patternname FROM dbo.'+@GameTABLEName+'_GamePatterns where denom = 1) gp on gp.patternname = gw.WinningPatternName_'+CAST(@WinningPatternCount AS VARCHAR(10))+'
			where gj.sessnum = '+CAST(@SessionNumber AS VARCHAR(10))+'
			and gw.WinningPatternName_'+CAST(@WinningPatternCount AS VARCHAR(10))+'  IS NOT NULL'
		
	
	--select @sqlCommand
		--select * from CrazyBout_GameWinningCards

		EXEC (@sqlCommand)
		SET @WinningPatternCount = @WinningPatternCount + 1
	END


	FETCH NEXT FROM GetResultCursor  INTO	@GameTypeId, @GameNameAliAS, @GameTABLEName
    
END
CLOSE GetResultCursor
DEALLOCATE GetResultCursor

DECLARE @WinningCardReportResult TABLE
(
	GameDate DATETIME,
	SessNum INT,
	GameNum	INT,
	ServerGameNum INT,
	GameName VARCHAR(32),
	CreditAcctNum INT,
	CardNumber VARCHAR(1000),
	PatternName VARCHAR(max),
	WinAmount INT,
	NumberOfWinners INT
)

INSERT INTO @WinningCardReportResult
(
	GameDate ,
SessNum ,
GameNum	,
ServerGameNum ,
GameName ,
CreditAcctNum ,
CardNumber ,
PatternName,
WinAmount,
NumberOfWinners 
)
SELECT 
	GameDate AS [Date], 
	SessNum AS [Session],
	GameNum,
	ServerGameNum,
	GameName,
	CreditAcctNum,
	'',
	PatternName ,
	SUM(WinAmount) AS WinAmount,
	1 AS NumberWinners --no need for this, But need to add it to remap all column to the rpt file
	FROM #WinningCardReportResult Results
	GROUP BY 
	GameDate, SessNum, CreditAcctNum,	
	GameName,
	GameNum,
		ServerGameNum,
	PatternName
	
	
	
	DECLARE  @GameNum int, @PatternName varchar(100), @GameName varchar(100)
DECLARE	GetCardNumberWinPerGameCursor	CURSOR FOR
SELECT	 GameNum, PatternName, GameName	FROM @WinningCardReportResult
OPEN	GetCardNumberWinPerGameCursor FETCH NEXT FROM GetCardNumberWinPerGameCursor
INTO	 @GameNum, @PatternName, @GameName
WHILE @@FETCH_STATUS = 0
BEGIN	

--SELECT	*	FROM #WinningCardReportResult where GameNum = @GameNum and PatternName = @PatternName

 declare @CardNumber varchar (50) set @CardNumber = ''
 declare @CardNumberResult varchar(500) set @CardNumberResult = ''
		DECLARE	GetCardNumberWinCursor	CURSOR FOR
			SELECT	CardNumber	FROM #WinningCardReportResult where GameNum = @GameNum and PatternName = @PatternName and GameName = @GameName
			OPEN	GetCardNumberWinCursor FETCH NEXT FROM GetCardNumberWinCursor
			INTO	@CardNumber
			
			WHILE @@FETCH_STATUS = 0
			BEGIN	

			set @CardNumberResult = @CardNumberResult  + @CardNumber + ', '
			FETCH NEXT FROM GetCardNumberWinCursor  INTO	@CardNumber
	   
		  END
		close GetCardNumberWinCursor
		deallocate GetCardNumberWinCursor




update @WinningCardReportResult
set CardNumber = @CardNumberResult
where GameNum = @GameNum
and PatternName = @PatternName


FETCH NEXT FROM GetCardNumberWinPerGameCursor  INTO	 @GameNum, @PatternName, @GameName
   
  END
close GetCardNumberWinPerGameCursor
deallocate GetCardNumberWinPerGameCursor  
	
	
	SELECT 
	GameDate ,
SessNum ,
GameNum	,
ServerGameNum ,
GameName ,
case 
		when  len(CreditAcctNum) = 1 then 'xxxx000'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 2 then 'xxxx00'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) = 3 then 'xxxx0'+CAST(CreditAcctNum AS varchar(10))
		when  len(CreditAcctNum) >= 4 then 'xxxx'+ Substring(CAST(CreditAcctNum AS varchar(10)),4,8)
		end as CreditAcctNum  ,
LEFT(CardNumber, LEN(CardNumber) -1) as WinningCardNumbers ,
PatternName,
WinAmount,
NumberOfWinners 
from @WinningCardReportResult
	
 IF OBJECT_ID('tempdb..#WinningCardReportResult') IS NOT NULL DROP TABLE #WinningCardReportResult
 
END



GO


