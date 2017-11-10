USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_ukickem_ConfigureTables_82_4000X_RNG]    Script Date: 09/15/2015 11:34:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_ukickem_ConfigureTables_82_4000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_ukickem_ConfigureTables_82_4000X_RNG]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_ukickem_ConfigureTables_82_4000X_RNG]    Script Date: 09/15/2015 11:34:11 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_ukickem_ConfigureTables_82_4000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_ukickem_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_ukickem_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE UKickEm_GamePayTable
			SET payunit_catch_3 = 1
			        , payunit_catch_4 = 2
			        , payunit_catch_5 = 5
			        , payunit_catch_6 = 40
			        , payunit_catch_7 = 400
			        , payunit_catch_8 = 4000

		SET @nDenomCount = @nDenomCount + 1
		END

	UPDATE
		[UKickEm_GameSettings]
		SET
			-- 82%, $1000 Prize Cap, Uniform Ball Distribution
			[mathmodel_denom_1_percent] = 82.00, 
			[mathmodel_denom_5_percent] = 82.00, 
			[mathmodel_denom_10_percent] = 82.00, 
			[mathmodel_denom_25_percent] = 82.00, 
			[mathmodel_denom_50_percent] = 82.00, 
			[mathmodel_denom_100_percent] = 82.00, 
			[mathmodel_denom_200_percent] = 82.00, 
			[mathmodel_denom_500_percent] = 82.00, 
			[mathmodel_denom_1_prizecap] = 1000.00, 
			[mathmodel_denom_5_prizecap] = 1000.00, 
			[mathmodel_denom_10_prizecap] = 1000.00, 
			[mathmodel_denom_25_prizecap] = 1000.00, 
			[mathmodel_denom_50_prizecap] = 1000.00, 
			[mathmodel_denom_100_prizecap] = 1000.00, 
			[mathmodel_denom_200_prizecap] = 1000.00, 
			[mathmodel_denom_500_prizecap] = 1000.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO


USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_ukickem_ConfigureTables_84_1000X_RNG]    Script Date: 09/15/2015 11:34:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_ukickem_ConfigureTables_84_1000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_ukickem_ConfigureTables_84_1000X_RNG]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_ukickem_ConfigureTables_84_1000X_RNG]    Script Date: 09/15/2015 11:34:15 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_ukickem_ConfigureTables_84_1000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE b3.dbo.usp_setup_ukickem_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE b3.dbo.usp_setup_ukickem_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE UKickEm_GamePayTable
			SET payunit_catch_3 = 1
			        , payunit_catch_4 = 2
			        , payunit_catch_5 = 12
			        , payunit_catch_6 = 25
			        , payunit_catch_7 = 100
			        , payunit_catch_8 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	UPDATE
		[UKickEm_GameSettings]
		SET
			-- 84%, $250 Prize Cap, Uniform Ball Distribution
			[mathmodel_denom_1_percent] = 84.00, 
			[mathmodel_denom_5_percent] = 84.00, 
			[mathmodel_denom_10_percent] = 84.00, 
			[mathmodel_denom_25_percent] = 84.00, 
			[mathmodel_denom_50_percent] = 84.00, 
			[mathmodel_denom_100_percent] = 84.00, 
			[mathmodel_denom_200_percent] = 84.00, 
			[mathmodel_denom_500_percent] = 84.00, 
			[mathmodel_denom_1_prizecap] = 250.00, 
			[mathmodel_denom_5_prizecap] = 250.00, 
			[mathmodel_denom_10_prizecap] = 250.00, 
			[mathmodel_denom_25_prizecap] = 250.00, 
			[mathmodel_denom_50_prizecap] = 250.00, 
			[mathmodel_denom_100_prizecap] = 250.00, 
			[mathmodel_denom_200_prizecap] = 250.00, 
			[mathmodel_denom_500_prizecap] = 250.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_ukickem_ConfigureTables_87_1000X_RNG]    Script Date: 09/15/2015 11:34:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_ukickem_ConfigureTables_87_1000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_ukickem_ConfigureTables_87_1000X_RNG]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_ukickem_ConfigureTables_87_1000X_RNG]    Script Date: 09/15/2015 11:34:19 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_ukickem_ConfigureTables_87_1000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_ukickem_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_ukickem_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE UKickEm_GamePayTable
			SET payunit_catch_3 = 1
			        , payunit_catch_4 = 2
			        , payunit_catch_5 = 8
			        , payunit_catch_6 = 40
			        , payunit_catch_7 = 400
			        , payunit_catch_8 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	UPDATE
		[UKickEm_GameSettings]
		SET
			-- 87%, $250 Prize Cap, Uniform Ball Distribution
			[mathmodel_denom_1_percent] = 87.00, 
			[mathmodel_denom_5_percent] = 87.00, 
			[mathmodel_denom_10_percent] = 87.00, 
			[mathmodel_denom_25_percent] = 87.00, 
			[mathmodel_denom_50_percent] = 87.00, 
			[mathmodel_denom_100_percent] = 87.00, 
			[mathmodel_denom_200_percent] = 87.00, 
			[mathmodel_denom_500_percent] = 87.00, 
			[mathmodel_denom_1_prizecap] = 250.00, 
			[mathmodel_denom_5_prizecap] = 250.00, 
			[mathmodel_denom_10_prizecap] = 250.00, 
			[mathmodel_denom_25_prizecap] = 250.00, 
			[mathmodel_denom_50_prizecap] = 250.00, 
			[mathmodel_denom_100_prizecap] = 250.00, 
			[mathmodel_denom_200_prizecap] = 250.00, 
			[mathmodel_denom_500_prizecap] = 250.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_ukickem_ConfigureTables_Demo]    Script Date: 09/15/2015 11:34:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_ukickem_ConfigureTables_Demo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_ukickem_ConfigureTables_Demo]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_ukickem_ConfigureTables_Demo]    Script Date: 09/15/2015 11:34:22 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_ukickem_ConfigureTables_Demo]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_ukickem_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_ukickem_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE UKickEm_GamePayTable
			SET payunit_catch_3 = 1
			        , payunit_catch_4 = 2
			        , payunit_catch_5 = 6
			        , payunit_catch_6 = 18
			        , payunit_catch_7 = 30
			        , payunit_catch_8 = 250

		SET @nDenomCount = @nDenomCount + 1
		END

	UPDATE
		[UKickEm_GameSettings]
		SET
			[mathmodel_denom_1_percent] = 100.00, 
			[mathmodel_denom_5_percent] = 100.00, 
			[mathmodel_denom_10_percent] = 100.00, 
			[mathmodel_denom_25_percent] = 100.00, 
			[mathmodel_denom_50_percent] = 100.00, 
			[mathmodel_denom_100_percent] = 100.00, 
			[mathmodel_denom_200_percent] = 100.00, 
			[mathmodel_denom_500_percent] = 100.00, 
			[mathmodel_denom_1_prizecap] = 100000.00, 
			[mathmodel_denom_5_prizecap] = 100000.00, 
			[mathmodel_denom_10_prizecap] = 100000.00, 
			[mathmodel_denom_25_prizecap] = 100000.00, 
			[mathmodel_denom_50_prizecap] = 100000.00, 
			[mathmodel_denom_100_prizecap] = 100000.00, 
			[mathmodel_denom_200_prizecap] = 100000.00, 
			[mathmodel_denom_500_prizecap] = 100000.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED DEMO',
			[autocall] = 'T';
GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_ukickem_ConfigureTables_82_4000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_ukickem_ConfigureTables_82_4000X_RNG_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_ukickem_ConfigureTables_82_4000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_ukickem_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_ukickem_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE UKickEm_GamePayTable
			SET payunit_catch_3 = 1
			        , payunit_catch_4 = 2
			        , payunit_catch_5 = 5
			        , payunit_catch_6 = 40
			        , payunit_catch_7 = 400
			        , payunit_catch_8 = 4000

		SET @nDenomCount = @nDenomCount + 1
		END

	UPDATE
		[UKickEm_GameSettings]
		SET
			-- 82%, $1000 Prize Cap, Uniform Ball Distribution
			[mathmodel_denom_1_percent] = 82.00, 
			[mathmodel_denom_5_percent] = 82.00, 
			[mathmodel_denom_10_percent] = 82.00, 
			[mathmodel_denom_25_percent] = 82.00, 
			[mathmodel_denom_50_percent] = 82.00, 
			[mathmodel_denom_100_percent] = 82.00, 
			[mathmodel_denom_200_percent] = 82.00, 
			[mathmodel_denom_500_percent] = 82.00, 
			[mathmodel_denom_1_prizecap] = 1000.00, 
			[mathmodel_denom_5_prizecap] = 1000.00, 
			[mathmodel_denom_10_prizecap] = 1000.00, 
			[mathmodel_denom_25_prizecap] = 1000.00, 
			[mathmodel_denom_50_prizecap] = 1000.00, 
			[mathmodel_denom_100_prizecap] = 1000.00, 
			[mathmodel_denom_200_prizecap] = 1000.00, 
			[mathmodel_denom_500_prizecap] = 1000.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_ukickem_ConfigureTables_84_1000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_ukickem_ConfigureTables_84_1000X_RNG_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_ukickem_ConfigureTables_84_1000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE b3.dbo.usp_setup_ukickem_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE b3.dbo.usp_setup_ukickem_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE UKickEm_GamePayTable
			SET payunit_catch_3 = 1
			        , payunit_catch_4 = 2
			        , payunit_catch_5 = 12
			        , payunit_catch_6 = 25
			        , payunit_catch_7 = 100
			        , payunit_catch_8 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	UPDATE
		[UKickEm_GameSettings]
		SET
			-- 84%, $250 Prize Cap, Uniform Ball Distribution
			[mathmodel_denom_1_percent] = 84.00, 
			[mathmodel_denom_5_percent] = 84.00, 
			[mathmodel_denom_10_percent] = 84.00, 
			[mathmodel_denom_25_percent] = 84.00, 
			[mathmodel_denom_50_percent] = 84.00, 
			[mathmodel_denom_100_percent] = 84.00, 
			[mathmodel_denom_200_percent] = 84.00, 
			[mathmodel_denom_500_percent] = 84.00, 
			[mathmodel_denom_1_prizecap] = 250.00, 
			[mathmodel_denom_5_prizecap] = 250.00, 
			[mathmodel_denom_10_prizecap] = 250.00, 
			[mathmodel_denom_25_prizecap] = 250.00, 
			[mathmodel_denom_50_prizecap] = 250.00, 
			[mathmodel_denom_100_prizecap] = 250.00, 
			[mathmodel_denom_200_prizecap] = 250.00, 
			[mathmodel_denom_500_prizecap] = 250.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO



USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_ukickem_ConfigureTables_87_1000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_ukickem_ConfigureTables_87_1000X_RNG_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_ukickem_ConfigureTables_87_1000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_ukickem_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_ukickem_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE UKickEm_GamePayTable
			SET payunit_catch_3 = 1
			        , payunit_catch_4 = 2
			        , payunit_catch_5 = 8
			        , payunit_catch_6 = 40
			        , payunit_catch_7 = 400
			        , payunit_catch_8 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	UPDATE
		[UKickEm_GameSettings]
		SET
			-- 87%, $250 Prize Cap, Uniform Ball Distribution
			[mathmodel_denom_1_percent] = 87.00, 
			[mathmodel_denom_5_percent] = 87.00, 
			[mathmodel_denom_10_percent] = 87.00, 
			[mathmodel_denom_25_percent] = 87.00, 
			[mathmodel_denom_50_percent] = 87.00, 
			[mathmodel_denom_100_percent] = 87.00, 
			[mathmodel_denom_200_percent] = 87.00, 
			[mathmodel_denom_500_percent] = 87.00, 
			[mathmodel_denom_1_prizecap] = 250.00, 
			[mathmodel_denom_5_prizecap] = 250.00, 
			[mathmodel_denom_10_prizecap] = 250.00, 
			[mathmodel_denom_25_prizecap] = 250.00, 
			[mathmodel_denom_50_prizecap] = 250.00, 
			[mathmodel_denom_100_prizecap] = 250.00, 
			[mathmodel_denom_200_prizecap] = 250.00, 
			[mathmodel_denom_500_prizecap] = 250.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO







