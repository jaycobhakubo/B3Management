USE [B3]
GO

DROP FUNCTION [dbo].[B3fn_server_BallCallwGameID]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE function [dbo].[B3fn_server_BallCallwGameID]
    (@session int,
    @GameID int,
	@BallCallType int,
	@GameName2 varchar(50)) --0  = regular; 1 = bonus
returns  nvarchar(max)
as
begin

if (@GameName2 = 'MayaMoney') set @GameName2 = 'Maya Money'
else if (@GameName2 = 'Time Bomb') set @GameName2 = 'TimeBomb'
--else if (@GameName2 = 'CrazyBout') set @GameName2 = 'Crazy Bout'

	declare @GameBallData2 table
   (ServerGameNumber int
        , DTStamp smalldatetime
        , GameTypeId int
        , GameTableName nvarchar(32)
        , GameName nvarchar(32)
        , GameBallCount int
        , GameBalls nvarchar(max)
        , BonusBallCount int
        , BonusBalls nvarchar(max)
        ,StaffID varchar(100))

    declare @GameBallData table
        (ServerGameNumber int
        , DTStamp smalldatetime
        , GameTypeId int
        , GameTableName nvarchar(32)
        , GameName nvarchar(32)
        , GameBallCount int
        , GameBalls nvarchar(max)
        , BonusBallCount int
        , BonusBalls nvarchar(max))

    declare @gameName varchar(100)
        , @tablePrefix varchar(32)
        , @ballCount int
        , @gameNumber int
        , @bonusBallCount int
        
    -- Gather all of the base game data
    insert into @GameBallData
        (ServerGameNumber
        , DTSTamp
        , GameTypeId
        , GameTableName
        , GameName
        , GameBallCount)
    select distinct
        sg.ServerGame
        , sg.DTStamp
        , sgj.GameTypeId
        , sgt.TableName
        , sgt.DisplayName
        , case when ConsolationBallIndex is null then 24 else (ConsolationBallIndex - 1) end -- Index is 1 based
        from Server_Game sg
            join Server_GameJournal sgj on sg.ServerGame = sgj.ServerGameNumber
            join Server_GameTypes sgt on sgj.GameTypeId = sgt.GameTypeId
        where SessionNumber = @session

    -- Gather all of the bonus game data to determine if a bonus game was played and
    --  how many balls were called 
    declare @BonusGames table
        (ServerGameNumber int
        , GameTypeId int
        , BallCount int)

    -- Find all of the Crazy Bout bonus games
    insert into @BonusGames
    select s.ServerGameNumber, s.GameTypeId, cb.bonuscallcount
        from CrazyBout_GameJournal cb
            join Server_GameJournal s on cb.gameNum = s.GameNumber
    where sessnum = @session and gametypeid = 36 and bonuscardsn_1 != 0 and bonusofferaccepted != 0
    group by s.ServerGameNumber, cb.bonusCallCount, s.GameTypeId
    


    -- Find all of the Jail Break bonus games
    insert into @BonusGames
    select s.ServerGameNumber, s.GameTypeId, jb.bonuscallcount
        from JailBreak_GameJournal jb
            join Server_GameJournal s on jb.gameNum = s.GameNumber
    where sessnum = @session and gametypeid = 37 and jb.bonuscardsn_1 != 0 and jb.bonusofferaccepted != 0
    group by s.ServerGameNumber, jb.bonuscallcount, s.GameTypeId
    
    -- update the bonus ball count in the results table
    update @GameBallData
    set BonusBallCount = bg.BallCount
    from @GameBallData gbd
        join @BonusGames bg on gbd.ServerGameNumber = bg.ServerGameNumber
    where gbd.ServerGameNumber = bg.ServerGameNumber and gbd.GameTypeId = bg.GameTypeId
    
    -- Use the cursor for generating a list of balls that were called and updating the
    --  results table.  This will convert the columns to a comma separated list of
    --  balls and update the appropriate columns in the results table
    declare ballList_cursor cursor for
    select ServerGameNumber, GameBallCount, BonusBallCount
    from @GameBallData
    order by ServerGameNumber
    
    declare @gameBalls nvarchar(max)
        , @bonusBalls nvarchar(max)
        , @sqlCommand nvarchar(max)
        , @parameters nvarchar(500)
    
    open ballList_cursor
    fetch next from ballList_cursor
    into @gameNumber, @ballCount, @bonusBallCount
    while @@fetch_status = 0
    begin
        
        -- empty the strings
        select @gameBalls = ''
            , @bonusBalls = ''
    
        -- Construct an sql command that will do the conversion
        set @parameters = '@gameBalls_Out nvarchar(500) output, @bonusBalls_Out nvarchar(500) output'
        set @sqlCommand = 'select @gameBalls_Out = '
                        + coalesce ('(' + dbo.b3_fnGetBallColumnList (@ballCount) + ')', '')
                        + coalesce (', @bonusBalls_Out = (' + dbo.b3_fnGetBallColumnList (@bonusBallCount) + ')', '')
                        + ' from Server_Game where ServerGame = '
                        + cast (@gameNumber as nvarchar)
                        
        exec sp_executesql @sqlCommand, @parameters, @gameBalls_Out = @gameBalls output, @bonusBalls_Out = @bonusBalls output;
        
        -- Now that the ball list has been created update the result table
        update @GameBallData
        set GameBalls = @gameBalls
            , BonusBalls = @bonusBalls
        where ServerGameNumber = @gameNumber 

        fetch next from ballList_cursor
        into @gameNumber, @ballCount, @bonusBallCount
    end
    close ballList_cursor
    deallocate ballList_cursor

--Is either B3 class II or Class III
if (select COUNT(*) from @GameBallData) != 0 --Class II
begin   insert into @GameBallData2
		(
				ServerGameNumber 
				, DTStamp 
				, GameTypeId 
				, GameName 
				, GameBallCount 
				, GameBalls 
				, BonusBallCount 
				, BonusBalls 
				,StaffID
		)
    select ServerGameNumber
        , DTStamp
        , GameTypeId
        , GameName
        , GameBallCount
        , GameBalls
        , BonusBallCount
        , BonusBalls
        ,'' as StaffID --Just for test
        

    from @GameBallData
    where ServerGameNumber = @GameID  and GameName = @GameName2
	order by ServerGameNumber   
end

else --Class III
begin

 insert into @GameBallData2
		(
				ServerGameNumber 
				, DTStamp 
				, GameTypeId 
				, GameName 
				, GameBallCount 
				, GameBalls 
				, BonusBallCount 
				, BonusBalls 
				,StaffID
		)
    select 
    ServerGameNumber ,
	DTStamp , 
	GameTypeID ,  
	GameName  ,                 
	GameBallCount ,
	GameBalls ,
	BonusBallCount ,
	BonusBalls,
	staff.UserName from  dbo.B3_fnGetBallCallB3_2(@session, @GameName2 , @GameID) x
	left join  dbo.B3_Login staff on staff.LoginID = x.StaffID 
	where ServerGameNumber = @GameID and GameName = @GameName2
	 order by ServerGameNumber    
end  

declare @result nvarchar(max) 
set @result = (select case when @BallCallType = 0 or GameName = 'Maya Money' then GameBalls else BonusBalls end as BallCall from @GameBallData2)

return @result
end


--declare 
--    @session int,
--    @GameID int,
--	@BallCallType int,
--	@GameName2 varchar(50) --0  = regular; 1 = bonus

--	set @session = 1008
--	set @GameID = 14
--	set @BallCallType = 0
--	set @GameName2 = 'WildFire'










GO


