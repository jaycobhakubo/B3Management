USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_sales_b3_Set_B3_Log_StaffForBallCallChange]    Script Date: 11/17/2015 14:47:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_sales_b3_Set_B3_Log_StaffForBallCallChange]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_sales_b3_Set_B3_Log_StaffForBallCallChange]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_sales_b3_Set_B3_Log_StaffForBallCallChange]    Script Date: 11/17/2015 14:47:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_sales_b3_Set_B3_Log_StaffForBallCallChange]
(
	@cName varchar(15),
	@cPassword varchar(15)
)
as
declare @nLoginID int 
declare @nSession int

SELECT TOP 1 @nLoginID = LoginID
				FROM B3_Login
					WHERE UserName = @cName AND UserPassword = @cPassword

--Get session
if  exists( select 1 from B3_Session where sessactive = 'T')
begin
set @nSession = (select top 1 sessnum from B3_Session where sessactive = 'T')
end
else
begin
set @nSession = -1;
end

Insert into B3_Log_StaffForBallCallChange (cLoginID,DateTimeBallChange, sessionnumber  )
 values ( @nLoginID, GETDATE(), @nSession)
 
 insert into dbo.B3_BallCallLogPerSession
				(
				[sessnum]
      ,[sessactive]
      ,[sessstart_dt]
      ,[sessend_dt]
      ,[payoutlimit]
      ,[payoutamt]
      ,[jackpotlimit]
      ,[jackpot_1_amt]
      ,[jackpot_2_amt]
      ,[jackpot_3_amt]
      ,[receiptnum]
      ,[enforcemix]
      ,[gamecalls]
      ,[bonuscalls]
      ,[ball_1]
      ,[ball_2]
      ,[ball_3]
      ,[ball_4]
      ,[ball_5]
      ,[ball_6]
      ,[ball_7]
      ,[ball_8]
      ,[ball_9]
      ,[ball_10]
      ,[ball_11]
      ,[ball_12]
      ,[ball_13]
      ,[ball_14]
      ,[ball_15]
      ,[ball_16]
      ,[ball_17]
      ,[ball_18]
      ,[ball_19]
      ,[ball_20]
      ,[ball_21]
      ,[ball_22]
      ,[ball_23]
      ,[ball_24]
      ,[ball_25]
      ,[ball_26]
      ,[ball_27]
      ,[ball_28]
      ,[ball_29]
      ,[ball_30]
      ,[ball_31]
      ,[ball_32]
      ,[ball_33]
      ,[ball_34]
      ,[ball_35]
      ,[ball_36]
      ,[ball_37]
      ,[ball_38]
      ,[ball_39]
      ,[ball_40]
      ,[ball_41]
      ,[ball_42]
      ,[ball_43]
      ,[ball_44]
      ,[ball_45]
      ,[ball_46]
      ,[ball_47]
      ,[ball_48]
      ,[ball_49]
      ,[ball_50]
      ,[ball_51]
      ,[ball_52]
      ,[ball_53]
      ,[ball_54]
      ,[ball_55]
      ,[ball_56]
      ,[ball_57]
      ,[ball_58]
      ,[ball_59]
      ,[ball_60]
      ,[ball_61]
      ,[ball_62]
      ,[ball_63]
      ,[ball_64]
      ,[ball_65]
      ,[ball_66]
      ,[ball_67]
      ,[ball_68]
      ,[ball_69]
      ,[ball_70]
      ,[ball_71]
      ,[ball_72]
      ,[ball_73]
      ,[ball_74]
      ,[ball_75]
      ,Action_ 
      ,ActionDateTime_
      ,LoginID
				)
				select 
			@nSession
      ,[sessactive]
      ,[sessstart_dt]
      ,[sessend_dt]
      ,[payoutlimit]
      ,[payoutamt]
      ,[jackpotlimit]
      ,[jackpot_1_amt]
      ,[jackpot_2_amt]
      ,[jackpot_3_amt]
      ,[receiptnum]
      ,[enforcemix]
      ,[gamecalls]
      ,[bonuscalls]
      ,[ball_1]
      ,[ball_2]
      ,[ball_3]
      ,[ball_4]
      ,[ball_5]
      ,[ball_6]
      ,[ball_7]
      ,[ball_8]
      ,[ball_9]
      ,[ball_10]
      ,[ball_11]
      ,[ball_12]
      ,[ball_13]
      ,[ball_14]
      ,[ball_15]
      ,[ball_16]
      ,[ball_17]
      ,[ball_18]
      ,[ball_19]
      ,[ball_20]
      ,[ball_21]
      ,[ball_22]
      ,[ball_23]
      ,[ball_24]
      ,[ball_25]
      ,[ball_26]
      ,[ball_27]
      ,[ball_28]
      ,[ball_29]
      ,[ball_30]
      ,[ball_31]
      ,[ball_32]
      ,[ball_33]
      ,[ball_34]
      ,[ball_35]
      ,[ball_36]
      ,[ball_37]
      ,[ball_38]
      ,[ball_39]
      ,[ball_40]
      ,[ball_41]
      ,[ball_42]
      ,[ball_43]
      ,[ball_44]
      ,[ball_45]
      ,[ball_46]
      ,[ball_47]
      ,[ball_48]
      ,[ball_49]
      ,[ball_50]
      ,[ball_51]
      ,[ball_52]
      ,[ball_53]
      ,[ball_54]
      ,[ball_55]
      ,[ball_56]
      ,[ball_57]
      ,[ball_58]
      ,[ball_59]
      ,[ball_60]
      ,[ball_61]
      ,[ball_62]
      ,[ball_63]
      ,[ball_64]
      ,[ball_65]
      ,[ball_66]
      ,[ball_67]
      ,[ball_68]
      ,[ball_69]
      ,[ball_70]
      ,[ball_71]
      ,[ball_72]
      ,[ball_73]
      ,[ball_74]
      ,[ball_75]
      ,'CHANGE SET BALL'
      ,GETDATE()
      ,@nLoginID
				 from dbo.B3_Session 
				 --where sessActive = 'T'
 
 
GO


