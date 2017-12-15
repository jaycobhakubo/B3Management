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
--declare
@SessionNum int, 
@DateRun datetime

--set @SessionNum = 1053
--set @DateRun = '1/1/2015 00:00:00'
)
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

---- Insert Crazy Bout Bingo Extra Bonus game winners -------------------------------

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
		WinAmount,
		PatternName
)

Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Extra Bonus',
		cb.clientname,
		cb.creditacctnum,
		(cb.Denom / 100.00),
		cb.BetLevel,
		1,
		(cb.gamewinamt / 100.00),
		'Coverall'
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.gamewinamt <> 0
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
And cb.numofwins_patt_12 = 0

------ Insert Crazy Bout Bingo Instant Winners --------------------------

------ Pattern 1
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Regular',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_patt_1,
		((cb.winamt_patt_1 / cb.numofwins_patt_1) / 100.0),
		(Select patternname from CrazyBout_GamePatterns where patternid = 1)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_patt_1 <> 0
And cb.winamt_patt_1 <> 0

------ Pattern 2
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Regular',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_patt_2,
		((cb.winamt_patt_2 / cb.numofwins_patt_2) / 100.0),
		(Select patternname from CrazyBout_GamePatterns where patternid = 2)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_patt_2 <> 0
And cb.winamt_patt_2 <> 0

------ Pattern 3
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Regular',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_patt_3,
		((cb.winamt_patt_3 / cb.numofwins_patt_3) / 100.0),
		(Select patternname from CrazyBout_GamePatterns where patternid = 3)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_patt_3 <> 0
And cb.winamt_patt_3 <> 0

------ Pattern 4
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Regular',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_patt_4,
		((cb.winamt_patt_4 / cb.numofwins_patt_4) / 100.0),
		(Select patternname from CrazyBout_GamePatterns where patternid = 4)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_patt_4 <> 0
And cb.winamt_patt_4 <> 0

------ Pattern 5
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Regular',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_patt_5,
		((cb.winamt_patt_5 / cb.numofwins_patt_5) / 100.0),
		(Select patternname from CrazyBout_GamePatterns where patternid = 5)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_patt_5 <> 0
And cb.winamt_patt_5 <> 0

------ Pattern 6
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Regular',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_patt_6,
		((cb.winamt_patt_6 / cb.numofwins_patt_6) / 100.0),
		(Select patternname from CrazyBout_GamePatterns where patternid = 6)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_patt_6 <> 0
And cb.winamt_patt_6 <> 0

------ Pattern 7
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Regular',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_patt_7,
		((cb.winamt_patt_7 / cb.numofwins_patt_7) / 100.0),
		(Select patternname from CrazyBout_GamePatterns where patternid = 7)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_patt_7 <> 0
And cb.winamt_patt_7 <> 0

------ Pattern 8
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Regular',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_patt_8,
		((cb.winamt_patt_8 / cb.numofwins_patt_8) / 100.0),
		(Select patternname from CrazyBout_GamePatterns where patternid = 8)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_patt_8 <> 0
And cb.winamt_patt_8 <> 0

------ Pattern 9
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Regular',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_patt_9,
		((cb.winamt_patt_9 / cb.numofwins_patt_9) / 100.0),
		(Select patternname from CrazyBout_GamePatterns where patternid = 9)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_patt_9 <> 0
And cb.winamt_patt_9 <> 0

------ Pattern 10
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Regular',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_patt_10,
		((cb.winamt_patt_10 / cb.numofwins_patt_10) / 100.0),
		(Select patternname from CrazyBout_GamePatterns where patternid = 10)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_patt_10 <> 0
And cb.winamt_patt_10 <> 0

------ Pattern 11
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Regular',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_patt_11,
		((cb.winamt_patt_11 / cb.numofwins_patt_11) / 100.0),
		(Select patternname from CrazyBout_GamePatterns where patternid = 11)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_patt_11 <> 0
And cb.winamt_patt_11 <> 0

------ Pattern 12
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Regular',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_patt_12,
		((cb.winamt_patt_12 / cb.numofwins_patt_12) / 100.0),
		(Select patternname from CrazyBout_GamePatterns where patternid = 12)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_patt_12 <> 0
And cb.winamt_patt_12 <> 0

------------Insert Crazy Bout Bingo Bonus Round Winners -------------------------------------------------------------------

------ Bonus Pattern 1
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Bonus',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_bonuspatt_1,
		((cb.bonuswinamt_patt_1 / cb.numofwins_bonuspatt_1) / 100.0),
		(Select patternname from CrazyBout_BonusPatterns where patternid = 1)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_bonuspatt_1 <> 0
And cb.bonuswinamt_patt_1 <> 0

------ Bonus Pattern 2
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Bonus',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_bonuspatt_2,
		((cb.bonuswinamt_patt_2 / cb.numofwins_bonuspatt_2) / 100.0),
		(Select patternname from CrazyBout_BonusPatterns where patternid = 2)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_bonuspatt_2 <> 0
And cb.bonuswinamt_patt_2 <> 0

------ Bonus Pattern 3
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Bonus',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_bonuspatt_3,
		((cb.bonuswinamt_patt_3 / cb.numofwins_bonuspatt_3) / 100.0),
		(Select patternname from CrazyBout_BonusPatterns where patternid = 3)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_bonuspatt_3 <> 0
And cb.bonuswinamt_patt_3 <> 0

------ Bonus Pattern 4
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Bonus',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_bonuspatt_4,
		((cb.bonuswinamt_patt_4 / cb.numofwins_bonuspatt_4) / 100.0),
		(Select patternname from CrazyBout_BonusPatterns where patternid = 4)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_bonuspatt_4 <> 0
And cb.bonuswinamt_patt_4 <> 0

------ Bonus Pattern 5
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Bonus',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_bonuspatt_5,
		((cb.bonuswinamt_patt_5 / cb.numofwins_bonuspatt_5) / 100.0),
		(Select patternname from CrazyBout_BonusPatterns where patternid = 5)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_bonuspatt_5 <> 0
And cb.bonuswinamt_patt_5 <> 0

------ Bonus Pattern 6
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Bonus',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_bonuspatt_6,
		((cb.bonuswinamt_patt_6 / cb.numofwins_bonuspatt_6) / 100.0),
		(Select patternname from CrazyBout_BonusPatterns where patternid = 6)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_bonuspatt_6 <> 0
And cb.bonuswinamt_patt_6 <> 0

------ Bonus Pattern 7
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Bonus',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_bonuspatt_7,
		((cb.bonuswinamt_patt_7 / cb.numofwins_bonuspatt_7) / 100.0),
		(Select patternname from CrazyBout_BonusPatterns where patternid = 7)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_bonuspatt_7 <> 0
And cb.bonuswinamt_patt_7 <> 0

------ Bonus Pattern 8
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Bonus',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_bonuspatt_8,
		((cb.bonuswinamt_patt_8 / cb.numofwins_bonuspatt_8) / 100.0),
		(Select patternname from CrazyBout_BonusPatterns where patternid = 8)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_bonuspatt_8 <> 0
And cb.bonuswinamt_patt_8 <> 0

------ Bonus Pattern 9
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Bonus',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_bonuspatt_9,
		((cb.bonuswinamt_patt_9 / cb.numofwins_bonuspatt_9) / 100.0),
		(Select patternname from CrazyBout_BonusPatterns where patternid = 9)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_bonuspatt_9 <> 0
And cb.bonuswinamt_patt_9 <> 0

------ Bonus Pattern 10
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Bonus',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_bonuspatt_10,
		((cb.bonuswinamt_patt_10 / cb.numofwins_bonuspatt_10) / 100.0),
		(Select patternname from CrazyBout_BonusPatterns where patternid = 10)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_bonuspatt_10 <> 0
And cb.bonuswinamt_patt_10 <> 0

------ Bonus Pattern 11
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Bonus',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_bonuspatt_11,
		((cb.bonuswinamt_patt_11 / cb.numofwins_bonuspatt_11) / 100.0),
		(Select patternname from CrazyBout_BonusPatterns where patternid = 11)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_bonuspatt_11 <> 0
And cb.bonuswinamt_patt_11 <> 0

------ Bonus Pattern 12
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
		WinAmount,
		PatternName
		
)
Select	cb.sessnum,
		cb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = cb.gamenum and sgj.GameTypeID = 36 /* Crazy Bout Bingo */ ),
		cb.recdatetime,
		'Crazy Bout',
		'Bonus',
		cb.clientname,
		cb.creditacctnum,
		(cb.denom / 100.0),
		cb.betlevel,
		cb.numofwins_bonuspatt_12,
		((cb.bonuswinamt_patt_12 / cb.numofwins_bonuspatt_12) / 100.0),
		(Select patternname from CrazyBout_BonusPatterns where patternid = 12)
From CrazyBout_GameJournal cb join B3_SessionsJournal sj on cb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And cb.numofwins_bonuspatt_12 <> 0
And cb.bonuswinamt_patt_12 <> 0

---- Insert Jailbreak Extra Bonus game winners -------------------------------

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
		WinAmount,
		PatternName
)

Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Extra Bonus',
		jb.clientname,
		jb.creditacctnum,
		(jb.Denom / 100.00),
		jb.BetLevel,
		1,
		(jb.gamewinamt / 100.00),
		'Coverall'
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.gamewinamt <> 0
And jb.numofwins_patt_1 = 0
And jb.numofwins_patt_2 = 0
And jb.numofwins_patt_3 = 0
And jb.numofwins_patt_4 = 0
And jb.numofwins_patt_5 = 0
And jb.numofwins_patt_6 = 0
And jb.numofwins_patt_7 = 0
And jb.numofwins_patt_8 = 0
And jb.numofwins_patt_9 = 0
And jb.numofwins_patt_10 = 0
And jb.numofwins_patt_11 = 0
And jb.numofwins_patt_12 = 0

------ Insert Jailbreak Instant Winners --------------------------

------ Pattern 1
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Regular',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_patt_1,
		((jb.winamt_patt_1 / jb.numofwins_patt_1) / 100.0),
		(Select patternname from JailBreak_GamePatterns where patternid = 1)
From JailBreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_patt_1 <> 0
And jb.winamt_patt_1 <> 0

------ Pattern 2
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Regular',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_patt_2,
		((jb.winamt_patt_2 / jb.numofwins_patt_2) / 100.0),
		(Select patternname from JailBreak_GamePatterns where patternid = 2)
From JailBreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_patt_2 <> 0
And jb.winamt_patt_2 <> 0


------ Pattern 3
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Regular',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_patt_3,
		((jb.winamt_patt_3 / jb.numofwins_patt_3) / 100.0),
		(Select patternname from Jailbreak_GamePatterns where patternid = 3)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_patt_3 <> 0
And jb.winamt_patt_3 <> 0


------ Pattern 4
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Regular',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_patt_4,
		((jb.winamt_patt_4 / jb.numofwins_patt_4) / 100.0),
		(Select patternname from Jailbreak_GamePatterns where patternid = 4)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_patt_4 <> 0
And jb.winamt_patt_4 <> 0

------ Pattern 5
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Regular',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_patt_5,
		((jb.winamt_patt_5 / jb.numofwins_patt_5) / 100.0),
		(Select patternname from Jailbreak_GamePatterns where patternid = 5)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_patt_5 <> 0
And jb.winamt_patt_5 <> 0

------ Pattern 6
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Regular',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_patt_6,
		((jb.winamt_patt_6 / jb.numofwins_patt_6) / 100.0),
		(Select patternname from Jailbreak_GamePatterns where patternid = 6)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_patt_6 <> 0
And jb.winamt_patt_6 <> 0

------ Pattern 7
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Regular',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_patt_7,
		((jb.winamt_patt_7 / jb.numofwins_patt_7) / 100.0),
		(Select patternname from Jailbreak_GamePatterns where patternid = 7)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_patt_7 <> 0
And jb.winamt_patt_7 <> 0

------ Pattern 8
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Regular',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_patt_8,
		((jb.winamt_patt_8 / jb.numofwins_patt_8) / 100.0),
		(Select patternname from Jailbreak_GamePatterns where patternid = 8)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_patt_8 <> 0
And jb.winamt_patt_8 <> 0

------ Pattern 9
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Regular',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_patt_9,
		((jb.winamt_patt_9 / jb.numofwins_patt_9) / 100.0),
		(Select patternname from Jailbreak_GamePatterns where patternid = 9)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_patt_9 <> 0
And jb.winamt_patt_9 <> 0

------ Pattern 10
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Regular',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_patt_10,
		((jb.winamt_patt_10 / jb.numofwins_patt_10) / 100.0),
		(Select patternname from Jailbreak_GamePatterns where patternid = 10)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_patt_10 <> 0
And jb.winamt_patt_10 <> 0

------ Pattern 11
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Regular',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_patt_11,
		((jb.winamt_patt_11 / jb.numofwins_patt_11) / 100.0),
		(Select patternname from Jailbreak_GamePatterns where patternid = 11)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_patt_11 <> 0
And jb.winamt_patt_11 <> 0

------ Pattern 12
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Regular',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_patt_12,
		((jb.winamt_patt_12 / jb.numofwins_patt_12) / 100.0),
		(Select patternname from Jailbreak_GamePatterns where patternid = 12)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_patt_12 <> 0
And jb.winamt_patt_12 <> 0


------------Insert Jailbreak Bonus Round Winners -------------------------------------------------------------------

------ Bonus Pattern 1
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Bonus',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_bonuspatt_1,
		((jb.bonuswinamt_patt_1 / jb.numofwins_bonuspatt_1) / 100.0),
		(Select patternname from Jailbreak_BonusPatterns where patternid = 1)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_bonuspatt_1 <> 0
And jb.bonuswinamt_patt_1 <> 0

------ Bonus Pattern 2
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Bonus',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_bonuspatt_2,
		((jb.bonuswinamt_patt_2 / jb.numofwins_bonuspatt_2) / 100.0),
		(Select patternname from Jailbreak_BonusPatterns where patternid = 2)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_bonuspatt_2 <> 0
And jb.bonuswinamt_patt_2 <> 0

------ Bonus Pattern 3
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Bonus',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_bonuspatt_3,
		((jb.bonuswinamt_patt_3 / jb.numofwins_bonuspatt_3) / 100.0),
		(Select patternname from Jailbreak_BonusPatterns where patternid = 3)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_bonuspatt_3 <> 0
And jb.bonuswinamt_patt_3 <> 0

------ Bonus Pattern 4
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Bonus',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_bonuspatt_4,
		((jb.bonuswinamt_patt_4 / jb.numofwins_bonuspatt_4) / 100.0),
		(Select patternname from Jailbreak_BonusPatterns where patternid = 4)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_bonuspatt_4 <> 0
And jb.bonuswinamt_patt_4 <> 0

------ Bonus Pattern 5
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Bonus',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_bonuspatt_5,
		((jb.bonuswinamt_patt_5 / jb.numofwins_bonuspatt_5) / 100.0),
		(Select patternname from Jailbreak_BonusPatterns where patternid = 5)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_bonuspatt_5 <> 0
And jb.bonuswinamt_patt_5 <> 0

------ Bonus Pattern 6
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Bonus',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_bonuspatt_6,
		((jb.bonuswinamt_patt_6 / jb.numofwins_bonuspatt_6) / 100.0),
		(Select patternname from Jailbreak_BonusPatterns where patternid = 6)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_bonuspatt_6 <> 0
And jb.bonuswinamt_patt_6 <> 0

------ Bonus Pattern 7
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Bonus',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_bonuspatt_7,
		((jb.bonuswinamt_patt_7 / jb.numofwins_bonuspatt_7) / 100.0),
		(Select patternname from Jailbreak_BonusPatterns where patternid = 7)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_bonuspatt_7 <> 0
And jb.bonuswinamt_patt_7 <> 0

------ Bonus Pattern 8
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Bonus',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_bonuspatt_8,
		((jb.bonuswinamt_patt_8 / jb.numofwins_bonuspatt_8) / 100.0),
		(Select patternname from Jailbreak_BonusPatterns where patternid = 8)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_bonuspatt_8 <> 0
And jb.bonuswinamt_patt_8 <> 0

------ Bonus Pattern 9
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Bonus',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_bonuspatt_9,
		((jb.bonuswinamt_patt_9 / jb.numofwins_bonuspatt_9) / 100.0),
		(Select patternname from Jailbreak_BonusPatterns where patternid = 9)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_bonuspatt_9 <> 0
And jb.bonuswinamt_patt_9 <> 0

------ Bonus Pattern 10
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Bonus',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_bonuspatt_10,
		((jb.bonuswinamt_patt_10 / jb.numofwins_bonuspatt_10) / 100.0),
		(Select patternname from Jailbreak_BonusPatterns where patternid = 10)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_bonuspatt_10 <> 0
And jb.bonuswinamt_patt_10 <> 0

------ Bonus Pattern 11
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Bonus',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_bonuspatt_11,
		((jb.bonuswinamt_patt_11 / jb.numofwins_bonuspatt_11) / 100.0),
		(Select patternname from Jailbreak_BonusPatterns where patternid = 11)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_bonuspatt_11 <> 0
And jb.bonuswinamt_patt_11 <> 0

------ Bonus Pattern 12
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
		WinAmount,
		PatternName
		
)
Select	jb.sessnum,
		jb.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = jb.gamenum and sgj.GameTypeID = 37 /* Jailbreak */ ),
		jb.recdatetime,
		'Jailbreak',
		'Bonus',
		jb.clientname,
		jb.creditacctnum,
		(jb.denom / 100.0),
		jb.betlevel,
		jb.numofwins_bonuspatt_12,
		((jb.bonuswinamt_patt_12 / jb.numofwins_bonuspatt_12) / 100.0),
		(Select patternname from Jailbreak_BonusPatterns where patternid = 12)
From Jailbreak_GameJournal jb join B3_SessionsJournal sj on jb.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And jb.numofwins_bonuspatt_12 <> 0
And jb.bonuswinamt_patt_12 <> 0

---- Insert MayaMoney Extra Bonus game winners -------------------------------

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
		WinAmount,
		PatternName
)

Select	mm.sessnum,
		mm.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = mm.gamenum and sgj.GameTypeID = 38 /* MayaMoney */ ),
		mm.recdatetime,
		'Maya Money',
		'Extra Bonus',
		mm.clientname,
		mm.creditacctnum,
		(mm.Denom / 100.00),
		mm.BetLevel,
		1,
		(mm.gamewinamt / 100.00),
		'Coverall'
From MayaMoney_GameJournal mm join B3_SessionsJournal sj on mm.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And mm.gamewinamt <> 0
And mm.numofwins_patt_1 = 0
And mm.numofwins_patt_2 = 0
And mm.numofwins_patt_3 = 0
And mm.numofwins_patt_4 = 0
And mm.numofwins_patt_5 = 0
And mm.numofwins_patt_6 = 0
And mm.numofwins_patt_7 = 0
And mm.numofwins_patt_8 = 0
And mm.numofwins_patt_9 = 0
And mm.numofwins_patt_10 = 0
And mm.numofwins_patt_11 = 0
And mm.numofwins_patt_12 = 0

------ Insert MayaMoney Instant Winners --------------------------

------ Pattern 1
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
		WinAmount,
		PatternName
		
)
Select	mm.sessnum,
		mm.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = mm.gamenum and sgj.GameTypeID = 38 /* MayaMoney */ ),
		mm.recdatetime,
		'Maya Money',
		'Regular',
		mm.clientname,
		mm.creditacctnum,
		(mm.denom / 100.0),
		mm.betlevel,
		mm.numofwins_patt_1,
		((mm.winamt_patt_1 / mm.numofwins_patt_1) / 100.0),
		(Select patternname from MayaMoney_GamePatterns where patternid = 1)
From MayaMoney_GameJournal mm join B3_SessionsJournal sj on mm.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And mm.numofwins_patt_1 <> 0
And mm.winamt_patt_1 <> 0

------ Pattern 2
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
		WinAmount,
		PatternName
		
)
Select	mm.sessnum,
		mm.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = mm.gamenum and sgj.GameTypeID = 38 /* MayaMoney */ ),
		mm.recdatetime,
		'Maya Money',
		'Regular',
		mm.clientname,
		mm.creditacctnum,
		(mm.denom / 100.0),
		mm.betlevel,
		mm.numofwins_patt_2,
		((mm.winamt_patt_2 / mm.numofwins_patt_2) / 100.0),
		(Select patternname from MayaMoney_GamePatterns where patternid = 2)
From MayaMoney_GameJournal mm join B3_SessionsJournal sj on mm.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And mm.numofwins_patt_2 <> 0
And mm.winamt_patt_2 <> 0


------ Pattern 3
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
		WinAmount,
		PatternName
		
)
Select	mm.sessnum,
		mm.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = mm.gamenum and sgj.GameTypeID = 38 /* MayaMoney */ ),
		mm.recdatetime,
		'Maya Money',
		'Regular',
		mm.clientname,
		mm.creditacctnum,
		(mm.denom / 100.0),
		mm.betlevel,
		mm.numofwins_patt_3,
		((mm.winamt_patt_3 / mm.numofwins_patt_3) / 100.0),
		(Select patternname from MayaMoney_GamePatterns where patternid = 3)
From MayaMoney_GameJournal mm join B3_SessionsJournal sj on mm.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And mm.numofwins_patt_3 <> 0
And mm.winamt_patt_3 <> 0


------ Pattern 4
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
		WinAmount,
		PatternName
		
)
Select	mm.sessnum,
		mm.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = mm.gamenum and sgj.GameTypeID = 38 /* MayaMoney */ ),
		mm.recdatetime,
		'Maya Money',
		'Regular',
		mm.clientname,
		mm.creditacctnum,
		(mm.denom / 100.0),
		mm.betlevel,
		mm.numofwins_patt_4,
		((mm.winamt_patt_4 / mm.numofwins_patt_4) / 100.0),
		(Select patternname from MayaMoney_GamePatterns where patternid = 4)
From MayaMoney_GameJournal mm join B3_SessionsJournal sj on mm.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And mm.numofwins_patt_4 <> 0
And mm.winamt_patt_4 <> 0

------ Pattern 5
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
		WinAmount,
		PatternName
		
)
Select	mm.sessnum,
		mm.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = mm.gamenum and sgj.GameTypeID = 38 /* MayaMoney */ ),
		mm.recdatetime,
		'Maya Money',
		'Regular',
		mm.clientname,
		mm.creditacctnum,
		(mm.denom / 100.0),
		mm.betlevel,
		mm.numofwins_patt_5,
		((mm.winamt_patt_5 / mm.numofwins_patt_5) / 100.0),
		(Select patternname from MayaMoney_GamePatterns where patternid = 5)
From MayaMoney_GameJournal mm join B3_SessionsJournal sj on mm.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And mm.numofwins_patt_5 <> 0
And mm.winamt_patt_5 <> 0

------ Pattern 6
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
		WinAmount,
		PatternName
		
)
Select	mm.sessnum,
		mm.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = mm.gamenum and sgj.GameTypeID = 38 /* MayaMoney */ ),
		mm.recdatetime,
		'Maya Money',
		'Regular',
		mm.clientname,
		mm.creditacctnum,
		(mm.denom / 100.0),
		mm.betlevel,
		mm.numofwins_patt_6,
		((mm.winamt_patt_6 / mm.numofwins_patt_6) / 100.0),
		(Select patternname from MayaMoney_GamePatterns where patternid = 6)
From MayaMoney_GameJournal mm join B3_SessionsJournal sj on mm.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And mm.numofwins_patt_6 <> 0
And mm.winamt_patt_6 <> 0

------ Pattern 7
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
		WinAmount,
		PatternName
		
)
Select	mm.sessnum,
		mm.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = mm.gamenum and sgj.GameTypeID = 38 /* MayaMoney */ ),
		mm.recdatetime,
		'Maya Money',
		'Regular',
		mm.clientname,
		mm.creditacctnum,
		(mm.denom / 100.0),
		mm.betlevel,
		mm.numofwins_patt_7,
		((mm.winamt_patt_7 / mm.numofwins_patt_7) / 100.0),
		(Select patternname from MayaMoney_GamePatterns where patternid = 7)
From MayaMoney_GameJournal mm join B3_SessionsJournal sj on mm.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And mm.numofwins_patt_7 <> 0
And mm.winamt_patt_7 <> 0

------ Pattern 8
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
		WinAmount,
		PatternName
		
)
Select	mm.sessnum,
		mm.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = mm.gamenum and sgj.GameTypeID = 38 /* MayaMoney */ ),
		mm.recdatetime,
		'Maya Money',
		'Regular',
		mm.clientname,
		mm.creditacctnum,
		(mm.denom / 100.0),
		mm.betlevel,
		mm.numofwins_patt_8,
		((mm.winamt_patt_8 / mm.numofwins_patt_8) / 100.0),
		(Select patternname from MayaMoney_GamePatterns where patternid = 8)
From MayaMoney_GameJournal mm join B3_SessionsJournal sj on mm.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And mm.numofwins_patt_8 <> 0
And mm.winamt_patt_8 <> 0

------ Pattern 9
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
		WinAmount,
		PatternName
		
)
Select	mm.sessnum,
		mm.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = mm.gamenum and sgj.GameTypeID = 38 /* MayaMoney */ ),
		mm.recdatetime,
		'Maya Money',
		'Regular',
		mm.clientname,
		mm.creditacctnum,
		(mm.denom / 100.0),
		mm.betlevel,
		mm.numofwins_patt_9,
		((mm.winamt_patt_9 / mm.numofwins_patt_9) / 100.0),
		(Select patternname from MayaMoney_GamePatterns where patternid = 9)
From MayaMoney_GameJournal mm join B3_SessionsJournal sj on mm.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And mm.numofwins_patt_9 <> 0
And mm.winamt_patt_9 <> 0

------ Pattern 10
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
		WinAmount,
		PatternName
		
)
Select	mm.sessnum,
		mm.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = mm.gamenum and sgj.GameTypeID = 38 /* MayaMoney */ ),
		mm.recdatetime,
		'Maya Money',
		'Regular',
		mm.clientname,
		mm.creditacctnum,
		(mm.denom / 100.0),
		mm.betlevel,
		mm.numofwins_patt_10,
		((mm.winamt_patt_10 / mm.numofwins_patt_10) / 100.0),
		(Select patternname from MayaMoney_GamePatterns where patternid = 10)
From MayaMoney_GameJournal mm join B3_SessionsJournal sj on mm.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And mm.numofwins_patt_10 <> 0
And mm.winamt_patt_10 <> 0

------ Pattern 11
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
		WinAmount,
		PatternName
		
)
Select	mm.sessnum,
		mm.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = mm.gamenum and sgj.GameTypeID = 38 /* MayaMoney */ ),
		mm.recdatetime,
		'Maya Money',
		'Regular',
		mm.clientname,
		mm.creditacctnum,
		(mm.denom / 100.0),
		mm.betlevel,
		mm.numofwins_patt_11,
		((mm.winamt_patt_11 / mm.numofwins_patt_11) / 100.0),
		(Select patternname from MayaMoney_GamePatterns where patternid = 11)
From MayaMoney_GameJournal mm join B3_SessionsJournal sj on mm.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And mm.numofwins_patt_11 <> 0
And mm.winamt_patt_11 <> 0

------ Pattern 12
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
		WinAmount,
		PatternName
		
)
Select	mm.sessnum,
		mm.gamenum,
		(Select sgj.ServerGameNumber From Server_GameJournal sgj Where sgj.GameNumber = mm.gamenum and sgj.GameTypeID = 38 /* MayaMoney */ ),
		mm.recdatetime,
		'Maya Money',
		'Regular',
		mm.clientname,
		mm.creditacctnum,
		(mm.denom / 100.0),
		mm.betlevel,
		mm.numofwins_patt_12,
		((mm.winamt_patt_12 / mm.numofwins_patt_12) / 100.0),
		(Select patternname from MayaMoney_GamePatterns where patternid = 12)
From MayaMoney_GameJournal mm join B3_SessionsJournal sj on mm.sessnum = sj.sessnum
Where sj.sessnum = @SessionNum
And mm.numofwins_patt_12 <> 0
And mm.winamt_patt_12 <> 0

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
		PatternName,
		IsServerGame  
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
		PatternName, 
		case  when ServerGameNum is null  then 0 else 1 end
		--(select dbo.B3_fnGetWinningCardNumber(PatternName, SessNum, 1, GameNum ))  as WinningCardNumber
From @Results 
Group By SessNum, GameNum, ServerGameNum, GameDate, GameName, PayoutType, CreditAcctNum, ClientName, Denom, BetLevel, WinAmount, NumberWinners, PatternName --, GameWinAmt, BonusWinAmt, TotalPaidAmt
Order By ServerGameNum
end

declare @ServerGamenum int, @RegGameNumber int, @PayoutType int, @Pattername varchar(50), @SessionNumber int, @GameName varchar(50), @IsServerGame bit

declare GetWinningCardNumber_Cursor cursor
for 
select 
		SessNum,
		ServerGameNum ,
		GameNum	,
		--GameDate ,
		GameName ,
		case when PayoutType = 'Regular' then 0 else 1 end,
		--ClientName ,
		--CreditAcctNum ,
		--Denom ,
		--BetLevel ,
		--NumberWinners ,
		--WinAmount ,
		PatternName,
		IsServerGame 
		from @Result2 

		open GetWinningCardNumber_Cursor

		FETCH NEXT FROM GetWinningCardNumber_Cursor 
				INTO  @SessionNumber, @ServerGamenum, @RegGameNumber, @GameName,  @PayoutType,  @Pattername, @IsServerGame
		
		while @@fetch_status = 0
		begin
		
	    declare @WinningCardNumber varchar(100)
		exec usp_management_rptGetWinningCardNumber @Pattername,  @SessionNumber, @PayoutType, @ServerGamenum, @RegGameNumber, @GameName,  @IsServerGame, @WinningCardNumber OUTPUT
	 

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
			INTO  @SessionNumber, @ServerGamenum, @RegGameNumber, @GameName,  @PayoutType,  @Pattername, @IsServerGame
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


