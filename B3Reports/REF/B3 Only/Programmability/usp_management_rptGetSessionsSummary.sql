USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_management_rptGetSessionsSummary]    Script Date: 12/22/2015 10:50:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_rptGetSessionsSummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_rptGetSessionsSummary]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_management_rptGetSessionsSummary]    Script Date: 12/22/2015 10:50:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[usp_management_rptGetSessionsSummary]
@DateTime datetime,
@SessionN int
AS
SET NOCOUNT ON


declare @SessEndDateTime datetime
set @SessEndDateTime =  DATEADD( ss,-1,CONVERT(VARCHAR(10), dateadd(dd, 1, @DateTime), 101))     

set @DateTime = CONVERT(VARCHAR(10),  @DateTime, 101)

declare @SessionNumber int
set @SessionNumber = (select top 1 sessnum from b3.dbo.B3_SessionsJournal where sessstart between @DateTime and @SessEndDateTime order by sessnum desc)

	DECLARE @nSessNum int, @nRecCount int
	DECLARE @Beginning_Date DateTime, @Ending_Date DateTime

	SELECT TOP 1 @nSessNum = sessnum, @Ending_Date = sessstart_dt
		FROM b3.dbo.B3_Session

	SET @Beginning_Date = @Ending_Date-1


--Will never be execute
if (@SessionNumber != (select MAX(sessnum) from b3.dbo.B3_SessionsJournal) OR @SessionNumber is null)--If its latest session, then no need to override.
	begin
	set @nSessNum = @SessionNumber
	set @Beginning_Date = @DateTime
	set @Ending_Date = @SessEndDateTime
	end
	
	
	if (select sessactive from B3_SessionsJournal where  sessnum = @SessionN) != 'T'
	begin

		set @Beginning_Date  = (select sessstart from B3_SessionsJournal where sessnum = @SessionN)
		set @Ending_Date  = (select sessend from B3_SessionsJournal where sessnum = @SessionN)
	
	end

	SELECT B3_SessionsJournal.sessnum, sessstart, sessend, operatorname
		, payoutlimit, payoutamt, jackpotlimit, jackpot_1_amt, jackpot_2_amt, jackpot_3_amt
		, acctssold, acctssoldamt, acctsredeem, acctsredeemamt
		, acctsoutstand, acctsoutstandamt, cardssold, cardssoldamt, acctsoutstandwinsamt
		,startingCreditAccountN, endingCreditAccountN
		,TransT.ToTalTransaction, TransT.TransactionStart, TransT.TransacionEnd, isnull(redeem_amt,0) redeem_amt, isnull(wincreditamt, 0) wincreditamt
		FROM b3.dbo.B3_SessionsJournal WITH (NOLOCK)
		left join (select MIN(creditacctnum) startingCreditAccountN , MAX(creditacctnum) endingCreditAccountN , sessnum 
				  from b3.dbo.B3_CreditJournal 
				  --where sessnum = @nSessNum
				  group by sessnum) creditAcctInfo on creditAcctInfo.sessnum = B3_SessionsJournal.sessnum
		left join (select  count(distinct receiptno) ToTalTransaction , x.sessNum, y.TransactionStart, z.TransacionEnd
					from dbo.B3_ActivityLog x
					join (select min(receiptno) TransactionStart , sessnum
					from dbo.B3_ActivityLog 
					where sessnum = @SessionN and receiptno is not null
					group by sessnum) y on y.sessNum = x.sessNum
					join (select max(receiptno) TransacionEnd , sessnum
					from dbo.B3_ActivityLog 
					where sessnum = @SessionN and receiptno is not null
					group by sessnum) z on z.sessNum = x.sessNum
					where x.sessNum = @SessionN and receiptno is not null
					group by x.sessnum,  y.TransactionStart, z.TransacionEnd)
					 TransT  on TransT.sessNum = b3.dbo.B3_SessionsJournal.sessnum
		left join (
				SELECT ISNULL(SUM(redeem_amt), 0) redeem_amt, ISNULL(SUM(wincreditamt), 0) wincreditamt, sessnum
					FROM B3_CreditJournal WITH (NOLOCK) 
						WHERE sessnum = @SessionN AND acctstatus = 'REDEEM'
						group by sessnum) a on a.sessnum = b3.dbo.B3_SessionsJournal.sessnum				
			WHERE
				--		CONVERT(varchar(110),sessstart , 10)	 BETWEEN 	CONVERT(varchar(110),@Beginning_Date , 10) AND 	CONVERT(varchar(110),@Ending_Date , 10) 
				--AND
				--B3_SessionsJournal.[sessnum] <= @nSessNum
				B3_SessionsJournal.[sessnum] = @SessionN
				ORDER BY B3_SessionsJournal.sessnum		









GO


