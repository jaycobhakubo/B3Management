USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_sales_b3_GetSessionsSummary_Day]    Script Date: 12/15/2015 12:41:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_sales_b3_GetSessionsSummary_Day]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_sales_b3_GetSessionsSummary_Day]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_sales_b3_GetSessionsSummary_Day]    Script Date: 12/15/2015 12:41:34 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[usp_sales_b3_GetSessionsSummary_Day]
AS
	SET NOCOUNT ON

	DECLARE @nSessNum int, @nRecCount int
	DECLARE @Beginning_Date DateTime, @Ending_Date DateTime

	SELECT TOP 1 @nSessNum = sessnum, @Ending_Date = sessstart_dt
		FROM B3_Session

	SET @Beginning_Date = @Ending_Date-1

	SELECT B3_SessionsJournal.sessnum, sessstart, sessend, operatorname
		, payoutlimit, payoutamt, jackpotlimit, jackpot_1_amt, jackpot_2_amt, jackpot_3_amt
		, acctssold, acctssoldamt, acctsredeem, acctsredeemamt
		, acctsoutstand, acctsoutstandamt, cardssold, cardssoldamt, acctsoutstandwinsamt
		,startingCreditAccountN, endingCreditAccountN
		FROM B3_SessionsJournal WITH (NOLOCK)
		join (select MIN(creditacctnum) startingCreditAccountN , MAX(creditacctnum) endingCreditAccountN , sessnum 
			  from dbo.B3_CreditJournal 
			  where sessnum <= @nSessNum
			  group by sessnum)
			  creditAcctInfo on creditAcctInfo.sessnum = B3_SessionsJournal.sessnum
			WHERE
				sessstart BETWEEN @Beginning_Date AND @Ending_Date
				AND
				B3_SessionsJournal.[sessnum] <= @nSessNum
				ORDER BY B3_SessionsJournal.sessnum



GO


