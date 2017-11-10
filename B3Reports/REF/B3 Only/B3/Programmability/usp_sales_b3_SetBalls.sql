USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_sales_b3_SetBalls]    Script Date: 12/14/2015 12:32:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_sales_b3_SetBalls]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_sales_b3_SetBalls]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_sales_b3_SetBalls]    Script Date: 12/14/2015 12:32:41 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[usp_sales_b3_SetBalls]
@StaffID int,
	  @cBall_1   tinyint, @cBall_2   tinyint, @cBall_3   tinyint, @cBall_4   tinyint, @cBall_5   tinyint
	, @cBall_6   tinyint, @cBall_7   tinyint, @cBall_8   tinyint, @cBall_9   tinyint, @cBall_10 tinyint
	, @cBall_11 tinyint, @cBall_12 tinyint, @cBall_13 tinyint, @cBall_14 tinyint, @cBall_15 tinyint
	, @cBall_16 tinyint, @cBall_17 tinyint, @cBall_18 tinyint, @cBall_19 tinyint, @cBall_20 tinyint
	, @cBall_21 tinyint, @cBall_22 tinyint, @cBall_23 tinyint, @cBall_24 tinyint, @cBall_25 tinyint
	, @cBall_26 tinyint, @cBall_27 tinyint, @cBall_28 tinyint, @cBall_29 tinyint, @cBall_30 tinyint
	, @cBall_31 tinyint, @cBall_32 tinyint, @cBall_33 tinyint, @cBall_34 tinyint, @cBall_35 tinyint
	, @cBall_36 tinyint, @cBall_37 tinyint, @cBall_38 tinyint, @cBall_39 tinyint, @cBall_40 tinyint
	, @cBall_41 tinyint, @cBall_42 tinyint, @cBall_43 tinyint, @cBall_44 tinyint, @cBall_45 tinyint
	, @cBall_46 tinyint, @cBall_47 tinyint, @cBall_48 tinyint, @cBall_49 tinyint, @cBall_50 tinyint
	, @cBall_51 tinyint, @cBall_52 tinyint, @cBall_53 tinyint, @cBall_54 tinyint, @cBall_55 tinyint
	, @cBall_56 tinyint, @cBall_57 tinyint, @cBall_58 tinyint, @cBall_59 tinyint, @cBall_60 tinyint
	, @cBall_61 tinyint, @cBall_62 tinyint, @cBall_63 tinyint, @cBall_64 tinyint, @cBall_65 tinyint
	, @cBall_66 tinyint, @cBall_67 tinyint, @cBall_68 tinyint, @cBall_69 tinyint, @cBall_70 tinyint
	, @cBall_71 tinyint, @cBall_72 tinyint, @cBall_73 tinyint, @cBall_74 tinyint, @cBall_75 tinyint
AS
	SET NOCOUNT ON

	UPDATE B3_Session
		SET ball_1 = @cBall_1, ball_2 = @cBall_2, ball_3 = @cBall_3, ball_4 = @cBall_4, ball_5 = @cBall_5
		        , ball_6 = @cBall_6, ball_7 = @cBall_7, ball_8 = @cBall_8, ball_9 = @cBall_9, ball_10 = @cBall_10
		        , ball_11 = @cBall_11, ball_12 = @cBall_12, ball_13 = @cBall_13, ball_14 = @cBall_14, ball_15 = @cBall_15
		        , ball_16 = @cBall_16, ball_17 = @cBall_17, ball_18 = @cBall_18, ball_19 = @cBall_19, ball_20 = @cBall_20
		        , ball_21 = @cBall_21, ball_22 = @cBall_22, ball_23 = @cBall_23, ball_24 = @cBall_24, ball_25 = @cBall_25
		        , ball_26 = @cBall_26, ball_27 = @cBall_27, ball_28 = @cBall_28, ball_29 = @cBall_29, ball_30 = @cBall_30
		        , ball_31 = @cBall_31, ball_32 = @cBall_32, ball_33 = @cBall_33, ball_34 = @cBall_34, ball_35 = @cBall_35
		        , ball_36 = @cBall_36, ball_37 = @cBall_37, ball_38 = @cBall_38, ball_39 = @cBall_39, ball_40 = @cBall_40
		        , ball_41 = @cBall_41, ball_42 = @cBall_42, ball_43 = @cBall_43, ball_44 = @cBall_44, ball_45 = @cBall_45
		        , ball_46 = @cBall_46, ball_47 = @cBall_47, ball_48 = @cBall_48, ball_49 = @cBall_49, ball_50 = @cBall_50
		        , ball_51 = @cBall_51, ball_52 = @cBall_52, ball_53 = @cBall_53, ball_54 = @cBall_54, ball_55 = @cBall_55
		        , ball_56 = @cBall_56, ball_57 = @cBall_57, ball_58 = @cBall_58, ball_59 = @cBall_59, ball_60 = @cBall_60
		        , ball_61 = @cBall_61, ball_62 = @cBall_62, ball_63 = @cBall_63, ball_64 = @cBall_64, ball_65 = @cBall_65
		        , ball_66 = @cBall_66, ball_67 = @cBall_67, ball_68 = @cBall_68, ball_69 = @cBall_69, ball_70 = @cBall_70
		        , ball_71 = @cBall_71, ball_72 = @cBall_72, ball_73 = @cBall_73, ball_74 = @cBall_74, ball_75 = @cBall_75

--Log ballcall change setting.
--Get the session number if session number is null set it to -1 
declare @B3SessionNumber int

if ((select sessactive from B3_Session) = 'F')
begin 
	set @B3SessionNumber = -1 
end
else 
begin 
	set @B3SessionNumber = (select sessnum from B3_Session)
end

insert into B3_Log_StaffForBallCallChange (cLoginID, DateTimeBallChange, sessionnumber)
values (@StaffID, GETDATE(), @B3SessionNumber)

GO



