USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_player_b3_GetClientName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_player_b3_GetClientName]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_player_b3_GetClientName]
--=============================================================================
-- Adding support for enabling and disabling units
-- 20160620(knc) White list Ted-E device on B3 if the Ted-E unit is white listed in gtiServer.
--=============================================================================
	@cClientMac char(12) , 
	@cIpAddress varchar(15) , 
	@cVersionNum varchar(8),
	@dtVersionDate datetime,
	@cClientName char(11) OUTPUT, 
	@clientEnabled char(1) OUTPUT
AS
	SET NOCOUNT ON

	DECLARE @dtSignIn datetime

	SELECT @dtSignIn = GETDATE()
	    , @clientEnabled = 'F'

	SELECT TOP 1 @cClientName = clientname
	    , @clientEnabled = isnull(clientEnabled, 'F')
		FROM B3_ClientMap
			WHERE clientmac = @cClientMac
			
			--White listing 
			--* If Gtiserver exists then set the Ted-E unit default to always true.
			--* If B3 Server only then do the old way white listed it manually using sql query.
			declare @dbname varchar(20)
			set @dbname = 'Daily'
			IF (EXISTS (SELECT name FROM master.dbo.sysdatabases  WHERE ('[' + name + ']' = @dbname OR name = @dbname)))
				begin
					set @clientEnabled = 'T'
				end
			
			--select @clientEnabled

	IF (@cClientName LIKE 'PLAYER%')
	BEGIN
		if(@clientEnabled = 'T')
		    UPDATE B3_ClientMap
			    SET lastsignin = @dtSignIn,
			              totalsignins = totalsignins + 1,
			              ipaddress = @cIpAddress,
			              clienttype = 'PLAYER',
			              clientver = @cVersionNum,
			              clientverdate = @dtVersionDate
			    WHERE clientmac = @cClientMac
	END
	ELSE
		BEGIN
			IF (@cClientName IS NOT NULL)
				DELETE FROM B3_ClientMap WHERE clientmac = @cClientMac

			DECLARE @nMaxClientNum integer

			SELECT @nMaxClientNum = CAST(SUBSTRING(clientname, LEN('PLAYER') + 1, 4) AS integer)
				FROM B3_ClientMap
					WHERE clientname = (SELECT MAX(clientname) 
						              			FROM B3_ClientMap WHERE clientname LIKE 'PLAYER%')
			IF @nMaxClientNum IS NULL
				SET @nMaxClientNum = 0
			
			DECLARE @cTemp varchar(4)

			SET @cTemp = CAST(@nMaxClientNum + 1 AS varchar(4))

			IF LEN(@cTemp) < 4
				SET @cTemp = REPLICATE('0', 4 - LEN(@cTemp)) + @cTemp

			SET @cClientName = 'PLAYER' + @cTemp + '*'

			INSERT INTO B3_ClientMap
			    (clientmac, ipaddress, clientname
			    , clienttype, clientver, clientverdate
			    , firstsignin, lastsignin, totalsignins, clientEnabled)
			VALUES
				(@cClientMac, @cIpAddress, @cClientName
				, 'PLAYER', @cVersionNum, @dtVersionDate
				, @dtSignIn, @dtSignIn, 1, 'F')
		END



GO


