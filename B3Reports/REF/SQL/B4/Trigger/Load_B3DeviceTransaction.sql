USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Load_B3DeviceTransaction]'))
DROP TRIGGER [dbo].[Load_B3DeviceTransaction]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Load_B3DeviceTransaction]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[Load_B3DeviceTransaction]
            -- =============================================
            -- Author:		Karlo  Camacho
            -- Create date: 7/30/2013 
            -- Description:	A trigger that will populate the [dbo].[B3_DeviceTransactions] in every insert on B3_ClientMap 
                   
            -- =============================================
            on [dbo].[B3_ClientMap]
            for insert
            as 
            begin



            --Get the ClientAddress after insert.
            declare @ClientMac char(12)
            select  @ClientMac = clientmac from inserted



            --Check if the client mac already exists in [dbo].[B3_DeviceTransactions].
            --Does it insert everytime they turn the unit on?.
            if not exists (select 1 from [dbo].[B3_DeviceTransactions] where MAC = @ClientMac)
            begin 

            insert into [dbo].[B3_DeviceTransactions] Values (@ClientMac, 1)

            -- check if the table [dbo].[B3_DeviceTransactions] exists
            --if exists (select 1 from sys.tables where name = ''B3_DeviceTransactions'')--not working
            --begin 
            --insert into [dbo].[B3_DeviceTransactions] Values (@ClientMac, 1)
            --end
            end
            end
            ' 
GO


