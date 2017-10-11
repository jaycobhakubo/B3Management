USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_60_1000X_1000X_55455]    Script Date: 09/15/2015 11:35:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildball_ConfigureTables_60_1000X_1000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_60_1000X_1000X_55455]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_60_1000X_1000X_55455]    Script Date: 09/15/2015 11:35:38 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_60_1000X_1000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_wildball_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE usp_setup_wildball_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 5
			        , payunit_patt_3 = 5
			        , payunit_patt_4 = 25
			        , payunit_patt_5 = 25
			        , payunit_patt_6 = 50
			        , payunit_patt_7 = 75
			        , payunit_patt_8 = 150
			        , payunit_patt_9 = 300
			        , payunit_patt_10 = 500
			        , payunit_patt_11 = 500
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the bonus pay table
	EXECUTE usp_setup_wildball_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_BonusPayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 5
			        , payunit_patt_3 = 5
			        , payunit_patt_4 = 25
			        , payunit_patt_5 = 25
			        , payunit_patt_6 = 50
			        , payunit_patt_7 = 75
			        , payunit_patt_8 = 150
			        , payunit_patt_9 = 300
			        , payunit_patt_10 = 500
			        , payunit_patt_11 = 500
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_wildball_CreateGamePatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_GamePatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount

		UPDATE WildBall_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 3 + @nPatternCount

		UPDATE WildBall_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 4 + @nPatternCount

		UPDATE WildBall_GamePatterns
			SET patternname = 'Star'
			        , numdesigns = 1
			        , design_1 = 4215812 WHERE patternid = 5 + @nPatternCount

		UPDATE WildBall_GamePatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 6 + @nPatternCount

		UPDATE WildBall_GamePatterns
			SET patternname = 'Chute'
			        , numdesigns = 2
			        , design_1 = 2271880
			        , design_2 = 9054370 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_wildball_CreateBonusPatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_BonusPatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Star'
			        , numdesigns = 1
			        , design_1 = 4215812 WHERE patternid = 5 + @nPatternCount

		UPDATE WildBall_BonusPatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Chute'
			        , numdesigns = 2
			        , design_1 = 2271880
			        , design_2 = 9054370 WHERE patternid = 7 + @nPatternCount

		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildBall_GameSettings]
		SET
			-- 60%, $250 Prize Cap, 55455 and 11211 Ball Distribution
			[mathmodel_denom_1_percent] = 60.00, 
			[mathmodel_denom_5_percent] = 60.00, 
			[mathmodel_denom_10_percent] = 60.00, 
			[mathmodel_denom_25_percent] = 60.00, 
			[mathmodel_denom_50_percent] = 60.00, 
			[mathmodel_denom_100_percent] = 60.00, 
			[mathmodel_denom_200_percent] = 60.00, 
			[mathmodel_denom_500_percent] = 60.00, 
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

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_60_5000X_5000X_55455]    Script Date: 09/15/2015 11:35:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildball_ConfigureTables_60_5000X_5000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_60_5000X_5000X_55455]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_60_5000X_5000X_55455]    Script Date: 09/15/2015 11:35:41 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_60_5000X_5000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_wildball_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE usp_setup_wildball_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 5
			        , payunit_patt_3 = 5
			        , payunit_patt_4 = 25
			        , payunit_patt_5 = 25
			        , payunit_patt_6 = 50
			        , payunit_patt_7 = 75
			        , payunit_patt_8 = 100
			        , payunit_patt_9 = 200
			        , payunit_patt_10 = 400
			        , payunit_patt_11 = 1000
			        , payunit_patt_12 = 5000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the bonus pay table
	EXECUTE usp_setup_wildball_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_BonusPayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 5
			        , payunit_patt_3 = 5
			        , payunit_patt_4 = 25
			        , payunit_patt_5 = 25
			        , payunit_patt_6 = 50
			        , payunit_patt_7 = 75
			        , payunit_patt_8 = 100
			        , payunit_patt_9 = 200
			        , payunit_patt_10 = 400
			        , payunit_patt_11 = 1000
			        , payunit_patt_12 = 5000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_wildball_CreateGamePatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_GamePatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount

		UPDATE WildBall_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Star'
			        , numdesigns = 1 
					, design_1 = 4215812 WHERE patternid = 5 + @nPatternCount

		UPDATE WildBall_GamePatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Chute'
			        , numdesigns = 2
			        , design_1 = 2271880
			        , design_2 = 9054370 WHERE patternid = 7 + @nPatternCount

		UPDATE WildBall_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_wildball_CreateBonusPatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_BonusPatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount

		UPDATE WildBall_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Star'
			        , numdesigns = 1 
					, design_1 = 4215812 WHERE patternid = 5 + @nPatternCount

		UPDATE WildBall_BonusPatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Chute'
			        , numdesigns = 2
			        , design_1 = 2271880
			        , design_2 = 9054370 WHERE patternid = 7 + @nPatternCount

		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET  @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildBall_GameSettings]
		SET
			-- 60%, $1250 Prize Cap, 55455 and 11211 Ball Distribution
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

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_82_5000X_10000X_RNG]    Script Date: 09/15/2015 11:35:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildball_ConfigureTables_82_5000X_10000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_82_5000X_10000X_RNG]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_82_5000X_10000X_RNG]    Script Date: 09/15/2015 11:35:49 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_82_5000X_10000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_wildball_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE usp_setup_wildball_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 10
			        , payunit_patt_5 = 10
			        , payunit_patt_6 = 10
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 500
			        , payunit_patt_9 = 500
			        , payunit_patt_10 = 1000
			        , payunit_patt_11 = 1000
			        , payunit_patt_12 = 5000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the bonus pay table
	EXECUTE usp_setup_wildball_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_BonusPayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 20
			        , payunit_patt_5 = 20
			        , payunit_patt_6 = 20
			        , payunit_patt_7 = 200
			        , payunit_patt_8 = 1000
			        , payunit_patt_9 = 1000
			        , payunit_patt_10 = 2000
			        , payunit_patt_11 = 2000
			        , payunit_patt_12 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_wildball_CreateGamePatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_GamePatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_wildball_CreateBonusPatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_BonusPatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildBall_GameSettings]
		SET
			-- 82%, $2500 Prize Cap, Uniform Ball Distribution
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

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_82_10000X_20000X_RNG_GLI]    Script Date: 09/15/2015 11:35:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildball_ConfigureTables_82_10000X_20000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_82_10000X_20000X_RNG_GLI]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_82_10000X_20000X_RNG_GLI]    Script Date: 09/15/2015 11:35:44 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_82_10000X_20000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_wildball_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE usp_setup_wildball_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 10
			        , payunit_patt_5 = 10
			        , payunit_patt_6 = 10
			        , payunit_patt_7 = 40
			        , payunit_patt_8 = 200
			        , payunit_patt_9 = 200
			        , payunit_patt_10 = 2000
			        , payunit_patt_11 = 2000
			        , payunit_patt_12 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the bonus pay table
	EXECUTE usp_setup_wildball_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_BonusPayTable
			SET payunit_patt_1 = 8
			        , payunit_patt_2 = 16
			        , payunit_patt_3 = 16
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 40
			        , payunit_patt_6 = 40
			        , payunit_patt_7 = 80
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 4000
			        , payunit_patt_11 = 4000
			        , payunit_patt_12 = 20000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_wildball_CreateGamePatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_GamePatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 17530576 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_wildball_CreateBonusPatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_BonusPatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 17530576 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildBall_GameSettings]
		SET
			-- 82%, $5000 Prize Cap, Uniform Ball Distribution GLI
			[mathmodel_denom_1_percent] = 82.00, 
			[mathmodel_denom_5_percent] = 82.00, 
			[mathmodel_denom_10_percent] = 82.00, 
			[mathmodel_denom_25_percent] = 82.00, 
			[mathmodel_denom_50_percent] = 82.00, 
			[mathmodel_denom_100_percent] = 82.00, 
			[mathmodel_denom_200_percent] = 82.00, 
			[mathmodel_denom_500_percent] = 82.00, 
			[mathmodel_denom_1_prizecap] = 5000.00, 
			[mathmodel_denom_5_prizecap] = 5000.00, 
			[mathmodel_denom_10_prizecap] = 5000.00, 
			[mathmodel_denom_25_prizecap] = 5000.00, 
			[mathmodel_denom_50_prizecap] = 5000.00, 
			[mathmodel_denom_100_prizecap] = 5000.00, 
			[mathmodel_denom_200_prizecap] = 5000.00, 
			[mathmodel_denom_500_prizecap] = 5000.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED GLI',
			[autocall] = 'T';
GO


USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_84_1000X_1000X_RNG]    Script Date: 09/15/2015 11:35:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildball_ConfigureTables_84_1000X_1000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_84_1000X_1000X_RNG]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_84_1000X_1000X_RNG]    Script Date: 09/15/2015 11:35:56 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_84_1000X_1000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE b3.dbo.usp_setup_wildball_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE b3.dbo.usp_setup_wildball_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 12
			        , payunit_patt_5 = 12
			        , payunit_patt_6 = 12
			        , payunit_patt_7 = 60
			        , payunit_patt_8 = 100
			        , payunit_patt_9 = 100
			        , payunit_patt_10 = 400
			        , payunit_patt_11 = 400
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the bonus pay table
	EXECUTE b3.dbo.usp_setup_wildball_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_BonusPayTable
			SET payunit_patt_1 = 8
			        , payunit_patt_2 = 20
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 40
			        , payunit_patt_6 = 40
			        , payunit_patt_7 = 200
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 600
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE b3.dbo.usp_setup_wildball_CreateGamePatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_GamePatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE b3.dbo.usp_setup_wildball_CreateBonusPatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_BonusPatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
		        	        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildBall_GameSettings]
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

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_84_10000X_20000X_RNG_GLI]    Script Date: 09/15/2015 11:35:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildball_ConfigureTables_84_10000X_20000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_84_10000X_20000X_RNG_GLI]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_84_10000X_20000X_RNG_GLI]    Script Date: 09/15/2015 11:35:53 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_84_10000X_20000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_wildball_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE usp_setup_wildball_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 10
			        , payunit_patt_5 = 10
			        , payunit_patt_6 = 10
			        , payunit_patt_7 = 50
			        , payunit_patt_8 = 200
			        , payunit_patt_9 = 200
			        , payunit_patt_10 = 2500
			        , payunit_patt_11 = 2500
			        , payunit_patt_12 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the bonus pay table
	EXECUTE usp_setup_wildball_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_BonusPayTable
			SET payunit_patt_1 = 8
			        , payunit_patt_2 = 16
			        , payunit_patt_3 = 16
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 40
			        , payunit_patt_6 = 40
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 5000
			        , payunit_patt_11 = 5000
			        , payunit_patt_12 = 20000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_wildball_CreateGamePatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_GamePatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 17530576 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_wildball_CreateBonusPatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_BonusPatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 17530576 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildBall_GameSettings]
		SET
			-- 84%, $5000 Prize Cap, Uniform Ball Distribution GLI
			[mathmodel_denom_1_percent] = 84.00, 
			[mathmodel_denom_5_percent] = 84.00, 
			[mathmodel_denom_10_percent] = 84.00, 
			[mathmodel_denom_25_percent] = 84.00, 
			[mathmodel_denom_50_percent] = 84.00, 
			[mathmodel_denom_100_percent] = 84.00, 
			[mathmodel_denom_200_percent] = 84.00, 
			[mathmodel_denom_500_percent] = 84.00, 
			[mathmodel_denom_1_prizecap] = 5000.00, 
			[mathmodel_denom_5_prizecap] = 5000.00, 
			[mathmodel_denom_10_prizecap] = 5000.00, 
			[mathmodel_denom_25_prizecap] = 5000.00, 
			[mathmodel_denom_50_prizecap] = 5000.00, 
			[mathmodel_denom_100_prizecap] = 5000.00, 
			[mathmodel_denom_200_prizecap] = 5000.00, 
			[mathmodel_denom_500_prizecap] = 5000.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED GLI',
			[autocall] = 'T';
GO


USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_87_250X_55455]    Script Date: 09/15/2015 11:36:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildball_ConfigureTables_87_250X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_87_250X_55455]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_87_250X_55455]    Script Date: 09/15/2015 11:36:17 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_87_250X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE b3.dbo.usp_setup_wildball_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE b3.dbo.usp_setup_wildball_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 10
			        , payunit_patt_5 = 10
			        , payunit_patt_6 = 25
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 125
			        , payunit_patt_9 = 150
			        , payunit_patt_10 = 175
			        , payunit_patt_11 = 200
			        , payunit_patt_12 = 250

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the bonus pay table
	EXECUTE b3.dbo.usp_setup_wildball_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_BonusPayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 25
			        , payunit_patt_5 = 25
			        , payunit_patt_6 = 50
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 250
			        , payunit_patt_9 = 250
			        , payunit_patt_10 = 250
			        , payunit_patt_11 = 250
			        , payunit_patt_12 = 250

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE b3.dbo.usp_setup_wildball_CreateGamePatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	UPDATE WildBall_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_GamePatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE b3.dbo.usp_setup_wildball_CreateBonusPatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_BonusPatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildBall_GameSettings]
		SET
			-- 87%, $62.50 Prize Cap, 55455 and 11211 Ball Distribution
			[mathmodel_denom_1_percent] = 87.00, 
			[mathmodel_denom_5_percent] = 87.00, 
			[mathmodel_denom_10_percent] = 87.00, 
			[mathmodel_denom_25_percent] = 87.00, 
			[mathmodel_denom_50_percent] = 87.00, 
			[mathmodel_denom_100_percent] = 87.00, 
			[mathmodel_denom_200_percent] = 87.00, 
			[mathmodel_denom_500_percent] = 87.00, 
			[mathmodel_denom_1_prizecap] = 62.50, 
			[mathmodel_denom_5_prizecap] = 62.50, 
			[mathmodel_denom_10_prizecap] = 62.50, 
			[mathmodel_denom_25_prizecap] = 62.50, 
			[mathmodel_denom_50_prizecap] = 62.50, 
			[mathmodel_denom_100_prizecap] = 62.50, 
			[mathmodel_denom_200_prizecap] = 62.50, 
			[mathmodel_denom_500_prizecap] = 62.50, 
			[mathmodel_balldistrib] = '55455',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'F';
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_87_1000X_1000X_55455]    Script Date: 09/15/2015 11:36:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildball_ConfigureTables_87_1000X_1000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_87_1000X_1000X_55455]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_87_1000X_1000X_55455]    Script Date: 09/15/2015 11:36:05 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_87_1000X_1000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_wildball_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE usp_setup_wildball_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 12
			        , payunit_patt_5 = 12
			        , payunit_patt_6 = 20
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 200
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 800
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the bonus pay table
	EXECUTE usp_setup_wildball_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_BonusPayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 24
			        , payunit_patt_5 = 24
			        , payunit_patt_6 = 40
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 200
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 800
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_wildball_CreateGamePatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_GamePatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_wildball_CreateBonusPatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_BonusPatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildBall_GameSettings]
		SET
			-- 87%, $250 Prize Cap, 55455 and 11211 Ball Distribution
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

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_87_1000X_1000X_55455_SingleOfferBonus]    Script Date: 09/15/2015 11:36:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildball_ConfigureTables_87_1000X_1000X_55455_SingleOfferBonus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_87_1000X_1000X_55455_SingleOfferBonus]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_87_1000X_1000X_55455_SingleOfferBonus]    Script Date: 09/15/2015 11:36:09 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_87_1000X_1000X_55455_SingleOfferBonus]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_wildball_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE usp_setup_wildball_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 3
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 10
			        , payunit_patt_5 = 10
			        , payunit_patt_6 = 20
			        , payunit_patt_7 = 40
			        , payunit_patt_8 = 100
			        , payunit_patt_9 = 100
			        , payunit_patt_10 = 200
			        , payunit_patt_11 = 400
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the bonus pay table
	EXECUTE usp_setup_wildball_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_BonusPayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 10
			        , payunit_patt_3 = 10
			        , payunit_patt_4 = 100
			        , payunit_patt_5 = 100
			        , payunit_patt_6 = 100
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 1000
			        , payunit_patt_9 = 1000
			        , payunit_patt_10 = 1000
			        , payunit_patt_11 = 1000
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_wildball_CreateGamePatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_GamePatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_wildball_CreateBonusPatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Spark'
			        , numdesigns = 1
			        , design_1 = 4096 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildBall_GameSettings]
		SET
			-- 87%, $250 Prize Cap, 55455 and 11211 Ball Distribution, Single Offer Bonus Round
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
			[mathmodel_typedesc] = 'UNVARIED SO',
			[autocall] = 'F';
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_87_1000X_1000X_RNG]    Script Date: 09/15/2015 11:36:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildball_ConfigureTables_87_1000X_1000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_87_1000X_1000X_RNG]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_87_1000X_1000X_RNG]    Script Date: 09/15/2015 11:36:13 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_87_1000X_1000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_wildball_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE usp_setup_wildball_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 12
			        , payunit_patt_5 = 12
			        , payunit_patt_6 = 12
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 200
			        , payunit_patt_9 = 200
			        , payunit_patt_10 = 400
			        , payunit_patt_11 = 400
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the bonus pay table
	EXECUTE usp_setup_wildball_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_BonusPayTable
			SET payunit_patt_1 = 12
			        , payunit_patt_2 = 20
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 40
			        , payunit_patt_6 = 40
			        , payunit_patt_7 = 200
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 600
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_wildball_CreateGamePatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_GamePatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_wildball_CreateBonusPatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_BonusPatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildBall_GameSettings]
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

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_87_5000X_5000X_55455]    Script Date: 09/15/2015 11:36:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildball_ConfigureTables_87_5000X_5000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_87_5000X_5000X_55455]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_87_5000X_5000X_55455]    Script Date: 09/15/2015 11:36:22 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_87_5000X_5000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_wildball_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE usp_setup_wildball_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 10
			        , payunit_patt_5 = 10
			        , payunit_patt_6 = 20
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 200
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 1000
			        , payunit_patt_11 = 2000
			        , payunit_patt_12 = 5000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the bonus pay table
	EXECUTE usp_setup_wildball_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_BonusPayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 20
			        , payunit_patt_5 = 20
			        , payunit_patt_6 = 40
			        , payunit_patt_7 = 160
			        , payunit_patt_8 = 320
			        , payunit_patt_9 = 600
			        , payunit_patt_10 = 1500
			        , payunit_patt_11 = 3000
			        , payunit_patt_12 = 5000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_wildball_CreateGamePatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_GamePatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_wildball_CreateBonusPatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_BonusPatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET  @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildBall_GameSettings]
		SET
			-- 87%, $1250 Prize Cap, 55455 and 11211 Ball Distribution
			[mathmodel_denom_1_percent] = 87.00, 
			[mathmodel_denom_5_percent] = 87.00, 
			[mathmodel_denom_10_percent] = 87.00, 
			[mathmodel_denom_25_percent] = 87.00, 
			[mathmodel_denom_50_percent] = 87.00, 
			[mathmodel_denom_100_percent] = 87.00, 
			[mathmodel_denom_200_percent] = 87.00, 
			[mathmodel_denom_500_percent] = 87.00, 
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

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_87_10000X_20000X_RNG_GLI]    Script Date: 09/15/2015 11:36:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildball_ConfigureTables_87_10000X_20000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_87_10000X_20000X_RNG_GLI]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildball_ConfigureTables_87_10000X_20000X_RNG_GLI]    Script Date: 09/15/2015 11:36:01 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_87_10000X_20000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_wildball_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE usp_setup_wildball_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 10
			        , payunit_patt_5 = 10
			        , payunit_patt_6 = 10
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 250
			        , payunit_patt_9 = 250
			        , payunit_patt_10 = 2500
			        , payunit_patt_11 = 2500
			        , payunit_patt_12 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the bonus pay table
	EXECUTE usp_setup_wildball_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_BonusPayTable
			SET payunit_patt_1 = 8
			        , payunit_patt_2 = 16
			        , payunit_patt_3 = 16
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 40
			        , payunit_patt_6 = 40
			        , payunit_patt_7 = 200
			        , payunit_patt_8 = 500
			        , payunit_patt_9 = 500
			        , payunit_patt_10 = 5000
			        , payunit_patt_11 = 5000
			        , payunit_patt_12 = 20000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_wildball_CreateGamePatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_GamePatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 17530576 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount +12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_wildball_CreateBonusPatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_BonusPatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 17530576 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildBall_GameSettings]
		SET
			-- 87%, $5000 Prize Cap, Uniform Ball Distribution GLI
			[mathmodel_denom_1_percent] = 87.00, 
			[mathmodel_denom_5_percent] = 87.00, 
			[mathmodel_denom_10_percent] = 87.00, 
			[mathmodel_denom_25_percent] = 87.00, 
			[mathmodel_denom_50_percent] = 87.00, 
			[mathmodel_denom_100_percent] = 87.00, 
			[mathmodel_denom_200_percent] = 87.00, 
			[mathmodel_denom_500_percent] = 87.00, 
			[mathmodel_denom_1_prizecap] = 5000.00, 
			[mathmodel_denom_5_prizecap] = 5000.00, 
			[mathmodel_denom_10_prizecap] = 5000.00, 
			[mathmodel_denom_25_prizecap] = 5000.00, 
			[mathmodel_denom_50_prizecap] = 5000.00, 
			[mathmodel_denom_100_prizecap] = 5000.00, 
			[mathmodel_denom_200_prizecap] = 5000.00, 
			[mathmodel_denom_500_prizecap] = 5000.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED GLI',
			[autocall] = 'T';
GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildball_ConfigureTables_82_5000X_10000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_82_5000X_10000X_RNG_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildball_ConfigureTables_82_5000X_10000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_wildball_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE usp_setup_wildball_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 10
			        , payunit_patt_5 = 10
			        , payunit_patt_6 = 10
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 500
			        , payunit_patt_9 = 500
			        , payunit_patt_10 = 1000
			        , payunit_patt_11 = 1000
			        , payunit_patt_12 = 5000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the bonus pay table
	EXECUTE usp_setup_wildball_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE WildBall_BonusPayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 20
			        , payunit_patt_5 = 20
			        , payunit_patt_6 = 20
			        , payunit_patt_7 = 200
			        , payunit_patt_8 = 1000
			        , payunit_patt_9 = 1000
			        , payunit_patt_10 = 2000
			        , payunit_patt_11 = 2000
			        , payunit_patt_12 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_wildball_CreateGamePatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_GamePatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_GamePatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_wildball_CreateBonusPatternTable

	UPDATE WildBall_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE WildBall_BonusPatterns
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
			        , design_12	= 1118480 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Six Pack'
			        , numdesigns = 24
			        , design_1	= 3171
			        , design_2	= 101472 
			        , design_3	= 3247104
	   		        , design_4	= 6342
			        , design_5	= 202944
			        , design_6	= 6494208
			        , design_7	= 12684
			        , design_8	= 405888
			        , design_9	= 12988416
			        , design_10	= 25368
			        , design_11	= 811776
			        , design_12	= 25976832
			        , design_13	= 231
			        , design_14	= 7392
			        , design_15	= 236544
			        , design_16	= 7569408
			        , design_17	= 462
			        , design_18	= 14784
			        , design_19	= 473088
			        , design_20	= 15138816
			        , design_21	= 924
			        , design_22	= 29568
			        , design_23	= 946176
			        , design_24	= 30277632 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Small X'
			        , numdesigns = 1
			        , design_1 = 332096 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536  WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Block of 9'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'TNT'
			        , numdesigns = 2
			        , design_1 = 1113121
			        , design_2 = 32772191 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Candles'
			        , numdesigns = 1
			        , design_1 = 27292698 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildBall_BonusPatterns
			SET patternname = 'Fire Hydrant'
			        , numdesigns = 1
			        , design_1 = 753344 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildBall_GameSettings]
		SET
			-- 82%, $2500 Prize Cap, Uniform Ball Distribution
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












