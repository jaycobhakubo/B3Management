USE [B3]
GO

/****** Object:  Table [dbo].[B3_PasswordStaff]    Script Date: 10/01/2014 14:15:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_PasswordStaff]') AND type in (N'U'))
DROP TABLE [dbo].[B3_PasswordStaff]
GO

USE [B3]
GO

/****** Object:  Table [dbo].[B3_PasswordStaff]    Script Date: 10/01/2014 14:15:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[B3_PasswordStaff](
	[PSID] [int] IDENTITY(1,1) NOT NULL,
	[LoginID] [int] NULL,
	[PasswordUsed] [char](15) NULL,
	[IsCurrent] [bit] NULL,
	[DateUsed] datetime Null
PRIMARY KEY CLUSTERED 
(
	[PSID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


--let us load all the password of the current user 
--This should only run one time upon installation 
truncate table B3_PasswordStaff
insert into B3_PasswordStaff
select LoginID, UserPassword, 1, ChangePasswordActualDate  from [dbo].[B3_Login]