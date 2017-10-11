USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_SecuritySettings]') AND type in (N'U'))
DROP TABLE [dbo].[B3_SecuritySettings]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_SecuritySettings]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[B3_SecuritySettings](
	[SSID] [int] IDENTITY(1,1) NOT NULL,
	[MinPasswordLength] [int] NULL,
	[PrevPasswordReuseN] [int] NULL,
	[PasswordLockoutAttempts] [int] NULL,
	[NPasswordsExpireDays] [int] NULL,
	[MaximumMachineLoginLimit] [int] NULL,
	[UsePasswordComplexity] [bit] NULL,
	[LogoutInactivity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO

                        insert into [dbo].[B3_SecuritySettings] 
                        select 1, 1, 5,30,0,0,0 
