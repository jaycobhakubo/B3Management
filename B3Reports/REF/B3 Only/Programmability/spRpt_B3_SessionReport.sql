USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRpt_B3_SessionReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRpt_B3_SessionReport]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--exec spRpt_B3_SessionReport 1002


CREATE PROCEDURE [dbo].[spRpt_B3_SessionReport]
@SessionID int,
@UserID int, --Will be use on the report.
@Station varchar(100)--Will be use on the report.
,@DateN datetime --UI
as
	SET NOCOUNT ON

--====================
--Author:	Karlo Camacho 
--Date:		10.14.2015
--Description:
--	Added this script if the session is active.
--	This SP matches the SP from B3(usp_sales_b3_GetSessionReport and usp_sales_b3_GetSessions ).
--====================


-- ===============
-- This script is added for active session only.
-- ================
declare 
@nNumSoldTotal int ,
@nSoldAmtTotal int,
@nNumRedeemTotal int,
@nRedeemAmtTotal int,
@nNumOutstandTotal int,
@nOutstandAmtTotal int 

    --sql script from B3
    declare @nSessNum int set @nSessNum = @SessionID

	SET NOCOUNT ON

	DECLARE @cSessActive char(1)
	DECLARE @nRecCount int

	SET @nNumSoldTotal = 0
	SET @nSoldAmtTotal = 0
	SET @nNumRedeemTotal = 0
	SET @nRedeemAmtTotal = 0
	SET @nNumOutstandTotal = 0
	SET @nOutstandAmtTotal = 0

	SELECT @nSessNum = sessnum, @cSessActive = sessactive
		FROM b3.dbo.B3_Session

	SELECT @nNumSoldTotal = COUNT(*)
		FROM b3.dbo.B3_CreditJournal WITH (NOLOCK)
			WHERE  sessnum = @nSessNum AND sold_amt > 0

	SELECT @nNumRedeemTotal = COUNT(*) 
		FROM b3.dbo.B3_CreditJournal WITH (NOLOCK)
			WHERE  sessnum = @nSessNum AND redeem_amt > 0

	SELECT @nSoldAmtTotal = ISNULL(SUM(sold_amt), 0), @nRedeemAmtTotal = ISNULL(SUM(redeem_amt), 0)
		FROM b3.dbo.B3_CreditJournal WITH (NOLOCK)
			WHERE sessnum = @nSessNum

	DECLARE @cDoubleAccount char(1)

	SELECT TOP 1 @cDoubleAccount = doubleaccount 
		FROM b3.dbo.B3_SystemConfig 

	IF ( @cDoubleAccount = 'T' )
		SELECT @nNumOutstandTotal = COUNT(*), @nOutstandAmtTotal = ISNULL(SUM(creditamt), 0) + ISNULL(SUM(wincreditamt), 0)
			FROM b3.dbo.B3_CreditJournal WITH (NOLOCK)
				WHERE  sessnum = @nSessNum AND (acctstatus = 'INACTIVE' OR acctstatus = 'ACTIVE' OR acctstatus = 'CASHOUT' OR acctstatus = 'EXPIRED' OR acctstatus = 'UNLOCK')
	ELSE
		SELECT @nNumOutstandTotal = COUNT(*), @nOutstandAmtTotal = ISNULL(SUM(creditamt), 0)
			FROM b3.dbo.B3_CreditJournal WITH (NOLOCK)
				WHERE  sessnum = @nSessNum AND (acctstatus = 'INACTIVE' OR acctstatus = 'ACTIVE' OR acctstatus = 'CASHOUT' OR acctstatus = 'EXPIRED' OR acctstatus = 'UNLOCK')

--===============
--END
--===============
declare @SessionIsActive varchar(10)
select @SessionIsActive = sessactive from b3.dbo.B3_SessionsJournal where sessnum = @SessionID

	SELECT recnum, sessnum, sessactive
		, sessstart, sessend
		, operatorid, operatorname
		, acctssold, 
		case when @SessionIsActive = 'F' then   acctssoldamt else   @nSoldAmtTotal end as acctssoldamt
		, acctsredeem, 
		 case when  @SessionIsActive = 'F' then acctsredeemamt else  @nRedeemAmtTotal  end as acctsredeemamt
		, acctsoutstand,
		case when @SessionIsActive = 'F' then  acctsoutstandamt else @nOutstandAmtTotal end as acctsoutstandamt
		, cardssold, cardssoldamt, totalpaidamt, payoutpercent
		, payoutlimit, payoutamt
		FROM b3.dbo.B3_SessionsJournal 
		where sessnum = @SessionID
			ORDER BY sessnum DESC
			




GO


