USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_timebomb_ConfigureTables_60_5000X_55455]    Script Date: 09/15/2015 11:31:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_timebomb_ConfigureTables_60_5000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_60_5000X_55455]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_timebomb_ConfigureTables_60_5000X_55455]    Script Date: 09/15/2015 11:31:43 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_60_5000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_timebomb_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_timebomb_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE TimeBomb_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 3
			        , payunit_patt_3 = 5
			        , payunit_patt_4 = 24
			        , payunit_patt_5 = 500
			        , payunit_patt_6 = 5000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_timebomb_CreateGamePatternTable

	UPDATE TimeBomb_GameSettings 
		SET maxpatterns = 6, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 48
		BEGIN
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Second Hand'
			        , numdesigns = 4
			        , design_1	= 138240
			        , design_2	= 4337664
			        , design_3	= 28800
	   		        , design_4	= 6276 WHERE patternid = 1 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Any Line'
			        , numdesigns = 12
			        , design_1	= 31
			        , design_2	= 992
			        , design_3	= 31744
	   		        , design_4	= 1015808
			        , design_5	= 32505856
			        , design_6	= 1082401
			        , design_7	= 2164802
			        , design_8	= 4329604
			        , design_9	= 8659208
			        , design_10	= 17318416
			        , design_11	= 17043521
			        , design_12	= 1118480 WHERE patternid = 2 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Fuse'
			        , numdesigns = 2
			        , design_1 = 17829905
			        , design_2 = 332096 WHERE patternid = 3 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Minute Hand'
			        , numdesigns = 4
			        , design_1 = 4329607
			        , design_2 = 1113088
			        , design_3 = 29495428
			        , design_4 = 32272 WHERE patternid = 4 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Bomb'
			        , numdesigns = 3
			        , design_1 = 407968
			        , design_2 = 408960
			        , design_3 = 440704 WHERE patternid = 5 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Explosion'
			        , numdesigns = 4
			        , design_1 = 22352213
			        , design_2 = 18175313
			        , design_3 = 5592404
			        , design_4 = 21321029 WHERE patternid = 6 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 6
		END

	UPDATE
		[TimeBomb_GameSettings]
		SET
			-- 60%, $1250 Prize Cap, 55455 Ball Distribution
			[maxcalls] = 24,
			[mathmodel_denom_1_percent] = 60.00, 
			[mathmodel_denom_5_percent] = 60.00, 
			[mathmodel_denom_10_percent] = 60.00, 
			[mathmodel_denom_25_percent] = 60.00, 
			[mathmodel_denom_50_percent] = 60.00, 
			[mathmodel_denom_100_percent] = 60.00, 
			[mathmodel_denom_200_percent] = 60.00, 
			[mathmodel_denom_500_percent] = 60.00, 
			[mathmodel_denom_1_prizecap] = 1250.00, 
			[mathmodel_denom_5_prizecap] = 1250.00, 
			[mathmodel_denom_10_prizecap] = 1250.00, 
			[mathmodel_denom_25_prizecap] = 1250.00, 
			[mathmodel_denom_50_prizecap] = 1250.00, 
			[mathmodel_denom_100_prizecap] = 1250.00, 
			[mathmodel_denom_200_prizecap] = 1250.00, 
			[mathmodel_denom_500_prizecap] = 1250.00, 
			[mathmodel_balldistrib] = '55455',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'F';
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_timebomb_ConfigureTables_82_1000X_55455]    Script Date: 09/15/2015 11:31:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_timebomb_ConfigureTables_82_1000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_82_1000X_55455]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_timebomb_ConfigureTables_82_1000X_55455]    Script Date: 09/15/2015 11:31:50 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_82_1000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_timebomb_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_timebomb_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE TimeBomb_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 12
			        , payunit_patt_4 = 80
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_timebomb_CreateGamePatternTable

	UPDATE TimeBomb_GameSettings 
		SET maxpatterns = 6, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 48
		BEGIN
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Second Hand'
			        , numdesigns = 4
			        , design_1	= 138240
			        , design_2	= 4337664
			        , design_3	= 28800
	   		        , design_4	= 6276 WHERE patternid = 1 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Any Line'
			        , numdesigns = 12
			        , design_1	= 31
			        , design_2	= 992
			        , design_3	= 31744
	   		        , design_4	= 1015808
			        , design_5	= 32505856
			        , design_6	= 1082401
			        , design_7	= 2164802
			        , design_8	= 4329604
			        , design_9	= 8659208
			        , design_10	= 17318416
			        , design_11	= 17043521
			        , design_12	= 1118480 WHERE patternid = 2 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Fuse'
			        , numdesigns = 2
			        , design_1 = 17829905
			        , design_2 = 332096 WHERE patternid = 3 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Minute Hand'
			        , numdesigns = 4
			        , design_1 = 4329607
			        , design_2 = 1113088
			        , design_3 = 29495428
			        , design_4 = 32272 WHERE patternid = 4 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Bomb'
			        , numdesigns = 3
			        , design_1 = 407968
			        , design_2 = 408960
			        , design_3 = 440704 WHERE patternid = 5 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Explosion'
			        , numdesigns = 4
			        , design_1 = 22352213
			        , design_2 = 18175313
			        , design_3 = 5592404
			        , design_4 = 21321029 WHERE patternid = 6 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 6
		END

	UPDATE
		[TimeBomb_GameSettings]
		SET
			-- 82%, $250 Prize Cap, 55455 Ball Distribution
			[maxcalls] = 24,
			[mathmodel_denom_1_percent] = 82.00, 
			[mathmodel_denom_5_percent] = 82.00, 
			[mathmodel_denom_10_percent] = 82.00, 
			[mathmodel_denom_25_percent] = 82.00, 
			[mathmodel_denom_50_percent] = 82.00, 
			[mathmodel_denom_100_percent] = 82.00, 
			[mathmodel_denom_200_percent] = 82.00, 
			[mathmodel_denom_500_percent] = 82.00, 
			[mathmodel_denom_1_prizecap] = 250.00, 
			[mathmodel_denom_5_prizecap] = 250.00, 
			[mathmodel_denom_10_prizecap] = 250.00, 
			[mathmodel_denom_25_prizecap] = 250.00, 
			[mathmodel_denom_50_prizecap] = 250.00, 
			[mathmodel_denom_100_prizecap] = 250.00, 
			[mathmodel_denom_200_prizecap] = 250.00, 
			[mathmodel_denom_500_prizecap] = 250.00, 
			[mathmodel_balldistrib] = '55455',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'F';
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_timebomb_ConfigureTables_82_10000X_RNG]    Script Date: 09/15/2015 11:31:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_timebomb_ConfigureTables_82_10000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_82_10000X_RNG]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_timebomb_ConfigureTables_82_10000X_RNG]    Script Date: 09/15/2015 11:31:46 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_82_10000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_timebomb_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_timebomb_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE TimeBomb_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 5
			        , payunit_patt_3 = 10
			        , payunit_patt_4 = 60
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_timebomb_CreateGamePatternTable

	UPDATE TimeBomb_GameSettings 
		SET maxpatterns = 6, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 48
		BEGIN
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Second Hand'
			        , numdesigns = 4
			        , design_1	= 138240
			        , design_2	= 4337664
			        , design_3	= 28800
	   		        , design_4	= 6276 WHERE patternid = 1 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Any Line'
			        , numdesigns = 12
			        , design_1	= 31
			        , design_2	= 992
			        , design_3	= 31744
	   		        , design_4	= 1015808
			        , design_5	= 32505856
			        , design_6	= 1082401
			        , design_7	= 2164802
			        , design_8	= 4329604
			        , design_9	= 8659208
			        , design_10	= 17318416
			        , design_11	= 17043521
			        , design_12	= 1118480 WHERE patternid = 2 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Fuse'
			        , numdesigns = 2
			        , design_1 = 17829905
			        , design_2 = 332096 WHERE patternid = 3 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Minute Hand'
			        , numdesigns = 4
			        , design_1 = 4329607
			        , design_2 = 1113088
			        , design_3 = 29495428
			        , design_4 = 32272 WHERE patternid = 4 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Bomb'
			        , numdesigns = 3
			        , design_1 = 407968
			        , design_2 = 408960
			        , design_3 = 440704 WHERE patternid = 5 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Explosion'
			        , numdesigns = 4
			        , design_1 = 22352213
			        , design_2 = 18175313
			        , design_3 = 5592404
			        , design_4 = 21321029 WHERE patternid = 6 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 6
		END

	UPDATE
		[TimeBomb_GameSettings]
		SET
			-- 82%, $2500 Prize Cap, Uniform Ball Distribution
			[maxcalls] = 24,
			[mathmodel_denom_1_percent] = 82.00, 
			[mathmodel_denom_5_percent] = 82.00, 
			[mathmodel_denom_10_percent] = 82.00, 
			[mathmodel_denom_25_percent] = 82.00, 
			[mathmodel_denom_50_percent] = 82.00, 
			[mathmodel_denom_100_percent] = 82.00, 
			[mathmodel_denom_200_percent] = 82.00, 
			[mathmodel_denom_500_percent] = 82.00, 
			[mathmodel_denom_1_prizecap] = 2500.00, 
			[mathmodel_denom_5_prizecap] = 2500.00, 
			[mathmodel_denom_10_prizecap] = 2500.00, 
			[mathmodel_denom_25_prizecap] = 2500.00, 
			[mathmodel_denom_50_prizecap] = 2500.00, 
			[mathmodel_denom_100_prizecap] = 2500.00, 
			[mathmodel_denom_200_prizecap] = 2500.00, 
			[mathmodel_denom_500_prizecap] = 2500.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_timebomb_ConfigureTables_84_10000X_RNG]    Script Date: 09/15/2015 11:31:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_timebomb_ConfigureTables_84_10000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_84_10000X_RNG]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_timebomb_ConfigureTables_84_10000X_RNG]    Script Date: 09/15/2015 11:31:55 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_84_10000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_timebomb_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_timebomb_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE TimeBomb_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 5
			        , payunit_patt_3 = 10
			        , payunit_patt_4 = 60
			        , payunit_patt_5 = 250
			        , payunit_patt_6 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_timebomb_CreateGamePatternTable

	UPDATE TimeBomb_GameSettings 
		SET maxpatterns = 6, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 48
		BEGIN
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Second Hand'
			        , numdesigns = 4
			        , design_1	= 138240
			        , design_2	= 4337664
			        , design_3	= 28800
	   		        , design_4	= 6276 WHERE patternid = 1 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Any Line'
			        , numdesigns = 12
			        , design_1	= 31
			        , design_2	= 992
			        , design_3	= 31744
	   		        , design_4	= 1015808
			        , design_5	= 32505856
			        , design_6	= 1082401
			        , design_7	= 2164802
			        , design_8	= 4329604
			        , design_9	= 8659208
			        , design_10	= 17318416
			        , design_11	= 17043521
			        , design_12	= 1118480 WHERE patternid = 2 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Fuse'
			        , numdesigns = 2
			        , design_1 = 17829905
			        , design_2 = 332096 WHERE patternid = 3 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Minute Hand'
			        , numdesigns = 4
			        , design_1 = 4329607
			        , design_2 = 1113088
			        , design_3 = 29495428
			        , design_4 = 32272 WHERE patternid = 4 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Bomb'
			        , numdesigns = 3
			        , design_1 = 407968
			        , design_2 = 408960
			        , design_3 = 440704 WHERE patternid = 5 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Explosion'
			        , numdesigns = 4
			        , design_1 = 22352213
			        , design_2 = 18175313
			        , design_3 = 5592404
			        , design_4 = 21321029 WHERE patternid = 6 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 6
		END

	UPDATE
		[TimeBomb_GameSettings]
		SET
			-- 84%, $2500 Prize Cap, Uniform Ball Distribution
			[maxcalls] = 24,
			[mathmodel_denom_1_percent] = 84.00, 
			[mathmodel_denom_5_percent] = 84.00, 
			[mathmodel_denom_10_percent] = 84.00, 
			[mathmodel_denom_25_percent] = 84.00, 
			[mathmodel_denom_50_percent] = 84.00, 
			[mathmodel_denom_100_percent] = 84.00, 
			[mathmodel_denom_200_percent] = 84.00, 
			[mathmodel_denom_500_percent] = 84.00, 
			[mathmodel_denom_1_prizecap] = 2500.00, 
			[mathmodel_denom_5_prizecap] = 2500.00, 
			[mathmodel_denom_10_prizecap] = 2500.00, 
			[mathmodel_denom_25_prizecap] = 2500.00, 
			[mathmodel_denom_50_prizecap] = 2500.00, 
			[mathmodel_denom_100_prizecap] = 2500.00, 
			[mathmodel_denom_200_prizecap] = 2500.00, 
			[mathmodel_denom_500_prizecap] = 2500.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO


USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_timebomb_ConfigureTables_87_1000X_55455]    Script Date: 09/15/2015 11:32:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_timebomb_ConfigureTables_87_1000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_87_1000X_55455]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_timebomb_ConfigureTables_87_1000X_55455]    Script Date: 09/15/2015 11:32:02 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_87_1000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_timebomb_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_timebomb_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE TimeBomb_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 6
			        , payunit_patt_3 = 12
			        , payunit_patt_4 = 50
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_timebomb_CreateGamePatternTable

	UPDATE TimeBomb_GameSettings 
		SET maxpatterns = 6, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 48
		BEGIN
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Second Hand'
			        , numdesigns = 4
			        , design_1	= 138240
			        , design_2	= 4337664
			        , design_3	= 28800
	   		        , design_4	= 6276 WHERE patternid = 1 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Any Line'
			        , numdesigns = 12
			        , design_1	= 31
			        , design_2	= 992
			        , design_3	= 31744
	   		        , design_4	= 1015808
			        , design_5	= 32505856
			        , design_6	= 1082401
			        , design_7	= 2164802
			        , design_8	= 4329604
			        , design_9	= 8659208
			        , design_10	= 17318416
			        , design_11	= 17043521
			        , design_12	= 1118480 WHERE patternid = 2 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Fuse'
			        , numdesigns = 2
			        , design_1 = 17829905
			        , design_2 = 332096 WHERE patternid = 3 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Minute Hand'
			        , numdesigns = 4
			        , design_1 = 4329607
			        , design_2 = 1113088
			        , design_3 = 29495428
			        , design_4 = 32272 WHERE patternid = 4 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Bomb'
			        , numdesigns = 3
			        , design_1 = 407968
			        , design_2 = 408960
			        , design_3 = 440704 WHERE patternid = 5 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Explosion'
			        , numdesigns = 4
			        , design_1 = 22352213
			        , design_2 = 18175313
			        , design_3 = 5592404
			        , design_4 = 21321029 WHERE patternid = 6 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 6
		END

	UPDATE
		[TimeBomb_GameSettings]
		SET
			-- 87%, $250 Prize Cap, 55455 Ball Distribution
			[maxcalls] = 24,
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
			[mathmodel_balldistrib] = '55455',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'F';
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_timebomb_ConfigureTables_87_10000X_RNG]    Script Date: 09/15/2015 11:31:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_timebomb_ConfigureTables_87_10000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_87_10000X_RNG]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_timebomb_ConfigureTables_87_10000X_RNG]    Script Date: 09/15/2015 11:31:58 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_87_10000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_timebomb_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_timebomb_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE TimeBomb_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 5
			        , payunit_patt_3 = 10
			        , payunit_patt_4 = 70
			        , payunit_patt_5 = 250
			        , payunit_patt_6 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_timebomb_CreateGamePatternTable

	UPDATE TimeBomb_GameSettings 
		SET maxpatterns = 6, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 48
		BEGIN
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Second Hand'
			        , numdesigns = 4
			        , design_1	= 138240
			        , design_2	= 4337664
			        , design_3	= 28800
	   		        , design_4	= 6276 WHERE patternid = 1 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Any Line'
			        , numdesigns = 12
			        , design_1	= 31
			        , design_2	= 992
			        , design_3	= 31744
	   		        , design_4	= 1015808
			        , design_5	= 32505856
			        , design_6	= 1082401
			        , design_7	= 2164802
			        , design_8	= 4329604
			        , design_9	= 8659208
			        , design_10	= 17318416
			        , design_11	= 17043521
			        , design_12	= 1118480 WHERE patternid = 2 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Fuse'
			        , numdesigns = 2
			        , design_1 = 17829905
			        , design_2 = 332096 WHERE patternid = 3 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Minute Hand'
			        , numdesigns = 4
			        , design_1 = 4329607
			        , design_2 = 1113088
			        , design_3 = 29495428
			        , design_4 = 32272 WHERE patternid = 4 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Bomb'
			        , numdesigns = 3
			        , design_1 = 407968
			        , design_2 = 408960
			        , design_3 = 440704 WHERE patternid = 5 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Explosion'
			        , numdesigns = 4
			        , design_1 = 22352213
			        , design_2 = 18175313
			        , design_3 = 5592404
			        , design_4 = 21321029 WHERE patternid = 6 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 6
		END

	UPDATE
		[TimeBomb_GameSettings]
		SET
			-- 87%, $2500 Prize Cap, Uniform Ball Distribution
			[maxcalls] = 24,
			[mathmodel_denom_1_percent] = 87.00, 
			[mathmodel_denom_5_percent] = 87.00, 
			[mathmodel_denom_10_percent] = 87.00, 
			[mathmodel_denom_25_percent] = 87.00, 
			[mathmodel_denom_50_percent] = 87.00, 
			[mathmodel_denom_100_percent] = 87.00, 
			[mathmodel_denom_200_percent] = 87.00, 
			[mathmodel_denom_500_percent] = 87.00, 
			[mathmodel_denom_1_prizecap] = 2500.00, 
			[mathmodel_denom_5_prizecap] = 2500.00, 
			[mathmodel_denom_10_prizecap] = 2500.00, 
			[mathmodel_denom_25_prizecap] = 2500.00, 
			[mathmodel_denom_50_prizecap] = 2500.00, 
			[mathmodel_denom_100_prizecap] = 2500.00, 
			[mathmodel_denom_200_prizecap] = 2500.00, 
			[mathmodel_denom_500_prizecap] = 2500.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_timebomb_ConfigureTables_Demo]    Script Date: 09/15/2015 11:32:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_timebomb_ConfigureTables_Demo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_Demo]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_timebomb_ConfigureTables_Demo]    Script Date: 09/15/2015 11:32:13 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_Demo]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_timebomb_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_timebomb_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE TimeBomb_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 6
			        , payunit_patt_3 = 12
			        , payunit_patt_4 = 50
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_timebomb_CreateGamePatternTable

	UPDATE TimeBomb_GameSettings 
		SET maxpatterns = 6, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 48
		BEGIN
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Second Hand'
			        , numdesigns = 4
			        , design_1	= 138240
			        , design_2	= 4337664
			        , design_3	= 28800
	   		        , design_4	= 6276 WHERE patternid = 1 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Any Line'
			        , numdesigns = 12
			        , design_1	= 31
			        , design_2	= 992
			        , design_3	= 31744
	   		        , design_4	= 1015808
			        , design_5	= 32505856
			        , design_6	= 1082401
			        , design_7	= 2164802
			        , design_8	= 4329604
			        , design_9	= 8659208
			        , design_10	= 17318416
			        , design_11	= 17043521
			        , design_12	= 1118480 WHERE patternid = 2 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Fuse'
			        , numdesigns = 2
			        , design_1 = 17829905
			        , design_2 = 332096 WHERE patternid = 3 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Minute Hand'
			        , numdesigns = 4
			        , design_1 = 4329607
			        , design_2 = 1113088
			        , design_3 = 29495428
			        , design_4 = 32272 WHERE patternid = 4 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Bomb'
			        , numdesigns = 3
			        , design_1 = 407968
			        , design_2 = 408960
			        , design_3 = 440704 WHERE patternid = 5 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Explosion'
			        , numdesigns = 4
			        , design_1 = 22352213
			        , design_2 = 18175313
			        , design_3 = 5592404
			        , design_4 = 21321029 WHERE patternid = 6 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 6
		END

	UPDATE
		[TimeBomb_GameSettings]
		SET
			[maxcalls] = 24,
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_timebomb_ConfigureTables_82_10000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_82_10000X_RNG_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_82_10000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_timebomb_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_timebomb_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE TimeBomb_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 5
			        , payunit_patt_3 = 10
			        , payunit_patt_4 = 60
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_timebomb_CreateGamePatternTable

	UPDATE TimeBomb_GameSettings 
		SET maxpatterns = 6, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 48
		BEGIN
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Second Hand'
			        , numdesigns = 4
			        , design_1	= 138240
			        , design_2	= 4337664
			        , design_3	= 28800
	   		        , design_4	= 6276 WHERE patternid = 1 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Any Line'
			        , numdesigns = 12
			        , design_1	= 31
			        , design_2	= 992
			        , design_3	= 31744
	   		        , design_4	= 1015808
			        , design_5	= 32505856
			        , design_6	= 1082401
			        , design_7	= 2164802
			        , design_8	= 4329604
			        , design_9	= 8659208
			        , design_10	= 17318416
			        , design_11	= 17043521
			        , design_12	= 1118480 WHERE patternid = 2 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Fuse'
			        , numdesigns = 2
			        , design_1 = 17829905
			        , design_2 = 332096 WHERE patternid = 3 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Minute Hand'
			        , numdesigns = 4
			        , design_1 = 4329607
			        , design_2 = 1113088
			        , design_3 = 29495428
			        , design_4 = 32272 WHERE patternid = 4 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Bomb'
			        , numdesigns = 3
			        , design_1 = 407968
			        , design_2 = 408960
			        , design_3 = 440704 WHERE patternid = 5 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Explosion'
			        , numdesigns = 4
			        , design_1 = 22352213
			        , design_2 = 18175313
			        , design_3 = 5592404
			        , design_4 = 21321029 WHERE patternid = 6 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 6
		END

	UPDATE
		[TimeBomb_GameSettings]
		SET
			-- 82%, $2500 Prize Cap, Uniform Ball Distribution
			[maxcalls] = 24,
			[mathmodel_denom_1_percent] = 82.00, 
			[mathmodel_denom_5_percent] = 82.00, 
			[mathmodel_denom_10_percent] = 82.00, 
			[mathmodel_denom_25_percent] = 82.00, 
			[mathmodel_denom_50_percent] = 82.00, 
			[mathmodel_denom_100_percent] = 82.00, 
			[mathmodel_denom_200_percent] = 82.00, 
			[mathmodel_denom_500_percent] = 82.00, 
			[mathmodel_denom_1_prizecap] = 2500.00, 
			[mathmodel_denom_5_prizecap] = 2500.00, 
			[mathmodel_denom_10_prizecap] = 2500.00, 
			[mathmodel_denom_25_prizecap] = 2500.00, 
			[mathmodel_denom_50_prizecap] = 2500.00, 
			[mathmodel_denom_100_prizecap] = 2500.00, 
			[mathmodel_denom_200_prizecap] = 2500.00, 
			[mathmodel_denom_500_prizecap] = 2500.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_timebomb_ConfigureTables_82_1000X_55455_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_82_1000X_55455_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_82_1000X_55455_GLI]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_timebomb_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_timebomb_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE TimeBomb_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 12
			        , payunit_patt_4 = 80
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_timebomb_CreateGamePatternTable

	UPDATE TimeBomb_GameSettings 
		SET maxpatterns = 6, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 48
		BEGIN
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Second Hand'
			        , numdesigns = 4
			        , design_1	= 138240
			        , design_2	= 4337664
			        , design_3	= 28800
	   		        , design_4	= 6276 WHERE patternid = 1 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Any Line'
			        , numdesigns = 12
			        , design_1	= 31
			        , design_2	= 992
			        , design_3	= 31744
	   		        , design_4	= 1015808
			        , design_5	= 32505856
			        , design_6	= 1082401
			        , design_7	= 2164802
			        , design_8	= 4329604
			        , design_9	= 8659208
			        , design_10	= 17318416
			        , design_11	= 17043521
			        , design_12	= 1118480 WHERE patternid = 2 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Fuse'
			        , numdesigns = 2
			        , design_1 = 17829905
			        , design_2 = 332096 WHERE patternid = 3 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Minute Hand'
			        , numdesigns = 4
			        , design_1 = 4329607
			        , design_2 = 1113088
			        , design_3 = 29495428
			        , design_4 = 32272 WHERE patternid = 4 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Bomb'
			        , numdesigns = 3
			        , design_1 = 407968
			        , design_2 = 408960
			        , design_3 = 440704 WHERE patternid = 5 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Explosion'
			        , numdesigns = 4
			        , design_1 = 22352213
			        , design_2 = 18175313
			        , design_3 = 5592404
			        , design_4 = 21321029 WHERE patternid = 6 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 6
		END

	UPDATE
		[TimeBomb_GameSettings]
		SET
			-- 82%, $250 Prize Cap, 55455 Ball Distribution
			[maxcalls] = 24,
			[mathmodel_denom_1_percent] = 82.00, 
			[mathmodel_denom_5_percent] = 82.00, 
			[mathmodel_denom_10_percent] = 82.00, 
			[mathmodel_denom_25_percent] = 82.00, 
			[mathmodel_denom_50_percent] = 82.00, 
			[mathmodel_denom_100_percent] = 82.00, 
			[mathmodel_denom_200_percent] = 82.00, 
			[mathmodel_denom_500_percent] = 82.00, 
			[mathmodel_denom_1_prizecap] = 250.00, 
			[mathmodel_denom_5_prizecap] = 250.00, 
			[mathmodel_denom_10_prizecap] = 250.00, 
			[mathmodel_denom_25_prizecap] = 250.00, 
			[mathmodel_denom_50_prizecap] = 250.00, 
			[mathmodel_denom_100_prizecap] = 250.00, 
			[mathmodel_denom_200_prizecap] = 250.00, 
			[mathmodel_denom_500_prizecap] = 250.00, 
			[mathmodel_balldistrib] = '55455',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'F';
GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_timebomb_ConfigureTables_84_10000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_84_10000X_RNG_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_84_10000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_timebomb_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_timebomb_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE TimeBomb_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 5
			        , payunit_patt_3 = 10
			        , payunit_patt_4 = 60
			        , payunit_patt_5 = 250
			        , payunit_patt_6 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_timebomb_CreateGamePatternTable

	UPDATE TimeBomb_GameSettings 
		SET maxpatterns = 6, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 48
		BEGIN
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Second Hand'
			        , numdesigns = 4
			        , design_1	= 138240
			        , design_2	= 4337664
			        , design_3	= 28800
	   		        , design_4	= 6276 WHERE patternid = 1 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Any Line'
			        , numdesigns = 12
			        , design_1	= 31
			        , design_2	= 992
			        , design_3	= 31744
	   		        , design_4	= 1015808
			        , design_5	= 32505856
			        , design_6	= 1082401
			        , design_7	= 2164802
			        , design_8	= 4329604
			        , design_9	= 8659208
			        , design_10	= 17318416
			        , design_11	= 17043521
			        , design_12	= 1118480 WHERE patternid = 2 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Fuse'
			        , numdesigns = 2
			        , design_1 = 17829905
			        , design_2 = 332096 WHERE patternid = 3 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Minute Hand'
			        , numdesigns = 4
			        , design_1 = 4329607
			        , design_2 = 1113088
			        , design_3 = 29495428
			        , design_4 = 32272 WHERE patternid = 4 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Bomb'
			        , numdesigns = 3
			        , design_1 = 407968
			        , design_2 = 408960
			        , design_3 = 440704 WHERE patternid = 5 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Explosion'
			        , numdesigns = 4
			        , design_1 = 22352213
			        , design_2 = 18175313
			        , design_3 = 5592404
			        , design_4 = 21321029 WHERE patternid = 6 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 6
		END

	UPDATE
		[TimeBomb_GameSettings]
		SET
			-- 84%, $2500 Prize Cap, Uniform Ball Distribution
			[maxcalls] = 24,
			[mathmodel_denom_1_percent] = 84.00, 
			[mathmodel_denom_5_percent] = 84.00, 
			[mathmodel_denom_10_percent] = 84.00, 
			[mathmodel_denom_25_percent] = 84.00, 
			[mathmodel_denom_50_percent] = 84.00, 
			[mathmodel_denom_100_percent] = 84.00, 
			[mathmodel_denom_200_percent] = 84.00, 
			[mathmodel_denom_500_percent] = 84.00, 
			[mathmodel_denom_1_prizecap] = 2500.00, 
			[mathmodel_denom_5_prizecap] = 2500.00, 
			[mathmodel_denom_10_prizecap] = 2500.00, 
			[mathmodel_denom_25_prizecap] = 2500.00, 
			[mathmodel_denom_50_prizecap] = 2500.00, 
			[mathmodel_denom_100_prizecap] = 2500.00, 
			[mathmodel_denom_200_prizecap] = 2500.00, 
			[mathmodel_denom_500_prizecap] = 2500.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_timebomb_ConfigureTables_87_10000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_87_10000X_RNG_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_87_10000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_timebomb_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_timebomb_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE TimeBomb_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 5
			        , payunit_patt_3 = 10
			        , payunit_patt_4 = 70
			        , payunit_patt_5 = 250
			        , payunit_patt_6 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_timebomb_CreateGamePatternTable

	UPDATE TimeBomb_GameSettings 
		SET maxpatterns = 6, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 48
		BEGIN
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Second Hand'
			        , numdesigns = 4
			        , design_1	= 138240
			        , design_2	= 4337664
			        , design_3	= 28800
	   		        , design_4	= 6276 WHERE patternid = 1 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Any Line'
			        , numdesigns = 12
			        , design_1	= 31
			        , design_2	= 992
			        , design_3	= 31744
	   		        , design_4	= 1015808
			        , design_5	= 32505856
			        , design_6	= 1082401
			        , design_7	= 2164802
			        , design_8	= 4329604
			        , design_9	= 8659208
			        , design_10	= 17318416
			        , design_11	= 17043521
			        , design_12	= 1118480 WHERE patternid = 2 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Fuse'
			        , numdesigns = 2
			        , design_1 = 17829905
			        , design_2 = 332096 WHERE patternid = 3 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Minute Hand'
			        , numdesigns = 4
			        , design_1 = 4329607
			        , design_2 = 1113088
			        , design_3 = 29495428
			        , design_4 = 32272 WHERE patternid = 4 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Bomb'
			        , numdesigns = 3
			        , design_1 = 407968
			        , design_2 = 408960
			        , design_3 = 440704 WHERE patternid = 5 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Explosion'
			        , numdesigns = 4
			        , design_1 = 22352213
			        , design_2 = 18175313
			        , design_3 = 5592404
			        , design_4 = 21321029 WHERE patternid = 6 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 6
		END

	UPDATE
		[TimeBomb_GameSettings]
		SET
			-- 87%, $2500 Prize Cap, Uniform Ball Distribution
			[maxcalls] = 24,
			[mathmodel_denom_1_percent] = 87.00, 
			[mathmodel_denom_5_percent] = 87.00, 
			[mathmodel_denom_10_percent] = 87.00, 
			[mathmodel_denom_25_percent] = 87.00, 
			[mathmodel_denom_50_percent] = 87.00, 
			[mathmodel_denom_100_percent] = 87.00, 
			[mathmodel_denom_200_percent] = 87.00, 
			[mathmodel_denom_500_percent] = 87.00, 
			[mathmodel_denom_1_prizecap] = 2500.00, 
			[mathmodel_denom_5_prizecap] = 2500.00, 
			[mathmodel_denom_10_prizecap] = 2500.00, 
			[mathmodel_denom_25_prizecap] = 2500.00, 
			[mathmodel_denom_50_prizecap] = 2500.00, 
			[mathmodel_denom_100_prizecap] = 2500.00, 
			[mathmodel_denom_200_prizecap] = 2500.00, 
			[mathmodel_denom_500_prizecap] = 2500.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_timebomb_ConfigureTables_87_1000X_55455_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_87_1000X_55455_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_timebomb_ConfigureTables_87_1000X_55455_GLI]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_timebomb_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_timebomb_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE TimeBomb_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 6
			        , payunit_patt_3 = 12
			        , payunit_patt_4 = 50
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_timebomb_CreateGamePatternTable

	UPDATE TimeBomb_GameSettings 
		SET maxpatterns = 6, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 48
		BEGIN
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Second Hand'
			        , numdesigns = 4
			        , design_1	= 138240
			        , design_2	= 4337664
			        , design_3	= 28800
	   		        , design_4	= 6276 WHERE patternid = 1 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Any Line'
			        , numdesigns = 12
			        , design_1	= 31
			        , design_2	= 992
			        , design_3	= 31744
	   		        , design_4	= 1015808
			        , design_5	= 32505856
			        , design_6	= 1082401
			        , design_7	= 2164802
			        , design_8	= 4329604
			        , design_9	= 8659208
			        , design_10	= 17318416
			        , design_11	= 17043521
			        , design_12	= 1118480 WHERE patternid = 2 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Fuse'
			        , numdesigns = 2
			        , design_1 = 17829905
			        , design_2 = 332096 WHERE patternid = 3 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Minute Hand'
			        , numdesigns = 4
			        , design_1 = 4329607
			        , design_2 = 1113088
			        , design_3 = 29495428
			        , design_4 = 32272 WHERE patternid = 4 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Bomb'
			        , numdesigns = 3
			        , design_1 = 407968
			        , design_2 = 408960
			        , design_3 = 440704 WHERE patternid = 5 + @nPatternCount
	
		UPDATE TimeBomb_GamePatterns
			SET patternname = 'Explosion'
			        , numdesigns = 4
			        , design_1 = 22352213
			        , design_2 = 18175313
			        , design_3 = 5592404
			        , design_4 = 21321029 WHERE patternid = 6 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 6
		END

	UPDATE
		[TimeBomb_GameSettings]
		SET
			-- 87%, $250 Prize Cap, 55455 Ball Distribution
			[maxcalls] = 24,
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
			[mathmodel_balldistrib] = '55455',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'F';
GO












