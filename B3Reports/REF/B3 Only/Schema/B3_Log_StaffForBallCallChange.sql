USE [B3]
GO

/****** Object:  Table [dbo].[B3_Log_StaffForBallCallChange]    Script Date: 11/17/2015 11:40:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_Log_StaffForBallCallChange]') AND type in (N'U'))
DROP TABLE [dbo].[B3_Log_StaffForBallCallChange]
GO

USE [B3]
GO

/****** Object:  Table [dbo].[B3_Log_StaffForBallCallChange]    Script Date: 11/17/2015 11:40:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[B3_Log_StaffForBallCallChange](
	[cLoginID] [int] NULL,
	[DateTimeBallChange] [datetime] NULL,
	[sessionnumber] [int] NULL
) ON [PRIMARY]

GO


