USE [B3]
GO

DROP PROCEDURE [dbo].[usp_management_GetWinningCardNumber2]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE  proc [dbo].[usp_management_GetWinningCardNumber2]
(
@SessionNumber int, 
@GameNumber int, 
@PayoutType int,
@GameName nvarchar(100),
@WinningCard nvarchar(500) OUTPUT
)
--==============
-- Author:			Fortunet
-- Date Created:	20151125
-- Description:		Get the winning card number -> range per game.		
-- 20160310(knc):	Fixed issue -> Card number is incorrect always returning card number from mayamoney.
----==============
as
begin


declare @ListOfGameName Table 
(
GameName varchar(50)
)
declare @NCardbet int
DECLARE @sqlCommand nvarchar(1000)
DECLARE @ParmDefinition nvarchar(500);

set @GameName = 'dbo.' + @GameName +'_GameJournal game'
insert into @ListOfGameName (GameName) values (@GameName)

			
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
	              else
	        if (@GameName2 = 'dbo.TimeBomb_GameJournal game')
				begin
					 set @sqlCommand = '          select @NCardbetOUT =
						(case when betplaced_card_1 = ''T'' then 1 else 0 end )+
						(case when betplaced_card_2 = ''T'' then 1 else 0 end) +
						(case when betplaced_card_3 = ''T'' then 1 else 0 end) +
						(case when betplaced_card_4 = ''T'' then 1 else 0 end) from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
					+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
					set @ParmDefinition = N'@NCardbetOUT varchar(10) OUTPUT'
					
					EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @NCardbetOUT = @NCardbet OUTPUT
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
		
	
--TEST
--declare 
--@SessionNumber int, 
--@GameNumber int, 
--@PayoutType int,
--@WinningCard nvarchar(500) OUTPUT
--TEST
--set @SessionNumber = 1052
--set @GameNumber = 293
--set @PayoutType = 0
--returns nvarchar(500)
--)
--	
	