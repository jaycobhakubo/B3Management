USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_mayamoney_ConfigureTables_60_5000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_60_5000X_55455]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_60_5000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_mayamoney_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_mayamoney_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE MayaMoney_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 2
			        , payunit_patt_3 = 2
			        , payunit_patt_4 = 3
			        , payunit_patt_5 = 6
			        , payunit_patt_6 = 6
			        , payunit_patt_7 = 10
			        , payunit_patt_8 = 10
			        , payunit_patt_9 = 20
			        , payunit_patt_10 = 40
			        , payunit_patt_11 = 100
			        , payunit_patt_12 = 500

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_mayamoney_CreateGamePatternTable

	UPDATE MayaMoney_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Tiny Pyramid'
			        , numdesigns = 3
			        , design_1 = 4292
		                        , design_2 = 137344
		                        , design_3 = 4395008 WHERE patternid = 1 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
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
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Any Six Pack'
			        , numdesigns = 24
			        , design_1 = 231
			        , design_2 = 7392
			        , design_3 = 236544
			        , design_4 = 7569408
			        , design_5 = 462
			        , design_6 = 14784
			        , design_7 = 473088
			        , design_8 = 15138816
			        , design_9 = 924
			        , design_10 = 29568
			        , design_11 = 946176
			        , design_12 = 30277632
			        , design_13 = 3171
			        , design_14 = 101472
			        , design_15 = 3247104
			        , design_16 = 6342
			        , design_17 = 202944
			        , design_18 = 6494208
			        , design_19 = 12684
			        , design_20 = 405888
			        , design_21 = 12988416
			        , design_22 = 25368
			        , design_23 = 811776
			        , design_24 = 25976832 WHERE patternid = 4 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 5 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 6 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536 WHERE patternid = 7 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Star'
			        , numdesigns = 1
			        , design_1 = 4215812 WHERE patternid = 8 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Pyramid'
			        , numdesigns = 3
			        , design_1 = 17593104
			        , design_2 = 8796552
			        , design_3 = 4398276 WHERE patternid = 9 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Steps'
			        , numdesigns = 2
			        , design_1 = 3355408
			        , design_2 = 17576131 WHERE patternid = 10 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Sun'
			        , numdesigns = 1
			        , design_1 = 11375466 WHERE patternid = 11 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Great Pyramid'
			        , numdesigns = 1
			        , design_1 = 17727376 WHERE patternid = 12 + @nPatternCount


		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[MayaMoney_GameSettings]
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_mayamoney_ConfigureTables_82_1000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_82_1000X_55455]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_82_1000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_mayamoney_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_mayamoney_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE MayaMoney_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 2
			        , payunit_patt_3 = 3
			        , payunit_patt_4 = 4
			        , payunit_patt_5 = 10
			        , payunit_patt_6 = 10
			        , payunit_patt_7 = 16
			        , payunit_patt_8 = 16
			        , payunit_patt_9 = 48
			        , payunit_patt_10 = 48
			        , payunit_patt_11 = 100
			        , payunit_patt_12 = 100

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_mayamoney_CreateGamePatternTable

	UPDATE MayaMoney_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Tiny Pyramid'
			        , numdesigns = 3
			        , design_1 = 4292
		                        , design_2 = 137344
		                        , design_3 = 4395008 WHERE patternid = 1 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
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
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Any Six Pack'
			        , numdesigns = 24
			        , design_1 = 231
			        , design_2 = 7392
			        , design_3 = 236544
			        , design_4 = 7569408
			        , design_5 = 462
			        , design_6 = 14784
			        , design_7 = 473088
			        , design_8 = 15138816
			        , design_9 = 924
			        , design_10 = 29568
			        , design_11 = 946176
			        , design_12 = 30277632
			        , design_13 = 3171
			        , design_14 = 101472
			        , design_15 = 3247104
			        , design_16 = 6342
			        , design_17 = 202944
			        , design_18 = 6494208
			        , design_19 = 12684
			        , design_20 = 405888
			        , design_21 = 12988416
			        , design_22 = 25368
			        , design_23 = 811776
			        , design_24 = 25976832 WHERE patternid = 4 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 5 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 6 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536 WHERE patternid = 7 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Star'
			        , numdesigns = 1
			        , design_1 = 4215812 WHERE patternid = 8 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Pyramid'
			        , numdesigns = 3
			        , design_1 = 17593104
			        , design_2 = 8796552
			        , design_3 = 4398276 WHERE patternid = 9 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Steps'
			        , numdesigns = 2
			        , design_1 = 3355408
			        , design_2 = 17576131 WHERE patternid = 10 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Sun'
			        , numdesigns = 1
			        , design_1 = 11375466 WHERE patternid = 11 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Great Pyramid'
			        , numdesigns = 1
			        , design_1 = 17727376 WHERE patternid = 12 + @nPatternCount


		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[MayaMoney_GameSettings]
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

/****** Object:  StoredProcedure [dbo].[usp_config_mayamoney_ConfigureTables_82_20000X_RNG]    Script Date: 09/15/2015 11:24:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_mayamoney_ConfigureTables_82_20000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_82_20000X_RNG]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_mayamoney_ConfigureTables_82_20000X_RNG]    Script Date: 09/15/2015 11:24:52 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_82_20000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_mayamoney_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_mayamoney_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE MayaMoney_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 2
			        , payunit_patt_3 = 3
			        , payunit_patt_4 = 3
			        , payunit_patt_5 = 10
			        , payunit_patt_6 = 10
			        , payunit_patt_7 = 10
			        , payunit_patt_8 = 10
			        , payunit_patt_9 = 150
			        , payunit_patt_10 = 200
			        , payunit_patt_11 = 1000
			        , payunit_patt_12 = 2000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_mayamoney_CreateGamePatternTable

	UPDATE MayaMoney_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Tiny Pyramid'
			        , numdesigns = 3
			        , design_1 = 4292
		                        , design_2 = 137344
		                        , design_3 = 4395008 WHERE patternid = 1 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
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
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Any Six Pack'
			        , numdesigns = 24
			        , design_1 = 231
			        , design_2 = 7392
			        , design_3 = 236544
			        , design_4 = 7569408
			        , design_5 = 462
			        , design_6 = 14784
			        , design_7 = 473088
			        , design_8 = 15138816
			        , design_9 = 924
			        , design_10 = 29568
			        , design_11 = 946176
			        , design_12 = 30277632
			        , design_13 = 3171
			        , design_14 = 101472
			        , design_15 = 3247104
			        , design_16 = 6342
			        , design_17 = 202944
			        , design_18 = 6494208
			        , design_19 = 12684
			        , design_20 = 405888
			        , design_21 = 12988416
			        , design_22 = 25368
			        , design_23 = 811776
			        , design_24 = 25976832 WHERE patternid = 4 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 5 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 6 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536 WHERE patternid = 7 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Star'
			        , numdesigns = 1
			        , design_1 = 4215812 WHERE patternid = 8 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Pyramid'
			        , numdesigns = 3
			        , design_1 = 17593104
			        , design_2 = 8796552
			        , design_3 = 4398276 WHERE patternid = 9 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Steps'
			        , numdesigns = 2
			        , design_1 = 3355408
			        , design_2 = 17576131 WHERE patternid = 10 + @nPatternCount

		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Flying Saucer'
			        , numdesigns = 1
			        , design_1 = 4658628 WHERE patternid = 11 + @nPatternCount

		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Sun'
			        , numdesigns = 1
			        , design_1 = 11375466 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[MayaMoney_GameSettings]
		SET
			-- 82%, $500 Prize Cap, Uniform Ball Distribution
			[maxcalls] = 24,
			[mathmodel_denom_1_percent] = 82.00, 
			[mathmodel_denom_5_percent] = 82.00, 
			[mathmodel_denom_10_percent] = 82.00, 
			[mathmodel_denom_25_percent] = 82.00, 
			[mathmodel_denom_50_percent] = 82.00, 
			[mathmodel_denom_100_percent] = 82.00, 
			[mathmodel_denom_200_percent] = 82.00, 
			[mathmodel_denom_500_percent] = 82.00, 
			[mathmodel_denom_1_prizecap] = 500.00, 
			[mathmodel_denom_5_prizecap] = 500.00, 
			[mathmodel_denom_10_prizecap] = 500.00, 
			[mathmodel_denom_25_prizecap] = 500.00, 
			[mathmodel_denom_50_prizecap] = 500.00, 
			[mathmodel_denom_100_prizecap] = 500.00, 
			[mathmodel_denom_200_prizecap] = 500.00, 
			[mathmodel_denom_500_prizecap] = 500.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_mayamoney_ConfigureTables_84_20000X_RNG]    Script Date: 09/15/2015 11:25:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_mayamoney_ConfigureTables_84_20000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_84_20000X_RNG]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_mayamoney_ConfigureTables_84_20000X_RNG]    Script Date: 09/15/2015 11:25:23 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_84_20000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_mayamoney_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_mayamoney_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE MayaMoney_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 2
			        , payunit_patt_3 = 3
			        , payunit_patt_4 = 3
			        , payunit_patt_5 = 10
			        , payunit_patt_6 = 10
			        , payunit_patt_7 = 10
			        , payunit_patt_8 = 10
			        , payunit_patt_9 = 200
			        , payunit_patt_10 = 300
			        , payunit_patt_11 = 1000
			        , payunit_patt_12 = 2000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_mayamoney_CreateGamePatternTable

	UPDATE MayaMoney_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Tiny Pyramid'
			        , numdesigns = 3
			        , design_1 = 4292
		                        , design_2 = 137344
		                        , design_3 = 4395008 WHERE patternid = 1 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
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
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Any Six Pack'
			        , numdesigns = 24
			        , design_1 = 231
			        , design_2 = 7392
			        , design_3 = 236544
			        , design_4 = 7569408
			        , design_5 = 462
			        , design_6 = 14784
			        , design_7 = 473088
			        , design_8 = 15138816
			        , design_9 = 924
			        , design_10 = 29568
			        , design_11 = 946176
			        , design_12 = 30277632
			        , design_13 = 3171
			        , design_14 = 101472
			        , design_15 = 3247104
			        , design_16 = 6342
			        , design_17 = 202944
			        , design_18 = 6494208
			        , design_19 = 12684
			        , design_20 = 405888
			        , design_21 = 12988416
			        , design_22 = 25368
			        , design_23 = 811776
			        , design_24 = 25976832 WHERE patternid = 4 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 5 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 6 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536 WHERE patternid = 7 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Star'
			        , numdesigns = 1
			        , design_1 = 4215812 WHERE patternid = 8 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Pyramid'
			        , numdesigns = 3
			        , design_1 = 17593104
			        , design_2 = 8796552
			        , design_3 = 4398276 WHERE patternid = 9 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Steps'
			        , numdesigns = 2
			        , design_1 = 3355408
			        , design_2 = 17576131 WHERE patternid = 10 + @nPatternCount

		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Flying Saucer'
			        , numdesigns = 1
			        , design_1 = 4658628 WHERE patternid = 11 + @nPatternCount

		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Sun'
			        , numdesigns = 1
			        , design_1 = 11375466 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[MayaMoney_GameSettings]
		SET
			-- 84%, $500 Prize Cap, Uniform Ball Distribution
			[maxcalls] = 24,
			[mathmodel_denom_1_percent] = 84.00, 
			[mathmodel_denom_5_percent] = 84.00, 
			[mathmodel_denom_10_percent] = 84.00, 
			[mathmodel_denom_25_percent] = 84.00, 
			[mathmodel_denom_50_percent] = 84.00, 
			[mathmodel_denom_100_percent] = 84.00, 
			[mathmodel_denom_200_percent] = 84.00, 
			[mathmodel_denom_500_percent] = 84.00, 
			[mathmodel_denom_1_prizecap] = 500.00, 
			[mathmodel_denom_5_prizecap] = 500.00, 
			[mathmodel_denom_10_prizecap] = 500.00, 
			[mathmodel_denom_25_prizecap] = 500.00, 
			[mathmodel_denom_50_prizecap] = 500.00, 
			[mathmodel_denom_100_prizecap] = 500.00, 
			[mathmodel_denom_200_prizecap] = 500.00, 
			[mathmodel_denom_500_prizecap] = 500.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_mayamoney_ConfigureTables_87_1000X_55455]    Script Date: 09/15/2015 11:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_mayamoney_ConfigureTables_87_1000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_87_1000X_55455]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_mayamoney_ConfigureTables_87_1000X_55455]    Script Date: 09/15/2015 11:25:27 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_87_1000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_mayamoney_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_mayamoney_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE MayaMoney_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 2
			        , payunit_patt_3 = 3
			        , payunit_patt_4 = 6
			        , payunit_patt_5 = 10
			        , payunit_patt_6 = 10
			        , payunit_patt_7 = 16
			        , payunit_patt_8 = 16
			        , payunit_patt_9 = 50
			        , payunit_patt_10 = 50
			        , payunit_patt_11 = 100
			        , payunit_patt_12 = 100

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_mayamoney_CreateGamePatternTable

	UPDATE MayaMoney_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Tiny Pyramid'
			        , numdesigns = 3
			        , design_1 = 4292
		                        , design_2 = 137344
		                        , design_3 = 4395008 WHERE patternid = 1 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
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
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Any Six Pack'
			        , numdesigns = 24
			        , design_1 = 231
			        , design_2 = 7392
			        , design_3 = 236544
			        , design_4 = 7569408
			        , design_5 = 462
			        , design_6 = 14784
			        , design_7 = 473088
			        , design_8 = 15138816
			        , design_9 = 924
			        , design_10 = 29568
			        , design_11 = 946176
			        , design_12 = 30277632
			        , design_13 = 3171
			        , design_14 = 101472
			        , design_15 = 3247104
			        , design_16 = 6342
			        , design_17 = 202944
			        , design_18 = 6494208
			        , design_19 = 12684
			        , design_20 = 405888
			        , design_21 = 12988416
			        , design_22 = 25368
			        , design_23 = 811776
			        , design_24 = 25976832 WHERE patternid = 4 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 5 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 6 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536 WHERE patternid = 7 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Star'
			        , numdesigns = 1
			        , design_1 = 4215812 WHERE patternid = 8 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Pyramid'
			        , numdesigns = 3
			        , design_1 = 17593104
			        , design_2 = 8796552
			        , design_3 = 4398276 WHERE patternid = 9 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Steps'
			        , numdesigns = 2
			        , design_1 = 3355408
			        , design_2 = 17576131 WHERE patternid = 10 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Sun'
			        , numdesigns = 1
			        , design_1 = 11375466 WHERE patternid = 11 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Great Pyramid'
			        , numdesigns = 1
			        , design_1 = 17727376 WHERE patternid = 12 + @nPatternCount


		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[MayaMoney_GameSettings]
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

/****** Object:  StoredProcedure [dbo].[usp_config_mayamoney_ConfigureTables_87_1000X_55455_GLI]    Script Date: 09/15/2015 11:25:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_mayamoney_ConfigureTables_87_1000X_55455_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_87_1000X_55455_GLI]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_mayamoney_ConfigureTables_87_1000X_55455_GLI]    Script Date: 09/15/2015 11:25:32 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_87_1000X_55455_GLI]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_mayamoney_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_mayamoney_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE MayaMoney_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 1
			        , payunit_patt_3 = 2
			        , payunit_patt_4 = 2
			        , payunit_patt_5 = 3
			        , payunit_patt_6 = 5
			        , payunit_patt_7 = 5
			        , payunit_patt_8 = 10
			        , payunit_patt_9 = 10
			        , payunit_patt_10 = 20
			        , payunit_patt_11 = 40
			        , payunit_patt_12 = 100

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_mayamoney_CreateGamePatternTable

	UPDATE MayaMoney_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Crazy Corner'
			        , numdesigns = 4
			        , design_1 = 35
		            , design_2 = 3178496
		            , design_3 = 25690112 
		            , design_4 = 536 WHERE patternid = 1 + @nPatternCount

		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Tiny Pyramid'
			        , numdesigns = 3
			        , design_1 = 4292
		                        , design_2 = 137344
		                        , design_3 = 4395008 WHERE patternid = 2 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Arrowhead'
			        , numdesigns = 2
			        , design_1 = 4234
		            , design_2 = 10620928 WHERE patternid = 3 + @nPatternCount

		UPDATE MayaMoney_GamePatterns
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
			        , design_12	= 1118480 WHERE patternid = 4 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 5 + @nPatternCount

		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 6 + @nPatternCount

		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 7 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536 WHERE patternid = 8 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Star'
			        , numdesigns = 1
			        , design_1 = 4215812 WHERE patternid = 9 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Pyramid'
			        , numdesigns = 3
			        , design_1 = 17593104
			        , design_2 = 8796552
			        , design_3 = 4398276 WHERE patternid = 10 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Steps'
			        , numdesigns = 2
			        , design_1 = 3355408
			        , design_2 = 17576131 WHERE patternid = 11 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Chichen Itza'
			        , numdesigns = 1
			        , design_1 = 29430876 WHERE patternid = 12 + @nPatternCount


		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[MayaMoney_GameSettings]
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

/****** Object:  StoredProcedure [dbo].[usp_config_mayamoney_ConfigureTables_87_1000X_RNG_GLI]    Script Date: 09/15/2015 11:25:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_mayamoney_ConfigureTables_87_1000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_87_1000X_RNG_GLI]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_mayamoney_ConfigureTables_87_1000X_RNG_GLI]    Script Date: 09/15/2015 11:25:36 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_87_1000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_mayamoney_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_mayamoney_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE MayaMoney_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 1
			        , payunit_patt_3 = 2
			        , payunit_patt_4 = 2
			        , payunit_patt_5 = 3
			        , payunit_patt_6 = 5
			        , payunit_patt_7 = 5
			        , payunit_patt_8 = 8
			        , payunit_patt_9 = 8
			        , payunit_patt_10 = 12
			        , payunit_patt_11 = 40
			        , payunit_patt_12 = 100

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_mayamoney_CreateGamePatternTable

	UPDATE MayaMoney_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Crazy Corner'
			        , numdesigns = 4
			        , design_1 = 35
		            , design_2 = 3178496
		            , design_3 = 25690112 
		            , design_4 = 536 WHERE patternid = 1 + @nPatternCount

		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Tiny Pyramid'
			        , numdesigns = 3
			        , design_1 = 4292
		                        , design_2 = 137344
		                        , design_3 = 4395008 WHERE patternid = 2 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Arrowhead'
			        , numdesigns = 2
			        , design_1 = 4234
		            , design_2 = 10620928 WHERE patternid = 3 + @nPatternCount

		UPDATE MayaMoney_GamePatterns
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
			        , design_12	= 1118480 WHERE patternid = 4 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 5 + @nPatternCount

		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 6 + @nPatternCount

		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 7 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536 WHERE patternid = 8 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Star'
			        , numdesigns = 1
			        , design_1 = 4215812 WHERE patternid = 9 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Pyramid'
			        , numdesigns = 3
			        , design_1 = 17593104
			        , design_2 = 8796552
			        , design_3 = 4398276 WHERE patternid = 10 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Steps'
			        , numdesigns = 2
			        , design_1 = 3355408
			        , design_2 = 17576131 WHERE patternid = 11 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Chichen Itza'
			        , numdesigns = 1
			        , design_1 = 29430876 WHERE patternid = 12 + @nPatternCount


		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[MayaMoney_GameSettings]
		SET
			-- 87%, $250 Prize Cap, Uniform Ball Distribution
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
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_mayamoney_ConfigureTables_87_20000X_RNG]    Script Date: 09/15/2015 11:25:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_mayamoney_ConfigureTables_87_20000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_87_20000X_RNG]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_mayamoney_ConfigureTables_87_20000X_RNG]    Script Date: 09/15/2015 11:25:41 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_87_20000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_mayamoney_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_mayamoney_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE MayaMoney_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 2
			        , payunit_patt_3 = 3
			        , payunit_patt_4 = 4
			        , payunit_patt_5 = 10
			        , payunit_patt_6 = 10
			        , payunit_patt_7 = 10
			        , payunit_patt_8 = 10
			        , payunit_patt_9 = 200
			        , payunit_patt_10 = 300
			        , payunit_patt_11 = 1000
			        , payunit_patt_12 = 2000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_mayamoney_CreateGamePatternTable

	UPDATE MayaMoney_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Tiny Pyramid'
			        , numdesigns = 3
			        , design_1 = 4292
		                        , design_2 = 137344
		                        , design_3 = 4395008 WHERE patternid = 1 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
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
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Any Six Pack'
			        , numdesigns = 24
			        , design_1 = 231
			        , design_2 = 7392
			        , design_3 = 236544
			        , design_4 = 7569408
			        , design_5 = 462
			        , design_6 = 14784
			        , design_7 = 473088
			        , design_8 = 15138816
			        , design_9 = 924
			        , design_10 = 29568
			        , design_11 = 946176
			        , design_12 = 30277632
			        , design_13 = 3171
			        , design_14 = 101472
			        , design_15 = 3247104
			        , design_16 = 6342
			        , design_17 = 202944
			        , design_18 = 6494208
			        , design_19 = 12684
			        , design_20 = 405888
			        , design_21 = 12988416
			        , design_22 = 25368
			        , design_23 = 811776
			        , design_24 = 25976832 WHERE patternid = 4 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 5 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 6 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536 WHERE patternid = 7 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Star'
			        , numdesigns = 1
			        , design_1 = 4215812 WHERE patternid = 8 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Pyramid'
			        , numdesigns = 3
			        , design_1 = 17593104
			        , design_2 = 8796552
			        , design_3 = 4398276 WHERE patternid = 9 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Steps'
			        , numdesigns = 2
			        , design_1 = 3355408
			        , design_2 = 17576131 WHERE patternid = 10 + @nPatternCount

		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Flying Saucer'
			        , numdesigns = 1
			        , design_1 = 4658628 WHERE patternid = 11 + @nPatternCount

		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Sun'
			        , numdesigns = 1
			        , design_1 = 11375466 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[MayaMoney_GameSettings]
		SET
			-- 87%, $500 Prize Cap, Uniform Ball Distribution
			[maxcalls] = 24,
			[mathmodel_denom_1_percent] = 87.00, 
			[mathmodel_denom_5_percent] = 87.00, 
			[mathmodel_denom_10_percent] = 87.00, 
			[mathmodel_denom_25_percent] = 87.00, 
			[mathmodel_denom_50_percent] = 87.00, 
			[mathmodel_denom_100_percent] = 87.00, 
			[mathmodel_denom_200_percent] = 87.00, 
			[mathmodel_denom_500_percent] = 87.00, 
			[mathmodel_denom_1_prizecap] = 500.00, 
			[mathmodel_denom_5_prizecap] = 500.00, 
			[mathmodel_denom_10_prizecap] = 500.00, 
			[mathmodel_denom_25_prizecap] = 500.00, 
			[mathmodel_denom_50_prizecap] = 500.00, 
			[mathmodel_denom_100_prizecap] = 500.00, 
			[mathmodel_denom_200_prizecap] = 500.00, 
			[mathmodel_denom_500_prizecap] = 500.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO


USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_mayamoney_ConfigureTables_Demo]    Script Date: 09/15/2015 11:25:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_mayamoney_ConfigureTables_Demo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_Demo]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_mayamoney_ConfigureTables_Demo]    Script Date: 09/15/2015 11:25:47 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_mayamoney_ConfigureTables_Demo]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_mayamoney_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_mayamoney_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE MayaMoney_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 2
			        , payunit_patt_3 = 2
			        , payunit_patt_4 = 2
			        , payunit_patt_5 = 4
			        , payunit_patt_6 = 4
			        , payunit_patt_7 = 10
			        , payunit_patt_8 = 20
			        , payunit_patt_9 = 20
			        , payunit_patt_10 = 40
			        , payunit_patt_11 = 80
			        , payunit_patt_12 = 100

		SET @nDenomCount = @nDenomCount + 1
		END


	-- setup and configure game patterns
	EXECUTE usp_setup_mayamoney_CreateGamePatternTable

	UPDATE MayaMoney_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Block of Four'
			        , numdesigns = 16
			        , design_1	= 99
			        , design_2	= 3168
			        , design_3	= 101376
	   		        , design_4	= 3244032
			        , design_5	= 198
			        , design_6	= 6336
			        , design_7	= 202752
			        , design_8	= 6488064
			        , design_9	= 396
			        , design_10	= 12672
			        , design_11	= 405504
			        , design_12	= 12976128
			        , design_13	= 792
			        , design_14	= 25344
			        , design_15	= 811008
			        , design_16	= 25952256 WHERE patternid = 1 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Vertical Lines'
			        , numdesigns = 5
			        , design_1 = 31
			        , design_2 = 992
			        , design_3 = 31744
			        , design_4 = 1015808
			        , design_5 = 32505856 WHERE patternid = 2 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Horiz Lines'
			        , numdesigns = 5
			        , design_1 = 1082401
			        , design_2 = 2164802
			        , design_3 = 4329604
			        , design_4 = 8659208
			        , design_5 = 17318416 WHERE patternid = 3 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Diagonals'
			        , numdesigns = 2
			        , design_1 = 17043521
			        , design_2 = 1118480 WHERE patternid = 4 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536 WHERE patternid = 5 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 6 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 7 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Large X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 8 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Stairs'
			        , numdesigns = 2
			        , design_1 = 80128
			        , design_2 = 276544 WHERE patternid = 9 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Spear'
			        , numdesigns = 15
			        , design_1 = 7
			        , design_2 = 224
			        , design_3 = 7168
			        , design_4 = 229376
			        , design_5 = 7340032
			        , design_6 = 14
			        , design_7 = 448
			        , design_8 = 14336
			        , design_9 = 458752
			        , design_10 = 14680064
			        , design_11 = 28
			        , design_12 = 896
			        , design_13 =28672
			        , design_14 = 917504
			        , design_15 = 29360128 WHERE patternid = 10 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Sundial'
			        , numdesigns = 8
			        , design_1 = 7168
			        , design_2 = 1118208
			        , design_3 = 4329472
			        , design_4 = 17043456
			        , design_5 = 28672
			        , design_6 = 4368
			        , design_7 = 4228
			        , design_8 = 4161 WHERE patternid = 11 + @nPatternCount
	
		UPDATE MayaMoney_GamePatterns
			SET patternname = 'Lrg Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 12 + @nPatternCount


		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[MayaMoney_GameSettings]
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

















