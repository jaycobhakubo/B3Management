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
BEGIN 
set @GameNumber = (select GameNumber from Server_GameJournal where ServerGameNumber = @GameNumber)
END

declare @ListOfGameName Table (GameName varchar(50))
declare @NCardbet int
declare @sqlCommand nvarchar(max)
declare @ParmDefinition nvarchar(500);
declare @Counter int set @Counter = 0
declare @FirstCardNumber varchar(10) 
declare @GameName2 varchar(100)
declare @CardNumber varchar(10) set @CardNumber = ''
declare @ListOfCardNumber varchar(200) set @ListOfCardNumber = ''
declare @ListOfCardNumber2 varchar(200) set @ListOfCardNumber2 = ''

--declare @Card1 bit
--declare @Card2 bit
--declare @Card3 bit
--declare @Card4 bit
--declare @Card5 bit
--declare @Card6 bit

insert into @ListOfGameName (GameName) values ('dbo.CrazyBout_GameJournal game')
insert into @ListOfGameName (GameName) values ('dbo.MayaMoney_GameJournal game')
insert into @ListOfGameName (GameName) values ('dbo.JailBreak_GameJournal game')
insert into @ListOfGameName (GameName) values ('dbo.Spirit76_GameJournal game')
insert into @ListOfGameName (GameName) values ('dbo.TimeBomb_GameJournal game')
insert into @ListOfGameName (GameName) values ('dbo.WildFire_GameJournal game')
insert into @ListOfGameName (GameName) values ('dbo.WildBall_GameJournal game')

	
--select GameName 
--from @ListOfGameName 

declare @counttest int
set @counttest = 0
			
declare  Game_cursor cursor for 
select GameName 
from @ListOfGameName 
open Game_cursor
fetch next from Game_cursor into @GameName2

while @@FETCH_STATUS = 0
BEGIN--1

	--select @GameName2
	--set @counttest += 1
	--select @counttest
	--select @GameName2
	set @FirstCardNumber = '';
	set @NCardbet = 0;
	
	if (@PayoutType = 0 or @GameName2 = 'dbo.MayaMoney_GameJournal game' )
	BEGIN--2		 
		set @sqlCommand = 'select @FirstCardNumberOUT = cardsn_1  from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
		set @ParmDefinition = N'@FirstCardNumberOUT varchar(10) OUTPUT'
		
		EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @FirstCardNumberOUT = @FirstCardNumber OUTPUT
			--select @FirstCardNumber		
		IF (@GameName2 != 'dbo.TimeBomb_GameJournal game')
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
			--select @sqlCommand
		
			--select 'hello'
			EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @NCardbetOUT = @NCardbet OUTPUT, @ListOfCardNumber2OUT = @ListOfCardNumber2 OUTPUT
					--print cast(@NCardbet as varchar(10))
					--select @NCardbet		
				     select @ListOfCardNumber2	= SUBSTRING(@ListOfCardNumber2, 0, len(@ListOfCardNumber2))	
				    --select @ListOfCardNumber2			
        END
             
        SET @Counter = 0
	     
        WHILE (@Counter != @NCardbet)   
		BEGIN--3b
			set @sqlCommand = 'select @cardOUT = cardsn_' + CAST(@Counter + 1 as varchar(10)) + ' from ' +  @GameName2 + ' where game.sessnum = ' + cast(@SessionNumber as varchar(10))+ ' and game.gamenum = ' + cast (@GameNumber as varchar(10)) 
			--select @sqlCommand
			set @ParmDefinition = N'@cardOUT varchar(10) OUTPUT'					
			EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @cardOUT = @CardNumber OUTPUT
			--select @CardNumber
			set @ListOfCardNumber = @ListOfCardNumber + @CardNumber + ', '	
			set @Counter = @Counter + 1	
			--select @Counter, @ListOfCardNumber
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
					
			--select * from dbo.CrazyBout_GameJournal
			--select @sqlCommand
			--select  bonuscardsn_1 from dbo.CrazyBout_GameJournal game where game.sessnum = 1053 and game.gamenum = 142
					
			EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @cardOUT = @CardNumber OUTPUT
		
			set @ListOfCardNumber = @ListOfCardNumber + @CardNumber + ', '	
			set @Counter = @Counter + 1	
			--select @Counter
		END--(@Counter != @NCardbet)	
		
		set @ListOfCardNumber =  SUBSTRING(@ListOfCardNumber, 0, len(@ListOfCardNumber))				
		if (len(@ListOfCardNumber) != 0)break	      
	END   --(@PayoutType = 0 or @GameName2 = 'dbo.MayaMoney_GameJournal game' )  	  
	      	
	fetch next from Game_cursor into @GameName2
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


