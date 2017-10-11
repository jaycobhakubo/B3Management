USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildfire_ConfigureTables_82_4000X_RNG]    Script Date: 09/15/2015 11:37:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildfire_ConfigureTables_82_4000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildfire_ConfigureTables_82_4000X_RNG]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildfire_ConfigureTables_82_4000X_RNG]    Script Date: 09/15/2015 11:37:50 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildfire_ConfigureTables_82_4000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_wildfire_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE usp_setup_wildfire_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 1
		BEGIN
		UPDATE WildFire_GamePayTable
			SET payunit_patt_1 = 2
			        , payunit_patt_2 = 4
			        , payunit_patt_3 = 4
			        , payunit_patt_4 = 20
			        , payunit_patt_5 = 200
			        , payunit_patt_6 = 1000
			        , payunit_patt_7 = 1000
			        , payunit_patt_8 = 4000
			        , payunit_patt_9 = 0
			        , payunit_patt_10 = 0
			        , payunit_patt_11 = 0
			        , payunit_patt_12 = 0

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure progressive pay table
	EXECUTE usp_setup_wildfire_CreateProgPayTable

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 12
		BEGIN
		UPDATE WildFire_ProgPayTable
			SET seedamt = 25000
			        , progamt = 25000
			        , contribution = 10
			        , progcap = 25000000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 50000
			        , progamt = 50000
			        , contribution = 10
			        , progcap = 25000000 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 50000
			        , progamt = 50000
			        , contribution = 10
			        , progcap = 25000000 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 250000
			        , progamt = 250000
			        , contribution = 10
			        , progcap = 25000000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 1000000
			        , progamt = 1000000
			        , contribution = 10
			        , progcap = 25000000 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 5000000
			        , progamt = 5000000
			        , contribution = 10
			        , progcap = 25000000 WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 5000000
			        , progamt = 5000000
			        , contribution = 10
			        , progcap = 25000000 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 25000000
			        , progamt = 25000000
			        , contribution = 2
			        , progcap = 25000000 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 0
			        , progamt = 0
			        , contribution = 0
			        , progcap = 0 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 0
			        , progamt = 0
			        , contribution = 0
			        , progcap = 0 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 0
			        , progamt = 0
			        , contribution = 0
			        , progcap = 0 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 0
			        , progamt = 0
			        , contribution = 0
			        , progcap = 0 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_wildfire_CreateGamePatternTable

	UPDATE WildFire_GameSettings 
		SET maxpatterns = 8, maxcalls = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 12
		BEGIN
		UPDATE WildFire_GamePatterns
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
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
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
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
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
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 1
			        , design_1 = 1113121 WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 8 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildFire_GameSettings]
		SET
			-- 82%, $2500 Prize Cap, Uniform Ball Distribution
			[mathmodel_denom_25_percent] = 82.00, 
			[mathmodel_denom_25_prizecap] = 2500.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO


USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildfire_ConfigureTables_84_1000X_RNG]    Script Date: 09/15/2015 11:37:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildfire_ConfigureTables_84_1000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildfire_ConfigureTables_84_1000X_RNG]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildfire_ConfigureTables_84_1000X_RNG]    Script Date: 09/15/2015 11:37:54 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildfire_ConfigureTables_84_1000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE b3.dbo.usp_setup_wildfire_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE b3.dbo.usp_setup_wildfire_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 1
		BEGIN
		UPDATE WildFire_GamePayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 6
			        , payunit_patt_3 = 6
			        , payunit_patt_4 = 12
			        , payunit_patt_5 = 80
			        , payunit_patt_6 = 200
			        , payunit_patt_7 = 200
			        , payunit_patt_8 = 1000
			        , payunit_patt_9 = 0
			        , payunit_patt_10 = 0
			        , payunit_patt_11 = 0
			        , payunit_patt_12 = 0

		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the progressive pay table
	EXECUTE b3.dbo.usp_setup_wildfire_CreateProgPayTable

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 12
		BEGIN
		UPDATE WildFire_ProgPayTable
			SET seedamt = 60000
			        , progamt = 60000
			        , contribution = 10
			        , progcap = 2500000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 80000
			        , progamt = 80000
			        , contribution = 10
			        , progcap = 2500000 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 80000
			        , progamt = 80000
			        , contribution = 10
			        , progcap = 2500000 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 150000
			        , progamt = 150000
			        , contribution = 5
			        , progcap = 2500000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 400000
			        , progamt = 400000
			        , contribution = 5
			        , progcap = 2500000 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 1000000
			        , progamt = 1000000
			        , contribution = 2
			        , progcap = 2500000 WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 1000000
			        , progamt = 1000000
			        , contribution = 2
			        , progcap = 2500000 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 2500000
			        , progamt = 2500000
			        , contribution = 2
			        , progcap = 2500000 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 0
			        , progamt = 0
			        , contribution = 0
			        , progcap = 0 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 0
			        , progamt = 0
			        , contribution = 0
			        , progcap = 0 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 0
			        , progamt = 0
			        , contribution = 0
			        , progcap = 0 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 0
			        , progamt = 0
			        , contribution = 0
			        , progcap = 0 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure game patterns
	EXECUTE b3.dbo.usp_setup_wildfire_CreateGamePatternTable

	UPDATE WildFire_GameSettings 
		SET maxpatterns = 8, maxcalls = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 12
		BEGIN
		UPDATE WildFire_GamePatterns
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
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
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
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
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
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 1
			        , design_1 = 1113121 WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 8 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildFire_GameSettings]
		SET
			-- 84%, $250 Prize Cap, Uniform Ball Distribution',
			[mathmodel_denom_25_percent] = 84.00, 
			[mathmodel_denom_25_prizecap] = 250.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildfire_ConfigureTables_87_1000X_RNG]    Script Date: 09/15/2015 11:37:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildfire_ConfigureTables_87_1000X_RNG]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildfire_ConfigureTables_87_1000X_RNG]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildfire_ConfigureTables_87_1000X_RNG]    Script Date: 09/15/2015 11:37:57 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildfire_ConfigureTables_87_1000X_RNG]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_wildfire_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE usp_setup_wildfire_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 1
		BEGIN
		UPDATE WildFire_GamePayTable
			SET payunit_patt_1 = 4
			        , payunit_patt_2 = 6
			        , payunit_patt_3 = 6
			        , payunit_patt_4 = 12
			        , payunit_patt_5 = 100
			        , payunit_patt_6 = 400
			        , payunit_patt_7 = 400
			        , payunit_patt_8 = 1000
			        , payunit_patt_9 = 0
			        , payunit_patt_10 = 0
			        , payunit_patt_11 = 0
			        , payunit_patt_12 = 0
		
		SET @nDenomCount = @nDenomCount + 1
		END

	-- setup and configure the progressive pay table
	EXECUTE usp_setup_wildfire_CreateProgPayTable

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 12
		BEGIN
		UPDATE WildFire_ProgPayTable
			SET seedamt = 50000
			        , progamt = 50000
			        , contribution = 12
			        , progcap = 11990000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 100000
			        , progamt = 100000
			        , contribution = 10
			        , progcap = 11990000 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 100000
			        , progamt = 100000
			        , contribution = 10
			        , progcap = 11990000 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 150000
			        , progamt = 150000
			        , contribution = 5
			        , progcap = 11990000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 400000
			        , progamt = 400000
			        , contribution = 5
			        , progcap = 11990000 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 1000000
			        , progamt = 1000000
			        , contribution = 2
			        , progcap = 11990000 WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 1000000
			        , progamt = 1000000
			        , contribution = 2
			        , progcap = 11990000 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 2500000
			        , progamt = 2500000
			        , contribution = 2
			        , progcap = 11990000 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 0
			        , progamt = 0
			        , contribution = 0
			        , progcap = 0 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 0
			        , progamt = 0
			        , contribution = 0
			        , progcap = 0 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 0
			        , progamt = 0
			        , contribution = 0
			        , progcap = 0 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 0
			        , progamt = 0
			        , contribution = 0
			        , progcap = 0 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_wildfire_CreateGamePatternTable

	UPDATE WildFire_GameSettings 
		SET maxpatterns = 8, maxcalls = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 12
		BEGIN
		UPDATE WildFire_GamePatterns
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
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Crazy Stamp'
			        , numdesigns = 4
			        , design_1 = 99
			        , design_2 = 3244032
			        , design_3 = 25952256
			        , design_4 = 792 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
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

		UPDATE WildFire_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 4 + @nPatternCount
		
		UPDATE WildFire_GamePatterns
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
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'TNT'
			        , numdesigns = 1
			        , design_1 = 1113121 WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Fireworks'
			        , numdesigns = 1
			        , design_1 = 17971345 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'WildFire'
			        , numdesigns = 1
			        , design_1 = 15217166 WHERE patternid = 8 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildFire_GameSettings]
		SET
			-- 87%, $250 Prize Cap, Uniform Ball Distribution
			[mathmodel_denom_25_percent] = 87.00, 
			[mathmodel_denom_25_prizecap] = 250.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED',
			[autocall] = 'T';
GO


USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildfire_ConfigureTables_Demo]    Script Date: 09/15/2015 11:38:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_config_wildfire_ConfigureTables_Demo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_config_wildfire_ConfigureTables_Demo]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_config_wildfire_ConfigureTables_Demo]    Script Date: 09/15/2015 11:38:00 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_config_wildfire_ConfigureTables_Demo]
AS
	SET NOCOUNT ON

	EXECUTE usp_setup_wildfire_CreateGameSettingsTable

	-- setup and configure the game pay table
	EXECUTE usp_setup_wildfire_CreateGamePayTable

	DECLARE @nDenomCount int

	SET @nDenomCount = 1

	WHILE @nDenomCount <= 1
		BEGIN
		UPDATE WildFire_GamePayTable
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

	-- setup and configure the progressive pay table
	EXECUTE usp_setup_wildfire_CreateProgPayTable

	DECLARE @nPatternCount int

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 12
		BEGIN
		UPDATE WildFire_ProgPayTable
			SET seedamt = 100000
			        , progamt = 100000
			        , contribution = 10
			        , progcap = 1000000 WHERE patternid = 1 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 200000
			        , progamt = 200000
			        , contribution = 20
			        , progcap = 2000000 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 300000
			        , progamt = 300000
			        , contribution = 30
			        , progcap = 3000000 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 400000
			        , progamt = 400000
			        , contribution = 40
			        , progcap = 4000000 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 500000
			        , progamt = 500000
			        , contribution = 50
			        , progcap = 5000000 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 600000
			        , progamt = 600000
			        , contribution = 60
			        , progcap = 6000000 WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 700000
			        , progamt = 700000
			        , contribution = 70
			        , progcap = 7000000 WHERE patternid = 7 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 800000
			        , progamt = 800000
			        , contribution = 80
			        , progcap = 8000000 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 900000
			        , progamt = 900000
			        , contribution = 90
			        , progcap = 9000000 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 1000000
			        , progamt = 1000000
			        , contribution = 100
			        , progcap = 10000000 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 1100000
			        , progamt = 1100000
			        , contribution = 110
			        , progcap = 11000000 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildFire_ProgPayTable
			SET seedamt = 1200000
			        , progamt = 1200000
			        , contribution = 120
			        , progcap = 12000000 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	-- setup and configure game patterns
	EXECUTE usp_setup_wildfire_CreateGamePatternTable

	UPDATE WildFire_GameSettings 
		SET maxpatterns = 12, maxcalls = 24

	SET @nPatternCount = 0

	WHILE @nPatternCount <= 12
		BEGIN
		UPDATE WildFire_GamePatterns
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
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Vertical Lines'
			        , numdesigns = 5
			        , design_1 = 31
			        , design_2 = 992
			        , design_3 = 31744
			        , design_4 = 1015808
			        , design_5 = 32505856 WHERE patternid = 2 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Horiz Lines'
			        , numdesigns = 5
			        , design_1 = 1082401
			        , design_2 = 2164802
			        , design_3 = 4329604
			        , design_4 = 8659208
			        , design_5 = 17318416 WHERE patternid = 3 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Diagonals'
			        , numdesigns = 2
			        , design_1 = 17043521
			        , design_2 = 1118480 WHERE patternid = 4 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Flower'
			        , numdesigns = 1
			        , design_1 = 145536 WHERE patternid = 5 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Four Corners'
			        , numdesigns = 1
			        , design_1 = 17825809 WHERE patternid = 6 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
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
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Letter X'
			        , numdesigns = 1
			        , design_1 = 18157905 WHERE patternid = 8 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Lrg Diamond'
			        , numdesigns = 1
			        , design_1 = 4539716 WHERE patternid = 9 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Crazy T'
			        , numdesigns = 4
			        , design_1 = 1113121
			        , design_2 = 32641156
			        , design_3 = 17333776
			        , design_4 = 4329631 WHERE patternid = 10 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Crazy L'
			        , numdesigns = 4
			        , design_1 = 17318431
			        , design_2 = 32539681
			        , design_3 = 33047056
			        , design_4 = 1082431 WHERE patternid = 11 + @nPatternCount
	
		UPDATE WildFire_GamePatterns
			SET patternname = 'Bow Tie'
			        , numdesigns = 1
			        , design_1 = 32837983 WHERE patternid = 12 + @nPatternCount

		SET @nPatternCount = @nPatternCount + 12
		END

	UPDATE
		[WildFire_GameSettings]
		SET
			[mathmodel_denom_25_percent] = 100.00, 
			[mathmodel_denom_25_prizecap] = 100000.00, 
			[mathmodel_balldistrib] = 'UNIFORM',
			[mathmodel_typedesc] = 'UNVARIED DEMO',
			[autocall] = 'T';
GO



