USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Load_B3BallCallPerSession_Table]'))
DROP TRIGGER [dbo].[Load_B3BallCallPerSession_Table]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Load_B3BallCallPerSession_Table]'))
EXEC dbo.sp_executesql @statement = N'
            CREATE trigger [dbo].[Load_B3BallCallPerSession_Table]
            --  ==============================================
            -- Author: Karlo Camacho
            -- Date: 4/3/2013 
            -- Summary: A trigger that will populate data on B3_BallCallLogPerSession
            --  ==============================================

            on [dbo].[B3_Session] 
            after update--, delete
            as
            BEGIN

            insert into dbo.B3_BallCallLogPerSession
            select * from dbo.B3_Session where sessActive = ''T''

            declare @SessID int
            select  @SessID = sessnum from inserted

            delete from dbo.B3_BallCallLogPerSession
            where sessActive = ''F''--this will take care of the first issue


            if ((select count(sessnum) from dbo.B3_BallCallLogPerSession where sessnum = @SessID) >= 2)
            begin 
	            while ((select count(sessnum) from dbo.B3_BallCallLogPerSession where sessnum = @SessID) >= 2)
	            begin
	            delete top (1) from dbo.B3_BallCallLogPerSession
	            where sessnum = @sessID
	            end
            end


            END' 
GO


