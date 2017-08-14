/*
	Author:		Mike McMahon
	Date:		May 27, 2008
	Product:	Big Bad Bingo
	
	Description:
		Generates all security entries required for the Big Bad Bingo system.
		To ensure proper security settings, all non-B3-related database security information will be removed.
		This includes logins, roles, and other security objects that may have improper rights to the database.
*/

/*
	Remove any existing security entries.
	Entries are removed to ensure that they are regenerated with the proper permissions and settings.
*/

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
exec sp_password @new = 'B3 beats the hell out of GRS!', @loginame='sa';
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
	SELECT
		[SPECIFIC_NAME]
		FROM
			INFORMATION_SCHEMA.ROUTINES
		WHERE
			SPECIFIC_NAME LIKE 'usp_sales_%'
			AND
			OBJECTPROPERTY(OBJECT_ID(ROUTINE_NAME),'IsMSShipped') = 0;

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