USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_DisputeResolution_GetInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_DisputeResolution_GetInfo]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO





CREATE proc [dbo].[usp_management_DisputeResolution_GetInfo]
    @spAcctNumber int
    ,@spPlayTime datetime = NULL
    ,@spStatus int
    ,@spB4Games varchar(100) = null 
    ,@spGameStartNum  int
    ,@spGameEndNum int
	,@spIsGameNumber varchar(10)
    as
    --=====TEST=========
    --@AccountNumber=12543386,@Playtime=NULL,@Status=0,@B4Games=N'Spirit 76',@GameStartNum=0,@GameEndNum=0,@IsGameNumber=N'F'
 --   declare 
 --       @spAcctNumber int
 --   ,@spPlayTime datetime = NULL
 --   ,@spStatus int
 --   ,@spB4Games varchar(100) = null 
 --   ,@spGameStartNum  int
 --   ,@spGameEndNum int
	--,@spIsGameNumber varchar(10)
	
	--set @spAcctNumber = 74686718
	--set @spPlayTime = '2018-01-02 11:56:54.540'
	--set @spStatus = 1
	--set @spB4Games = 'TimeBomb'
	--set @spGameStartNum = 0
	--set @spGameEndNum = 0
	--set @spIsGameNumber = 'F'
    --=================
    
    
--    select * from TimeBomb_GameJournal
--where creditacctnum = 74686718

    declare @InfoTable table
    (
    DateTimePlay datetime
    ,B4Games varchar(100)
    ,StartingCrdtAmnt int
    ,EndingCrdAmnt int
    ,WinAmount int
    ,BonusWinAmount int
    ,BetAmount int
    ,BetLevel int
    ,BetDenom int
    ,CallCount int
    ,GameNumber int
    ,StartCardNumber int
    ,EndCardNumber int
    ,FirstBonusCardNumber int
    ,LastBonusCardNumber int
    ,CallCountBonus int
    ,BonusOfferAccepted int
	,ServerGameNumber int
    )

    if (@spB4Games = 'ALL')
    begin
    set @spB4Games = null;
    end


	--if (@spB4Games is not null and @spGameStartNum = 0)
	--begin 
	--  set @spGameStartNum = -1
	--end
	--else 
	if (@spB4Games is  null)
	begin 
	  set @spGameStartNum = -1
	end

	if (@spIsGameNumber = 'F')
	begin
	  set @spGameStartNum = -1
	end


    if (/*@GameCardNumber = 0 and*/ @spPlayTime is null)
    begin
        --CrazyBout
        if exists( select 1 from dbo.CrazyBout_GameJournal where creditacctnum = @spAcctNumber)
        begin
            --get the very first game
			insert into @InfoTable
			(DateTimePlay 
			,B4Games 
			,StartingCrdtAmnt 
			,EndingCrdAmnt 
			,WinAmount 
			,BonusWinAmount 
			,BetAmount 
			,BetLevel 
			,BetDenom 
			,CallCount 
			,GameNumber 
			,StartCardNumber 
			,EndCardNumber 
			,FirstBonusCardNumber 
			,LastBonusCardNumber 
			,CallCountBonus 
			,BonusOfferAccepted )

			select top 1 recdatetime [DateTimePlay]
			,'CrazyBout' as B4Games
			,(creditamt + betamt) as StartingCrdtAmnt  
			,(creditamt  + gamewinamt) + bonuswinamt as EndingCrdtAmnt
			,(gamewinamt) as [WinAmount]  
			,bonuswinamt as [BonusWinAmount]
			,betamt [BetAmount]  
			,betlevel as [BetLevel]   
			,denom as [BetDenom]   
			,callcount as [CallCount]
			,gamenum as [GameNumber]
			,cardsn_1 as [StartCardNumber]
			,cardsn_6 as [EndCardNumber]
			,bonuscardsn_1 as [FirstBonusCardNumber]
			,bonuscardsn_3 as [LastBonusCardNumber]
			,bonuscallcount as [CallCountBonus]
			,bonusofferaccepted as [BonusOfferAccepted]
			from dbo.CrazyBout_GameJournal		
			where creditacctnum = @spAcctNumber 
			and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )		
			order by recdatetime desc
        end
        --JailBreak
        if exists( select 1 from dbo.JailBreak_GameJournal where creditacctnum = @spAcctNumber)
        begin
			--get the very first game
			--select top 1 * from dbo.JailBreak_GameJournal where creditacctnum = @spAcctNumber order by recdatetime asc
			insert into @InfoTable
			(DateTimePlay 
			,B4Games 
			,StartingCrdtAmnt 
			,EndingCrdAmnt 
			,WinAmount 
			,BonusWinAmount 
			,BetAmount 
			,BetLevel 
			,BetDenom 
			,CallCount 
			,GameNumber 
			,StartCardNumber 
			,EndCardNumber 
			,FirstBonusCardNumber 
			,LastBonusCardNumber 
			,CallCountBonus 
			,BonusOfferAccepted )
			select top 1 recdatetime [DateTimePlay]
			,'JailBreak' as B4Games
			,(creditamt + betamt) as StartingCrdtAmnt  
			,(creditamt  + gamewinamt) + bonuswinamt as EndingCrdtAmnt
			,(gamewinamt) as [WinAmount]  
			,bonuswinamt as [BonusWinAmount]
			,betamt [BetAmount]  
			,betlevel as [BetLevel]   
			,denom as [BetDenom]  
			,callcount as [CallCount]  
			,gamenum as [GameNumber]
			,cardsn_1 as [StartCardNumber]
			,cardsn_6 as [EndCardNumber]
			,bonuscardsn_1 as [FirstBonusCardNumber]
			,bonuscardsn_3 as [LastBonusCardNumber]		
			,bonuscallcount as [CallCountBonus]
			,bonusofferaccepted as [BonusOfferAccepted]
			from dbo.JailBreak_GameJournal 
			where creditacctnum = @spAcctNumber 
			and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
			order by recdatetime desc
        end
            --MoyaMoney
        if exists( select 1 from dbo.MayaMoney_GameJournal where creditacctnum = @spAcctNumber)
        begin
			--get the very first game
			--select top 1 * from dbo.MayaMoney_GameJournal where creditacctnum = @spAcctNumber order by recdatetime asc
			insert into @InfoTable
			(DateTimePlay 
			,B4Games 
			,StartingCrdtAmnt 
			,EndingCrdAmnt 
			,WinAmount 
			,BonusWinAmount 
			,BetAmount 
			,BetLevel 
			,BetDenom 
			,CallCount 
			,GameNumber 
			,StartCardNumber 
			,EndCardNumber 
			,FirstBonusCardNumber 
			,LastBonusCardNumber 
			,CallCountBonus 
			,BonusOfferAccepted )
			select top 1 recdatetime [DateTimePlay]
			,'MayaMoney' as B4Games
			,(creditamt + betamt) as StartingCrdtAmnt  
			,(creditamt  + gamewinamt) /*+ bonuswinamt*/ as EndingCrdtAmnt
			,(gamewinamt) as [WinAmount]  
			,0 as [BonusWinAmount]
			,betamt [BetAmount]  
			,betlevel as [BetLevel]   
			,denom as [BetDenom]   
			,callcount as [CallCount] 
			,gamenum as [GameNumber]
			,cardsn_1 as [StartCardNumber]
			,cardsn_6 as [EndCardNumber]
			,0--,bonuscardsn_1 as [FirstBonusCardNumber]
			,0--,bonuscardsn_3 as [LastBonusCardNumber]		
			,0--,bonuscallcount as [CallCountBonus]
			,0--,bonusofferaccepted as [BonusOfferAccepted]
			from dbo.MayaMoney_GameJournal 
			where creditacctnum = @spAcctNumber 
			and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
			order by recdatetime desc
        end
        --Spirit76
        if exists( select 1 from dbo.Spirit76_GameJournal where creditacctnum = @spAcctNumber)
        begin
        

			--get the very first game
			--select top 1 * from dbo.Spirit76_GameJournal where creditacctnum = @spAcctNumber order by recdatetime asc
			insert into @InfoTable
			(DateTimePlay 
			,B4Games 
			,StartingCrdtAmnt 
			,EndingCrdAmnt 
			,WinAmount 
			,BonusWinAmount 
			,BetAmount 
			,BetLevel 
			,BetDenom 
			,CallCount 
			,GameNumber 
			,StartCardNumber 
			,EndCardNumber 
			,FirstBonusCardNumber 
			,LastBonusCardNumber 
			,CallCountBonus 
			,BonusOfferAccepted )
			select top 1 recdatetime [DateTimePlay]
			,'Spirit76' as B4Games
			,(creditamt + betamt) as StartingCrdtAmnt  
			,(creditamt  + gamewinamt) + bonuswinamt as EndingCrdtAmnt
			,(gamewinamt) as [WinAmount]  
			,bonuswinamt as [BonusWinAmount]
			,betamt [BetAmount]  
			,betlevel as [BetLevel]   
			,denom as [BetDenom]
			,callcount as [CallCount]   
			,gamenum as [GameNumber] 
			,cardsn_1 as [StartCardNumber]
			,cardsn_6 as [EndCardNumber]             
			,bonuscardsn_1 as [FirstBonusCardNumber]
			,bonuscardsn_3 as [LastBonusCardNumber]			
			,bonuscallcount as [CallCountBonus]
			,bonusofferaccepted as [BonusOfferAccepted]
			from dbo.Spirit76_GameJournal
			where creditacctnum = @spAcctNumber 
			and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
			order by recdatetime desc
             
         
             
        end
        
        if exists( select 1 from dbo.WildBall_GameJournal where creditacctnum = @spAcctNumber)
        begin
			--get the very first game
			--select top 1 * from dbo.Spirit76_GameJournal where creditacctnum = @spAcctNumber order by recdatetime asc
			insert into @InfoTable
			(DateTimePlay 
			,B4Games 
			,StartingCrdtAmnt 
			,EndingCrdAmnt 
			,WinAmount 
			,BonusWinAmount 
			,BetAmount 
			,BetLevel 
			,BetDenom 
			,CallCount 
			,GameNumber 
			,StartCardNumber 
			,EndCardNumber 
			,FirstBonusCardNumber 
			,LastBonusCardNumber 
			,CallCountBonus 
			,BonusOfferAccepted )
			select top 1 recdatetime [DateTimePlay]
			,'WildBall' as B4Games
			,(creditamt + betamt) as StartingCrdtAmnt  
			,(creditamt  + gamewinamt) + bonuswinamt as EndingCrdtAmnt
			,(gamewinamt) as [WinAmount]  
			,bonuswinamt as [BonusWinAmount]
			,betamt [BetAmount]  
			,betlevel as [BetLevel]   
			,denom as [BetDenom]
			,callcount as [CallCount]   
			,gamenum as [GameNumber] 
			,cardsn_1 as [StartCardNumber]
			,cardsn_6 as [EndCardNumber]             
			,bonuscardsn_1 as [FirstBonusCardNumber]
			,bonuscardsn_4 as [LastBonusCardNumber]			
			,bonuscallcount as [CallCountBonus]
			,bonusofferaccepted as [BonusOfferAccepted]
			from dbo.WildBall_GameJournal
			where creditacctnum = @spAcctNumber 
			and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
			order by recdatetime desc
        end
        
        if exists( select 1 from dbo.TimeBomb_GameJournal where creditacctnum = @spAcctNumber)
        begin
			--get the very first game
			--select top 1 * from dbo.Spirit76_GameJournal where creditacctnum = @spAcctNumber order by recdatetime asc
			insert into @InfoTable
			(DateTimePlay 
			,B4Games 
			,StartingCrdtAmnt 
			,EndingCrdAmnt 
			,WinAmount 
			,BonusWinAmount 
			,BetAmount 
			,BetLevel 
			,BetDenom 
			,CallCount 
			,GameNumber 
			,StartCardNumber 
			,EndCardNumber 
			,FirstBonusCardNumber 
			,LastBonusCardNumber 
			,CallCountBonus 
			,BonusOfferAccepted )
			select top 1 recdatetime [DateTimePlay]
			,'TimeBomb' as B4Games
			,(creditamt + betamt) as StartingCrdtAmnt  
			,(creditamt  + gamewinamt) /*+ bonuswinamt*/ as EndingCrdtAmnt
			,(gamewinamt) as [WinAmount]  
			,0 as [BonusWinAmount]
			,betamt [BetAmount]  
			,betlevel as [BetLevel]   
			,denom as [BetDenom]
			,callcount as [CallCount]   
			,gamenum as [GameNumber] 
			,cardsn_1 as [StartCardNumber]
			,cardsn_4 as [EndCardNumber]             
			,0 as [FirstBonusCardNumber]
			,0 as [LastBonusCardNumber]			
			,0 as [CallCountBonus]
			,0 as [BonusOfferAccepted]
			from dbo.TimeBomb_GameJournal			
			where creditacctnum = @spAcctNumber 
			and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
			order by recdatetime desc
        end
    end
    
    else --if datetime is not null
    
    begin
            --CrazyBout
        if exists( select 1 from dbo.CrazyBout_GameJournal where creditacctnum = @spAcctNumber)
        begin
			if (@spStatus = 1)
			begin
				insert into @InfoTable
				(DateTimePlay 
				,B4Games 
				,StartingCrdtAmnt 
				,EndingCrdAmnt 
				,WinAmount 
				,BonusWinAmount 
				,BetAmount 
				,BetLevel 
				,BetDenom 
				,CallCount 
				,GameNumber 
				,StartCardNumber 
				,EndCardNumber 
				,FirstBonusCardNumber 
				,LastBonusCardNumber 
				,CallCountBonus 
				,BonusOfferAccepted )
				select top 1 recdatetime [DateTimePlay]
				,'CrazyBout' as B4Games
				,(creditamt + betamt) as StartingCrdtAmnt  
				,(creditamt  + gamewinamt) + bonuswinamt as EndingCrdtAmnt
				,(gamewinamt) as [WinAmount]  
				,bonuswinamt as [BonusWinAmount]
				,betamt [BetAmount]  
				,betlevel as [BetLevel]   
				,denom as [BetDenom]   
				,callcount as [CallCount]
				,gamenum as [GameNumber]
				,cardsn_1 as [StartCardNumber]
				,cardsn_6 as [EndCardNumber]
				,bonuscardsn_1 as [FirstBonusCardNumber]
				,bonuscardsn_3 as [LastBonusCardNumber]
				,bonuscallcount as [CallCountBonus]
				,bonusofferaccepted as [BonusOfferAccepted]
				from dbo.CrazyBout_GameJournal	
				where creditacctnum = @spAcctNumber 
				and recdatetime >  @spPlayTime
				and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
				order by recdatetime asc
             end
             else if (@spStatus = 2) --back
             begin
				insert into @InfoTable
				(DateTimePlay 
				,B4Games 
				,StartingCrdtAmnt 
				,EndingCrdAmnt 
				,WinAmount 
				,BonusWinAmount 
				,BetAmount 
				,BetLevel 
				,BetDenom 
				,CallCount 
				,GameNumber 
				,StartCardNumber 
				,EndCardNumber 
				,FirstBonusCardNumber 
				,LastBonusCardNumber 
				,CallCountBonus 
				,BonusOfferAccepted )
				select top 1  
				recdatetime [DateTimePlay]
				,'CrazyBout' as B4Games
				,(creditamt + betamt) as StartingCrdtAmnt  
				,(creditamt  + gamewinamt) + bonuswinamt as EndingCrdtAmnt
				,(gamewinamt) as [WinAmount]  
				, bonuswinamt as [BonusWinAmount]
				,betamt [BetAmount]  
				,betlevel as [BetLevel]   
				,denom as [BetDenom]
				,callcount as [CallCount]  
				,gamenum as [GameNumber] 
				,cardsn_1 as [StartCardNumber]
				,cardsn_6 as [EndCardNumber]
				,bonuscardsn_1 as [FirstBonusCardNumber]
				,bonuscardsn_3 as [LastBonusCardNumber]
				,bonuscallcount as [CallCountBonus]
				,bonusofferaccepted as [BonusOfferAccepted]
				from dbo.CrazyBout_GameJournal	
				where creditacctnum = @spAcctNumber 
				and recdatetime <  @spPlayTime
				and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
				order by recdatetime desc
             end
        end
        --JailBreak
        if exists( select 1 from dbo.JailBreak_GameJournal where creditacctnum = @spAcctNumber)
        begin
			if (@spStatus = 1)
			begin
				insert into @InfoTable
				(DateTimePlay 
				,B4Games 
				,StartingCrdtAmnt 
				,EndingCrdAmnt 
				,WinAmount 
				,BonusWinAmount 
				,BetAmount 
				,BetLevel 
				,BetDenom 
				,CallCount 
				,GameNumber 
				,StartCardNumber 
				,EndCardNumber 
				,FirstBonusCardNumber 
				,LastBonusCardNumber 
				,CallCountBonus 
				,BonusOfferAccepted )
				select top 1 recdatetime [DateTimePlay]
				,'JailBreak' as B4Games
				,(creditamt + betamt) as StartingCrdtAmnt  
				,(creditamt  + gamewinamt) + bonuswinamt as EndingCrdtAmnt
				,(gamewinamt) as [WinAmount]  
				,bonuswinamt as [BonusWinAmount]
				,betamt [BetAmount]  
				,betlevel as [BetLevel]   
				,denom as [BetDenom]
				,callcount as [CallCount] 
				,gamenum as [GameNumber] 
				,cardsn_1 as [StartCardNumber]
				,cardsn_6 as [EndCardNumber]    
				,bonuscardsn_1 as [FirstBonusCardNumber]
				,bonuscardsn_3 as [LastBonusCardNumber]
				,bonuscallcount as [CallCountBonus]
				,bonusofferaccepted as [BonusOfferAccepted]
				from dbo.JailBreak_GameJournal
				where creditacctnum = @spAcctNumber 
				and recdatetime >  @spPlayTime
				and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
				order by recdatetime asc
			end
			else if (@spStatus = 2)
			begin
				insert into @InfoTable
				(DateTimePlay 
				,B4Games 
				,StartingCrdtAmnt 
				,EndingCrdAmnt 
				,WinAmount 
				,BonusWinAmount 
				,BetAmount 
				,BetLevel 
				,BetDenom 
				,CallCount 
				,GameNumber 
				,StartCardNumber 
				,EndCardNumber 
				,FirstBonusCardNumber 
				,LastBonusCardNumber 
				,CallCountBonus 
				,BonusOfferAccepted )
				select top 1 recdatetime [DateTimePlay]
				,'JailBreak' as B4Games
				,(creditamt + betamt) as StartingCrdtAmnt  
				,(creditamt  + gamewinamt) + bonuswinamt as EndingCrdtAmnt
				,(gamewinamt) as [WinAmount]  
				,bonuswinamt as [BonusWinAmount]
				,betamt [BetAmount]  
				,betlevel as [BetLevel]   
				,denom as [BetDenom]    
				,callcount as [CallCount]
				,gamenum as [GameNumber]  
				,cardsn_1 as [StartCardNumber]
				,cardsn_6 as [EndCardNumber]
				,bonuscardsn_1 as [FirstBonusCardNumber]
				,bonuscardsn_3 as [LastBonusCardNumber]				
				,bonuscallcount as [CallCountBonus]
				,bonusofferaccepted as [BonusOfferAccepted]
				from dbo.JailBreak_GameJournal
				where creditacctnum = @spAcctNumber 
				and recdatetime <  @spPlayTime
				and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
				order by recdatetime desc
			end
		end
            --MoyaMoney
        if exists( select 1 from dbo.MayaMoney_GameJournal where creditacctnum = @spAcctNumber)
        begin
			if (@spStatus = 1)
			begin
				insert into @InfoTable
				(DateTimePlay 
				,B4Games 
				,StartingCrdtAmnt 
				,EndingCrdAmnt 
				,WinAmount 
				,BonusWinAmount 
				,BetAmount 
				,BetLevel 
				,BetDenom 
				,CallCount 
				,GameNumber 
				,StartCardNumber 
				,EndCardNumber 
				,FirstBonusCardNumber 
				,LastBonusCardNumber 
				,CallCountBonus 
				,BonusOfferAccepted )
				select top 1 recdatetime [DateTimePlay]
				,'MayaMoney' as B4Games
				,(creditamt + betamt) as StartingCrdtAmnt  
				,(creditamt  + gamewinamt) /*+ bonuswinamt*/ as EndingCrdtAmnt
				,(gamewinamt) as [WinAmount]  
				,0 as [BonusWinAmount]
				,betamt [BetAmount]  
				,betlevel as [BetLevel]   
				,denom as [BetDenom]    
				,callcount as [CallCount]
				,gamenum as [GameNumber]
				,cardsn_1 as [StartCardNumber]
				,cardsn_6 as [EndCardNumber]
				,0--,bonuscardsn_1 as [FirstBonusCardNumber]
				,0--,bonuscardsn_3 as [LastBonusCardNumber]				
				,0--,bonuscallcount as [CallCountBonus]
				,0--,bonusofferaccepted as [BonusOfferAccepted]
				from dbo.MayaMoney_GameJournal 
				where creditacctnum = @spAcctNumber 
				and recdatetime >  @spPlayTime
				and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
				order by recdatetime asc
			end
			else 
			if (@spStatus = 2)
			begin
				insert into @InfoTable
				(DateTimePlay 
				,B4Games 
				,StartingCrdtAmnt 
				,EndingCrdAmnt 
				,WinAmount 
				,BonusWinAmount 
				,BetAmount 
				,BetLevel 
				,BetDenom 
				,CallCount 
				,GameNumber 
				,StartCardNumber 
				,EndCardNumber 
				,FirstBonusCardNumber 
				,LastBonusCardNumber 
				,CallCountBonus 
				,BonusOfferAccepted )
				select top 1 recdatetime [DateTimePlay]
				,'MayaMoney' as B4Games
				,(creditamt + betamt) as StartingCrdtAmnt  
				,(creditamt  + gamewinamt) /*+ bonuswinamt*/ as EndingCrdtAmnt
				,(gamewinamt) as [WinAmount]  
				,0 as [BonusWinAmount]
				,betamt [BetAmount]  
				,betlevel as [BetLevel]   
				,denom as [BetDenom]    
				,callcount as [CallCount]
				,gamenum as [GameNumber]
				,cardsn_1 as [StartCardNumber]
				,cardsn_6 as [EndCardNumber]
				,0 --,bonuscardsn_1 as [FirstBonusCardNumber]
				,0--,bonuscardsn_3 as [LastBonusCardNumber]				
				,0--,bonuscallcount as [CallCountBonus]
				,0--,bonusofferaccepted as [BonusOfferAccepted]
				from dbo.MayaMoney_GameJournal 
				where creditacctnum = @spAcctNumber 
				and recdatetime <  @spPlayTime
				and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
				order by recdatetime desc
			end
		end
        --Spirit76
        if exists( select 1 from dbo.Spirit76_GameJournal where creditacctnum = @spAcctNumber)
        begin   
			if (@spStatus = 1)
			begin
				insert into @InfoTable
				(DateTimePlay 
				,B4Games 
				,StartingCrdtAmnt 
				,EndingCrdAmnt 
				,WinAmount 
				,BonusWinAmount 
				,BetAmount 
				,BetLevel 
				,BetDenom 
				,CallCount 
				,GameNumber 
				,StartCardNumber 
				,EndCardNumber 
				,FirstBonusCardNumber 
				,LastBonusCardNumber 
				,CallCountBonus 
				,BonusOfferAccepted )
				select top 1 recdatetime [DateTimePlay]
				,'Spirit76' as B4Games
				,(creditamt + betamt) as StartingCrdtAmnt  
				,(creditamt  + gamewinamt) + bonuswinamt as EndingCrdtAmnt
				,(gamewinamt) as [WinAmount]  
				,bonuswinamt as [BonusWinAmount]
				,betamt [BetAmount]  
				,betlevel as [BetLevel]   
				,denom as [BetDenom]    
				,callcount as [CallCount]
				,gamenum as [GameNumber]
				,cardsn_1 as [StartCardNumber]
				,cardsn_6 as [EndCardNumber]
				,bonuscardsn_1 as [FirstBonusCardNumber]
				,bonuscardsn_3 as [LastBonusCardNumber]				
				,bonuscallcount as [CallCountBonus]
				,bonusofferaccepted as [BonusOfferAccepted]
				from dbo.Spirit76_GameJournal 
				where creditacctnum = @spAcctNumber 
				and recdatetime >  @spPlayTime
				and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
				order by recdatetime asc
			end
			else
			if(@spStatus = 2)
			begin
				insert into @InfoTable
				(DateTimePlay 
				,B4Games 
				,StartingCrdtAmnt 
				,EndingCrdAmnt 
				,WinAmount 
				,BonusWinAmount 
				,BetAmount 
				,BetLevel 
				,BetDenom 
				,CallCount 
				,GameNumber 
				,StartCardNumber 
				,EndCardNumber 
				,FirstBonusCardNumber 
				,LastBonusCardNumber 
				,CallCountBonus 
				,BonusOfferAccepted )
				select top 1 recdatetime [DateTimePlay]
				,'Spirit76' as B4Games
				,(creditamt + betamt) as StartingCrdtAmnt  
				,(creditamt  + gamewinamt) + bonuswinamt as EndingCrdtAmnt
				,(gamewinamt) as [WinAmount]  
				,bonuswinamt as [BonusWinAmount]
				,betamt [BetAmount]  
				,betlevel as [BetLevel]   
				,denom as [BetDenom]    
				,callcount as [CallCount]
				,gamenum as [GameNumber]
				,cardsn_1 as [StartCardNumber]
				,cardsn_6 as [EndCardNumber]
				,bonuscardsn_1 as [FirstBonusCardNumber]
				,bonuscardsn_3 as [LastBonusCardNumber]
				,bonuscallcount as [CallCountBonus]
				,bonusofferaccepted as [BonusOfferAccepted]
				from dbo.Spirit76_GameJournal 
				where creditacctnum = @spAcctNumber 
				and recdatetime <  @spPlayTime
				and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
				order by recdatetime desc
			end
		end
        
        --WildBall
        if exists( select 1 from dbo.WildBall_GameJournal where creditacctnum = @spAcctNumber)
        begin
			if (@spStatus = 1)
			begin
				insert into @InfoTable
				(DateTimePlay 
				,B4Games 
				,StartingCrdtAmnt 
				,EndingCrdAmnt 
				,WinAmount 
				,BonusWinAmount 
				,BetAmount 
				,BetLevel 
				,BetDenom 
				,CallCount 
				,GameNumber 
				,StartCardNumber 
				,EndCardNumber 
				,FirstBonusCardNumber 
				,LastBonusCardNumber 
				,CallCountBonus 
				,BonusOfferAccepted )
				select top 1 recdatetime [DateTimePlay]
				,'WildBall' as B4Games
				,(creditamt + betamt) as StartingCrdtAmnt  
				,(creditamt  + gamewinamt) + bonuswinamt as EndingCrdtAmnt
				,(gamewinamt) as [WinAmount]  
				,bonuswinamt as [BonusWinAmount]
				,betamt [BetAmount]  
				,betlevel as [BetLevel]   
				,denom as [BetDenom]    
				,callcount as [CallCount]
				,gamenum as [GameNumber]
				,cardsn_1 as [StartCardNumber]
				,cardsn_6 as [EndCardNumber]
				,bonuscardsn_1 as [FirstBonusCardNumber]
				,bonuscardsn_4 as [LastBonusCardNumber]				
				,bonuscallcount as [CallCountBonus]
				,bonusofferaccepted as [BonusOfferAccepted]
				from dbo.WildBall_GameJournal 
				where creditacctnum = @spAcctNumber 
				and recdatetime >  @spPlayTime
				and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
				order by recdatetime asc
			end
			else
			if(@spStatus = 2)
			begin
				insert into @InfoTable
				(DateTimePlay 
				,B4Games 
				,StartingCrdtAmnt 
				,EndingCrdAmnt 
				,WinAmount 
				,BonusWinAmount 
				,BetAmount 
				,BetLevel 
				,BetDenom 
				,CallCount 
				,GameNumber 
				,StartCardNumber 
				,EndCardNumber 
				,FirstBonusCardNumber 
				,LastBonusCardNumber 
				,CallCountBonus 
				,BonusOfferAccepted )
				select top 1 recdatetime [DateTimePlay]
				,'WildBall' as B4Games
				,(creditamt + betamt) as StartingCrdtAmnt  
				,(creditamt  + gamewinamt) + bonuswinamt as EndingCrdtAmnt
				,(gamewinamt) as [WinAmount]  
				,bonuswinamt as [BonusWinAmount]
				,betamt [BetAmount]  
				,betlevel as [BetLevel]   
				,denom as [BetDenom]    
				,callcount as [CallCount]
				,gamenum as [GameNumber]
				,cardsn_1 as [StartCardNumber]
				,cardsn_6 as [EndCardNumber]
				,bonuscardsn_1 as [FirstBonusCardNumber]
				,bonuscardsn_4 as [LastBonusCardNumber]
				,bonuscallcount as [CallCountBonus]
				,bonusofferaccepted as [BonusOfferAccepted]
				from dbo.WildBall_GameJournal  
				where creditacctnum = @spAcctNumber 
				and recdatetime <  @spPlayTime
				and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
				order by recdatetime desc
			end
		end  
		
		  --TimeBomb
        if exists( select 1 from dbo.TimeBomb_GameJournal where creditacctnum = @spAcctNumber)
        begin
			if (@spStatus = 1)
			begin
						
				insert into @InfoTable
				(DateTimePlay 
				,B4Games 
				,StartingCrdtAmnt 
				,EndingCrdAmnt 
				,WinAmount 
				,BonusWinAmount 
				,BetAmount 
				,BetLevel 
				,BetDenom 
				,CallCount 
				,GameNumber 
				,StartCardNumber 
				,EndCardNumber 
				,FirstBonusCardNumber 
				,LastBonusCardNumber 
				,CallCountBonus 
				,BonusOfferAccepted )
			select top 1 recdatetime [DateTimePlay]
			,'TimeBomb' as B4Games
			,(creditamt + betamt) as StartingCrdtAmnt  
			,(creditamt  + gamewinamt) /*+ bonuswinamt*/ as EndingCrdtAmnt
			,(gamewinamt) as [WinAmount]  
			,0 as [BonusWinAmount]
			,betamt [BetAmount]  
			,betlevel as [BetLevel]   
			,denom as [BetDenom]
			,callcount as [CallCount]   
			,gamenum as [GameNumber] 
			,cardsn_1 as [StartCardNumber]
			,cardsn_4 as [EndCardNumber]             
			,0 as [FirstBonusCardNumber]
			,0 as [LastBonusCardNumber]			
			,0 as [CallCountBonus]
			,0 as [BonusOfferAccepted]
			from dbo.TimeBomb_GameJournal					
				where creditacctnum = @spAcctNumber 
				and recdatetime >  @spPlayTime
				and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
				order by recdatetime asc	
				
				

			end
			else
			if(@spStatus = 2)
			begin
				insert into @InfoTable
				(DateTimePlay 
				,B4Games 
				,StartingCrdtAmnt 
				,EndingCrdAmnt 
				,WinAmount 
				,BonusWinAmount 
				,BetAmount 
				,BetLevel 
				,BetDenom 
				,CallCount 
				,GameNumber 
				,StartCardNumber 
				,EndCardNumber 
				,FirstBonusCardNumber 
				,LastBonusCardNumber 
				,CallCountBonus 
				,BonusOfferAccepted )
					select top 1 recdatetime [DateTimePlay]
			,'TimeBomb' as B4Games
			,(creditamt + betamt) as StartingCrdtAmnt  
			,(creditamt  + gamewinamt) /*+ bonuswinamt*/ as EndingCrdtAmnt
			,(gamewinamt) as [WinAmount]  
			,0 as [BonusWinAmount]
			,betamt [BetAmount]  
			,betlevel as [BetLevel]   
			,denom as [BetDenom]
			,callcount as [CallCount]   
			,gamenum as [GameNumber] 
			,cardsn_1 as [StartCardNumber]
			,cardsn_4 as [EndCardNumber]             
			,0 as [FirstBonusCardNumber]
			,0 as [LastBonusCardNumber]			
			,0 as [CallCountBonus]
			,0 as [BonusOfferAccepted]
			from dbo.TimeBomb_GameJournal				
				where creditacctnum = @spAcctNumber 
				and recdatetime <  @spPlayTime
				and (@spGameStartNum  = -1 or gamenum between @spGameStartNum and @spGameEndNum )
				order by recdatetime desc
			end
		end                 
    end
    
	  declare @FInfoTable table
    (
    DateTimePlay datetime
    ,B4Games varchar(100)
    ,StartingCrdtAmnt int
    ,EndingCrdAmnt int
    ,WinAmount int
    ,BonusWinAmount int
    ,BetAmount int
    ,BetLevel int
    ,BetDenom int
    ,CallCount int
    ,GameNumber int
    ,StartCardNumber int
    ,EndCardNumber int
    ,FirstBonusCardNumber int
    ,LastBonusCardNumber int
    ,CallCountBonus int
    ,BonusOfferAccepted int
	,ServerGameNumber int
    )

    if (@spStatus = 1 or @spStatus = 0)
    begin
   
	 insert into @FInfoTable
               	(DateTimePlay 
    ,B4Games 
    ,StartingCrdtAmnt 
    ,EndingCrdAmnt 
    ,WinAmount 
    ,BonusWinAmount 
    ,BetAmount 
    ,BetLevel 
    ,BetDenom 
    ,CallCount 
    ,GameNumber 
    ,StartCardNumber 
    ,EndCardNumber 
    ,FirstBonusCardNumber 
    ,LastBonusCardNumber 
    ,CallCountBonus 
    ,BonusOfferAccepted )
        select top 1 
        DateTimePlay
        ,B4Games 
        ,StartingCrdtAmnt 
        ,EndingCrdAmnt 
        ,WinAmount 
        ,BonusWinAmount 
        ,BetAmount 
        ,BetLevel 
        ,BetDenom 
        ,CallCount
        ,GameNumber
        ,StartCardNumber 
        ,EndCardNumber 
        ,[FirstBonusCardNumber]
        ,[LastBonusCardNumber]
        ,[CallCountBonus]
        ,[BonusOfferAccepted]
         from  @InfoTable 
         where (@spB4Games is null or B4Games = @spB4Games)
         order by datetimeplay asc
    end
    else if (@spStatus = 2)
    begin
	 insert into @FInfoTable
               	(DateTimePlay 
    ,B4Games 
    ,StartingCrdtAmnt 
    ,EndingCrdAmnt 
    ,WinAmount 
    ,BonusWinAmount 
    ,BetAmount 
    ,BetLevel 
    ,BetDenom 
    ,CallCount 
    ,GameNumber 
    ,StartCardNumber 
    ,EndCardNumber 
    ,FirstBonusCardNumber 
    ,LastBonusCardNumber 
    ,CallCountBonus 
    ,BonusOfferAccepted )
        select top 1
        DateTimePlay
        ,B4Games 
        ,StartingCrdtAmnt 
        ,EndingCrdAmnt 
        ,WinAmount 
        ,BonusWinAmount 
        ,BetAmount 
        ,BetLevel 
        ,BetDenom 
        ,CallCount
        ,GameNumber
        ,StartCardNumber 
        ,EndCardNumber 
        ,[FirstBonusCardNumber]
        ,[LastBonusCardNumber]
        ,[CallCountBonus]
        ,[BonusOfferAccepted]
         from  @InfoTable  
         where (@spB4Games is null or B4Games = @spB4Games)
         order by datetimeplay desc
    end



		declare @GameTypeID int
		select @GameTypeID = 
		case 
		when B4Games = 'WildFire' then 40
		when B4Games = 'CrazyBout' then 36
		when B4Games = 'JailBreak' then 37
		when B4Games = 'MayaMoney' then 38
		when B4Games = 'Spirit76' then 39
		when B4Games = 'WildFire' then 40
		when B4Games = 'WildBall' then 41 
		when B4Games = 'TimeBomb' then 42 end
		from @FInfoTable
		
		--select @GameTypeID

		declare @SpGameNumber int
		select @SpGameNumber = GameNumber from @FInfoTable
		--select @spGameNumber
		
		declare @PlayTime2 datetime
		select @PlayTime2 = DateTimePlay from @FInfoTable
		set @PlayTime2 = CONVERT(VARCHAR(10), @PlayTime2, 101)		
		--select @PlayTime2

		declare @IsClass2 bit
		set @IsClass2 = 0

		declare @ServerGameNumber int 

		if exists
		(select 1  from [dbo].[Server_GameJournal] sgj
		inner  join [dbo].[Server_Game] sg on sg.servergame = sgj.servergamenumber
		where gamenumber =  @spGameNumber
		and CONVERT(VARCHAR(10), Dtstamp, 101) = @PlayTime2
		and sgj.GameTypeID = @GameTypeID
		)
		begin 
			select @ServerGameNumber = sg.servergame
			from [dbo].[Server_GameJournal] sgj
		inner  join [dbo].[Server_Game] sg on sg.servergame = sgj.servergamenumber
		where gamenumber =  @spGameNumber
		and CONVERT(VARCHAR(10), Dtstamp, 101) = @PlayTime2
		and sgj.GameTypeID = @GameTypeID
		
		set @IsClass2 = 1  
		
		end 

		if (@IsClass2 = 1)
		begin
		update @FInfoTable      
		set ServerGameNumber = @ServerGameNumber
		end
	
		--if firstbonuscard != 0 and winamount = 0
          select 
		    DateTimePlay
        ,B4Games 
        ,StartingCrdtAmnt 
        ,EndingCrdAmnt 
        ,WinAmount 
        ,BonusWinAmount 
        ,BetAmount 
        ,BetLevel 
        ,BetDenom 
        ,CallCount
        ,GameNumber
        ,StartCardNumber 
        ,EndCardNumber 
        ,[FirstBonusCardNumber]
        ,[LastBonusCardNumber]
        ,[CallCountBonus]
        ,[BonusOfferAccepted]
		,ServerGameNumber
		--,case when [FirstBonusCardNumber] != 0 and WinAmount = 0 then 1 else 0 end as IsGameInProgress -- 1 then yes
		   from    @FInfoTable      
		   where  
		   (case when [FirstBonusCardNumber] != 0 and [BonusOfferAccepted] = 0 then 1 else 0 end) = 0








GO


