USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_jailbreak_ConfigureTables_60_1000X_1000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_60_1000X_1000X_55455]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_60_1000X_1000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_jailbreak_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_jailbreak_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_GamePayTable
			SET payunit_patt_1 = 3
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 15
			        , payunit_patt_5 = 25
			        , payunit_patt_6 = 50
			        , payunit_patt_7 = 75
			        , payunit_patt_8 = 100
			        , payunit_patt_9 = 200
			        , payunit_patt_10 = 300
			        , payunit_patt_11 = 500
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_jailbreak_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_BonusPayTable
			SET payunit_patt_1 = 3
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 15
			        , payunit_patt_5 = 25
			        , payunit_patt_6 = 50
			        , payunit_patt_7 = 75
			        , payunit_patt_8 = 100
			        , payunit_patt_9 = 200
			        , payunit_patt_10 = 300
			        , payunit_patt_11 = 500
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_jailbreak_CreateGamePatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_GamePatterns
			SET patternname = 'File'
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

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 4'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 2 + @nPatternCount

		UPDATE JailBreak_GamePatterns
			SET patternname = 'The Yard'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 6'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Key'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 12718222
			        , design_2 = 14815372 WHERE patternid = 5 + @nPatternCount

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Windows'
			        , bonustrigger = 'F'
			        , numdesigns = 3
			        , design_1 = 7335
	   		        , design_2 = 234720
			        , design_3 = 7511040 WHERE patternid = 6 + @nPatternCount

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 9'
			        , bonustrigger = 'F'
			        , numdesigns = 9
			        , design_1	= 7399
			        , design_2	= 236768
			        , design_3	= 7576576
			        , design_4	= 14798
			        , design_5	= 473536
			        , design_6	= 15153152
			        , design_7	= 29596
			        , design_8	= 947072
			        , design_9	= 30306304 WHERE patternid = 7 + @nPatternCount

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cot'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 9184012 
			        , design_2 = 13378312 WHERE patternid = 8 + @nPatternCount

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Bars'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 9 + @nPatternCount

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Tunnel'
			        , bonustrigger = 'F'
			        , numdesigns = 3
			        , design_1 = 5412005
			        , design_2 = 10824010
			        , design_3 = 21648020 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Guard'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Dynamite'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 27288602 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_jailbreak_CreateBonusPatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'File'
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

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 4'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 2 + @nPatternCount

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'The Yard'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 6'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Key'
			        , numdesigns = 2
			        , design_1 = 12718222
			        , design_2 = 14815372 WHERE patternid = 5 + @nPatternCount

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Windows'
			        , numdesigns = 3
			        , design_1 = 7335
	   		        , design_2 = 234720
			        , design_3 = 7511040 WHERE patternid = 6 + @nPatternCount

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 9'
			        , numdesigns = 9
			        , design_1	= 7399
			        , design_2	= 236768
			        , design_3	= 7576576
			        , design_4	= 14798
			        , design_5	= 473536
			        , design_6	= 15153152
			        , design_7	= 29596
			        , design_8	= 947072
			        , design_9	= 30306304 WHERE patternid = 7 + @nPatternCount

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cot'
			        , numdesigns = 2
			        , design_1 = 9184012 
			        , design_2 = 13378312 WHERE patternid = 8 + @nPatternCount

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Bars'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Tunnel'
			        , numdesigns = 3
			        , design_1 = 5412005
			        , design_2 = 10824010
			        , design_3 = 21648020 WHERE patternid = 10 + @nPatternCount

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Guard'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Dynamite'
			        , numdesigns = 1
			        , design_1 = 27288602 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- configure bonus trigger
	EXECUTE usp_setup_jailbreak_CreateBonusTriggerTable

	UPDATE JailBreak_BonusTrigger
		SET patt1_start	= 1
		        , patt1_end = 20
		        , patt2_start = 21
		        , patt2_end	= 50
		        , patt3_start = 51
		        , patt3_end	= 80
		        , patt4_start = 81
		        , patt4_end	= 200
		        , patt5_start = 201
		        , patt5_end	= 350
		        , patt6_start = 351
		        , patt6_end	= 500
		        , patt7_start = 501
		        , patt7_end	= 680
		        , patt8_start = 681
		        , patt8_end	= 830
		        , patt9_start = 831
		        , patt9_end	= 910
		        , patt10_start = 911
		        , patt10_end = 960
		        , patt11_start = 961
		        , patt11_end = 990
		        , patt12_start = 991
		        , patt12_end = 1000

	UPDATE
		[JailBreak_GameSettings]
		SET
			-- 60%, $250 Prize Cap, 55455 and 11211 Ball Distribution
			[maxcalls] = 24,
			[maxcalls_bonus] = 30,
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_jailbreak_ConfigureTables_60_5000X_5000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_60_5000X_5000X_55455]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_60_5000X_5000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_jailbreak_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_jailbreak_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_GamePayTable
			SET payunit_patt_1 = 3
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 15
			        , payunit_patt_5 = 25
			        , payunit_patt_6 = 50
			        , payunit_patt_7 = 75
			        , payunit_patt_8 = 100
			        , payunit_patt_9 = 200
			        , payunit_patt_10 = 400
			        , payunit_patt_11 = 1500
			        , payunit_patt_12 = 5000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_jailbreak_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_BonusPayTable
			SET payunit_patt_1 = 3
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 15
			        , payunit_patt_5 = 25
			        , payunit_patt_6 = 50
			        , payunit_patt_7 = 75
			        , payunit_patt_8 = 100
			        , payunit_patt_9 = 200
			        , payunit_patt_10 = 400
			        , payunit_patt_11 = 1500
			        , payunit_patt_12 = 5000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_jailbreak_CreateGamePatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_GamePatterns
			SET patternname = 'File'
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

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 4'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 2 + @nPatternCount

		UPDATE JailBreak_GamePatterns
			SET patternname = 'The Yard'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 6'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Key'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 12718222
			        , design_2 = 14815372 WHERE patternid = 5 + @nPatternCount

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Windows'
			        , bonustrigger = 'F'
			        , numdesigns = 3
			        , design_1 = 7335
	   		        , design_2 = 234720
			        , design_3 = 7511040 WHERE patternid = 6 + @nPatternCount

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 9'
			        , bonustrigger = 'F'
			        , numdesigns = 9
			        , design_1	= 7399
			        , design_2	= 236768
			        , design_3	= 7576576
			        , design_4	= 14798
			        , design_5	= 473536
			        , design_6	= 15153152
			        , design_7	= 29596
			        , design_8	= 947072
			        , design_9	= 30306304 WHERE patternid = 7 + @nPatternCount

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cot'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 9184012 
			        , design_2 = 13378312 WHERE patternid = 8 + @nPatternCount

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Bars'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 9 + @nPatternCount

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Tunnel'
			        , bonustrigger = 'F'
			        , numdesigns = 3
			        , design_1 = 5412005
			        , design_2 = 10824010
			        , design_3 = 21648020 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Dynamite'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 27288602 WHERE patternid = 11 + @nPatternCount

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Freedom'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 6962822 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_jailbreak_CreateBonusPatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'File'
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

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 4'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 2 + @nPatternCount

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'The Yard'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 6'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Key'
			        , numdesigns = 2
			        , design_1 = 12718222
			        , design_2 = 14815372 WHERE patternid = 5 + @nPatternCount

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Windows'
			        , numdesigns = 3
			        , design_1 = 7335
	   		        , design_2 = 234720
			        , design_3 = 7511040 WHERE patternid = 6 + @nPatternCount

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 9'
			        , numdesigns = 9
			        , design_1	= 7399
			        , design_2	= 236768
			        , design_3	= 7576576
			        , design_4	= 14798
			        , design_5	= 473536
			        , design_6	= 15153152
			        , design_7	= 29596
			        , design_8	= 947072
			        , design_9	= 30306304 WHERE patternid = 7 + @nPatternCount

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cot'
			        , numdesigns = 2
			        , design_1 = 9184012 
			        , design_2 = 13378312 WHERE patternid = 8 + @nPatternCount

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Bars'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Tunnel'
			        , numdesigns = 3
			        , design_1 = 5412005
			        , design_2 = 10824010
			        , design_3 = 21648020 WHERE patternid = 10 + @nPatternCount

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Dynamite'
			        , numdesigns = 1
			        , design_1 = 27288602 WHERE patternid = 11 + @nPatternCount

		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Freedom'
			        , numdesigns = 1
			        , design_1 = 6962822 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- configure bonus trigger
	EXECUTE usp_setup_jailbreak_CreateBonusTriggerTable

	UPDATE JailBreak_BonusTrigger
		SET patt1_start	= 1
		        , patt1_end = 20
		        , patt2_start = 21
		        , patt2_end	= 50
		        , patt3_start = 51
		        , patt3_end	= 80
		        , patt4_start = 81
		        , patt4_end	= 140
		        , patt5_start = 141
		        , patt5_end	= 300
		        , patt6_start = 301
		        , patt6_end	= 460
		        , patt7_start = 461
		        , patt7_end	= 620
		        , patt8_start = 621
		        , patt8_end	= 780
		        , patt9_start = 781
		        , patt9_end	= 940
		        , patt10_start = 941
		        , patt10_end = 970
		        , patt11_start = 971
		        , patt11_end = 990
		        , patt12_start = 991
		        , patt12_end = 1000

	UPDATE
		[JailBreak_GameSettings]
		SET
			-- 60%, $1250 Prize Cap, 55455 and 11211 Ball Distribution
			[maxcalls] = 24,
			[maxcalls_bonus] = 30,
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_jailbreak_ConfigureTables_82_1000X_1000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_82_1000X_1000X_55455]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_82_1000X_1000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_jailbreak_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_jailbreak_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 6
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 24
			        , payunit_patt_5 = 40
			        , payunit_patt_6 = 80
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 200
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 800
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_jailbreak_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_BonusPayTable
			SET payunit_patt_1 = 10
			        , payunit_patt_2 = 20
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 100
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 600
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 1000
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_jailbreak_CreateGamePatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_GamePatterns
			SET patternname = 'The Yard'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'File'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 4'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 6'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 8'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 9'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Bars'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Key'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cot'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Guard'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Tunnel'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Dynamite'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_jailbreak_CreateBonusPatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'The Yard'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'File'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 4'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 6'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 8'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 9'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Bars'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Key'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cot'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Guard'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Tunnel'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Dynamite'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- configure bonus trigger
	EXECUTE usp_setup_jailbreak_CreateBonusTriggerTable

	UPDATE JailBreak_BonusTrigger
		SET patt1_start	= 1
		        , patt1_end = 40
		        , patt2_start = 41
		        , patt2_end	= 70
		        , patt3_start = 71
		        , patt3_end	= 100
		        , patt4_start = 101
		        , patt4_end	= 220
		        , patt5_start = 221
		        , patt5_end	= 370
		        , patt6_start = 371
		        , patt6_end	= 520
		        , patt7_start = 521
		        , patt7_end	= 670
		        , patt8_start = 671
		        , patt8_end	= 820
		        , patt9_start = 821
		        , patt9_end	= 940
		        , patt10_start = 941
		        , patt10_end = 970
		        , patt11_start = 971
		        , patt11_end = 990
		        , patt12_start = 991
		        , patt12_end = 1000

	UPDATE
		[JailBreak_GameSettings]
		SET
			-- 82%, $250 Prize Cap, 55455 and 11211 Ball Distribution
			[maxcalls] = 24,
			[maxcalls_bonus] = 30,
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_jailbreak_ConfigureTables_82_10000X_20000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_82_10000X_20000X_RNG]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_82_10000X_20000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_jailbreak_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_jailbreak_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_GamePayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 45
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 200
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 1000
			        , payunit_patt_11 = 2500
			        , payunit_patt_12 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_jailbreak_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_BonusPayTable
			SET payunit_patt_1 = 8
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 90
			        , payunit_patt_5 = 400
			        , payunit_patt_6 = 400
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 800
			        , payunit_patt_9 = 800
			        , payunit_patt_10 = 2000
			        , payunit_patt_11 = 5000
			        , payunit_patt_12 = 20000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_jailbreak_CreateGamePatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_GamePatterns
			SET patternname = 'The Yard'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'File'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 4'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 6'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 8'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 9'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Bars'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Key'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cot'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Guard'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Tunnel'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Dynamite'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_jailbreak_CreateBonusPatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'The Yard'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'File'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 4'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 6'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 8'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 9'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Bars'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Key'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cot'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Guard'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Tunnel'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Dynamite'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- configure bonus trigger
	EXECUTE usp_setup_jailbreak_CreateBonusTriggerTable

	UPDATE JailBreak_BonusTrigger
		SET patt1_start	= 1
		        , patt1_end = 40
		        , patt2_start = 41
		        , patt2_end	= 70
		        , patt3_start = 71
		        , patt3_end	= 100
		        , patt4_start = 101
		        , patt4_end	= 220
		        , patt5_start = 221
		        , patt5_end	= 370
		        , patt6_start = 371
		        , patt6_end	= 520
		        , patt7_start = 521
		        , patt7_end	= 670
		        , patt8_start = 671
		        , patt8_end	= 820
		        , patt9_start = 821
		        , patt9_end	= 940
		        , patt10_start = 941
		        , patt10_end = 970
		        , patt11_start = 971
		        , patt11_end = 990
		        , patt12_start = 991
		        , patt12_end = 1000

	UPDATE
		[JailBreak_GameSettings]
		SET
			-- 82%, $5000 Prize Cap, Uniform Ball Distribution
			[maxcalls] = 24,
			[maxcalls_bonus] = 30,
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_jailbreak_ConfigureTables_84_10000X_20000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_84_10000X_20000X_RNG]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_84_10000X_20000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_jailbreak_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_jailbreak_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_GamePayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 45
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 300
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 1000
			        , payunit_patt_11 = 2500
			        , payunit_patt_12 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_jailbreak_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_BonusPayTable
			SET payunit_patt_1 = 8
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 90
			        , payunit_patt_5 = 400
			        , payunit_patt_6 = 400
			        , payunit_patt_7 = 600
			        , payunit_patt_8 = 800
			        , payunit_patt_9 = 800
			        , payunit_patt_10 = 2000
			        , payunit_patt_11 = 5000
			        , payunit_patt_12 = 20000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_jailbreak_CreateGamePatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_GamePatterns
			SET patternname = 'The Yard'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'File'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 4'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 6'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 8'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 9'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Bars'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Key'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cot'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Guard'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Tunnel'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Dynamite'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_jailbreak_CreateBonusPatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'The Yard'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'File'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 4'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 6'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 8'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 9'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Bars'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Key'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cot'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Guard'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Tunnel'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Dynamite'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- configure bonus trigger
	EXECUTE usp_setup_jailbreak_CreateBonusTriggerTable

	UPDATE JailBreak_BonusTrigger
		SET patt1_start	= 1
		        , patt1_end = 40
		        , patt2_start = 41
		        , patt2_end	= 70
		        , patt3_start = 71
		        , patt3_end	= 100
		        , patt4_start = 101
		        , patt4_end	= 220
		        , patt5_start = 221
		        , patt5_end	= 370
		        , patt6_start = 371
		        , patt6_end	= 520
		        , patt7_start = 521
		        , patt7_end	= 670
		        , patt8_start = 671
		        , patt8_end	= 820
		        , patt9_start = 821
		        , patt9_end	= 940
		        , patt10_start = 941
		        , patt10_end = 970
		        , patt11_start = 971
		        , patt11_end = 990
		        , patt12_start = 991
		        , patt12_end = 1000

	UPDATE
		[JailBreak_GameSettings]
		SET
			-- 84%, $5000 Prize Cap, Uniform Ball Distribution
			[maxcalls] = 24,
			[maxcalls_bonus] = 30,
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
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO


USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_jailbreak_ConfigureTables_87_1000X_1000X_55455]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_87_1000X_1000X_55455]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_87_1000X_1000X_55455]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_jailbreak_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_jailbreak_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_GamePayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 6
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 20
			        , payunit_patt_5 = 40
			        , payunit_patt_6 = 60
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 200
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 800
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_jailbreak_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_BonusPayTable
			SET payunit_patt_1 = 10
			        , payunit_patt_2 = 20
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 100
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 600
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 1000
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_jailbreak_CreateGamePatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_GamePatterns
			SET patternname = 'The Yard'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'File'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 4'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 6'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 8'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 9'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Bars'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Key'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cot'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Guard'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Tunnel'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Dynamite'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_jailbreak_CreateBonusPatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'The Yard'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'File'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 4'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 6'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 8'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 9'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Bars'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Key'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cot'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Guard'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Tunnel'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Dynamite'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- configure bonus trigger
	EXECUTE usp_setup_jailbreak_CreateBonusTriggerTable

	UPDATE JailBreak_BonusTrigger
		SET patt1_start	= 1
		        , patt1_end = 40
		        , patt2_start = 41
		        , patt2_end	= 70
		        , patt3_start = 71
		        , patt3_end	= 100
		        , patt4_start = 101
		        , patt4_end	= 220
		        , patt5_start = 221
		        , patt5_end	= 370
		        , patt6_start = 371
		        , patt6_end	= 520
		        , patt7_start = 521
		        , patt7_end	= 670
		        , patt8_start = 671
		        , patt8_end	= 820
		        , patt9_start = 821
		        , patt9_end	= 940
		        , patt10_start = 941
		        , patt10_end = 970
		        , patt11_start = 971
		        , patt11_end = 990
		        , patt12_start = 991
		        , patt12_end = 1000

	UPDATE
		[JailBreak_GameSettings]
		SET
			-- 87%, $250 Prize Cap, 55455 and 11211 Ball Distribution
			[maxcalls] = 24,
			[maxcalls_bonus] = 30,
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_jailbreak_ConfigureTables_87_10000X_20000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_87_10000X_20000X_RNG]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_87_10000X_20000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_jailbreak_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_jailbreak_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_GamePayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 50
			        , payunit_patt_5 = 200
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
	EXECUTE usp_setup_jailbreak_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_BonusPayTable
			SET payunit_patt_1 = 8
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 100
			        , payunit_patt_5 = 400
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
	EXECUTE usp_setup_jailbreak_CreateGamePatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_GamePatterns
			SET patternname = 'The Yard'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'File'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 4'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 6'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 8'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 9'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Bars'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Key'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cot'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Guard'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Tunnel'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Dynamite'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_jailbreak_CreateBonusPatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'The Yard'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'File'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 4'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 6'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 8'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 9'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Bars'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Key'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cot'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Guard'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Tunnel'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Dynamite'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- configure bonus trigger
	EXECUTE usp_setup_jailbreak_CreateBonusTriggerTable

	UPDATE JailBreak_BonusTrigger
		SET patt1_start	= 1
		        , patt1_end = 40
		        , patt2_start = 41
		        , patt2_end	= 70
		        , patt3_start = 71
		        , patt3_end	= 100
		        , patt4_start = 101
		        , patt4_end	= 220
		        , patt5_start = 221
		        , patt5_end	= 370
		        , patt6_start = 371
		        , patt6_end	= 520
		        , patt7_start = 521
		        , patt7_end	= 670
		        , patt8_start = 671
		        , patt8_end	= 820
		        , patt9_start = 821
		        , patt9_end	= 940
		        , patt10_start = 941
		        , patt10_end = 970
		        , patt11_start = 971
		        , patt11_end = 990
		        , patt12_start = 991
		        , patt12_end = 1000

	UPDATE
		[JailBreak_GameSettings]
		SET
			-- 87%, $5000 Prize Cap, Uniform Ball Distribution
			[maxcalls] = 24,
			[maxcalls_bonus] = 30,
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
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_jailbreak_ConfigureTables_Demo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_Demo]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_Demo]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_jailbreak_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_jailbreak_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_GamePayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 6
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 20
			        , payunit_patt_5 = 40
			        , payunit_patt_6 = 60
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 200
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 800
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_jailbreak_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_BonusPayTable
			SET payunit_patt_1 = 10
			        , payunit_patt_2 = 20
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 100
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 600
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 1000
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_jailbreak_CreateGamePatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_GamePatterns
			SET patternname = 'File'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 1118480
			        , design_2 = 17043521 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'The Yard'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 4'
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
			        , design_16	= 25952256 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 6'
			        , bonustrigger = 'F'
			        , numdesigns = 24
			        , design_1	= 231
			        , design_2	= 7392
			        , design_3	= 236544
	   		        , design_4	= 7569408
			        , design_5	= 462
			        , design_6	= 14784
			        , design_7	= 473088
			        , design_8	= 15138816
			        , design_9	= 924
			        , design_10	= 29568
			        , design_11	= 946176
			        , design_12	= 30277632
			        , design_13	=3171
			        , design_14	= 101472
			        , design_15	= 3247104
			        , design_16	= 6342
			        , design_17	= 202944
			        , design_18	= 6494208
			        , design_19	= 12684
			        , design_20	= 405888
			        , design_21	= 12988416
			        , design_22	= 25368
			        , design_23	= 811776
			        , design_24	= 25976832 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 8'
			        , bonustrigger = 'F'
			        , numdesigns = 16
			        , design_1	= 495
			        , design_2	= 15840
			        , design_3	= 506880
	   		        , design_4	= 16220160
			        , design_5	= 990
			        , design_6	= 31680
			        , design_7	= 1013760
			        , design_8	= 32440320
			        , design_9	= 101475
			        , design_10	= 202950
			        , design_11	= 405900
			        , design_12	= 811800
			        , design_13	= 3247200
			        , design_14	= 6494400
			        , design_15	= 12988800
			        , design_16	= 25977600 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 9'
			        , bonustrigger = 'F'
			        , numdesigns = 9
			        , design_1	= 7399
			        , design_2	= 236768
			        , design_3	= 7576576
	   		        , design_4	= 14798
			        , design_5	= 473536
			        , design_6	= 15153152
			        , design_7	= 29596
			        , design_8	= 947072
			        , design_9	= 30306304 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cot'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 9184014 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Crazy Key'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 12718542
			        , design_2 = 130656
			        , design_3 = 15143046
			        , design_4 = 851712 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Stripes'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 10824010 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Bars'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 1016800 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cake'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 22730421 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Tunnel'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_jailbreak_CreateBonusPatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns_bonus = 12, maxcalls_bonus = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'File'
			        , numdesigns = 2
			        , design_1 = 1118480
			        , design_2 = 17043521 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'The Yard'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 4'
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
			        , design_16	= 25952256 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 6'
			        , numdesigns = 24
			        , design_1	= 231
			        , design_2	= 7392
			        , design_3	= 236544
	   		        , design_4	= 7569408
			        , design_5	= 462
			        , design_6	= 14784
			        , design_7	= 473088
			        , design_8	= 15138816
			        , design_9	= 924
			        , design_10	= 29568
			        , design_11	= 946176
			        , design_12	= 30277632
			        , design_13	=3171
			        , design_14	= 101472
			        , design_15	= 3247104
			        , design_16	= 6342
			        , design_17	= 202944
			        , design_18	= 6494208
			        , design_19	= 12684
			        , design_20	= 405888
			        , design_21	= 12988416
			        , design_22	= 25368
			        , design_23	= 811776
			        , design_24	= 25976832 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 8'
			        , numdesigns = 16
			        , design_1	= 495
			        , design_2	= 15840
			        , design_3	= 506880
	   		        , design_4	= 16220160
			        , design_5	= 990
			        , design_6	= 31680
			        , design_7	= 1013760
			        , design_8	= 32440320
			        , design_9	= 101475
			        , design_10	= 202950
			        , design_11	= 405900
			        , design_12	= 811800
			        , design_13	= 3247200
			        , design_14	= 6494400
			        , design_15	= 12988800
			        , design_16	= 25977600 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 9'
			        , numdesigns = 9
			        , design_1	= 7399
			        , design_2	= 236768
			        , design_3	= 7576576
	   		        , design_4	= 14798
			        , design_5	= 473536
			        , design_6	= 15153152
			        , design_7	= 29596
			        , design_8	= 947072
			        , design_9	= 30306304 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cot'
			        , numdesigns = 1
			        , design_1 = 9184014 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Crazy Key'
			        , numdesigns = 4
			        , design_1 = 12718542
			        , design_2 = 130656
			        , design_3 = 15143046
			        , design_4 = 851712 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Stripes'
			        , numdesigns = 1
			        , design_1 = 10824010 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Bars'
			        , numdesigns = 1
			        , design_1 = 1016800 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cake'
			        , numdesigns = 1
			        , design_1 = 22730421 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Tunnel'
			        , numdesigns = 1
			        , design_1 = 33080895 WHERE patternid = 12 + @nPatternCount


		SET @nPatternCount = @nPatternCount + 12
		END

	-- configure bonus trigger
	EXECUTE usp_setup_jailbreak_CreateBonusTriggerTable

	UPDATE JailBreak_BonusTrigger
		SET patt1_start	= 1
		        , patt1_end = 420
		        , patt2_start = 421
		        , patt2_end	= 550
		        , patt3_start = 551
		        , patt3_end	= 640
		        , patt4_start = 641
		        , patt4_end	= 984
		        , patt5_start = 985
		        , patt5_end	= 986
		        , patt6_start = 987
		        , patt6_end	= 988
		        , patt7_start = 989
		        , patt7_end	= 990
		        , patt8_start = 991
		        , patt8_end	= 992
		        , patt9_start = 993
		        , patt9_end	= 994
		        , patt10_start = 995
		        , patt10_end = 996
		        , patt11_start = 997
		        , patt11_end = 998
		        , patt12_start = 999
		        , patt12_end = 1000

	UPDATE
		[JailBreak_GameSettings]
		SET
			-- High Payout for Demonstration Purpose Only
			[maxcalls] = 24,
			[maxcalls_bonus] = 30,
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
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO


USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_jailbreak_ConfigureTables_82_10000X_20000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_82_10000X_20000X_RNG_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_82_10000X_20000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_jailbreak_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_jailbreak_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_GamePayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 45
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 200
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 1000
			        , payunit_patt_11 = 2500
			        , payunit_patt_12 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_jailbreak_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_BonusPayTable
			SET payunit_patt_1 = 8
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 90
			        , payunit_patt_5 = 400
			        , payunit_patt_6 = 400
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 800
			        , payunit_patt_9 = 800
			        , payunit_patt_10 = 2000
			        , payunit_patt_11 = 5000
			        , payunit_patt_12 = 20000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_jailbreak_CreateGamePatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_GamePatterns
			SET patternname = 'The Yard'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'File'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 4'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 6'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 8'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 9'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Bars'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Key'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cot'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Guard'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Tunnel'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Dynamite'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_jailbreak_CreateBonusPatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'The Yard'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'File'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 4'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 6'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 8'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 9'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Bars'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Key'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cot'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Guard'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Tunnel'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Dynamite'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- configure bonus trigger
	EXECUTE usp_setup_jailbreak_CreateBonusTriggerTable

	UPDATE JailBreak_BonusTrigger
		SET patt1_start	= 1
		        , patt1_end = 40
		        , patt2_start = 41
		        , patt2_end	= 70
		        , patt3_start = 71
		        , patt3_end	= 100
		        , patt4_start = 101
		        , patt4_end	= 220
		        , patt5_start = 221
		        , patt5_end	= 370
		        , patt6_start = 371
		        , patt6_end	= 520
		        , patt7_start = 521
		        , patt7_end	= 670
		        , patt8_start = 671
		        , patt8_end	= 820
		        , patt9_start = 821
		        , patt9_end	= 940
		        , patt10_start = 941
		        , patt10_end = 970
		        , patt11_start = 971
		        , patt11_end = 990
		        , patt12_start = 991
		        , patt12_end = 1000

	UPDATE
		[JailBreak_GameSettings]
		SET
			-- 82%, $5000 Prize Cap, Uniform Ball Distribution
			[maxcalls] = 24,
			[maxcalls_bonus] = 30,
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_jailbreak_ConfigureTables_82_1000X_1000X_55455_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_82_1000X_1000X_55455_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_82_1000X_1000X_55455_GLI]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_jailbreak_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_jailbreak_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 6
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 24
			        , payunit_patt_5 = 40
			        , payunit_patt_6 = 80
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 200
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 800
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_jailbreak_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_BonusPayTable
			SET payunit_patt_1 = 10
			        , payunit_patt_2 = 20
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 100
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 600
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 1000
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_jailbreak_CreateGamePatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_GamePatterns
			SET patternname = 'The Yard'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'File'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 4'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 6'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 8'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 9'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Bars'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Key'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cot'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Guard'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Tunnel'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Dynamite'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_jailbreak_CreateBonusPatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'The Yard'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'File'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 4'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 6'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 8'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 9'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Bars'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Key'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cot'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Guard'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Tunnel'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Dynamite'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- configure bonus trigger
	EXECUTE usp_setup_jailbreak_CreateBonusTriggerTable

	UPDATE JailBreak_BonusTrigger
		SET patt1_start	= 1
		        , patt1_end = 40
		        , patt2_start = 41
		        , patt2_end	= 70
		        , patt3_start = 71
		        , patt3_end	= 100
		        , patt4_start = 101
		        , patt4_end	= 220
		        , patt5_start = 221
		        , patt5_end	= 370
		        , patt6_start = 371
		        , patt6_end	= 520
		        , patt7_start = 521
		        , patt7_end	= 670
		        , patt8_start = 671
		        , patt8_end	= 820
		        , patt9_start = 821
		        , patt9_end	= 940
		        , patt10_start = 941
		        , patt10_end = 970
		        , patt11_start = 971
		        , patt11_end = 990
		        , patt12_start = 991
		        , patt12_end = 1000

	UPDATE
		[JailBreak_GameSettings]
		SET
			-- 82%, $250 Prize Cap, 55455 and 11211 Ball Distribution
			[maxcalls] = 24,
			[maxcalls_bonus] = 30,
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_jailbreak_ConfigureTables_84_10000X_20000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_84_10000X_20000X_RNG_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_84_10000X_20000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_jailbreak_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_jailbreak_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_GamePayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 45
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 300
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 1000
			        , payunit_patt_11 = 2500
			        , payunit_patt_12 = 10000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_jailbreak_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_BonusPayTable
			SET payunit_patt_1 = 8
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 90
			        , payunit_patt_5 = 400
			        , payunit_patt_6 = 400
			        , payunit_patt_7 = 600
			        , payunit_patt_8 = 800
			        , payunit_patt_9 = 800
			        , payunit_patt_10 = 2000
			        , payunit_patt_11 = 5000
			        , payunit_patt_12 = 20000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_jailbreak_CreateGamePatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_GamePatterns
			SET patternname = 'The Yard'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'File'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 4'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 6'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 8'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 9'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Bars'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Key'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	

		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cot'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Guard'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Tunnel'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Dynamite'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_jailbreak_CreateBonusPatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'The Yard'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'File'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 4'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 6'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 8'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 9'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Bars'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Key'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cot'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Guard'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Tunnel'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Dynamite'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- configure bonus trigger
	EXECUTE usp_setup_jailbreak_CreateBonusTriggerTable

	UPDATE JailBreak_BonusTrigger
		SET patt1_start	= 1
		        , patt1_end = 40
		        , patt2_start = 41
		        , patt2_end	= 70
		        , patt3_start = 71
		        , patt3_end	= 100
		        , patt4_start = 101
		        , patt4_end	= 220
		        , patt5_start = 221
		        , patt5_end	= 370
		        , patt6_start = 371
		        , patt6_end	= 520
		        , patt7_start = 521
		        , patt7_end	= 670
		        , patt8_start = 671
		        , patt8_end	= 820
		        , patt9_start = 821
		        , patt9_end	= 940
		        , patt10_start = 941
		        , patt10_end = 970
		        , patt11_start = 971
		        , patt11_end = 990
		        , patt12_start = 991
		        , patt12_end = 1000

	UPDATE
		[JailBreak_GameSettings]
		SET
			-- 84%, $5000 Prize Cap, Uniform Ball Distribution
			[maxcalls] = 24,
			[maxcalls_bonus] = 30,
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
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO

USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_jailbreak_ConfigureTables_87_10000X_20000X_RNG_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_87_10000X_20000X_RNG_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_87_10000X_20000X_RNG_GLI]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_jailbreak_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_jailbreak_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_GamePayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 50
			        , payunit_patt_5 = 200
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
	EXECUTE usp_setup_jailbreak_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_BonusPayTable
			SET payunit_patt_1 = 8
			        , payunit_patt_2 = 8
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 100
			        , payunit_patt_5 = 400
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
	EXECUTE usp_setup_jailbreak_CreateGamePatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_GamePatterns
			SET patternname = 'The Yard'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'File'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 4'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 6'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 8'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 9'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Bars'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Key'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cot'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Guard'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Tunnel'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Dynamite'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_jailbreak_CreateBonusPatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'The Yard'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'File'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 4'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 6'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 8'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 9'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Bars'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Key'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cot'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Guard'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Tunnel'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Dynamite'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- configure bonus trigger
	EXECUTE usp_setup_jailbreak_CreateBonusTriggerTable

	UPDATE JailBreak_BonusTrigger
		SET patt1_start	= 1
		        , patt1_end = 40
		        , patt2_start = 41
		        , patt2_end	= 70
		        , patt3_start = 71
		        , patt3_end	= 100
		        , patt4_start = 101
		        , patt4_end	= 220
		        , patt5_start = 221
		        , patt5_end	= 370
		        , patt6_start = 371
		        , patt6_end	= 520
		        , patt7_start = 521
		        , patt7_end	= 670
		        , patt8_start = 671
		        , patt8_end	= 820
		        , patt9_start = 821
		        , patt9_end	= 940
		        , patt10_start = 941
		        , patt10_end = 970
		        , patt11_start = 971
		        , patt11_end = 990
		        , patt12_start = 991
		        , patt12_end = 1000

	UPDATE
		[JailBreak_GameSettings]
		SET
			-- 87%, $5000 Prize Cap, Uniform Ball Distribution
			[maxcalls] = 24,
			[maxcalls_bonus] = 30,
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
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO


USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_jailbreak_ConfigureTables_87_1000X_1000X_55455_GLI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_87_1000X_1000X_55455_GLI]
GO

USE [B3]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_jailbreak_ConfigureTables_87_1000X_1000X_55455_GLI]
AS
	SET NOCOUNT ON

	UPDATE B3_SystemConfig 
		SET CommonRNGBallCall = 'F'

	EXECUTE usp_setup_jailbreak_CreateGameSettingsTable

	-- setup and configure game pay table
	EXECUTE usp_setup_jailbreak_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_GamePayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 6
			        , payunit_patt_3 = 8
			        , payunit_patt_4 = 20
			        , payunit_patt_5 = 40
			        , payunit_patt_6 = 60
			        , payunit_patt_7 = 100
			        , payunit_patt_8 = 200
			        , payunit_patt_9 = 400
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 800
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure bonus pay table
	EXECUTE usp_setup_jailbreak_CreateBonusPayTable

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 8
		BEGIN
		UPDATE JailBreak_BonusPayTable
			SET payunit_patt_1 = 10
			        , payunit_patt_2 = 20
			        , payunit_patt_3 = 20
			        , payunit_patt_4 = 100
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 400
			        , payunit_patt_9 = 600
			        , payunit_patt_10 = 600
			        , payunit_patt_11 = 1000
			        , payunit_patt_12 = 1000

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_jailbreak_CreateGamePatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_GamePatterns
			SET patternname = 'The Yard'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'File'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 4'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 6'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 8'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cellblock 9'
			        , bonustrigger = 'F'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Bars'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Key'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Cot'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Guard'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Tunnel'
			        , bonustrigger = 'F'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_GamePatterns
			SET patternname = 'Dynamite'
			        , bonustrigger = 'F'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure bonus patterns
	EXECUTE usp_setup_jailbreak_CreateBonusPatternTable

	UPDATE JailBreak_GameSettings 
		SET maxpatterns = 12, maxcalls = 30

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 96
		BEGIN
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'The Yard'
			        , numdesigns = 4
			        , design_1 = 17825809
			        , design_2 = 4211716
			        , design_3 = 141440
			        , design_4 = 328000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'File'
			        , numdesigns = 4
			        , design_1 = 1118480
			        , design_2 = 17043521 
			        , design_3 = 4329604 
			        , design_4 = 31744 WHERE patternid = 2 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 4'
			        , numdesigns = 4
			        , design_1	= 99
			        , design_2	= 3244032
			        , design_3	= 25952256
	   		        , design_4	= 792 WHERE patternid = 3 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 6'
			        , numdesigns = 4
			        , design_1	= 231
			        , design_2	= 7569408
			        , design_3	= 30277632
	   		        , design_4	= 924 WHERE patternid = 4 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 8'
			        , numdesigns = 4
			        , design_1 = 495
	   		        , design_2 = 16220160
			        , design_3 = 32440320
			        , design_4 = 990 WHERE patternid = 5 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cellblock 9'
			        , numdesigns = 4
			        , design_1	= 7399
			        , design_2	= 7576576
			        , design_3	= 30306304
	   		        , design_4	= 29596 WHERE patternid = 6 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Bars'
			        , numdesigns = 2
			        , design_1 = 10517514
			        , design_2 = 4887204 WHERE patternid = 7 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Key'
			        , numdesigns = 2
			        , design_1 = 12718542
			        , design_2 = 15143052 WHERE patternid = 8 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Cot'
			        , numdesigns = 2
			        , design_1 = 9184014 
			        , design_2 = 15475464 WHERE patternid = 9 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Guard'
			        , numdesigns = 1
			        , design_1 = 13174348 WHERE patternid = 10 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Tunnel'
			        , numdesigns = 2
			        , design_1 = 10824010
			        , design_2 = 1016800 WHERE patternid = 11 + @nPatternCount
	
		UPDATE JailBreak_BonusPatterns
			SET patternname = 'Dynamite'
			        , numdesigns = 1
			        , design_1 = 30438429 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- configure bonus trigger
	EXECUTE usp_setup_jailbreak_CreateBonusTriggerTable

	UPDATE JailBreak_BonusTrigger
		SET patt1_start	= 1
		        , patt1_end = 40
		        , patt2_start = 41
		        , patt2_end	= 70
		        , patt3_start = 71
		        , patt3_end	= 100
		        , patt4_start = 101
		        , patt4_end	= 220
		        , patt5_start = 221
		        , patt5_end	= 370
		        , patt6_start = 371
		        , patt6_end	= 520
		        , patt7_start = 521
		        , patt7_end	= 670
		        , patt8_start = 671
		        , patt8_end	= 820
		        , patt9_start = 821
		        , patt9_end	= 940
		        , patt10_start = 941
		        , patt10_end = 970
		        , patt11_start = 971
		        , patt11_end = 990
		        , patt12_start = 991
		        , patt12_end = 1000

	UPDATE
		[JailBreak_GameSettings]
		SET
			-- 87%, $250 Prize Cap, 55455 and 11211 Ball Distribution
			[maxcalls] = 24,
			[maxcalls_bonus] = 30,
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











