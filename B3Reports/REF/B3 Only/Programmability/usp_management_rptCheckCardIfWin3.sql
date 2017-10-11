USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_management_rptCheckCardIfWin3]    Script Date: 12/15/2015 12:53:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_rptCheckCardIfWin3]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_rptCheckCardIfWin3]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_management_rptCheckCardIfWin3]    Script Date: 12/15/2015 12:53:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--USE [B3]
--GO

--/****** Object:  StoredProcedure [dbo].[b3_fnCheckCardIfWin3]    Script Date: 11/29/2015 1:31:35 PM ******/
--DROP PROCEDURE [dbo].[b3_fnCheckCardIfWin3]
--GO

--/****** Object:  StoredProcedure [dbo].[b3_fnCheckCardIfWin3]    Script Date: 11/29/2015 1:31:35 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


CREATE PROC [dbo].[usp_management_rptCheckCardIfWin3]
--Function Variable
(
	@TempN int,
	@BallCall varchar(1000),
	@m_CardN int,
	@Exists BIT Output
)
--returns bit 
AS
begin
--Function return
	--declare @Exists bit 
	set @Exists = 1
	DECLARE @command nvarchar(4000);
	DECLARE @ParmDefinition nvarchar(500);
	declare @WinningNumber varchar(50) set @WinningNumber = ''
	declare @TempWinningCardNumber int

	select @command = 'select  @cardNumber = cardnum_' +  CAST(@TempN as varchar(10)) + ' from dbo.B3_CardPerm_GTI_250K where cardNumber = @cardN' 
	set @ParmDefinition = N'@cardN int,   @cardNumber int OUTPUT'
	EXECUTE sp_executesql @command, @ParmDefinition, @cardN = @m_CardN, @cardNumber = @TempWinningCardNumber OUTPUT	
	set @WinningNumber = @WinningNumber + cast(@TempWinningCardNumber as varchar(10)) +','
	declare @x varchar(10)	set @x = ','+ cast(@TempWinningCardNumber as varchar(10)) +',' 	

	if (CHARINDEX(@x , @BallCall )) > 0
	begin
	set @Exists = 1
	end
	else
	begin
	set @Exists = 0--No winner.
	end

	return
	 --@Exists
end



GO


