USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_GetWinningCardNumber2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_GetWinningCardNumber2]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE  proc [dbo].[usp_management_GetWinningCardNumber2]
(
--declare 
@SessionNumber int, 
@GameNumber int, 
@PayoutType int,
@WinningCard nvarchar(500) OUTPUT
--TEST
--set @SessionNumber = 1052
--set @GameNumber = 293
--set @PayoutType = 0
--returns nvarchar(500)
)
--==============
-- Author:			Fortunet
-- Date Created:	20151125
-- Description:		Get the winning card number -> range per game.		

----==============
as
begin

if exists (select 1 from Server_GameJournal where ServerGameNumber = @GameNumber )
begin 
--select 'It Exists'
set @GameNumber = (select GameNumber from Server_GameJournal where ServerGameNumber = @GameNumber)
end


declare @ListOfGameName Table 
(
GameName varchar(50)
)
declare @NCardbet int
DECLARE @sqlCommand nvarchar(1000)
DECLARE @ParmDefinition nvarchar(500);

insert into @ListOfGameName (GameName) values ('dbo.MayaMoney_GameJournal game')
insert into @ListOfGameName (GameName) values ('dbo.CrazyBout_GameJournal game')
insert into @ListOfGameName (GameName) values ('dbo.JailBreak_GameJournal game')
insert into @ListOfGameName (GameName) values ('dbo.Spirit76_GameJournal game')
insert into @ListOfGameName (GameName) values ('dbo.TimeBomb_GameJournal game')
insert into @ListOfGameName (GameName) values ('dbo.WildFire_GameJournal game')
insert into @ListOfGameName (GameName) values ('dbo.WildBall_GameJournal game')


			
declare @Counter int set @Counter = 0
declare @FirstCardNumber varchar(10) 
declare @GameName2 varchar(100)
--declare @GameName varchar(50) set @GameName = 'dbo.MayaMoney_GameJournal game'
declare @CardNumber varchar(10) set @CardNumber = ''
declare @ListOfCardNumber varchar(200) set @ListOfCardNumber = ''

declare  Game_cursor cursor for


select GameName from @ListOfGameName
open Game_cursor
fetch next from Game_cursor into @GameName2
while @@FETCH_STATUS = 0
begin
	--select @GameName2
	set @FirstCardNumber = '';
	set @NCardbet = 0;
	
	--select @GameName2
	
	if (@PayoutType = 0 or @GameName2 = 'dbo.MayaMoney_GameJournal game' )
	begin
		 set @sqlCommand = 'select @FirstCardNumberOUT = cardsn_1  from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
		+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
		set @ParmDefinition = N'@FirstCardNumberOUT varchar(10) OUTPUT'
		
				EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @FirstCardNumberOUT = @FirstCardNumber OUTPUT
				
	
			if (@GameName2 != 'dbo.TimeBomb_GameJournal game')
				begin
					 set @sqlCommand = '          select @NCardbetOUT =
						(case when betplaced_card_1 = ''T'' then 1 else 0 end )+
						(case when betplaced_card_2 = ''T'' then 1 else 0 end) +
						(case when betplaced_card_3 = ''T'' then 1 else 0 end) +
						(case when betplaced_card_4 = ''T'' then 1 else 0 end) +
						(case when betplaced_card_5 = ''T'' then 1 else 0 end) +
						(case when betplaced_card_6 = ''T'' then 1 else 0 end)  from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
					+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
					set @ParmDefinition = N'@NCardbetOUT varchar(10) OUTPUT'
					
					EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @NCardbetOUT = @NCardbet OUTPUT
							--print cast(@NCardbet as varchar(10))
	             end
	             
	             set @Counter = 0
	     
	             while (@Counter != @NCardbet)
		   
					begin

					 set @sqlCommand = 'select @cardOUT = cardsn_' + CAST(@Counter + 1 as varchar(10)) + ' from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
					+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
					set @ParmDefinition = N'@cardOUT varchar(10) OUTPUT'
					
					EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @cardOUT = @CardNumber OUTPUT
				
					set @ListOfCardNumber = @ListOfCardNumber + @CardNumber + ', '	
					set @Counter = @Counter + 1	
					--select @Counter
					end
		
				set @ListOfCardNumber =  SUBSTRING(@ListOfCardNumber, 0, len(@ListOfCardNumber))
				
				if (len(@ListOfCardNumber) != 0)break
	      end
	      else
	      if (@PayoutType = 1  )
	      begin
				--select 	@GameName2
	      
	       set @sqlCommand = 'select @FirstCardNumberOUT = cardsn_1  from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
		+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
		set @ParmDefinition = N'@FirstCardNumberOUT varchar(10) OUTPUT'
		
				EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @FirstCardNumberOUT = @FirstCardNumber OUTPUT
				
	
			if (@GameName2 != 'dbo.TimeBomb_GameJournal game')
				begin
				if (@GameName2 != 'dbo.WildBall_GameJournal game')
				begin
					 set @sqlCommand = 'select @NCardbetOUT =
						(case when bonuscardsn_1 != 0 then 1 else 0 end )+
						(case when bonuscardsn_2 != 0 then 1 else 0 end) +
						(case when bonuscardsn_3 != 0 then 1 else 0 end) 
						  from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
					+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
					set @ParmDefinition = N'@NCardbetOUT varchar(10) OUTPUT'
					
					EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @NCardbetOUT = @NCardbet OUTPUT

	             end
	             else
	             begin
	              set @sqlCommand = 'select @NCardbetOUT =
						(case when bonuscardsn_1 != 0 then 1 else 0 end )+
						(case when bonuscardsn_2 != 0 then 1 else 0 end) +
						(case when bonuscardsn_3 != 0 then 1 else 0 end) +
						(case when bonuscardsn_3 != 0 then 1 else 0 end) 
						  from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
					+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
					set @ParmDefinition = N'@NCardbetOUT varchar(10) OUTPUT'
					
					EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @NCardbetOUT = @NCardbet OUTPUT
	             end
	         end
	         
	             while (@Counter != @NCardbet)
		   
					begin

					 set @sqlCommand = 'select @cardOUT = bonuscardsn_' + CAST(@Counter + 1 as varchar(10)) + ' from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
					+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
					set @ParmDefinition = N'@cardOUT varchar(10) OUTPUT'
					
				--select * from dbo.CrazyBout_GameJournal
				--select @sqlCommand
				--select  bonuscardsn_1 from dbo.CrazyBout_GameJournal game where game.sessnum = 1053 and game.gamenum = 142
					
					EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @cardOUT = @CardNumber OUTPUT
				
		
					set @ListOfCardNumber = @ListOfCardNumber + @CardNumber + ', '	
					set @Counter = @Counter + 1	
					--select @Counter
					end
		
				set @ListOfCardNumber =  SUBSTRING(@ListOfCardNumber, 0, len(@ListOfCardNumber))
				
				if (len(@ListOfCardNumber) != 0)break
	      
	      end       

	
	fetch next from Game_cursor into @GameName2
end
close  Game_cursor
deallocate  Game_cursor

set @WinningCard = @ListOfCardNumber
--select @WinningCard
return 
				
	
end
		
	
		
		--while (@Counter != @NCardbet)
		   
		--begin

		-- set @sqlCommand = 'select @cardOUT = cardsn_' + CAST(@Counter + 1 as varchar(10)) + ' from ' +  @GameName + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
		--+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
		--set @ParmDefinition = N'@cardOUT varchar(10) OUTPUT'
		
		--EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @cardOUT = @CardNumber OUTPUT
	
	 --   set @ListOfCardNumber = @ListOfCardNumber + @CardNumber + ', '	
		--set @Counter = @Counter + 1	
		
		--end
		
		--set @ListOfCardNumber =  SUBSTRING(@ListOfCardNumber, 0, len(@ListOfCardNumber))
	

--declare @Result nvarchar(500)
		
--		;with CrazyBoutCardNumber(GameNumber, CardNumber)as
--		(select game.gamenum,
--		case when  @PayoutType = 0
--		then  
--			case when betplaced_card_1 = 'T' then
--			cast(game.cardsn_1 as varchar(10)) +', '
--			else '' end
--			+ case when betplaced_card_2 = 'T' then
--			 cast(game.cardsn_2 as varchar(10))+', '
--			 else '' end
--			+ case when betplaced_card_3 = 'T' then
--			 cast (game.cardsn_3 as varchar(10))+', '
--			 else '' end
--			+ case when betplaced_card_4 = 'T' then 
--			 CAST (game.cardsn_4 as varchar(10))+', '
--			else '' end
--			+ case when betplaced_card_5 = 'T' then 
--			 CAST (game.cardsn_5 as varchar(10))+', '
--			else '' end
--			+ case when betplaced_card_6 = 'T' then 
--			 CAST (game.cardsn_6 as varchar(10))
--			else '' end 
--		else 
--		 cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10))
--		end
		
--		from 
--		dbo.CrazyBout_GameJournal game
--		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
--		where game.sessnum = @SessionNumber
--		and game.gamenum = @GameNumber
--		)
		
	
		
--		,JailBreakCardNumber (GameNumber, CardNumber) as
--		(
--		select game.gamenum,
--		case when @PayoutType = 0
--		then
--		case when betplaced_card_1 = 'T' then
--		cast(game.cardsn_1 as varchar(10)) +', '
--		else '' end
--	    + case when betplaced_card_2 = 'T' then
--	     cast(game.cardsn_2 as varchar(10))+', '
--	     else '' end
--		+ case when betplaced_card_3 = 'T' then
--		 cast (game.cardsn_3 as varchar(10))+', '
--		 else '' end
--		+ case when betplaced_card_4 = 'T' then 
--		 CAST (game.cardsn_4 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_5 = 'T' then 
--		 CAST (game.cardsn_5 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_6 = 'T' then 
--		 CAST (game.cardsn_6 as varchar(10))
--		else '' end
--		else
--		cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10)) end
--		from 
--		dbo.JailBreak_GameJournal game
--		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
--		where game.sessnum = @SessionNumber
--		and game.gamenum = @GameNumber
--		)
--		,MayaMoneyCardNumber (GameNumber, CardNumber) as  
--		(
--		select game.gamenum,
--		case when @PayoutType = 0
--		then
--		case when betplaced_card_1 = 'T' then
--		cast(game.cardsn_1 as varchar(10)) +', '
--		else '' end
--	    + case when betplaced_card_2 = 'T' then
--	     cast(game.cardsn_2 as varchar(10))+', '
--	     else '' end
--		+ case when betplaced_card_3 = 'T' then
--		 cast (game.cardsn_3 as varchar(10))+', '
--		 else '' end
--		+ case when betplaced_card_4 = 'T' then 
--		 CAST (game.cardsn_4 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_5 = 'T' then 
--		 CAST (game.cardsn_5 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_6 = 'T' then 
--		 CAST (game.cardsn_6 as varchar(10))
--		else '' end		
--		end
--		from 
--		dbo.MayaMoney_GameJournal game
--		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
--		where game.sessnum = @SessionNumber
--		and game.gamenum = @GameNumber
--		)
--		,Spirit76CardNumber (GameNumber, CardNumber) as  
--		(
--		select game.gamenum,
--		case when @PayoutType = 0
--		then
--		case when betplaced_card_1 = 'T' then
--		cast(game.cardsn_1 as varchar(10)) +', '
--		else '' end
--	    + case when betplaced_card_2 = 'T' then
--	     cast(game.cardsn_2 as varchar(10))+', '
--	     else '' end
--		+ case when betplaced_card_3 = 'T' then
--		 cast (game.cardsn_3 as varchar(10))+', '
--		 else '' end
--		+ case when betplaced_card_4 = 'T' then 
--		 CAST (game.cardsn_4 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_5 = 'T' then 
--		 CAST (game.cardsn_5 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_6 = 'T' then 
--		 CAST (game.cardsn_6 as varchar(10))
--		else '' end
--		else
--		cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10))
--		 end

--		from 
--		dbo.Spirit76_GameJournal game
--		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
--		where game.sessnum = @SessionNumber
--		and game.gamenum = @GameNumber
--		)
--		,TimeBombCardNumber (GameNumber, CardNumber) as  
--		(
--		select game.gamenum, 
--		case when @PayoutType = 0
--		then
--		case when betplaced_card_1 = 'T' then
--		cast(game.cardsn_1 as varchar(10)) +', '
--		else '' end
--	    + case when betplaced_card_2 = 'T' then
--	     cast(game.cardsn_2 as varchar(10))+', '
--	     else '' end
--		+ case when betplaced_card_3 = 'T' then
--		 cast (game.cardsn_3 as varchar(10))+', '
--		 else '' end
--		+ case when betplaced_card_4 = 'T' then 
--		 CAST (game.cardsn_4 as varchar(10))
--		else '' end		
--		end
--		from 
--		dbo.TimeBomb_GameJournal game
--		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
--		where game.sessnum = @SessionNumber
--		and game.gamenum = @GameNumber
--		)
--		--,UkickEmCardNumber (GameNumber, CardNumber) as  
--		--(		
--		--select game.gamenum,
--		--cast(game.cardsn_1 as varchar(10)) +', '
--		--+ cast(game.cardsn_2 as varchar(10))+', '
--		--+ cast (game.cardsn_3 as varchar(10))+', '
--		--+ CAST (game.cardsn_4 as varchar(10))+', '
--		--+ CAST (game.cardsn_5 as varchar(10))+', '
--		--+ CAST (game.cardsn_6 as varchar(10))
--		--from 
--		--dbo.UKickEm_GameJournal game
--		--where game.sessnum = @SessionNumber
--		--and game.gamenum = @GameNumber
--		--)
--		,WildBallCardNumber (GameNumber, CardNumber) as  
--		(
--		select game.gamenum,
--		case when @PayoutType = 0
--		then
--		case when betplaced_card_1 = 'T' then
--		cast(game.cardsn_1 as varchar(10)) +', '
--		else '' end
--	    + case when betplaced_card_2 = 'T' then
--	     cast(game.cardsn_2 as varchar(10))+', '
--	     else '' end
--		+ case when betplaced_card_3 = 'T' then
--		 cast (game.cardsn_3 as varchar(10))+', '
--		 else '' end
--		+ case when betplaced_card_4 = 'T' then 
--		 CAST (game.cardsn_4 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_5 = 'T' then 
--		 CAST (game.cardsn_5 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_6 = 'T' then 
--		 CAST (game.cardsn_6 as varchar(10))
--		else '' end
--		else
--		 cast(game.bonuscardsn_1 AS varchar(10)) +', ' + cast(game.bonuscardsn_2 AS varchar(10)) +', ' + cast(game.bonuscardsn_3 AS varchar(10)) +', ' + cast(game.bonuscardsn_4 AS varchar(10))
--		 end

--		from 
--		dbo.WildBall_GameJournal game
--		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
--		where game.sessnum = @SessionNumber
--		and game.gamenum = @GameNumber
--		)
--		,WildFireCardNumber (GameNumber, CardNumber) as  
--		(
--		select game.gamenum,
--		case when @PayoutType = 0 
--		then
--		case when betplaced_card_1 = 'T' then
--		cast(game.cardsn_1 as varchar(10)) +', '
--		else '' end
--	    + case when betplaced_card_2 = 'T' then
--	     cast(game.cardsn_2 as varchar(10))+', '
--	     else '' end
--		+ case when betplaced_card_3 = 'T' then
--		 cast (game.cardsn_3 as varchar(10))+', '
--		 else '' end
--		+ case when betplaced_card_4 = 'T' then 
--		 CAST (game.cardsn_4 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_5 = 'T' then 
--		 CAST (game.cardsn_5 as varchar(10))+', '
--		else '' end
--		+ case when betplaced_card_6 = 'T' then 
--		 CAST (game.cardsn_6 as varchar(10))
--		else '' end
--		end
--		from 
--		dbo.WildFire_GameJournal game
--		--inner join B3_JackpotJournal jj on jj.gamenum  = game.gamenum
--		where game.sessnum = @SessionNumber
--		and game.gamenum = @GameNumber
--		)
--		,ResultSet  (GameNumber, CardNumber) as
--		(
--		select GameNumber, CardNumber from CrazyBoutCardNumber
--		union all 
--		select GameNumber, CardNumber from JailBreakCardNumber
--		union all 
--		select GameNumber, CardNumber from MayaMoneyCardNumber
--		union all 
--		select GameNumber, CardNumber from Spirit76CardNumber
--		union all 
--		select GameNumber, CardNumber from TimeBombCardNumber
--		union all 
--		select GameNumber, CardNumber from WildBallCardNumber
--		union all 
--		select GameNumber, CardNumber from WildFireCardNumber	
--		)
--	--insert into @JackpotCardNumber (GameNum, CardNumbers)
--	select @Result = CardNumber from ResultSet ;
		
		
--		--20150904(knc): Use distinct to kill duplicate record::Since we only need the rec number and card number there is no need for duplicate record.
		
--		select @Result

--return @Result
--end












GO


