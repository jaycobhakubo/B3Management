
use master 
go
grant control server to [B3-Server\Sales]
--GRANT ALTER ANY EVENT NOTIFICATION TO [B3-Server\Sales]
--revoke control server to [B3-Server\Sales]
--revoke alter any EVENT NOTIFICATION TO [B3-Server\Sales]
go
use b3
go
--GRANT EXECUTE TO [B3-Server\Sales];
--GRANT INSERT ON B3.dbo.B3_Log_Hosts TO [B3-Server\Sales];
--GRANT TAKE OWNERSHIP TO [B3-Server\Sales];

--revoke execute to [B3-Server\Sales];
--Revoke INSERT ON B3.dbo.B3_Log_Hosts TO [B3-Server\Sales];
--revoke TAKE OWNERSHIP TO [B3-Server\Sales];
go



USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_Log_Hosts]') AND type in (N'U'))
DROP TABLE [dbo].[B3_Log_Hosts]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_Log_Hosts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[B3_Log_Hosts](
	[EventID] [int] IDENTITY(1,1) NOT NULL,
	[ClientConnection] [varchar](100) NULL,
	[PostTime] [datetime] NULL,
	[LoginName] [varchar](128) NULL,
	[IPAddress] [varchar](128) NULL,
	[MacAddress] [varchar](128) NULL,
PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO



--use b3
--go
--drop trigger myTest_LogonTrigger on all server
--disable trigger  myTest_LogonTrigger on all server
--enable trigger myTest_LogonTrigger on all server

USE [master]
GO

IF  EXISTS (SELECT * FROM master.sys.server_triggers WHERE parent_class_desc = 'SERVER' AND name = N'TrgLogonB3SalesLog')
DROP TRIGGER [TrgLogonB3SalesLog] ON ALL SERVER
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM master.sys.server_triggers WHERE parent_class_desc = 'SERVER' AND name = N'TrgLogonB3SalesLog')
EXECUTE dbo.sp_executesql N'
create TRIGGER [TrgLogonB3SalesLog]
ON ALL SERVER WITH EXECUTE AS ''B3-SERVER\SALES''
FOR LOGON
AS
BEGIN

	declare @LogonTriggerData xml,
	@EventType VARCHAR(100),	 
	@PostTime DATETIME,
	@SPID SMALLINT,
	@LoginName VARCHAR(128),
	@ClientHost NVARCHAR(128),
	@MacAddress VARCHAR(128)


   declare @TempTable table 
   (
   EventType VARCHAR(100),	 
   PostTime DATETIME,
   LoginName VARCHAR(128),
   ClientHost VARCHAR(128),
   MacAddress varchar(100)
   )

	set @LogonTriggerData = eventdata()

	set @EventType = @LogonTriggerData.value(''(/EVENT_INSTANCE/EventType)[1]'', ''varchar(100)'')
	set @PostTime = @LogonTriggerData.value(''(/EVENT_INSTANCE/PostTime)[1]'', ''datetime'')
	set @SPID = @LogonTriggerData.value(''(/EVENT_INSTANCE/SPID)[1]'', ''smallint'')
	set @LoginName = @LogonTriggerData.value(''(/EVENT_INSTANCE/LoginName)[1]'', ''varchar(100)'')
  

	set @ClientHost = (  SELECT client_net_address
		FROM sys.dm_exec_connections
		WHERE session_id = @@SPID)
	set  @MacAddress  = (select net_address from sys.sysprocesses where spid = @@SPID)

	insert into @TempTable values (
	@EventType,
	@PostTime,
	@LoginName ,
	@ClientHost,
	@MacAddress)

	insert into b3.dbo.B3_Log_Hosts  select
	@EventType,
	@PostTime,
	@LoginName ,
	@ClientHost ,
	@MacAddress
	from @TempTable where @LoginName = ''B3-SERVER\SALES''

end'
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

ENABLE TRIGGER [TrgLogonB3SalesLog] ON ALL SERVER
GO




USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trgB3LogHost]'))
DROP TRIGGER [dbo].[trgB3LogHost]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trgB3LogHost]'))
EXEC dbo.sp_executesql @statement = N'CREATE trigger [dbo].[trgB3LogHost]
 on  [dbo].[B3_Log_Hosts]
for insert 
as 
declare @IPAddress varchar(50)
set @IPAddress = (select IPAddress from inserted)

declare @EventID int
set @EventID = (select EventID from inserted)

declare @MacAddress varchar(50)
set @MacAddress = (select clientmac from [dbo].[B3_ClientMap] where ipaddress = @IPAddress)

update [dbo].[B3_Log_Hosts]
set MacAddress = @MacAddress 
where EventID = @EventID

--select * from [dbo].[B3_ClientMap]

--select * from [dbo].[B3_ClientMap]' 
GO





--<EventType>event_type</EventType>
--  <PostTime>post_time</PostTime>
--  <SPID>spid</SPID>
--  <TextData>text_data</TextData>
--  <BinaryData>binary_data</BinaryData>
--  <DatabaseID>database_id</DatabaseID>
--  <NTUserName>nt_user_name</NTUserName>
--  <NTDomainName>nt_domain_name</NTDomainName>
--  <HostName>host_name</HostName>
--  <ClientProcessID>client_process_id</ClientProcessID>
--  <ApplicationName>application_name</ApplicationName>
--  <LoginName>login_name</LoginName>
--  <StartTime>start_time</StartTime>
--  <EventSubClass>event_subclass</EventSubClass>
--  <Success>success</Success>
--  <IntegerData>integer_data</IntegerData>
--  <ServerName>server_name</ServerName>
--  <DatabaseName>database_name</DatabaseName>
--  <LoginSid>login_sid</LoginSid>
--  <RequestID>request_id</RequestID>
--  <EventSequence>event_sequence</EventSequence>
--  <IsSystem>is_system</IsSystem>
--  <SessionLoginName>session_login_name</SessionLoginName>
