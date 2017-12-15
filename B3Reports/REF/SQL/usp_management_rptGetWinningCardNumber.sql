USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_rptGetWinningCardNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_rptGetWinningCardNumber]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE proc [dbo].[usp_management_rptGetWinningCardNumber]
(
@PatterName varchar(100),
@SessionNumber int, 
@BallCallType int, --0 regular; 1 = bonus
@GameID int,
@RegGameID int,
@GameName varchar(50),
@IsServerGame bit,
@WinningCardNumber3 varchar(500) OUTPUT
)
as
begin

declare @RangeWinCardNumber varchar(500)
declare @Pattern table (Design varchar(100))
declare @WinningNumber varchar(50) set @WinningNumber = ''
declare @result int 
declare @tempValue varchar(50)
DECLARE @command nvarchar(4000);
DECLARE @ParmDefinition nvarchar(500);
declare @Exists bit 
declare @BallCall varchar(1000)
declare @m_CardN int
declare @WinnerCount int set @WinnerCount = 0
declare @TempN nvarchar(10)
declare @TempWinningCardNumber int
declare @C_Card nvarchar(100)
declare @TempCardNumber varchar(10)
declare @result2 int
--For Mayamoney Bonus round
declare @PreviousCardWinner int
declare @CountPreviousCardWinner int set @CountPreviousCardWinner = 0

if (@PatterName is null or @PatterName = 'NULL')
begin
	set @PatterName = ''
end

set  @WinningCardNumber3 = '';
set @Exists = 1
set @WinningNumber = ''

exec dbo.usp_management_GetWinningCardNumber2 @SessionNumber, @RegGameID, @BallCallType, @RangeWinCardNumber output	
exec dbo.usp_management_Report_BallCallwGameID @SessionNumber, @GameID, @BallCallType, @GameName, @IsServerGame,@BallCall output

set @BallCall = ','+ @BallCall+',0,' set @BallCall = REPLACE(@BallCall,' ','')
set @C_Card = @RangeWinCardNumber set @C_Card = REPLACE(@C_Card,' ','')+',' 
set @result2 = (select CHARINDEX(',',@C_Card))

		while (@result2 != 0 and len(@C_Card) > 1)
		begin	
					 set @TempCardNumber = SUBSTRING(@C_Card, 0, @result2) 
					 set @m_CardN = cast(@TempCardNumber as int)
					 
					 declare @dub1 int, @dub2 int, @dub3 int, @dub4 int, @dub5 int, @dub6 int, @dub7 int, @dub8 int, @dub9 int 		
					declare @count2 int , @count int	
					declare @TempPattern varchar(100)	
					
					    if (@PatterName = 'Tiny Pyramid')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('3|7|8|13|' )
							insert into @Pattern  values ('8|12|13|18|' )
							insert into @Pattern  values ('13|17|18|23|' )


							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output													
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
									 
						else if (@PatterName = 'Any Line')
						begin
						    delete from @Pattern
							insert into @Pattern  values ('1|6|11|16|21|' )
							insert into @Pattern  values ('2|7|12|17|22|' )
							insert into @Pattern  values ('3|8|13|18|23|' )
							insert into @Pattern  values ('4|9|14|19|24|' )
							insert into @Pattern  values ('5|10|15|20|25|' )
							insert into @Pattern  values ('1|2|3|4|5|' )
							insert into @Pattern  values ('6|7|8|9|10|' )
							insert into @Pattern  values ('11|12|13|14|15|' )
							insert into @Pattern  values ('16|17|18|19|20|' )
							insert into @Pattern  values ('21|22|23|24|25|' )
							insert into @Pattern  values ('5|9|13|17|21|' )
							insert into @Pattern  values ('1|7|13|19|25|' )
	
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output															
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end

						else if (@PatterName = 'Up and Down')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('3|7|11|17|23|' )
							insert into @Pattern  values ('3|9|15|19|23|' )
							

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end

								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor
						end
						
							else if (@PatterName = 'Crazy V')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|7|13|17|21|')
							insert into @Pattern  values ('1|5|7|9|13|')
							insert into @Pattern  values ('5|9|13|19|25|' )
							insert into @Pattern  values ('13|17|19|21|25|' )
							

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end

								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor
						end

						else if (@PatterName = 'Crazy Stamp' Or @PatterName = 'Cellblock 4')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|2|6|7|' )
							insert into @Pattern  values ('16|17|21|22|' )
							insert into @Pattern  values ('4|5|9|10|' )
							insert into @Pattern  values ('19|20|24|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end

								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor
						end
							else if (@PatterName = 'Any Six Pack')
						begin
				
							delete from @Pattern

							--insert into @Pattern  values ('3|7|8|13|' )
							--insert into @Pattern  values ('8|12|13|18|' )
							--insert into @Pattern  values ('13|17|18|23|' )


							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Four Corners')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|5|21|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
					 	else if (@PatterName = 'Small X')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('7|9|13|17|19' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Flower')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('8|12|13|14|18|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Star')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('3|11|13|15|23|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Pyramid')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('3|7|8|11|12|13|17|18|23' )
							insert into @Pattern  values ('4|8|9|12|13|14|18|19|24' )
							insert into @Pattern  values ('5|9|10|13|14|15|19|20|25' )


							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Steps')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|2|7|8|13|14|19|20|25|' )
							insert into @Pattern  values ('5|9|10|13|14|17|18|21|22|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Sun')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('2|4|6|7|9|10|13|16|17|19|20|22|24|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Great Pyramid')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('5|8|9|10|11|12|13|14|15|18|19|20|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Small Crazy Kite')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|2|6|7|13|19|25|' )
							insert into @Pattern  values ('5|9|13|16|17|21|22|' )
							insert into @Pattern  values ('1|7|13|19|20|24|25|' )
							insert into @Pattern  values ('4|5|9|10|13|17|21|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						else if (@PatterName = 'Block of 9')
						begin
				
							delete from @Pattern
							
							--declare @dub1 int, @dub2 int, @dub3 int, @dub4 int, @dub5 int, @dub6 int, @dub7 int, @dub8 int, @dub9 int 
							set @dub1 = 1 set @dub2 = 2 set @dub3 = 3 set @dub4 = 6 set @dub5 = 7 set @dub6 = 8 set @dub7 = 11 set @dub8 = 12 set @dub9 = 13
							
							--declare  @count int 
							set @count= 0 
							while (@count != 3)
							begin
								--declare @TempPattern varchar(100)
								set @TempPattern =  cast(@dub1 + @count  as varchar(10))+'|'
													+cast(@dub2 + @count  as varchar(10))+'|'
													+cast(@dub3 + @count  as varchar(10))+'|'
													+cast(@dub4 + @count  as varchar(10))+'|'
													+cast(@dub5 + @count  as varchar(10))+'|'
													+cast(@dub6 + @count  as varchar(10))+'|'
													+cast(@dub7 + @count  as varchar(10))+'|'
													+cast(@dub8 + @count  as varchar(10))+'|'
													+cast(@dub9 + @count  as varchar(10))+'|'
								
								insert into @Pattern  values(@TempPattern)
								--declare @count2 int 
								set @count2 = 5
								while (@count2 != 15)
								begin
								set @TempPattern =  cast(@dub1 + @count2 + @count  as varchar(10))+'|'
													+cast(@dub2 + @count2 + @count as varchar(10))+'|'
													+cast(@dub3 + @count2 + @count as varchar(10))+'|'
													+cast(@dub4 + @count2 + @count as varchar(10))+'|'
													+cast(@dub5 + @count2 + @count as varchar(10))+'|'
													+cast(@dub6 + @count2 + @count as varchar(10))+'|'
													+cast(@dub7 + @count2 + @count as varchar(10))+'|'
													+cast(@dub8 + @count2 + @count as varchar(10))+'|'
													+cast(@dub9 + @count2 + @count as varchar(10))+'|'
												
													insert into @Pattern  values(@TempPattern)
													set @count2 = @count2 + 5
								end
								set @count2 = 0
						
								set @count = @count + 1
							end
				

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Crazy T')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|6|11|12|13|14|15|16|21|' )
							insert into @Pattern  values ('3|8|13|18|21|22|23|24|25|' )
							insert into @Pattern  values ('5|10|11|12|13|14|15|20|25|' )
							insert into @Pattern  values ('1|2|3|4|5|8|13|18|23|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						else if (@PatterName = 'Letter X')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|5|7|9|13|17|19|21|25|' )
				

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end

						else if (@PatterName = 'Large Diamond')
						begin
				
							delete from @Pattern

						   insert into @Pattern  values ('3|7|9|11|15|17|19|23|' )
						   insert into @Pattern  values ('3|7|8|9|11|12|13|14|15|17|18|19|23|' )--For 76 Bingo

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Small Frame')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('7|8|9|12|14|17|18|19|' )
				

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'Crazy L')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|2|3|4|5|10|15|20|25|' )
							insert into @Pattern  values ('1|2|3|4|5|6|11|16|21|' )
							insert into @Pattern  values ('1|6|11|16|21|22|23|24|25|' )
							insert into @Pattern  values ('5|10|15|20|25|21|22|23|24|' )
				

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end

						else if (@PatterName = 'Crazy Love Letter')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|2|3|4|5|10|15|20|25|21|' )
							insert into @Pattern  values ('1|2|3|4|5|6|11|16|21|25|' )
							insert into @Pattern  values ('1|6|11|16|21|22|23|24|25|5|' )
							insert into @Pattern  values ('5|10|15|20|25|21|22|23|24|1|' )
				
							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						else if (@PatterName = 'Four Brackets')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|2|4|5|6|10|16|20|21|22|24|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end

								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'The Yard')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|5|21|25|')
							insert into @Pattern  values ('3|11|15|23|')
							insert into @Pattern  values ('7|9|17|19|')
							insert into @Pattern  values ('8|12|14|18|')
						

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'File')
						begin
						    delete from @Pattern
				
							insert into @Pattern  values ('11|12|13|14|15|' )
							insert into @Pattern  values ('3|8|13|18|23|' )
							insert into @Pattern  values ('5|9|13|17|21|' )
							insert into @Pattern  values ('1|7|13|19|25|' )
	
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
					else if (@PatterName =  'Cellblock 6')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|2|3|6|7|8|' )
							insert into @Pattern  values ('16|17|18|21|22|23|' )
							insert into @Pattern  values ('3|4|5|8|9|10|' )
							insert into @Pattern  values ('18|19|20|23|24|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end

								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor
						end
						
							else if (@PatterName =  'Cellblock 8')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|2|3|4|6|7|8|9|' )
							insert into @Pattern  values ('16|17|18|19|21|22|23|24|' )
							insert into @Pattern  values ('2|3|4|5|7|8|9|10|' )
							insert into @Pattern  values ('17|18|19|20|22|23|24|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end

								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor
						end
					else if (@PatterName =  'Cellblock 9')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|2|3|6|7|8|11|12|13|' )
							insert into @Pattern  values ('11|12|13|16|17|18|21|22|23|' )
							insert into @Pattern  values ('3|4|5|8|9|10|13|14|15|' )
							insert into @Pattern  values ('13|14|15|18|19|20|23|24|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end

								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor
						end
						else if (@PatterName = 'Bars')
						begin
						    delete from @Pattern
				
							insert into @Pattern  values ('2|4|11|12|13|14|15|22|24|' )
							insert into @Pattern  values ('3|6|8|10|13|16|18|20|23|' )

	
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						
						else if (@PatterName = 'Key')
						begin
						    delete from @Pattern
				
							
							insert into @Pattern  values ('2|3|4|7|8|9|13|18|23|24|' )
							insert into @Pattern  values ('3|4|8|13|17|18|19|22|23|24' )
				
	
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						
						else if (@PatterName = 'Cot')
						begin
						    delete from @Pattern
				
							
							insert into @Pattern  values ('2|3|4|9|10|14|19|20|24|' )
							insert into @Pattern  values ('4|9|10|14|19|20|22|23|24|' )
				
	
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						
							else if (@PatterName = 'Guard')
						begin
						    delete from @Pattern
				
							
							insert into @Pattern  values ('3|4|7|10|11|17|20|23|24|' )				
	
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						else if (@PatterName = 'Tunnel')
						begin
						    delete from @Pattern
	
							insert into @Pattern  values ('2|7|12|17|22|4|9|14|19|24|' )
							insert into @Pattern  values ('6|7|8|9|10|16|17|18|19|20|' )
			
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
								else if (@PatterName = 'Dynamite')
						begin
						    delete from @Pattern
	
							insert into @Pattern  values ('1|3|4|5|11|13|14|15|21|23|24|25|' )
			
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						
							else if (@PatterName = 'Six Pack')
						begin
				
							delete from @Pattern
							
			
							set @dub1 = 1 set @dub2 = 2 set @dub3 = 3 set @dub4 = 6 set @dub5 = 7 set @dub6 = 8 
							
		
							set @count= 0 		
		
							while (@count != 3)
							begin
					
								set @TempPattern =  cast(@dub1 + @count  as varchar(10))+'|'
													+cast(@dub2 + @count  as varchar(10))+'|'
													+cast(@dub3 + @count  as varchar(10))+'|'
													+cast(@dub4 + @count  as varchar(10))+'|'
													+cast(@dub5 + @count  as varchar(10))+'|'
													+cast(@dub6 + @count  as varchar(10))+'|'

								--select @TempPattern
								insert into @Pattern  values(@TempPattern)
						 set @count2 = 5
								while (@count2 != 20)
								begin
								set @TempPattern =  cast(@dub1 + @count2 + @count  as varchar(10))+'|'
													+cast(@dub2 + @count2 + @count as varchar(10))+'|'
													+cast(@dub3 + @count2 + @count as varchar(10))+'|'
													+cast(@dub4 + @count2 + @count as varchar(10))+'|'
													+cast(@dub5 + @count2 + @count as varchar(10))+'|'
													+cast(@dub6 + @count2 + @count as varchar(10))+'|'

												
												--select @TempPattern
													insert into @Pattern  values(@TempPattern)
													set @count2 = @count2 + 5
								end
								set @count2 = 0
						
								set @count = @count + 1
							end
							
							set @dub1 = 1 set @dub2 = 2 set @dub3 = 6 set @dub4 = 7 set @dub5 = 11 set @dub6 = 12 
							
						 set @count= 0 
							while (@count != 4)
							begin
			
								set @TempPattern =  cast(@dub1 + @count  as varchar(10))+'|'
													+cast(@dub2 + @count  as varchar(10))+'|'
													+cast(@dub3 + @count  as varchar(10))+'|'
													+cast(@dub4 + @count  as varchar(10))+'|'
													+cast(@dub5 + @count  as varchar(10))+'|'
													+cast(@dub6 + @count  as varchar(10))+'|'

								select @TempPattern
								insert into @Pattern  values(@TempPattern)
							set @count2 = 5
								while (@count2 != 15)
								begin
								set @TempPattern =  cast(@dub1 + @count2 + @count  as varchar(10))+'|'
													+cast(@dub2 + @count2 + @count as varchar(10))+'|'
													+cast(@dub3 + @count2 + @count as varchar(10))+'|'
													+cast(@dub4 + @count2 + @count as varchar(10))+'|'
													+cast(@dub5 + @count2 + @count as varchar(10))+'|'
													+cast(@dub6 + @count2 + @count as varchar(10))+'|'

												
												select @TempPattern
													insert into @Pattern  values(@TempPattern)
													set @count2 = @count2 + 5
								end
								set @count2 = 0
						
								set @count = @count + 1
							end
							
							
				

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							else if (@PatterName = 'TNT')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|6|11|12|13|14|15|16|21|' )
							insert into @Pattern  values ('1|2|3|4|5|7|13|19|21|22|23|24|25|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						
							else if (@PatterName = 'Fireworks')
						begin
				
							delete from @Pattern

							insert into @Pattern  values ('1|5|21|25|8|12|13|14|18|' )

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						
							else if (@PatterName = 'Candles')
						begin
						    delete from @Pattern
	
							insert into @Pattern  values ('2|4|5|11|13|14|15|22|24|25|' )
			
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						
							else if (@PatterName = 'WildFire')
						begin
						    delete from @Pattern
	
							insert into @Pattern  values ('2|3|4|10|13|14|20|22|23|24|' )
			
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						
						else if (@PatterName = 'Fire Hydrant')
						begin
						    delete from @Pattern
	
							insert into @Pattern  values ('7|8|10|11|12|13|14|15|17|18|20|' )
			
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						
								else if (@PatterName = 'Number 7')
						begin
						    delete from @Pattern
	
							insert into @Pattern  values ('11|16|21|22|23|24|25|' )
		
							declare Pattern_Cursor cursor
							for 
							select Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin
								set @result = (select CHARINDEX('|',@tempValue))

								while (@result != 0 and @Exists =1)
								begin
								    set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									--set @Exists = (select dbo.b3_fnCheckCardIfWin4(@TempN, @BallCall, @m_CardN))	
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))
								end
									
								if (@Exists = 1)--WINNER
								begin
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end		
								
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 
							close Pattern_Cursor
							deallocate Pattern_Cursor	
						end
						else if (@PatterName = 'Number 6')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('11|12|13|14|15|16|18|20|21|23|24|25|')

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						
								else if (@PatterName = 'Crazy Corner' and @GameName != 'Crazy Bout')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|2|6|')
							insert into @Pattern  values ('16|21|22|')
							insert into @Pattern  values ('4|5|10|')									
							insert into @Pattern  values ('20|24|25|')									

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						
						else if (@PatterName = 'Crazy Corner' and @GameName = 'Crazy Bout')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('1|')
							insert into @Pattern  values ('21|')
							insert into @Pattern  values ('5|')									
							insert into @Pattern  values ('25|')									

							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						
						else if (@PatterName = 'Arrowhead')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('2|4|8|13|')
							insert into @Pattern  values ('13|18|22|24|')
							
							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
						
						else if (@PatterName = 'Chichen itza')
						begin
				
							delete from @Pattern
							insert into @Pattern  values ('3|4|5|7|11|13|17|23|24|25|')
	
							
							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
									 --select cast(@m_CardN as varchar(10))
									set @WinnerCount = @WinnerCount + 1
									set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', ' break
								end
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end
							--FOR MAYAMONEY BONUS ROUND
						else if (@PatterName = '' )
						begin
				
							delete from @Pattern
					
							--Crazy Corner		
							insert into @Pattern  values ('1|2|6|')
							insert into @Pattern  values ('16|21|22|')
							insert into @Pattern  values ('4|5|10|')									
							insert into @Pattern  values ('20|24|25|')

							--Tiny Pyramid
							insert into @Pattern  values ('3|7|8|13|' )
							insert into @Pattern  values ('8|12|13|18|' )
							insert into @Pattern  values ('13|17|18|23|' )	

							--ArrowHead
							insert into @Pattern  values ('2|4|8|13|')
							insert into @Pattern  values ('13|18|22|24|')

							--AnyLine
							insert into @Pattern  values ('1|6|11|16|21|' )
							insert into @Pattern  values ('2|7|12|17|22|' )
							insert into @Pattern  values ('3|8|13|18|23|' )
							insert into @Pattern  values ('4|9|14|19|24|' )
							insert into @Pattern  values ('5|10|15|20|25|' )
							insert into @Pattern  values ('1|2|3|4|5|' )
							insert into @Pattern  values ('6|7|8|9|10|' )
							insert into @Pattern  values ('11|12|13|14|15|' )
							insert into @Pattern  values ('16|17|18|19|20|' )
							insert into @Pattern  values ('21|22|23|24|25|' )
							insert into @Pattern  values ('5|9|13|17|21|' )
							insert into @Pattern  values ('1|7|13|19|25|' )
							--Crazy Stamp

							insert into @Pattern  values ('1|2|6|7|' )
							insert into @Pattern  values ('16|17|21|22|' )
							insert into @Pattern  values ('4|5|9|10|' )
							insert into @Pattern  values ('19|20|24|25|' )	
							--Four Corners

							insert into @Pattern  values ('1|5|21|25|' )

							--Small X
							insert into @Pattern  values ('7|9|13|17|19' )

							--Flower
							insert into @Pattern  values ('8|12|13|14|18|' )

							--Star
							insert into @Pattern  values ('3|11|13|15|23|' )

							--Payramid
							insert into @Pattern  values ('3|7|8|11|12|13|17|18|23' )
							insert into @Pattern  values ('4|8|9|12|13|14|18|19|24' )
							insert into @Pattern  values ('5|9|10|13|14|15|19|20|25' )

							--Steps
							insert into @Pattern  values ('1|2|7|8|13|14|19|20|25|' )
							insert into @Pattern  values ('5|9|10|13|14|17|18|21|22|' )

							--Chichen
							insert into @Pattern  values ('3|4|5|7|11|13|17|23|24|25|')
							
							declare Pattern_Cursor cursor
							for 
							select /*@tempValue =8*/ Design from @Pattern
							open Pattern_Cursor
							fetch next from Pattern_Cursor into @tempValue

							while @@FETCH_STATUS = 0
							begin

								set @result = (select CHARINDEX('|',@tempValue))


								while (@result != 0 and @Exists =1)
								begin

									set @TempN = SUBSTRING(@tempValue, 0, @result) 	
									
									exec dbo.usp_management_rptCheckCardIfWin3 @TempN, @BallCall,@m_CardN, @Exists output							
									set @tempValue =  SUBSTRING(@tempValue, @result + 1, LEN(@tempValue)) 
									set @result = (select CHARINDEX('|',@tempValue))

								end


								if (@Exists = 1)--WINNER
								begin
					
									 --select cast(@m_CardN as varchar(10))
					
									set @WinnerCount = @WinnerCount + 1
									if (CHARINDEX(cast(@m_CardN as varchar(10)),  @WinningCardNumber3 ) = 0)
									begin
										--set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', '
										
										if (@CountPreviousCardWinner = 0)
										begin							
											set @PreviousCardWinner = @m_CardN
											set @CountPreviousCardWinner = 1
											set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', '
										end
										else if (@PreviousCardWinner + 1= @m_CardN)
										begin								
										   set @PreviousCardWinner = @PreviousCardWinner + 1
										   set @CountPreviousCardWinner = @CountPreviousCardWinner + 1
											set  @WinningCardNumber3 =  @WinningCardNumber3 + cast(@m_CardN as varchar(10)) + ', '
										end	
																								
									end
									
									
								end 
								--else
								--begin
								--	break;
								--end 
		
								set @Exists = 1
								fetch next from Pattern_Cursor into @tempValue

							end 

							close Pattern_Cursor
							deallocate Pattern_Cursor

						end

					 --NEXT CARD NUMBER
					 set @C_Card =  SUBSTRING(@C_Card, @result2 + 1, LEN(@C_Card)) 
					 set @result2 = (select CHARINDEX(',',@C_Card))
		end
		if (@WinnerCount != 0)
		begin

			set  @WinningCardNumber3 = SUBSTRING( @WinningCardNumber3, 0, len( @WinningCardNumber3))
			if (@PatterName = '')
			begin
				if (@CountPreviousCardWinner = 3)
				begin
					set  @WinningCardNumber3 = @WinningCardNumber3 +'_3X JAGUAR Level'
				end
				else
				if (@CountPreviousCardWinner = 5)
				begin
					set  @WinningCardNumber3 = @WinningCardNumber3 +'_5X SERPENT Multiplier'
				end
				else
				if (@CountPreviousCardWinner = 6)
				begin
					set  @WinningCardNumber3 = @WinningCardNumber3 +'_10X EAGLE Multiplier'
				end
				
			end
		end
		--NOTE: Number of winners is reported in payout(sp).
		return 
end					





GO


