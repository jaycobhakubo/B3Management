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
AS BEGIN
----==========TEST==============
--Declare 
--	@SessionNum int, 
--	@DateRun datetime
	
--SET @SessionNum = 1021
--SET @DateRun = '12/28/2017 00:00:00'
--BEGIN
--=============================


IF OBJECT_ID('tempdb..#TempResults') IS not null drop table #TempResults
CREATE TABLE #TempResults 
(
	SessNum int,
	GameNum	int,
	ServerGameNum int,
	GameDate DateTime,
	GameName varchar(32),
	GameTypeId int,
	PayoutType varchar(32),
	ClientName char(11),
	CreditAcctNum int,
	Denom money,
	BetLevel int,
	NumberWinners int,
	WinAmount money,
	PatternName varchar(32)
)

DECLARE @sqlCommand nvarchar(max)
DECLARE @ListOfAvailableGames TABLE
(
	GameTypeId INT,
	GameNameAlias VARCHAR(50),
	GameTableName varchar(50)
)

INSERT INTO @ListOfAvailableGames (GameTypeId, GameNameAlias, GameTableName) VALUES  (36, 'Crazy Bout', 'CrazyBout')
INSERT INTO @ListOfAvailableGames (GameTypeId, GameNameAlias, GameTableName) VALUES  (37, 'Jailbreak', 'JailBreak')
INSERT INTO @ListOfAvailableGames (GameTypeId, GameNameAlias, GameTableName) VALUES  (38, 'Maya Money', 'MayaMoney')
INSERT INTO @ListOfAvailableGames (GameTypeId, GameNameAlias, GameTableName) VALUES  (41, 'Wild Ball', 'WildBall')
INSERT INTO @ListOfAvailableGames (GameTypeId, GameNameAlias, GameTableName) VALUES  (42, 'Time Bomb', 'TimeBomb')
INSERT INTO @ListOfAvailableGames (GameTypeId, GameNameAlias, GameTableName) VALUES  (39, 'Spirit of 76', 'Spirit76')



DECLARE @GameTypeId INT
DECLARE @GameNameAlias VARCHAR(50)
DECLARE @GameTableName VARCHAR(50)

DECLARE	GetResultCursor	CURSOR FOR
SELECT	GameTypeId, GameNameAlias, GameTableName	FROM @ListOfAvailableGames 
OPEN	GetResultCursor FETCH NEXT FROM GetResultCursor
INTO	@GameTypeId, @GameNameAlias, @GameTableName

WHILE @@FETCH_STATUS = 0
BEGIN

--=========================================
-- INSTANT game BINGO EXTRA BONUS GAME WINNERS
--=========================================
    if (@GameTypeId != 42)--TIMEBOMB!
    BEGIN
		set @sqlCommand = 
		'
			insert into #TempResults (SessNum,GameNum,ServerGameNum,GameDate,GameName,GameTypeId,PayoutType,ClientName,CreditAcctNum,Denom,BetLevel,NumberWinners,WinAmount,PatternName)
			Select cb.sessnum,cb.gamenum,(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = '+cast(@GameTypeId as varchar(10))+'),cb.recdatetime,'''+@GameNameAlias+''','+cast(@GameTypeId as varchar(10))+',''Extra Bonus'',cb.clientname,cb.creditacctnum,(cb.Denom / 100.00),cb.BetLevel,1,(cb.gamewinamt / 100.00),''Coverall''
			From '+@GameTableName+'_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
			Where sj.sessnum = '+CAST(@SessionNum as varchar(10))+'And cb.gamewinamt <> 0 And cb.numofwins_patt_1 = 0 And cb.numofwins_patt_2 = 0 And cb.numofwins_patt_3 = 0 And cb.numofwins_patt_4 = 0 And cb.numofwins_patt_5 = 0 And cb.numofwins_patt_6 = 0 And cb.numofwins_patt_7 = 0 And cb.numofwins_patt_8 = 0 And cb.numofwins_patt_9 = 0 And cb.numofwins_patt_10 = 0And cb.numofwins_patt_11 = 0 And cb.numofwins_patt_12 = 0
		 '                 
		exec (@sqlCommand) 
	END
	ELSE
	BEGIN

		set @sqlCommand = 
		'
			insert into #TempResults (SessNum,GameNum,ServerGameNum,GameDate,GameName,GameTypeId,PayoutType,ClientName,CreditAcctNum,Denom,BetLevel,NumberWinners,WinAmount,PatternName)
			Select cb.sessnum,cb.gamenum,(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = '+cast(@GameTypeId as varchar(10))+'),cb.recdatetime,'''+@GameNameAlias+''','+cast(@GameTypeId as varchar(10))+',''Extra Bonus'',cb.clientname,cb.creditacctnum,(cb.Denom / 100.00),cb.BetLevel,1,(cb.gamewinamt / 100.00),''Coverall''
			From '+@GameTableName+'_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
			Where sj.sessnum = '+CAST(@SessionNum as varchar(10))+'And cb.gamewinamt <> 0 And cb.numofwins_patt_1 = 0 And cb.numofwins_patt_2 = 0 And cb.numofwins_patt_3 = 0 And cb.numofwins_patt_4 = 0 And cb.numofwins_patt_5 = 0 And cb.numofwins_patt_6 = 0 
		 '          
		exec (@sqlCommand)
	END

--==================================
--INSERT BINGO INSTANT WINNERS PATTERN 1 to 12
--==================================

	DECLARE @CountPatternId int set @CountPatternId = 1
	WHILE (@CountPatternId != 13)
	BEGIN
	 set @sqlCommand = 
		 '
			insert into #TempResults 
			(
				SessNum,GameNum,ServerGameNum,GameDate,GameName,GameTypeId,PayoutType,ClientName,CreditAcctNum,
				Denom,BetLevel,NumberWinners,WinAmount,PatternName
			)
				Select	cb.sessnum,
				cb.gamenum,
				(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = '+cast(@GameTypeId as varchar(10))+'),
				cb.recdatetime,
				'''+@GameNameAlias+''',
				'++cast(@GameTypeId as varchar(10))+',
				''Regular'',
				cb.clientname,
				cb.creditacctnum,
				(cb.denom / 100.0),
				cb.betlevel,
				cb.numofwins_patt_'+cast(@CountPatternId as varchar(10))+',
				((cb.winamt_patt_'+cast(@CountPatternId as varchar(10))+' / cb.numofwins_patt_'+cast(@CountPatternId as varchar(10))+') / 100.0),
				(Select patternname from '+@GameTableName+'_GamePatterns where patternid = '+cast(@CountPatternId as varchar(10))+')
				From '+@GameTableName+'_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
				Where sj.sessnum = '+CAST(@SessionNum as varchar(10))+'
				And cb.numofwins_patt_'+cast(@CountPatternId as varchar(10))+' <> 0
				And cb.winamt_patt_'+cast(@CountPatternId as varchar(10))+' <> 0

		 '		 
	
		 IF (@CountPatternId = 7 AND @GameTypeId = 42)
		 BEGIN
		      Break
		 END
		 
		 exec (@sqlCommand)
		 set @CountPatternId += 1
	END
	
----=====================================
----INSERT GAME BINGO BONUS ROUND WINNERS 1 to 12
----=====================================	
	if (@GameTypeId != 38 AND @GameTypeId != 42)--TimeBomb No Bonus Round
	--Maya Money Had a different way of getting the bonus round winners.
	BEGIN
		set @CountPatternId = 1
		WHILE (@CountPatternId != 13)
		BEGIN
		set @sqlCommand = 
		'
			insert into #TempResults 
			(
				SessNum,GameNum,ServerGameNum,GameDate,GameName,GameTypeId,PayoutType,
				ClientName,CreditAcctNum,Denom,BetLevel,NumberWinners,WinAmount,PatternName		
			)
			Select	cb.sessnum,
			cb.gamenum,
			(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID ='+cast(@GameTypeId as varchar(10))+'),
			cb.recdatetime,
			'''+@GameNameAlias+''',
			'++cast(@GameTypeId as varchar(10))+',
			''Bonus'',
			cb.clientname,
			cb.creditacctnum,
			(cb.denom / 100.0),
			cb.betlevel,
			cb.numofwins_bonuspatt_'+cast(@CountPatternId as varchar(10))+',
			((cb.bonuswinamt_patt_'+cast(@CountPatternId as varchar(10))+' / cb.numofwins_bonuspatt_'+cast(@CountPatternId as varchar(10))+') / 100.0),
			(Select patternname from '+@GameTableName+'_BonusPatterns where patternid = '+cast(@CountPatternId as varchar(10))+')
			From '+@GameTableName+'_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
			Where sj.sessnum =  '+CAST(@SessionNum as varchar(10))+'
			And cb.numofwins_bonuspatt_'+cast(@CountPatternId as varchar(10))+' <> 0
			And cb.bonuswinamt_patt_'+cast(@CountPatternId as varchar(10))+' <> 0
		 ' 
		 --select @sqlCommand
		set @CountPatternId += 1                
		exec (@sqlCommand)
		END
	END
	else IF (@GameTypeId = 38)
	BEGIN
		Insert into #TempResults 
		(
		SessNum,
		GameNum,
		ServerGameNum,
		GameDate,
		GameName,
		GameTypeId,
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
		38,
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
	END
	

FETCH NEXT FROM GetResultCursor  INTO	@GameTypeId, @GameNameAlias, @GameTableName
    
END
close GetResultCursor
deallocate GetResultCursor

--insert into @Results 
--select  * from #TempResults 

declare @Result2 table
(
	    SessNum int,
		GameNum	int,
		ServerGameNum int,
		GameDate DateTime,
		GameName varchar(32),
		GameTypeId int,
		PayoutType varchar(32),
		ClientName char(11),
		CreditAcctNum varchar(100),
		Denom money,
		BetLevel int,
		NumberWinners int,
		WinAmount money,
		PatternName varchar(32),
		WinningCardNumber nvarchar(4000),
		IsServerGame bit
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
		GameTypeId,
		PayoutType ,
		ClientName ,
		CreditAcctNum ,
		Denom ,
		BetLevel ,
		NumberWinners ,
		WinAmount ,
		PatternName ,
		IsServerGame
)
Select 
		SessNum ,
		GameNum	,
		ISNULL(ServerGameNum ,Gamenum) ServerGameNum,
		GameDate ,
		GameName ,
		GameTypeId,
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
		PatternName ,
		case  when ServerGameNum is null  then 0 else 1 end
					--(select dbo.B3_fnGetWinningCardNumber(PatternName, SessNum, 1, GameNum ))  as WinningCardNumber  
From #TempResults 
Group By SessNum, GameNum, ServerGameNum, GameDate, GameName, PayoutType, CreditAcctNum, ClientName, Denom, BetLevel, WinAmount, NumberWinners, PatternName, GameTypeId --, GameWinAmt, BonusWinAmt, TotalPaidAmt
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
		GameTypeId,
		PayoutType ,
		ClientName ,
		CreditAcctNum ,
		Denom ,
		BetLevel ,
		NumberWinners ,
		WinAmount ,
		PatternName,
		IsServerGame  
)
Select 
		SessNum ,
		GameNum	,
		ISNULL(ServerGameNum ,Gamenum) ServerGameNum,
		GameDate ,
		GameName ,
		GameTypeId,
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
		PatternName, 
		case  when ServerGameNum is null  then 0 else 1 end
		--(select dbo.B3_fnGetWinningCardNumber(PatternName, SessNum, 1, GameNum ))  as WinningCardNumber
From #TempResults 
Group By SessNum, GameNum, ServerGameNum, GameDate, GameName, PayoutType, CreditAcctNum, ClientName, Denom, BetLevel, WinAmount, NumberWinners, PatternName, GameTypeId --, GameWinAmt, BonusWinAmt, TotalPaidAmt
Order By ServerGameNum
end



IF OBJECT_ID('tempdb..#TempResults') IS not null drop table #TempResults

declare @ServerGamenum int, @RegGameNumber int, @PayoutType int, @Pattername varchar(50), @SessionNumber int, @GameName varchar(50), @IsServerGame bit

declare GetWinningCardNumber_Cursor cursor
for 
select 
		SessNum,
		ServerGameNum ,
		GameNum	,
		GameName ,
		case when PayoutType = 'Regular' then 0 else 1 end,
		PatternName,
		IsServerGame 
		,GameTypeId
		from @Result2 

		open GetWinningCardNumber_Cursor
		FETCH NEXT FROM GetWinningCardNumber_Cursor 
	    INTO  @SessionNumber, @ServerGamenum, @RegGameNumber, @GameName,  @PayoutType,  @Pattername, @IsServerGame, @GameTypeId
		
		while @@fetch_status = 0
		begin
		
	    declare @WinningCardNumber varchar(100)
	                                         --select @Pattername,  @SessionNumber, @PayoutType, @ServerGamenum, @RegGameNumber, @GameName,  @IsServerGame, @GameTypeId
		exec usp_management_Report_GetWinningCardNumber  @Pattername,  @SessionNumber, @PayoutType, @ServerGamenum, @RegGameNumber, @GameName,  @IsServerGame, @GameTypeId, @WinningCardNumber OUTPUT
	 
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
			end

					FETCH NEXT FROM GetWinningCardNumber_Cursor 
			INTO  @SessionNumber, @ServerGamenum, @RegGameNumber, @GameName,  @PayoutType,  @Pattername, @IsServerGame,  @GameTypeId
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
END



GO


