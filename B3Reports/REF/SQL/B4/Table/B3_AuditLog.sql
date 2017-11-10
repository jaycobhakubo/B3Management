USE [B3]
GO

/****** Object:  Table [dbo].[B3_AuditLog]    Script Date: 02/06/2015 14:59:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_AuditLog]') AND type in (N'U'))
DROP TABLE [dbo].[B3_AuditLog]
GO

USE [B3]
GO

/****** Object:  Table [dbo].[B3_AuditLog]    Script Date: 02/06/2015 14:59:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[B3_AuditLog](
	[DateNTime] [datetime] NULL,
	[CurrentLoginUser] [varchar](15) NULL,
	[UserName] [varchar](15) NULL,
	[PhysicalAdress] [varchar](50) NULL,
	[Settings] [varchar](100) NULL,
	[Action] [varchar](1000) NULL,
	[PreviousValue] [varchar](15) NULL,
	[NewValue] [varchar](15) NULL,
	[PhysicalAddress_Modified] [varchar](20) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


