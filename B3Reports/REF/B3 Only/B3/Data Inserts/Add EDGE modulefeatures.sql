--select * from [dbo].[ModuleFeatures]
use daily
go
if not exists(select 1 from daily.dbo.ModuleFeatures where ModuleFeatureID = 47)
begin
set identity_insert daily.dbo.ModuleFeatures on
insert into ModuleFeatures(ModuleFeatureID, ModuleID, ModuleFeatureName, ModuleFeatureDescription, IsCreditFeature, IsGTIStaffFeature, SequenceNo)
values (47, 247, 'Paytable Settings','Allow the user to modify B3 Setting paytable',0,0,1)
set identity_insert daily.dbo.ModuleFeatures off
end