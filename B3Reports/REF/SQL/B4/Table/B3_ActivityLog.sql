USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_ActivityLog]') AND type in (N'U'))
DROP TABLE [dbo].[B3_ActivityLog]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_ActivityLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[B3_ActivityLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MAC] [char](12) NOT NULL,
	[TransType] [int] NOT NULL,
	[TransNo] [int] NULL,
	[TransDate] [datetime] NOT NULL,
	[MachineName] [char](11) NULL,
	[CreditAcctNum] [int] NULL,
	[CreditAmt] [int] NULL,
	[WinsAmt] [int] NULL,
	[ReceiptNo] [int] NULL,
	[TransDesc] [nvarchar](32) NULL,
	[UserName] [char](10) NULL,
	[sessNum] [int] NULL,
 CONSTRAINT [PK_B3_ActivityLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_PADDING OFF
GO


