
use Daily
declare @w2Trigger int
select @w2Trigger = w2trigger from b3.dbo.B3_SystemConfig 

if  exists(select 1 from [Daily].[dbo].[B3SettingsGlobal] where SettingID = 61)
begin
delete from [Daily].[dbo].[B3SettingsGlobal] where SettingID = 61
end

insert into [Daily].[dbo].[B3SettingsGlobal](SettingID, SettingCategoryID, SettingValue, SettingDesc)
values (61, 7, cast(@w2Trigger as varchar(100)),'W2 Trigger' )


