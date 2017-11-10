USE [B3]
GO

/****** Object:  Table [dbo].[B3_BallCallLogPerSession]    Script Date: 11/17/2015 14:57:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_BallCallLogPerSession]') AND type in (N'U'))
DROP TABLE [dbo].[B3_BallCallLogPerSession]
GO

USE [B3]
GO

/****** Object:  Table [dbo].[B3_BallCallLogPerSession]    Script Date: 11/17/2015 14:57:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[B3_BallCallLogPerSession](
	[sessnum] [int] NOT NULL,
	[sessactive] [char](1) NOT NULL,
	[sessstart_dt] [datetime] NOT NULL,
	[sessend_dt] [datetime] NOT NULL,
	[payoutlimit] [int] NOT NULL,
	[payoutamt] [int] NOT NULL,
	[jackpotlimit] [int] NOT NULL,
	[jackpot_1_amt] [int] NOT NULL,
	[jackpot_2_amt] [int] NOT NULL,
	[jackpot_3_amt] [int] NOT NULL,
	[receiptnum] [int] NOT NULL,
	[enforcemix] [char](1) NOT NULL,
	[gamecalls] [tinyint] NOT NULL,
	[bonuscalls] [tinyint] NOT NULL,
	[ball_1] [tinyint] NOT NULL,
	[ball_2] [tinyint] NOT NULL,
	[ball_3] [tinyint] NOT NULL,
	[ball_4] [tinyint] NOT NULL,
	[ball_5] [tinyint] NOT NULL,
	[ball_6] [tinyint] NOT NULL,
	[ball_7] [tinyint] NOT NULL,
	[ball_8] [tinyint] NOT NULL,
	[ball_9] [tinyint] NOT NULL,
	[ball_10] [tinyint] NOT NULL,
	[ball_11] [tinyint] NOT NULL,
	[ball_12] [tinyint] NOT NULL,
	[ball_13] [tinyint] NOT NULL,
	[ball_14] [tinyint] NOT NULL,
	[ball_15] [tinyint] NOT NULL,
	[ball_16] [tinyint] NOT NULL,
	[ball_17] [tinyint] NOT NULL,
	[ball_18] [tinyint] NOT NULL,
	[ball_19] [tinyint] NOT NULL,
	[ball_20] [tinyint] NOT NULL,
	[ball_21] [tinyint] NOT NULL,
	[ball_22] [tinyint] NOT NULL,
	[ball_23] [tinyint] NOT NULL,
	[ball_24] [tinyint] NOT NULL,
	[ball_25] [tinyint] NOT NULL,
	[ball_26] [tinyint] NOT NULL,
	[ball_27] [tinyint] NOT NULL,
	[ball_28] [tinyint] NOT NULL,
	[ball_29] [tinyint] NOT NULL,
	[ball_30] [tinyint] NOT NULL,
	[ball_31] [tinyint] NOT NULL,
	[ball_32] [tinyint] NOT NULL,
	[ball_33] [tinyint] NOT NULL,
	[ball_34] [tinyint] NOT NULL,
	[ball_35] [tinyint] NOT NULL,
	[ball_36] [tinyint] NOT NULL,
	[ball_37] [tinyint] NOT NULL,
	[ball_38] [tinyint] NOT NULL,
	[ball_39] [tinyint] NOT NULL,
	[ball_40] [tinyint] NOT NULL,
	[ball_41] [tinyint] NOT NULL,
	[ball_42] [tinyint] NOT NULL,
	[ball_43] [tinyint] NOT NULL,
	[ball_44] [tinyint] NOT NULL,
	[ball_45] [tinyint] NOT NULL,
	[ball_46] [tinyint] NOT NULL,
	[ball_47] [tinyint] NOT NULL,
	[ball_48] [tinyint] NOT NULL,
	[ball_49] [tinyint] NOT NULL,
	[ball_50] [tinyint] NOT NULL,
	[ball_51] [tinyint] NOT NULL,
	[ball_52] [tinyint] NOT NULL,
	[ball_53] [tinyint] NOT NULL,
	[ball_54] [tinyint] NOT NULL,
	[ball_55] [tinyint] NOT NULL,
	[ball_56] [tinyint] NOT NULL,
	[ball_57] [tinyint] NOT NULL,
	[ball_58] [tinyint] NOT NULL,
	[ball_59] [tinyint] NOT NULL,
	[ball_60] [tinyint] NOT NULL,
	[ball_61] [tinyint] NOT NULL,
	[ball_62] [tinyint] NOT NULL,
	[ball_63] [tinyint] NOT NULL,
	[ball_64] [tinyint] NOT NULL,
	[ball_65] [tinyint] NOT NULL,
	[ball_66] [tinyint] NOT NULL,
	[ball_67] [tinyint] NOT NULL,
	[ball_68] [tinyint] NOT NULL,
	[ball_69] [tinyint] NOT NULL,
	[ball_70] [tinyint] NOT NULL,
	[ball_71] [tinyint] NOT NULL,
	[ball_72] [tinyint] NOT NULL,
	[ball_73] [tinyint] NOT NULL,
	[ball_74] [tinyint] NOT NULL,
	[ball_75] [tinyint] NOT NULL,
	[Action_] [varchar](50) NULL,
	[ActionDateTime_] [datetime] NULL,
	[LoginID] [int] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


