USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_VersionInfo]') AND type in (N'U'))
DROP TABLE [dbo].[B3_VersionInfo]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[B3_VersionInfo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[B3_VersionInfo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Version] [nvarchar](32) NOT NULL,
	[Major] [int] NULL,
	[Minor] [int] NULL,
	[Build] [int] NULL,
	[Revision] [int] NULL,
 CONSTRAINT [pk_B3VersionInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
set identity_insert B3_VersionInfo on

INSERT INTO [B3_VersionInfo] ([Id],[Version],[Major],[Minor],[Build],[Revision])VALUES(1,'B3 4.0',3,0,11,1)
INSERT INTO [B3_VersionInfo] ([Id],[Version],[Major],[Minor],[Build],[Revision])VALUES(2,'B3OTG.exe',3,0,11,0)
INSERT INTO [B3_VersionInfo] ([Id],[Version],[Major],[Minor],[Build],[Revision])VALUES(3,'B3Player.exe',3,0,11,0)
INSERT INTO [B3_VersionInfo] ([Id],[Version],[Major],[Minor],[Build],[Revision])VALUES(4,'B3Sales.exe',3,0,11,0)
INSERT INTO [B3_VersionInfo] ([Id],[Version],[Major],[Minor],[Build],[Revision])VALUES(5,'binkw32.dll',1,0,23,0)
INSERT INTO [B3_VersionInfo] ([Id],[Version],[Major],[Minor],[Build],[Revision])VALUES(6,'Sales Extractor.exe',1,5,1,0)
INSERT INTO [B3_VersionInfo] ([Id],[Version],[Major],[Minor],[Build],[Revision])VALUES(7,'B3OTGServer.exe',3,0,11,0)
INSERT INTO [B3_VersionInfo] ([Id],[Version],[Major],[Minor],[Build],[Revision])VALUES(8,'B3Management.exe',1,0,0,0)

set identity_insert B3_VersionInfo off
