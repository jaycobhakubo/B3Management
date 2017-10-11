USE [B3]
GO

/****** Object:  UserDefinedFunction [dbo].[B3_fnGetWinningCardNumber2]    Script Date: 12/01/2015 12:06:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_fnGetWinningCardNumber2]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[B3_fnGetWinningCardNumber2]
GO

USE [B3]
GO

/****** Object:  UserDefinedFunction [dbo].[B3_fnGetWinningCardNumber2]    Script Date: 12/01/2015 12:06:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE function [dbo].[B3_fnGetWinningCardNumber2](@SessionNumber int, @GameNumber int, @PayoutType int)
returns nvarchar(500)

--==============
-- Author:			Karlo Camacho
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


