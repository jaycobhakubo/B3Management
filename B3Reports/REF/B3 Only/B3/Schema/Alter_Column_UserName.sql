use B3 
go
Alter table b3.dbo.B3_CashDrawerJournal
alter column UserName char(50)
go
alter table dbo.B3_ActivityLog
alter column UserName char(50)
go 
alter table dbo.B3_CreditJournal
alter column redeem_username char(50)
go
alter table dbo.B3_CreditJournal
alter column sold_username char(50)
go 
alter table dbo.B3_VoidAccountsJournal
alter column UserName char(50)