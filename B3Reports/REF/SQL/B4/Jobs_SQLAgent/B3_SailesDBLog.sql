--exec B3_SailesDBLog
USE [master]
GO
/****** Object:  StoredProcedure [dbo].[B3_SailesDBLog]    Script Date: 02/05/2015 13:14:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_SailesDBLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[B3_SailesDBLog]
go


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[B3_SailesDBLog]
as
exec sp_configure 'show_advanced options', 1
reconfigure
exec sp_configure 'xp_cmdshell',1
reconfigure

--Create the folder
declare @DirTree2 TABLE(subdirectory nvarchar(255), depth INT)
--declare @DirTree TABLE(subdirectory nvarchar(255), depth INT)
declare @Path varchar(500)
set @Path = 'C:\Program Files (x86)\GameTech International, Inc\Big Bad Bingo\'
insert into @DirTree2(subdirectory, depth)
exec master.sys.xp_dirtree @Path
if not exists (select 1 from @DirTree2 where subdirectory = 'SalesTransactionDBLog' and depth = 1)
begin
set @path = 'C:\Program Files (x86)\GameTech International, Inc\Big Bad Bingo\SalesTransactionDBLog\'
exec master.sys.xp_create_subdir @path
end 
else
begin
set @path = 'C:\Program Files (x86)\GameTech International, Inc\Big Bad Bingo\SalesTransactionDBLog\'
print 'exist'
end

--Add log file in the new folder
declare @filedate varchar(20)
set @filedate = convert(varchar(20), dateadd(day, - 1, getdate()),112)
--insert into @DirTree(subdirectory, depth)
--exec master.sys.xp_dirtree @Path
declare @cmd varchar(500) 
set @cmd = 'bcp "select * from b3.dbo.B3_Log_Hosts where convert(varchar(20), PostTime ,112) = convert(varchar(20), dateadd(day, - 1, getdate()),112)" queryout "' + @path + @filedate +  '.txt" -T -c'
declare @fileName varchar(8000)
declare @FileExists int 
set @fileName = @path + @filedate + '.txt'
exec master.sys.xp_fileexist @filename, @FileExists output
if (@FileExists = 0)
begin
exec  master..xp_cmdshell @cmd
end

--Delete 30 days old file 
declare @OldsDate varchar(100)
set @OldsDate = convert(varchar(20), (select dateadd(day, -30, getdate())),112) --(select dateadd(day, -7, getdate()))
set @filename = @path + @Oldsdate +'.txt'
exec master.sys.xp_fileexist @filename, @FileExists output
if (@FileExists = 1)
begin
set @cmd = 'del ' +'"'+ @filename +'"'
select @cmd
exec master..xp_cmdshell @cmd
end


delete from b3.dbo.B3_Log_Hosts
where convert(varchar(20), PostTime ,112) = convert(varchar(20), dateadd(day, - 30, getdate()),112)

go

USE [msdb]
GO

/****** Object:  Job [Log_SalesDB_Transaction_into_txtFile]    Script Date: 02/05/2015 14:29:52 ******/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Log_SalesDB_Transaction_into_txtFile')
begin
declare @jobID varchar(1000)
select @jobID = job_id from msdb.dbo.sysjobs_view WHERE name = N'Log_SalesDB_Transaction_into_txtFile'
EXEC msdb.dbo.sp_delete_job @job_id= @jobID, @delete_unused_schedule=1
end

go


USE [msdb]
GO
/****** Object:  Job [Log_SalesDB_Transaction_into_txtFile]    Script Date: 02/05/2015 13:14:01 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
select @jobId = job_id from msdb.dbo.sysjobs where (name = N'Log_SalesDB_Transaction_into_txtFile')
if (@jobId is NULL)
BEGIN
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Log_SalesDB_Transaction_into_txtFile', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END
IF NOT EXISTS (SELECT * FROM msdb.dbo.sysjobsteps WHERE job_id = @jobId and step_id = 1)
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Log_SalesDBTransaction', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec B3_SailesDBLog;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Log_SalesDBTransaction', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20150205, 
		@active_end_date=99991231, 
		@active_start_time=30000, 
		@active_end_time=235959
		--@schedule_uid=N'5167d309-b813-413c-bd2b-40e184cfcf9b'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


