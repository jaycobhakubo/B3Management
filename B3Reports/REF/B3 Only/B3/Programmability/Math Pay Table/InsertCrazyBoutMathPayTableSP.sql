-- =========================
-- usp_config_crazybout_ConfigureTables_Demo (1)
-- ==========================
USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_crazybout_ConfigureTables_Demo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_Demo]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_Demo]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_crazybout_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_crazybout_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_GamePayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 2
			        , payunit_patt_3 = 2
			        , payunit_patt_4 = 2
			        , payunit_patt_5 = 5
			        , payunit_patt_6 = 5
			        , payunit_patt_7 = 40
			        , payunit_patt_8 = 60
			        , payunit_patt_9 = 60
			        , payunit_patt_10 = 80
			        , payunit_patt_11 = 160
			        , payunit_patt_12 = 250

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_crazybout_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_BonusPayTable
			SET payunit_patt_1 = 1
			        , payunit_patt_2 = 2
			        , payunit_patt_3 = 2
			        , payunit_patt_4 = 2
			        , payunit_patt_5 = 5
			        , payunit_patt_6 = 5
			        , payunit_patt_7 = 40
			        , payunit_patt_8 = 60
			        , payunit_patt_9 = 60
			        , payunit_patt_10 = 80
			        , payunit_patt_11 = 160
			        , payunit_patt_12 = 250

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_crazybout_CreateGamePatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of Four'
			        , bonustrigger = 'F'
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
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Vertical Lines'
			        , bonustrigger = 'F'
			        , numdesigns = 5
			        , design_1 = 31
			        , design_2 = 992
			        , design_3 = 31744
			        , design_4 = 1015808
			        , design_5 = 32505856 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Horiz Lines'
			        , bonustrigger = 'T'
			        , numdesigns = 5
			        , design_1 = 1082401
			        , design_2 = 2164802
			        , design_3 = 4329604
			        , design_4 = 8659208
			        , design_5 = 17318416 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Diagonals'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 17043521
			        , design_2 = 1118480 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Flower'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 145536 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Corners'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of Nine'
			        , bonustrigger = 'F'
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
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Letter X'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Lrg Diamond'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy T'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1113121
			        , design_2 = 32641156
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy L'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Bow Tie'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 32837983 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_crazybout_CreateBonusPatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Vertical Lines'
			        , numdesigns = 5
			        , design_1 = 31
			        , design_2 = 992
			        , design_3 = 31744
			        , design_4 = 1015808
			        , design_5 = 32505856 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Horiz Lines'
			        , numdesigns = 5
			        , design_1 = 1082401
			        , design_2 = 2164802
			        , design_3 = 4329604
			        , design_4 = 8659208
			        , design_5 = 17318416 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Diagonals'
			        , numdesigns = 2
			        , design_1 = 17043521
			        , design_2 = 1118480 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Block of Nine'
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Lrg Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121
			        , design_2 = 32641156
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy L'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Bow Tie'
			        , numdesigns = 1
			        , design_1 = 32837983 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount =  @nPatternCount + 12
		END

	UPDATE
		[CrazyBout_GameSettings]
		SET
			-- High Payout for Demonstration Purpose Only
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


-- ===============================
-- usp_config_crazybout_ConfigureTables_87_10000X_20000X_RNG_GLI(2)
-- ================================
USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_crazybout_ConfigureTables_87_10000X_20000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_87_10000X_20000X_RNG_GLI]
GO

USE [B3]
GO


SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_87_10000X_20000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_crazybout_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_crazybout_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 100
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 1000
			        , payunit_patt_11 = 2500
			        , payunit_patt_12 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_crazybout_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_BonusPayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 40
			        , payunit_patt_4 = 80
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 400
			        , payunit_patt_7 = 800
			        , payunit_patt_8 = 800
			        , payunit_patt_9 = 800
			        , payunit_patt_10 = 2000
			        , payunit_patt_11 = 5000
			        , payunit_patt_12 = 20000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_crazybout_CreateGamePatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Any Line'
			        , bonustrigger = 'F'
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
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Corners'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Crazy Kite'
			        , bonustrigger = 'T'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of 9'
			        , bonustrigger = 'F'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy T'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Letter X'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Diamond'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy L'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Love Letter'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Brackets'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 28869179 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_crazybout_CreateBonusPatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Crazy Kite'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
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
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Frame'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy L'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Love Letter'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Brackets'
			        , numdesigns = 1
			        , design_1 = 28869179 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount =  @nPatternCount + 12
		END

	UPDATE
		[CrazyBout_GameSettings]
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


-- ========================================
-- usp_config_crazybout_ConfigureTables_87_5000X_5000X_55455(3)
-- =======================================

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_crazybout_ConfigureTables_87_5000X_5000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_87_5000X_5000X_55455]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_87_5000X_5000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_crazybout_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_crazybout_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 80
			        , payunit_patt_6 = 160
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 1000
			        , payunit_patt_10 = 1000
			        , payunit_patt_11 = 3000
			        , payunit_patt_12 = 5000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_crazybout_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_BonusPayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 40
			        , payunit_patt_4 = 80
			        , payunit_patt_5 = 160
			        , payunit_patt_6 = 320
			        , payunit_patt_7 = 600
			        , payunit_patt_8 = 600
			        , payunit_patt_9 = 1000
			        , payunit_patt_10 = 1000
			        , payunit_patt_11 = 3000
			        , payunit_patt_12 = 5000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_crazybout_CreateGamePatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Any Line'
			        , bonustrigger = 'F'
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
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Corners'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Crazy Kite'
			        , bonustrigger = 'T'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of 9'
			        , bonustrigger = 'F'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Letter X'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Diamond'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy T'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy L'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Love Letter'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_crazybout_CreateBonusPatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Crazy Kite'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
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
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Frame'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy L'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Love Letter'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Frame'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount =  @nPatternCount + 12
		END

	UPDATE
		[CrazyBout_GameSettings]
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

-- ==================================
-- usp_config_crazybout_ConfigureTables_87_1000X_1000X_RNG(4)
-- =================================
USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_crazybout_ConfigureTables_87_1000X_1000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_87_1000X_1000X_RNG]
GO

USE [B3]
GO
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_87_1000X_1000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_crazybout_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_crazybout_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 100
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 400
			        , payunit_patt_11 = 600
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_crazybout_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_BonusPayTable
			SET payunit_patt_1 = 20
			        , payunit_patt_2 = 40
			        , payunit_patt_3 = 100
			        , payunit_patt_4 = 120
			        , payunit_patt_5 = 160
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 400
			        , payunit_patt_11 = 600
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_crazybout_CreateGamePatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Any Line'
			        , bonustrigger = 'F'
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
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Corners'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Crazy Kite'
			        , bonustrigger = 'T'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of 9'
			        , bonustrigger = 'F'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy T'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Letter X'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Diamond'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy L'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Love Letter'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_crazybout_CreateBonusPatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Crazy Kite'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
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
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Frame'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy L'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Love Letter'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Frame'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount =  @nPatternCount + 12
		END

	UPDATE
		[CrazyBout_GameSettings]
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


-- ===================================
-- usp_config_crazybout_ConfigureTables_87_1000X_1000X_55455_SingleOfferBonus(5)
-- ===================================

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_crazybout_ConfigureTables_87_1000X_1000X_55455_SingleOfferBonus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_87_1000X_1000X_55455_SingleOfferBonus]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_87_1000X_1000X_55455_SingleOfferBonus]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_crazybout_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_crazybout_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_GamePayTable
			SET payunit_patt_1 = 3
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 10
			        , payunit_patt_5 = 20
			        , payunit_patt_6 = 50
			        , payunit_patt_7 = 75
			        , payunit_patt_8 = 125
			        , payunit_patt_9 = 200
			        , payunit_patt_10 = 300
			        , payunit_patt_11 = 400
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_crazybout_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_BonusPayTable
			SET payunit_patt_1 = 3
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 10
			        , payunit_patt_5 = 40
			        , payunit_patt_6 = 100
			        , payunit_patt_7 = 150
			        , payunit_patt_8 = 250
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 800
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_crazybout_CreateGamePatternTable

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_GameSettings 
			SET maxpatterns = 12, maxcalls = 24
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Any Line'
			        , bonustrigger = 'F'
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

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy V'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1118273
			        , design_2 = 18157568
			        , design_3 = 17043728
			        , design_4 = 4433 WHERE patternid = 2 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Up and Down'
			        , bonustrigger = 'T'
			        , numdesigns = 2
			        , design_1 = 4260932
			        , design_2 = 4473092 WHERE patternid = 4 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Crazy Kite'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 5 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of 9'
			        , bonustrigger = 'F'
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
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Letter X'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Diamond'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy T'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy L'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Love Letter'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_crazybout_CreateBonusPatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy V'
			        , numdesigns = 4
			        , design_1 = 1118273
			        , design_2 = 18157568
			        , design_3 = 17043728
			        , design_4 = 4433 WHERE patternid = 2 + @nPatternCount

		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Corner'
			        , numdesigns = 4
			        , design_1 = 1
			        , design_2 = 1048576
			        , design_3 = 16
			        , design_4 = 16777216 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Crazy Kite'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Frame'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy L'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Love Letter'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 12 + @nPatternCount
	
		SET @nPatternCount =  @nPatternCount + 12
		END

	UPDATE
		[CrazyBout_GameSettings]
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


-- ===================================
-- usp_config_crazybout_ConfigureTables_87_1000X_1000X_55455(6)
-- ===================================

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_crazybout_ConfigureTables_87_1000X_1000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_87_1000X_1000X_55455]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_87_1000X_1000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_crazybout_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_crazybout_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 600
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 800
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_crazybout_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_BonusPayTable
			SET payunit_patt_1 = 8
			        , payunit_patt_2 = 16
			        , payunit_patt_3 = 40
			        , payunit_patt_4 = 80
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 600
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 800
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_crazybout_CreateGamePatternTable

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_GameSettings 
			SET maxpatterns = 12, maxcalls = 24
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Any Line'
			        , bonustrigger = 'F'
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
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Corners'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Crazy Kite'
			        , bonustrigger = 'T'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of 9'
			        , bonustrigger = 'F'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Letter X'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Diamond'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy T'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy L'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Love Letter'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_crazybout_CreateBonusPatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Crazy Kite'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
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
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Frame'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy L'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Love Letter'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Frame'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount =  @nPatternCount + 12
		END

	UPDATE
		[CrazyBout_GameSettings]
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

-- ======================================
-- usp_config_crazybout_ConfigureTables_87_250X_250X_55455(7)
-- ======================================
USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_crazybout_ConfigureTables_87_250X_250X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_87_250X_250X_55455]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_87_250X_250X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE b3.dbo.usp_setup_crazybout_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE b3.dbo.usp_setup_crazybout_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 6
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 60
			        , payunit_patt_6 = 80
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 125
			        , payunit_patt_9 = 150
			        , payunit_patt_10 = 175
			        , payunit_patt_11 = 200
			        , payunit_patt_12 = 250

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE b3.dbo.usp_setup_crazybout_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_BonusPayTable
			SET payunit_patt_1 = 8
			        , payunit_patt_2 = 20
			        , payunit_patt_3 = 50
			        , payunit_patt_4 = 100
			        , payunit_patt_5 = 250
			        , payunit_patt_6 = 250
			        , payunit_patt_7 = 250
			        , payunit_patt_8 = 250
			        , payunit_patt_9 = 250
			        , payunit_patt_10 = 250
			        , payunit_patt_11 = 250
			        , payunit_patt_12 = 250

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE b3.dbo.usp_setup_crazybout_CreateGamePatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Any Line'
			        , bonustrigger = 'F'
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
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Corners'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Crazy Kite'
			        , bonustrigger = 'T'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of 9'
			        , bonustrigger = 'F'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Letter X'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Diamond'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy T'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy L'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Love Letter'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE b3.dbo.usp_setup_crazybout_CreateBonusPatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Crazy Kite'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
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
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Frame'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy L'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Love Letter'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Frame'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount =  @nPatternCount + 12
		END

	UPDATE
		[CrazyBout_GameSettings]
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

-- ================================
-- usp_config_crazybout_ConfigureTables_84_10000X_20000X_RNG_GLI(8)
-- ================================

USE [B3]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_crazybout_ConfigureTables_84_10000X_20000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_84_10000X_20000X_RNG_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_84_10000X_20000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_crazybout_CreateGameSettingsTable
	
	-- setup and configure game pay table
	EXECUTE usp_setup_crazybout_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 100
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 800
			        , payunit_patt_11 = 1500
			        , payunit_patt_12 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_crazybout_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_BonusPayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 40
			        , payunit_patt_4 = 80
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 400
			        , payunit_patt_7 = 800
			        , payunit_patt_8 = 800
			        , payunit_patt_9 = 800
			        , payunit_patt_10 = 1600
			        , payunit_patt_11 = 3000
			        , payunit_patt_12 = 20000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_crazybout_CreateGamePatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Any Line'
			        , bonustrigger = 'F'
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
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Corners'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Crazy Kite'
			        , bonustrigger = 'T'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of 9'
			        , bonustrigger = 'F'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy T'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Letter X'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Diamond'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy L'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Love Letter'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Brackets'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 28869179 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_crazybout_CreateBonusPatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Crazy Kite'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
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
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Frame'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy L'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Love Letter'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Brackets'
			        , numdesigns = 1
			        , design_1 = 28869179 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount =  @nPatternCount + 12
		END

	UPDATE
		[CrazyBout_GameSettings]
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

-- ===============================
-- usp_config_crazybout_ConfigureTables_84_1000X_1000X_RNG(9)
-- ===============================

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_crazybout_ConfigureTables_84_1000X_1000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_84_1000X_1000X_RNG]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_84_1000X_1000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE b3.dbo.usp_setup_crazybout_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_crazybout_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 100
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 400
			        , payunit_patt_11 = 600
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_crazybout_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_BonusPayTable
			SET payunit_patt_1 = 12
			        , payunit_patt_2 = 24
			        , payunit_patt_3 = 60
			        , payunit_patt_4 = 120
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 400
			        , payunit_patt_7 = 600
			        , payunit_patt_8 = 600
			        , payunit_patt_9 = 600
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 800
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_crazybout_CreateGamePatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Any Line'
			        , bonustrigger = 'F'
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
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Corners'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Crazy Kite'
			        , bonustrigger = 'T'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of 9'
			        , bonustrigger = 'F'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy T'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Letter X'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Diamond'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy L'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Love Letter'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_crazybout_CreateBonusPatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Crazy Kite'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
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
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Frame'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy L'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Love Letter'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Frame'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount =  @nPatternCount + 12
		END

	UPDATE
		[CrazyBout_GameSettings]
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
 -- ========================
 -- usp_config_crazybout_ConfigureTables_82_10000X_20000X_RNG_GLI(10)
 -- ========================

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_crazybout_ConfigureTables_82_10000X_20000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_82_10000X_20000X_RNG_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_82_10000X_20000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_crazybout_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_crazybout_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 100
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 400
			        , payunit_patt_11 = 2000
			        , payunit_patt_12 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_crazybout_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_BonusPayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 40
			        , payunit_patt_4 = 80
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 400
			        , payunit_patt_7 = 800
			        , payunit_patt_8 = 800
			        , payunit_patt_9 = 800
			        , payunit_patt_10 = 800
			        , payunit_patt_11 = 4000
			        , payunit_patt_12 = 20000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_crazybout_CreateGamePatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Any Line'
			        , bonustrigger = 'F'
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
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Corners'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Crazy Kite'
			        , bonustrigger = 'T'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of 9'
			        , bonustrigger = 'F'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy T'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Letter X'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Diamond'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy L'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Love Letter'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Brackets'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 28869179 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_crazybout_CreateBonusPatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Crazy Kite'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
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
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Frame'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy L'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Love Letter'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Brackets'
			        , numdesigns = 1
			        , design_1 = 28869179 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount =  @nPatternCount + 12
		END

	UPDATE
		[CrazyBout_GameSettings]
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

-- ======================
-- usp_config_crazybout_ConfigureTables_82_10000X_10000X_RNG(11)
-- =======================

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_crazybout_ConfigureTables_82_10000X_10000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_82_10000X_10000X_RNG]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_82_10000X_10000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE b3.dbo.usp_setup_crazybout_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE b3.dbo.usp_setup_crazybout_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 100
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 400
			        , payunit_patt_11 = 2000
			        , payunit_patt_12 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the bonus pay table
	EXECUTE b3.dbo.usp_setup_crazybout_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_BonusPayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 40
			        , payunit_patt_4 = 80
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 400
			        , payunit_patt_7 = 800
			        , payunit_patt_8 = 800
			        , payunit_patt_9 = 800
			        , payunit_patt_10 = 800
			        , payunit_patt_11 = 4000
			        , payunit_patt_12 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the game patterns
	EXECUTE b3.dbo.usp_setup_crazybout_CreateGamePatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Any Line'
				, bonustrigger = 'F'
				, numdesigns = 12
				, design_1 = 31
				, design_2 = 992
				, design_3 = 31744
   				, design_4 = 1015808
				, design_5 = 32505856
				, design_6 = 1082401
				, design_7 = 2164802
				, design_8 = 4329604
				, design_9 = 8659208
				, design_10 = 17318416
				, design_11 = 17043521
				, design_12 = 1118480 WHERE patternid = 1 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Stamp'
				, bonustrigger = 'F'
				, numdesigns = 4
				, design_1 = 99
				, design_2 = 3244032
				, design_3 = 25952256
				, design_4 = 792 WHERE patternid = 2 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Corners'
				, bonustrigger = 'F'
				, numdesigns = 1
				, design_1 = 17825809 WHERE patternid = 3 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Crazy Kite'
				, bonustrigger = 'T'
				, numdesigns = 4
				, design_1 = 17043555
				, design_2 = 3248400
				, design_3 = 25956417
				, design_4 = 1119000 WHERE patternid = 4 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of 9'
				, bonustrigger = 'F'
				, numdesigns = 9
				, design_1 = 7399
				, design_2 = 236768
				, design_3 = 7576576
				, design_4 = 14798
				, design_5 = 473536
				, design_6 = 15153152
				, design_7 = 29596
				, design_8 = 947072
				, design_9 = 30306304 WHERE patternid = 5 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy T'
				, bonustrigger = 'F'
				, numdesigns = 4
				, design_1 = 1113121 
				, design_2 = 32641156 
				, design_3 = 17333776
				, design_4 = 4329631 WHERE patternid = 6 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Letter X'
				, bonustrigger = 'F'
				, numdesigns = 1
				, design_1 = 18157905 WHERE patternid = 7 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Diamond'
				, bonustrigger = 'F'
				, numdesigns = 1
				, design_1 = 4539716 WHERE patternid = 8 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Frame'
				, bonustrigger = 'F'
				, numdesigns = 1
				, design_1 = 469440 WHERE patternid = 9 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy L'
				, bonustrigger = 'F'
				, numdesigns = 4
				, design_1 = 17318431
				, design_2 = 32539681
				, design_3 = 33047056
				, design_4 = 1082431 WHERE patternid = 10 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Love Letter'
				, bonustrigger = 'F'
				, numdesigns = 4
				, design_1 = 18367007
				, design_2 = 17859647
				, design_3 = 32539697
				, design_4 = 33047057 WHERE patternid = 11 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Frame'
				, bonustrigger = 'F'
				, numdesigns = 1
				, design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount =  @nPatternCount + 12
		END

	-- setup and configure the bonus patterns
	EXECUTE b3.dbo.usp_setup_crazybout_CreateBonusPatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Crazy Kite'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
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
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Frame'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy L'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Love Letter'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Frame'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount =  @nPatternCount + 12
		END

	UPDATE [CrazyBout_GameSettings] 
		SET 	-- 82%, $2500 Prize Cap, Uniform Ball Distribution
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

-- ==============================
-- usp_config_crazybout_ConfigureTables_60_5000X_5000X_55455 (12)
-- =============================
USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_crazybout_ConfigureTables_60_5000X_5000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_60_5000X_5000X_55455]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_60_5000X_5000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_crazybout_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_crazybout_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 3
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 8
			        , payunit_patt_5 = 20
			        , payunit_patt_6 = 30
			        , payunit_patt_7 = 40
			        , payunit_patt_8 = 100
			        , payunit_patt_9 = 200
			        , payunit_patt_10 = 400
			        , payunit_patt_11 = 1000
			        , payunit_patt_12 = 5000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_crazybout_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_BonusPayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 3
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 8
			        , payunit_patt_5 = 20
			        , payunit_patt_6 = 30
			        , payunit_patt_7 = 40
			        , payunit_patt_8 = 100
			        , payunit_patt_9 = 200
			        , payunit_patt_10 = 400
			        , payunit_patt_11 = 1000
			        , payunit_patt_12 = 5000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_crazybout_CreateGamePatternTable

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_GameSettings 
			SET maxpatterns = 12, maxcalls = 24

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Any Line'
			        , bonustrigger = 'F'
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

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy V'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1118273
			        , design_2 = 18157568
			        , design_3 = 17043728
			        , design_4 = 4433 WHERE patternid = 2 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 3 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Corners'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Crazy Kite'
			        , bonustrigger = 'T'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 5 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of 9'
			        , bonustrigger = 'F'
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
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Letter X'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Diamond'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy T'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Bow'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17584735
			        , design_2 = 1152319
			        , design_3 = 32805985
			        , design_4 = 33116944 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Arrow'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 18436895
			        , design_2 = 18125951
			        , design_3 = 32609585
			        , design_4 = 33313361 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_crazybout_CreateBonusPatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_BonusPatterns
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

		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy V'
			        , numdesigns = 4
			        , design_1 = 1118273
			        , design_2 = 18157568
			        , design_3 = 17043728
			        , design_4 = 4433 WHERE patternid = 2 + @nPatternCount

		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 3 + @nPatternCount

		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Crazy Kite'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 5 + @nPatternCount

		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Frame'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 10 + @nPatternCount

		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Bow'
			        , numdesigns = 4
			        , design_1 = 17584735
			        , design_2 = 1152319
			        , design_3 = 32805985
			        , design_4 = 33116944 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Arrow'
			        , numdesigns = 4
			        , design_1 = 18436895
			        , design_2 = 18125951
			        , design_3 = 32609585
			        , design_4 = 33313361 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount =  @nPatternCount + 12
		END

	UPDATE
		[CrazyBout_GameSettings]
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

-- ==================================
-- usp_config_crazybout_ConfigureTables_60_1000X_1000X_55455(13)
-- ==================================

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_crazybout_ConfigureTables_60_1000X_1000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_60_1000X_1000X_55455]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_60_1000X_1000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_crazybout_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_crazybout_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 3
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 8
			        , payunit_patt_5 = 20
			        , payunit_patt_6 = 30
			        , payunit_patt_7 = 40
			        , payunit_patt_8 = 80
			        , payunit_patt_9 = 125
			        , payunit_patt_10 = 250
			        , payunit_patt_11 = 500
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_crazybout_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_BonusPayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 3
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 8
			        , payunit_patt_5 = 20
			        , payunit_patt_6 = 30
			        , payunit_patt_7 = 40
			        , payunit_patt_8 = 80
			        , payunit_patt_9 = 125
			        , payunit_patt_10 = 250
			        , payunit_patt_11 = 500
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_crazybout_CreateGamePatternTable

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_GameSettings 
			SET maxpatterns = 12, maxcalls = 24

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Any Line'
			        , bonustrigger = 'F'
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

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy V'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1118273
			        , design_2 = 18157568
			        , design_3 = 17043728
			        , design_4 = 4433 WHERE patternid = 2 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 3 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Corners'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Crazy Kite'
			        , bonustrigger = 'T'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 5 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of 9'
			        , bonustrigger = 'F'
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
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Letter X'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Diamond'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy T'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy L'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Love Letter'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_crazybout_CreateBonusPatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_BonusPatterns
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

		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy V'
			        , numdesigns = 4
			        , design_1 = 1118273
			        , design_2 = 18157568
			        , design_3 = 17043728
			        , design_4 = 4433 WHERE patternid = 2 + @nPatternCount

		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 3 + @nPatternCount

		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Crazy Kite'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 5 + @nPatternCount

		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Frame'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy L'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Love Letter'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount =  @nPatternCount + 12
		END

	UPDATE
		[CrazyBout_GameSettings]
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
-- ==============================
-- usp_config_crazybout_ConfigureTables_82_10000X_20000X_RNG (14)
-- ==============================
USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_crazybout_ConfigureTables_82_10000X_20000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_82_10000X_20000X_RNG]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_82_10000X_20000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_crazybout_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE usp_setup_crazybout_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 100
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 400
			        , payunit_patt_11 = 2000
			        , payunit_patt_12 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the bonus pay table
	EXECUTE usp_setup_crazybout_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_BonusPayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 40
			        , payunit_patt_4 = 80
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 400
			        , payunit_patt_7 = 800
			        , payunit_patt_8 = 800
			        , payunit_patt_9 = 800
			        , payunit_patt_10 = 800
			        , payunit_patt_11 = 4000
			        , payunit_patt_12 = 20000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the game patterns
	EXECUTE usp_setup_crazybout_CreateGamePatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Any Line'
			        , bonustrigger = 'F'
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

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Corners'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Crazy Kite'
			        , bonustrigger = 'T'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of 9'
			        , bonustrigger = 'F'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy T'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 6 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Letter X'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Diamond'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy L'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Love Letter'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount

		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
		   	     , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure the bonus patterns
	EXECUTE usp_setup_crazybout_CreateBonusPatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Crazy Kite'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
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
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Frame'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy L'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Love Letter'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Frame'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount =  @nPatternCount + 12
		END

	UPDATE [CrazyBout_GameSettings] 
		SET 	-- 82%, $5000 Prize Cap, Uniform Ball Distribution
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
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_crazybout_ConfigureTables_87_250X_250X_55455_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_87_250X_250X_55455_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_crazybout_ConfigureTables_87_250X_250X_55455_GLI]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE b3.dbo.usp_setup_crazybout_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE b3.dbo.usp_setup_crazybout_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 6
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 40
			        , payunit_patt_5 = 60
			        , payunit_patt_6 = 80
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 125
			        , payunit_patt_9 = 150
			        , payunit_patt_10 = 175
			        , payunit_patt_11 = 200
			        , payunit_patt_12 = 250

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE b3.dbo.usp_setup_crazybout_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE CrazyBout_BonusPayTable
			SET payunit_patt_1 = 8
			        , payunit_patt_2 = 20
			        , payunit_patt_3 = 50
			        , payunit_patt_4 = 100
			        , payunit_patt_5 = 250
			        , payunit_patt_6 = 250
			        , payunit_patt_7 = 250
			        , payunit_patt_8 = 250
			        , payunit_patt_9 = 250
			        , payunit_patt_10 = 250
			        , payunit_patt_11 = 250
			        , payunit_patt_12 = 250

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE b3.dbo.usp_setup_crazybout_CreateGamePatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Any Line'
			        , bonustrigger = 'F'
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
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Four Corners'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Crazy Kite'
			        , bonustrigger = 'T'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Block of 9'
			        , bonustrigger = 'F'
			        , numdesigns = 9
			        , design_1 = 7399
			        , design_2 = 236768
			        , design_3 = 7576576
			        , design_4 = 14798
			        , design_5 = 473536
			        , design_6 = 15153152
			        , design_7 = 29596
			        , design_8 = 947072
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Letter X'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Diamond'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy T'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Small Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy L'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Crazy Love Letter'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_GamePatterns
			SET patternname = 'Large Frame'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE b3.dbo.usp_setup_crazybout_CreateBonusPatternTable

	UPDATE CrazyBout_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE CrazyBout_BonusPatterns
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
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 3 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Crazy Kite'
			        , numdesigns = 4
			        , design_1 = 17043555
			        , design_2 = 3248400
			        , design_3 = 25956417
			        , design_4 = 1119000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
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
			        , design_9 = 30306304 WHERE patternid = 5 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 6 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 7 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121 
			        , design_2 = 32641156 
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 8 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Small Frame'
			        , numdesigns = 1
			        , design_1 = 469440 WHERE patternid = 9 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy L'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 10 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Crazy Love Letter'
			        , numdesigns = 4
			        , design_1 = 18367007
			        , design_2 = 17859647
			        , design_3 = 32539697
			        , design_4 = 33047057 WHERE patternid = 11 + @nPatternCount
	
		UPDATE CrazyBout_BonusPatterns
			SET patternname = 'Large Frame'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount =  @nPatternCount + 12
		END

	UPDATE
		[CrazyBout_GameSettings]
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


