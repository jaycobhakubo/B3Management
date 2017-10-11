  
 
 
 
 
 
 
  Use b3
  go

if not exists (select *  from Information_SCHEMA.columns where Table_name='B3_CashDrawerJournal'  and column_name='TransNo')
begin
alter table B3_CashDrawerJournal add TransNo int null;
print 'B3_CashDrawerJournal altered';
end

if not exists (select *  from Information_SCHEMA.columns where Table_name='B3_CreditJournal'  and column_name='TransNo')
    begin
    alter table B3_CreditJournal add TransNo int null;
    print 'B3_CreditJournal altered';
end

if not exists (select *  from Information_SCHEMA.columns where Table_name='B3_JackpotJournal'  and column_name='TransNo')
    begin
    alter table B3_JackpotJournal add TransNo int null;
    print 'B3_JackpotJournal altered';
end

if not exists (select *  from Information_SCHEMA.columns where Table_name='B3_SessionsJournal'  and column_name='TransNo')
    begin
    alter table B3_SessionsJournal add TransNo int null;
    print 'B3_SessionsJournal altered';
end

if not exists (select *  from Information_SCHEMA.columns where Table_name='B3_VIPPlayerJournal'  and column_name='TransNo')
    begin
    alter table B3_VIPPlayerJournal add TransNo int null;
    print 'B3_VIPPlayerJournal altered';
end

if not exists (select *  from Information_SCHEMA.columns where Table_name='CrazyBout_GameJournal'  and column_name='TransNo')
    begin
    alter table CrazyBout_GameJournal add TransNo int null;
    print 'CrazyBout_GameJournal altered';
end

if not exists (select *  from Information_SCHEMA.columns where Table_name='JailBreak_GameJournal'  and column_name='TransNo')
    begin
    alter table JailBreak_GameJournal add TransNo int null;
    print 'JailBreak_GameJournal altered';
end

if not exists (select *  from Information_SCHEMA.columns where Table_name='MayaMoney_GameJournal'  and column_name='TransNo')
    begin
    alter table MayaMoney_GameJournal add TransNo int null;
    print 'MayaMoney_GameJournal altered';
end

if not exists (select *  from Information_SCHEMA.columns where Table_name='Spirit76_GameJournal'  and column_name='TransNo')
    begin
    alter table Spirit76_GameJournal add TransNo int null;
    print 'Spirit76_GameJournal altered';
end

if not exists (select *  from Information_SCHEMA.columns where Table_name='TimeBomb_GameJournal'  and column_name='TransNo')
    begin
    alter table TimeBomb_GameJournal add TransNo int null;
    print 'TimeBomb_GameJournal altered';
end

if not exists (select *  from Information_SCHEMA.columns where Table_name='UKickEm_GameJournal'  and column_name='TransNo')
    begin
    alter table UKickEm_GameJournal add TransNo int null;
    print 'UKickEm_GameJournal altered';
end

if not exists (select *  from Information_SCHEMA.columns where Table_name='WildBall_GameJournal'  and column_name='TransNo')
    begin
    alter table WildBall_GameJournal add TransNo int null;
    print 'WildBall_GameJournal altered';
end

if not exists (select *  from Information_SCHEMA.columns where Table_name='WildFire_GameJournal'  and column_name='TransNo')
    begin
    alter table WildFire_GameJournal add TransNo int null;
    print 'WildFire_GameJournal altered'
    end


  go
  if  exists(select 1 from sys.columns where Name = N'UserName' and Object_ID = Object_ID(N'dbo.B3_Login'))
  begin
	alter table dbo.B3_Login
	alter column UserName varchar(15) not null
  end
  go
  if  exists(select 1 from sys.columns where Name = N'UserPassword' and Object_ID = Object_ID(N'dbo.B3_Login'))
  begin
	  alter table dbo.B3_Login
      alter column UserPassword varchar(15) not null
  end
  go
    if  not exists(select 1 from sys.columns where Name = N'Locked' and Object_ID = Object_ID(N'dbo.B3_Login'))
  begin
	  alter table dbo.B3_Login
	  add Locked char(1)
  end
  go
  if   exists(select 1 from sys.columns where Name = N'Locked' and Object_ID = Object_ID(N'dbo.B3_Login'))
  begin
      --set them all unlocked as default
	  update B3_Login	
	  set Locked  = 'F'
  end

  go
   if  not exists(select 1 from sys.columns where Name = N'ChangePasswordActualDate' and Object_ID = Object_ID(N'dbo.B3_Login'))
  begin
    alter table dbo.B3_Login
    add ChangePasswordActualDate datetime
  end

  go
  --this should only run once upon installation or update
  --upate to whaever the value of changePasswordDate is
  if  exists(select 1 from sys.columns where Name = N'ChangePasswordActualDate' and Object_ID = Object_ID(N'dbo.B3_Login'))
  begin
  update x
	  set ChangePasswordActualDate = y.ChangePasswordDate
	  from dbo.B3_Login x
	  join dbo.B3_Login y  on x.LoginID = y.LoginID
  end

  go
  if not exists(select 1 from sys.columns where Name = N'NofLoginAttempt' and Object_ID = Object_ID(N'dbo.B3_Login'))
  begin
	  alter table dbo.B3_Login
      add NofLoginAttempt int
  end
  go

  if  not exists(select 1 from sys.columns where Name = N'LockedDueToLoginFailedAttempt' and Object_ID = Object_ID(N'dbo.B3_Login'))
  begin
		alter table dbo.B3_login
		add LockedDueToLoginFailedAttempt Char(1)
  end

go
  if  not exists(select 1 from sys.columns where Name = N'LockedDueToAttemptTime' and Object_ID = Object_ID(N'dbo.B3_Login'))
  begin
		alter table dbo.B3_Login
		add LockedDueToAttemptTime datetime
  end
go
 if  not exists(select 1 from sys.columns where Name = N'FirstName' and Object_ID = Object_ID(N'dbo.B3_Login'))
  begin
		alter table dbo.B3_Login
		add FirstName varchar(200)
  end
go
 if  not exists(select 1 from sys.columns where Name = N'LastName' and Object_ID = Object_ID(N'dbo.B3_Login'))
  begin
		alter table dbo.B3_Login
		add LastName Varchar(200)
  end
go
	if  not exists(select 1 from sys.columns where Name = N'GameRecallPassword' and Object_ID = Object_ID(N'dbo.Server_GameSettings'))
	begin
	alter table [dbo].[Server_GameSettings]
	add GameRecallPassword varchar(25)
	end
go
	if ((select GameRecallPassword from [dbo].[Server_GameSettings]) is null)
	begin 
	update [dbo].[Server_GameSettings] 
	set GameRecallPassword = '' 
	end
go
	if  not exists(select 1 from sys.columns where Name = N'WaitCountdownTimerForOtherPlayers' and Object_ID = Object_ID(N'dbo.Server_GameSettings'))
	begin
	alter table [dbo].[Server_GameSettings]
	add WaitCountdownTimerForOtherPlayers int
	end	
go
	if ((select WaitCountdownTimerForOtherPlayers from [dbo].[Server_GameSettings]) is null)
	begin 
	update [dbo].[Server_GameSettings] 
	set WaitCountdownTimerForOtherPlayers = 10
	end
go
 
 if  not exists(select 1 from sys.columns where Name = N'PermitManagementReports' and Object_ID = Object_ID(N'dbo.B3_Login'))
  begin
		alter table [dbo].[B3_Login]
		add PermitManagementReports char(1)
  end
go
 if  not exists(select 1 from sys.columns where Name = N'PermitManagementSecurity' and Object_ID = Object_ID(N'dbo.B3_Login'))
  begin
		alter table [dbo].[B3_Login]
		add PermitManagementSecurity char(1)
  end
go
 if  not exists(select 1 from sys.columns where Name = N'PermitManagementSystemSettings' and Object_ID = Object_ID(N'dbo.B3_Login'))
  begin
		alter table [dbo].[B3_Login]
		add PermitManagementSystemSettings char(1)
  end
go
 if  not exists(select 1 from sys.columns where Name = N'PermitManagementDisputeResolution' and Object_ID = Object_ID(N'dbo.B3_Login'))
  begin
		alter table [dbo].[B3_Login]
		add PermitManagementDisputeResolution char(1)

	end


go
			update [dbo].[B3_Login]
			set PermitManagementSystemSettings = 'T' 

			update [dbo].[B3_Login]
			set PermitManagementReports = 'T' 

			update [dbo].[B3_Login]
			set PermitManagementDisputeResolution = 'T' 

			update [dbo].[B3_Login]
			set PermitManagementSecurity = 'T' 

go


if  not exists(select 1 from sys.columns where Name = N'PermitClientAccessControl' and Object_ID = Object_ID(N'dbo.B3_Login'))
begin
	alter table [dbo].[B3_Login] 
	add PermitClientAccessControl char(1) default 'F'

	update [dbo].[B3_Login] 
	set PermitClientAccessControl = 'F'
end
go

if  not exists(select 1 from sys.columns where Name = N'ClientEnabled' and Object_ID = Object_ID(N'dbo.B3_ClientMap'))
begin
	alter table [dbo].[B3_ClientMap]
	add ClientEnabled char(1) default 'T'

	update [dbo].[B3_ClientMap] 
	set ClientEnabled = 'T'
end



go


set nocount on;



declare @mac char(12);
declare CLIENTS cursor local fast_forward for select clientmac from B3_ClientMap order by clientmac;
open CLIENTS;

fetch next from CLIENTS into @mac;
while(@@FETCH_STATUS = 0)
begin
    begin try
        insert into B3_DeviceTransactions values (@mac, 1);
    end try
    begin catch 
        print 'Duplicate encountered, skipping';
    end catch
    fetch next from CLIENTS into @mac;
end;

close CLIENTS;
deallocate CLIENTS;


go

 alter table dbo.B3_Login
alter column UserName varchar(15) not null

go

      alter table dbo.B3_Login
alter column UserPassword varchar(15) not null

go

if  not exists(select 1 from sys.columns where Name = N'PhysicalAddress_Modified' and Object_ID = Object_ID(N'dbo.B3_AuditLog'))
begin
	alter table dbo.B3_AuditLog
	add PhysicalAddress_Modified varchar(20)
end
go