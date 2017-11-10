use b3 
go
update b3.dbo.B3_SystemConfig
set [version] = '4.4.0'
go 
update b3.dbo.B3_VersionInfo
set Version = 'B3 4.4.0' where ID = 1;



