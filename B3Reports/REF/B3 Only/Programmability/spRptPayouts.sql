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


