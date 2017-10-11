/*

	Description:
		Generates all security entries required for the Big Bad Bingo system.
		To ensure proper security settings, all non-B3-related database security information will be removed.
		This includes logins, roles, and other security objects that may have improper rights to the database.
*/

/*
	Remove any existing security entries.
	Entries are removed to ensure that they are regenerated with the proper permissions and settings.
*/


--Remove member_roles
USE [B3];
GO


DECLARE @cmd AS NVARCHAR(MAX) = N'';

SELECT @cmd = @cmd + 'Execute sp_droprolemember '+QUOTENAME([roles].[name])+', '+QUOTENAME([members].[name])+';'
FROM sys.database_role_members AS rolemembers
    JOIN sys.database_principals AS roles 
        ON roles.[principal_id] = rolemembers.[role_principal_id]
    JOIN sys.database_principals AS members 
        ON members.[principal_id] = rolemembers.[member_principal_id]
WHERE roles.[name]=[roles].[name]
and members.[name] != 'dbo'


EXECUTE sp_executesql @cmd;


-- Remove roles and users.
USE [B3];
GO

declare @removeRoles nvarchar(4000);
declare @removeUsers nvarchar(4000);
SET @removeRoles = '';
SET @removeUsers = '';

SELECT
	@removeRoles = @removeRoles + 'EXECUTE sp_droprole ' + QUOTENAME([name]) + ';'
	FROM
		sysusers
	WHERE
		[issqlrole] = 1
		AND
		[name] != 'public'
		AND
		[name] NOT LIKE 'db_%'
		AND
		[name] LIKE 'role_%';
			
SELECT
	@removeUsers = @removeUsers + 'EXECUTE sp_revokedbaccess ' + QUOTENAME([name]) + ';'
	FROM
		sysusers
	WHERE
		[issqlrole] = 0
		AND
		[name] NOT IN ('dbo', 'guest', 'INFORMATION_SCHEMA', 'sys')
		and [name] = 'Sales' or [name] = 'Player' or [name] = 'Management';
		
-- Remove users before roles because roles must be empty to be removed.
EXECUTE sp_executesql @removeUsers;
EXECUTE sp_executesql @removeRoles;


-- Remove logins.
USE [master];
GO

declare @removeNTLogins nvarchar(4000);
declare @removeSQLLogins nvarchar(4000);
SET @removeNTLogins = '';
SET @removeSQLLogins = '';

SELECT
	@removeNTLogins = @removeNTLogins + 'EXECUTE sp_revokelogin ' + QUOTENAME([name]) + ';'
	FROM
		syslogins
	WHERE
		[isntname] = 1
		AND
		[name] != 'BUILTIN\Administrators'
		and [name] = 'B3-Server\Sales' or [name] = 'B3-Server\Player';
	

SELECT
	@removeSQLLogins = @removeSQLLogins + 'EXECUTE sp_droplogin ' + QUOTENAME([name]) + ';'
	FROM
		syslogins
	WHERE
		[isntname] = 0
		AND
		--[name] != 'sa'
		[name] not in ('sa' , 'gti')
		AND
		[name] NOT LIKE '##%'
			and
		[name] = 'Management';


EXECUTE sp_executesql @removeNTLogins;
EXECUTE sp_executesql @removeSQLLogins;

-- Reset the "sa" user password to ensure security.
-- A blank "sa" password is prohibited for security reasons.
--exec sp_password @new = 'B3 beats the hell out of GRS!', @loginame='sa';
GO

USE [B3];
GO

-- Add roles
EXEC sp_addrole N'role_Player'
EXEC sp_addrole N'role_Sales'
EXEC sp_addrole N'role_Management'

-- Add logins
EXEC sp_grantlogin 'B3-Server\Sales';
GO

EXEC sp_grantlogin 'B3-Server\Player';
GO

EXEC sp_addlogin @loginame = 'Management', @passwd = 'aloha', @defdb = 'B3' ;
GO

-- Add users
EXEC sp_grantdbaccess 'B3-server\Sales', 'Sales'
GO

EXEC sp_grantdbaccess 'B3-server\Player', 'Player'
GO

EXEC sp_grantdbaccess 'Management', 'Management'
GO

-- Add users to their roles
EXEC sp_addrolemember 'role_Player', 'Player'
GO

EXEC sp_addrolemember 'role_Sales', 'Sales'
GO

EXEC sp_addrolemember 'role_Management', 'Management'
GO
EXEC sp_addrolemember 'db_datareader', 'Management';
GO

/* Set table security. */
USE [B3];
GO

declare @salesRole  sysname ; set @salesRole = QUOTENAME('role_Sales');
declare @playerRole  sysname ; set @playerRole = QUOTENAME('role_Player');
declare @managementRole  sysname ; set @managementRole = QUOTENAME('role_Management');

DECLARE @table nvarchar(1000);
DECLARE @command nvarchar(4000);

-- All tables
DECLARE AllTables Cursor FOR
	SELECT
		[name]
		FROM
			sysobjects
		WHERE
			[xtype] = 'U';

-- Open the cursor and get the first value.
OPEN AllTables;

Fetch NEXT FROM AllTables INTO @table;

-- Iterate through each table.
While (@@FETCH_STATUS <> -1)
BEGIN

	-- Remove all access to tables from our roles - they only interact through stored procedures.
	SELECT @command = 'REVOKE ALL ON [dbo].' + QUOTENAME(@table) + ' TO ' + @salesRole;
	EXECUTE sp_executesql @command;
	
	SELECT @command = 'REVOKE ALL ON [dbo].' + QUOTENAME(@table) + ' TO ' + @playerRole;
	EXECUTE sp_executesql @command;
	
	SELECT @command = 'REVOKE ALL ON [dbo].' + QUOTENAME(@table) + ' TO ' + @managementRole;
	EXECUTE sp_executesql @command;
	
	-- Get the next value.
	Fetch NEXT FROM AllTables INTO @table;

END

-- Clean up cursors.
CLOSE AllTables;
DEALLOCATE AllTables;

GO

/* Set stored procedure security. */
USE [B3];
GO

declare @salesRole  sysname ; set @salesRole = QUOTENAME('role_Sales');
declare @playerRole  sysname ; set @playerRole = QUOTENAME('role_Player');
declare @managementRole  sysname ; set @managementRole = QUOTENAME('role_Management');

DECLARE @procedure nvarchar(1000);
DECLARE @command nvarchar(4000);

-- All stored procedures
DECLARE AllStoredProcedures Cursor FOR
	SELECT
		[SPECIFIC_NAME]
	FROM
		INFORMATION_SCHEMA.ROUTINES
	WHERE
		OBJECTPROPERTY(OBJECT_ID(ROUTINE_NAME),'IsMSShipped') = 0;

-- Sales stored procedures
DECLARE SalesStoredProcedures Cursor FOR
	--SELECT
	--	[SPECIFIC_NAME]
	--	FROM
	--		INFORMATION_SCHEMA.ROUTINES
	--	WHERE
	--		SPECIFIC_NAME LIKE 'usp_sales_%' 
	--		AND
	--		OBJECTPROPERTY(OBJECT_ID(ROUTINE_NAME),'IsMSShipped') = 0;

	SELECT
		[SPECIFIC_NAME]
		FROM
			INFORMATION_SCHEMA.ROUTINES
		WHERE
			(SPECIFIC_NAME LIKE 'usp_sales_%'  or SPECIFIC_NAME LIKE 'usp_SystemSetting_b3_Security_Get') --or SPECIFIC_NAME like 'xp_cmdshell')
			and OBJECTPROPERTY(OBJECT_ID(ROUTINE_NAME),'IsMSShipped') = 0;

			--select * from  INFORMATION_SCHEMA.ROUTINES 
			--where ROUTINE_TYPE like 'T%'
			--order by specific_name asc

-- Player stored procedures
DECLARE PlayerStoredProcedures Cursor FOR
	SELECT
		[SPECIFIC_NAME]
		FROM
			INFORMATION_SCHEMA.ROUTINES
		WHERE
			SPECIFIC_NAME LIKE 'usp_player_%'
			AND
			OBJECTPROPERTY(OBJECT_ID(ROUTINE_NAME),'IsMSShipped') = 0;
			
-- Management stored procedures (these have my long-naming scheme)
DECLARE ManagementStoredProcedures Cursor FOR
	SELECT
		[SPECIFIC_NAME]
		FROM
			INFORMATION_SCHEMA.ROUTINES
		WHERE
			SPECIFIC_NAME LIKE '%: %'
			AND
			OBJECTPROPERTY(OBJECT_ID(ROUTINE_NAME),'IsMSShipped') = 0;

-- Open the cursor and get the first value.
OPEN AllStoredProcedures;

Fetch NEXT FROM AllStoredProcedures INTO @procedure;

-- Iterate through each procedure
While (@@FETCH_STATUS <> -1)
BEGIN

	-- Remove all access to stored procedures.
	SELECT @command = 'REVOKE ALL ON [dbo].' + QUOTENAME(@procedure) + ' TO ' + @salesRole;
	EXECUTE sp_executesql @command;
	
	SELECT @command = 'REVOKE ALL ON [dbo].' + QUOTENAME(@procedure) + ' TO ' + @playerRole;
	EXECUTE sp_executesql @command;
	
	SELECT @command = 'REVOKE ALL ON [dbo].' + QUOTENAME(@procedure) + ' TO ' + @managementRole;
	EXECUTE sp_executesql @command;
	
	-- Get the next value.
	Fetch NEXT FROM AllStoredProcedures INTO @procedure;

END

-- Clean up cursors.
CLOSE AllStoredProcedures;
DEALLOCATE AllStoredProcedures;


-- Open the cursor and get the first value.
OPEN SalesStoredProcedures;

Fetch NEXT FROM SalesStoredProcedures INTO @procedure;

-- Iterate through each procedure
While (@@FETCH_STATUS <> -1)
BEGIN

	-- Allow the sales role to execute sales-related stored procedures.
	SELECT @command = 'GRANT EXECUTE ON [dbo].' + QUOTENAME(@procedure) + ' TO ' + @salesRole;
	EXECUTE sp_executesql @command;
	
	-- Get the next value.
	Fetch NEXT FROM SalesStoredProcedures INTO @procedure;

END

SELECT @command = 'GRANT EXECUTE ON [dbo].usp_management_GetSystemConfigSettings TO ' + @salesRole;
	EXECUTE sp_executesql @command;



--EXEC sp_xp_cmdshell_proxy_account 'B3-Server\Sales', 'borabora'

-- Clean up cursors.
CLOSE SalesStoredProcedures;
DEALLOCATE SalesStoredProcedures;


-- Open the cursor and get the first value.
OPEN PlayerStoredProcedures;

Fetch NEXT FROM PlayerStoredProcedures INTO @procedure;

-- Iterate through each procedure
While (@@FETCH_STATUS <> -1)
BEGIN

	-- Allow the sales role to execute sales-related stored procedures.
	SELECT @command = 'GRANT EXECUTE ON [dbo].' + QUOTENAME(@procedure) + ' TO ' + @playerRole;
	EXECUTE sp_executesql @command;
	
	-- Get the next value.
	Fetch NEXT FROM PlayerStoredProcedures INTO @procedure;

END

-- Clean up cursors.
CLOSE PlayerStoredProcedures;
DEALLOCATE PlayerStoredProcedures;

-- Open the cursor and get the first value.
OPEN ManagementStoredProcedures;

Fetch NEXT FROM ManagementStoredProcedures INTO @procedure;

-- Iterate through each procedure
While (@@FETCH_STATUS <> -1)
BEGIN

	-- Allow the management role to execute management-related stored procedures.
	SELECT @command = 'GRANT EXECUTE ON [dbo].' + QUOTENAME(@procedure) + ' TO ' + @managementRole;
	EXECUTE sp_executesql @command;
	
	-- Get the next value.
	Fetch NEXT FROM ManagementStoredProcedures INTO @procedure;

END

-- Clean up cursors.
CLOSE ManagementStoredProcedures;
DEALLOCATE ManagementStoredProcedures;

GO

--USE master;
--GRANT CONTROL SERVER TO [B3-Server\Sales]
--GO

declare @salesRole  sysname 
set @salesRole = QUOTENAME('role_Sales');
GRANT INSERT ON [dbo].[B3_Log_Hosts] TO [B3-Server\Sales]


USE [B3]

/****** Object:  User [RptUser]    Script Date: 10/19/2015 08:17:38 ******/
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'RptUser')
DROP USER [RptUser]

CREATE USER [RptUser] FOR LOGIN [RptUser] WITH DEFAULT_SCHEMA=[dbo]

DECLARE @RoleName sysname
set @RoleName = N'B3Reports'
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = @RoleName AND type = 'R')
Begin
    DECLARE @RoleMemberName sysname
    DECLARE Member_Cursor CURSOR FOR
    select [name]
    from sys.database_principals 
    where principal_id in ( 
	    select member_principal_id 
	    from sys.database_role_members 
	    where role_principal_id in (
		    select principal_id
		    FROM sys.database_principals where [name] = @RoleName  AND type = 'R' ))

    OPEN Member_Cursor;

    FETCH NEXT FROM Member_Cursor
    into @RoleMemberName

    WHILE @@FETCH_STATUS = 0
    BEGIN

	    exec sp_droprolemember @rolename=@RoleName, @membername= @RoleMemberName

	    FETCH NEXT FROM Member_Cursor
	    into @RoleMemberName
    END;

    CLOSE Member_Cursor;
    DEALLOCATE Member_Cursor;
End

/****** Object:  DatabaseRole [B3Reports]    Script Date: 10/19/2015 08:17:52 ******/
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'B3Reports' AND type = 'R')
DROP ROLE [B3Reports]

/****** Object:  DatabaseRole [B3Reports]    Script Date: 10/19/2015 08:17:52 ******/
CREATE ROLE [B3Reports] AUTHORIZATION [dbo]

exec sp_addrolemember N'B3Reports', N'rptUser'

grant select to rptUser

/****** Object:  User [EliteUser]    Script Date: 10/20/2015 10:21:07 ******/
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'EliteUser')
DROP USER [EliteUser]

CREATE USER [EliteUser] FOR LOGIN [EliteUser] WITH DEFAULT_SCHEMA=[dbo]

EXEC sp_addrolemember N'role_Sales', N'EliteUser'
EXEC sp_addrolemember N'role_Management', N'EliteUser'
EXEC sp_addrolemember N'role_Player', N'EliteUser'
exec sp_addrolemember N'db_owner', N'RptUser'
exec sp_addrolemember N'db_owner', N'EliteUser'


