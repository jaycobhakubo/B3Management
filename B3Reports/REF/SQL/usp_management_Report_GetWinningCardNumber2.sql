USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_Report_GetWinningCardNumber2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_Report_GetWinningCardNumber2]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE  proc [dbo].[usp_management_Report_GetWinningCardNumber2]

(
@SessionNumber int, 
@GameNumber int, 
@PayoutType int,
@GameTypeId int,
@WinningCard nvarchar(500) OUTPUT
)
AS BEGIN
--==============
-- Author:			Fortunet
-- Date Created:	20151125
-- Description:		Get the winning card number -> range per game.		

----==============
--========TEST=================
--1021	18	0	39
--declare
--@SessionNumber int, 
--@GameNumber int, 
--@PayoutType int,
--@GameTypeId int,
--@WinningCard nvarchar(500)

--set @SessionNumber = 1021
--set @GameNumber = 18
--set @PayoutType = 0
--set @GameTypeId = 39
--BEGIN
--===============================

declare @ListOfGameName Table (GameName varchar(50),  GameTypeId int)
declare @NCardbet int
declare @sqlCommand nvarchar(max)
declare @ParmDefinition nvarchar(500);
declare @Counter int set @Counter = 0
declare @FirstCardNumber varchar(10) 
declare @GameName2 varchar(100)
declare @GameTypeId2 int
declare @CardNumber varchar(10) set @CardNumber = ''
declare @ListOfCardNumber varchar(200) set @ListOfCardNumber = ''
declare @ListOfCardNumber2 varchar(200) set @ListOfCardNumber2 = ''
declare @counttest int

insert into @ListOfGameName (GameName, GameTypeId) values ('dbo.CrazyBout_GameJournal game',36)
insert into @ListOfGameName (GameName, GameTypeId) values ('dbo.MayaMoney_GameJournal game',38)
insert into @ListOfGameName (GameName, GameTypeId) values ('dbo.JailBreak_GameJournal game',37)
insert into @ListOfGameName (GameName, GameTypeId) values ('dbo.WildBall_GameJournal game',41)
insert into @ListOfGameName (GameName, GameTypeId) values ('dbo.TimeBomb_GameJournal game',42)
insert into @ListOfGameName (GameName, GameTypeId) values ('dbo.Spirit76_GameJournal game',39)
set @counttest = 0
			
declare  Game_cursor cursor for 
select GameName , GameTypeId
from @ListOfGameName where GameTypeId = @GameTypeId
open Game_cursor
fetch next from Game_cursor into @GameName2, @GameTypeId2

while @@FETCH_STATUS = 0
BEGIN--1

	set @FirstCardNumber = '';
	set @NCardbet = 0;
	
	if (@PayoutType = 0 or @GameName2 = 'dbo.MayaMoney_GameJournal game' )
	BEGIN--2		 
		set @sqlCommand = 'select @FirstCardNumberOUT = cardsn_1  from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
		set @ParmDefinition = N'@FirstCardNumberOUT varchar(10) OUTPUT'

		EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @FirstCardNumberOUT = @FirstCardNumber OUTPUT

		IF (@GameTypeId != 42)
		BEGIN--3a
			 set @sqlCommand = ' select     
			 @NCardbetOUT = 
			 (case when betplaced_card_1 = ''T'' then 1 else 0 END )+      
			  (case when betplaced_card_2 = ''T'' then 1 else 0 END) +      
			  (case when betplaced_card_3 = ''T'' then 1 else 0 END) +      
			  (case when betplaced_card_4 = ''T'' then 1 else 0 END) +      
			  (case when betplaced_card_5 = ''T'' then 1 else 0 END) +      
			  (case when betplaced_card_6 = ''T'' then 1 else 0 END)
					   , 
				@ListOfCardNumber2OUT =
			   (case when betplaced_card_1 = ''T'' then cast(cardsn_1 as varchar(10)) + '','' else '''' END ) +
			   (case when betplaced_card_2 = ''T'' then '' ''+ cast(cardsn_2 as varchar(10))+ '','' else '''' END )  +
				  (case when betplaced_card_3 = ''T'' then '' ''+cast(cardsn_3 as varchar(10))+ '','' else '''' END ) +
				   (case when betplaced_card_4 = ''T'' then '' ''+cast(cardsn_4 as varchar(10))+ '','' else '''' END)  +
				   (case when betplaced_card_5 = ''T'' then '' ''+cast(cardsn_5 as varchar(10))+ '','' else '''' END )  +
					(case when betplaced_card_6 = ''T'' then '' ''+cast(cardsn_6 as varchar(10))+ '','' else '''' END )
					from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
				+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
				set @ParmDefinition = N'@NCardbetOUT varchar(10) OUTPUT, @ListOfCardNumber2OUT varchar(200) OUTPUT'

				EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @NCardbetOUT = @NCardbet OUTPUT, @ListOfCardNumber2OUT = @ListOfCardNumber2 OUTPUT	
				select @ListOfCardNumber2	= SUBSTRING(@ListOfCardNumber2, 0, len(@ListOfCardNumber2))				
        END
        ELSE
        IF (@GameTypeId = 42)
        BEGIN
         set @sqlCommand = ' select     			 
				@ListOfCardNumber2OUT =
 (case when cardpair_1_exploded = ''F'' then (case when betplaced_card_1 = ''T'' then cast(cardsn_1 as varchar(10)) + '','' else '''' END ) else '''' end) +        
  (case when cardpair_2_exploded = ''F'' then (case when betplaced_card_2 = ''T'' then '' ''+ cast(cardsn_2 as varchar(10))+ '','' else '''' END) else '''' end) +      
   (case when cardpair_3_exploded = ''F'' then (case when betplaced_card_3 = ''T'' then '' ''+cast(cardsn_3 as varchar(10))+ '','' else '''' END ) else '''' end) +           
    (case when cardpair_4_exploded = ''F'' then (case when betplaced_card_4 = ''T'' then '' ''+cast(cardsn_4 as varchar(10))+ '','' else '''' END) else '''' end) 
   +(case when bombcard_1_defused = ''T'' then '' '' + cast(bombcardsn_1 AS varchar(10)) +'','' else '''' END)   
    +(case when bombcard_2_defused = ''T'' then '' '' + cast(bombcardsn_2 AS varchar(10)) +'','' else '''' END)      
     +(case when bombcard_3_defused = ''T'' then '' '' + cast(bombcardsn_3 AS varchar(10)) +'','' else '''' END)      
      +(case when bombcard_4_defused = ''T'' then '' '' + cast(bombcardsn_4 AS varchar(10)) +'','' else '''' END)               	   		
					from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
				+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
				set @ParmDefinition = N'@NCardbetOUT varchar(10) OUTPUT, @ListOfCardNumber2OUT varchar(200) OUTPUT'

				EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @NCardbetOUT = @NCardbet OUTPUT, @ListOfCardNumber2OUT = @ListOfCardNumber2 OUTPUT	
				select @ListOfCardNumber2	= SUBSTRING(@ListOfCardNumber2, 0, len(@ListOfCardNumber2))			
        END
        
          
        SET @Counter = 0
	     
        WHILE (@Counter != @NCardbet)   
		BEGIN--3b
			set @sqlCommand = 'select @cardOUT = cardsn_' + CAST(@Counter + 1 as varchar(10)) + ' from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
		
			set @ParmDefinition = N'@cardOUT varchar(10) OUTPUT'					
			EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @cardOUT = @CardNumber OUTPUT

			set @ListOfCardNumber = @ListOfCardNumber + @CardNumber + ', '	
			set @Counter = @Counter + 1	

		END
		
		set @ListOfCardNumber =  SUBSTRING(@ListOfCardNumber, 0, len(@ListOfCardNumber))		
		if (len(@ListOfCardNumber) != 0)break
	END	    
	else
	if (@PayoutType = 1  )
	BEGIN
		
		--select 	@GameName2	      
	    set @sqlCommand = 'select @FirstCardNumberOUT = cardsn_1  from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
		+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
		set @ParmDefinition = N'@FirstCardNumberOUT varchar(10) OUTPUT'

		EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @FirstCardNumberOUT = @FirstCardNumber OUTPUT
		
			if (@GameName2 = 'dbo.WildFire_GameJournal game')
			BEGIN
				fetch next from Game_cursor into @GameName2
			     continue
			END
					
		if (@GameName2 != 'dbo.TimeBomb_GameJournal game')
		BEGIN
			
			if (@GameName2 != 'dbo.WildBall_GameJournal game')
			BEGIN
				 set @sqlCommand = 'select @NCardbetOUT =
					(case when bonuscardsn_1 != 0 then 1 else 0 END )+
					(case when bonuscardsn_2 != 0 then 1 else 0 END) +
					(case when bonuscardsn_3 != 0 then 1 else 0 END) 
					  from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
				+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
				set @ParmDefinition = N'@NCardbetOUT varchar(10) OUTPUT'			
				EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @NCardbetOUT = @NCardbet OUTPUT		
			END
	        else
	        BEGIN
	        
              set @sqlCommand = 'select @NCardbetOUT =
					(case when bonuscardsn_1 != 0 then 1 else 0 END )+
					(case when bonuscardsn_2 != 0 then 1 else 0 END) +
					(case when bonuscardsn_3 != 0 then 1 else 0 END) +
					(case when bonuscardsn_3 != 0 then 1 else 0 END) 
					  from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
				+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
				set @ParmDefinition = N'@NCardbetOUT varchar(10) OUTPUT'	
					
				EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @NCardbetOUT = @NCardbet OUTPUT
	        END--(@GameName2 != 'dbo.WildBall_GameJournal game')
	    END--(@GameName2 != 'dbo.TimeBomb_GameJournal game')	         

	    while (@Counter != @NCardbet)		   
		BEGIN

			set @sqlCommand = 'select @cardOUT = bonuscardsn_' + CAST(@Counter + 1 as varchar(10)) + ' from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))
			+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
			set @ParmDefinition = N'@cardOUT varchar(10) OUTPUT'
					
					
			EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @cardOUT = @CardNumber OUTPUT
		
			set @ListOfCardNumber = @ListOfCardNumber + @CardNumber + ', '	
			set @Counter = @Counter + 1	

		END--(@Counter != @NCardbet)	
		
		set @ListOfCardNumber =  SUBSTRING(@ListOfCardNumber, 0, len(@ListOfCardNumber))				
		if (len(@ListOfCardNumber) != 0)break	      
	END   --(@PayoutType = 0 or @GameName2 = 'dbo.MayaMoney_GameJournal game' )  	  
	      	
	fetch next from Game_cursor into @GameName2, @GameTypeId2
END-- end while(1)


close  Game_cursor
deallocate  Game_cursor
if (len(@ListOfCardNumber2) > 0 )
BEGIN
set @WinningCard = @ListOfCardNumber2
END
ELSE
BEGIN
set @WinningCard = @ListOfCardNumber
END

--select @WinningCard
return 				
end
		






GO


