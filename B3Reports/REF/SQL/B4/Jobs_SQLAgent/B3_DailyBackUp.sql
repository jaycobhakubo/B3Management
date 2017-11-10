USE [master]
GO

/****** Object:  StoredProcedure [dbo].[B3_DailyBackUp]    Script Date: 02/05/2015 14:19:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_DailyBackUp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[B3_DailyBackUp]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[B3_DailyBackUp]    Script Date: 02/05/2015 14:19:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[B3_DailyBackUp]
as
--ENABLE xp_cmdshell
exec sp_configure 'show advanced options', 1
reconfigure
exec sp_configure 'xp_cmdshell',1
reconfigure



declare @name varchar(50)
declare @path varchar(256)
declare @path2 varchar(256)
declare @path3 varchar(256)
declare @fileName varchar(8000)
declare @filename2 varchar(8000)
declare @filedate varchar(20)
declare @DirTree TABLE(subdirectory nvarchar(255), depth INT)
declare @DirTree2 TABLE(subdirectory nvarchar(255), depth INT)

declare @DBName varchar(100)
select @DBName = [name] from master.dbo.sysdatabases
where [name] = 'B3'

declare @OldsDate varchar(100)
set @OldsDate = convert(varchar(20), (select dateadd(day, -7, getdate())),112) --(select dateadd(day, -7, getdate()))

--select @OldsDate

--CREATING THE DAILY FOLDER
set @path = 'C:\Program Files (x86)\GameTech International, Inc\Big Bad Bingo\Database\Backup\Database\' --this already exists
insert into @DirTree2(subdirectory, depth)
exec master.sys.xp_dirtree @Path

if not exists (select 1 from @DirTree2 where subdirectory = 'Daily')
begin
set @path = 'C:\Program Files (x86)\GameTech International, Inc\Big Bad Bingo\Database\Backup\Database\Daily\'
exec master.sys.xp_create_subdir @path
print 'not exists'
end 
else
begin
set @path = 'C:\Program Files (x86)\GameTech International, Inc\Big Bad Bingo\Database\Backup\Database\Daily\'
print 'exist'
end


--CREATING THE DATE DIRECTORY AND THE B3.bak

insert into @DirTree(subdirectory, depth)
exec master.sys.xp_dirtree @Path

set @filedate = convert(varchar(20), getdate(),112)
set @path2 = '"' + @path + @OldsDate+ '"' 
set @path3 = '"' + @path + @OldsDate+'\'
set @path = @path + @filedate + '\'


set @filename = @path + @DBname +'.bak'
declare @FileExists int 
exec master.sys.xp_fileexist @filename, @FileExists output

if (@FileExists = 0)
begin
exec master.sys.xp_create_subdir @path
backup database @DBName to disk = @filename
end

--
--if not exists(select 1 from @DirTree where subdirectory = @filedate)
--begin
--exec master.sys.xp_create_subdir @path
--
--set @filename = @path + @DBname +'.bak'
--backup database @DBName to disk = @filename
----print 'not exists'
--end
--else
--begin
--set @filename = @path + @DBname +'.bak'
--
----print 'Exists'
--end

set @filename = @path3 + @DBname +'.bak'
exec master.sys.xp_fileexist @filename, @FileExists output

if (@FileExists = 1)
begin
	declare @cmd varchar(1000)
	declare @cmd2 varchar(1000)
	set @cmd = 'del "' + @filename +'"'
	set @cmd2 = 'RMDIR ' + @path2

	exec master..xp_cmdshell @cmd
	exec master..xp_cmdshell @cmd2

end

--
--if exists (select 1 from @DirTree where subdirectory = @Oldsdate)
--begin
----if exists (select 1 from )
--set @fileName2 =  @path3 + @DBname +'.bak"'
----
----select @fileName2
----select @path2
--
--declare @cmd varchar(1000)
--declare @cmd2 varchar(1000)
--set @cmd = 'del ' + @filename2
--set @cmd2 = 'RMDIR ' + @path2
--
--exec master..xp_cmdshell @cmd
--exec master..xp_cmdshell @cmd2
----exec master..xp_cmdshell 'del "C:\Program Files (x86)\GameTech International, Inc\Big Bad Bingo\Database\Backup\Database\Daily\20140304\b3.bak"'
----exec master..xp_cmdshell 'RMDIR "C:\Program Files (x86)\GameTech International, Inc\Big Bad Bingo\Database\Backup\Database\Daily\20140304"'
----DELETING THE database back up after 7 days
--
--end
GO

USE [msdb]
GO

--/****** Object:  Job [Backup_DB_Daily_AND_Remove_DB_7days_old]    Script Date: 02/05/2015 14:19:58 ******/
--IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Backup_DB_Daily_AND_Remove_DB_7days_old')
--EXEC msdb.dbo.sp_delete_job @job_id=N'30a090b4-2cbd-446c-bda0-b501d0878497', @delete_unused_schedule=1
--GO

/****** Object:  Job [Log_SalesDB_Transaction_into_txtFile]    Script Date: 02/05/2015 14:29:52 ******/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Backup_DB_Daily_AND_Remove_DB_7days_old')
begin
declare @jobID varchar(1000)
select @jobID = job_id from msdb.dbo.sysjobs_view WHERE name =N'Backup_DB_Daily_AND_Remove_DB_7days_old'
EXEC msdb.dbo.sp_delete_job @job_id= @jobID, @delete_unused_schedule=1
end
GO

USE [msdb]
GO

/****** Object:  Job [Backup_DB_Daily_AND_Remove_DB_7days_old]    Script Date: 02/05/2015 14:19:58 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/05/2015 14:19:59 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Backup_DB_Daily_AND_Remove_DB_7days_old', 
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
/****** Object:  Step [BackUp_DB_Daily_Remove_DB_7Days_OLD]    Script Date: 02/05/2015 14:19:59 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'BackUp_DB_Daily_Remove_DB_7Days_OLD', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec B3_DailyBackUp;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'BackUp_Daily', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140304, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959 
		--@schedule_uid=N'0add04ac-2a23-41d5-bd35-b3e9be2a762f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO



