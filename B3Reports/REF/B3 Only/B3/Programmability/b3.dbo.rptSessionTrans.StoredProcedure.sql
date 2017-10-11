USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[rptSessionTrans]    Script Date: 03/24/2017 11:36:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rptSessionTrans]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rptSessionTrans]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[rptSessionTrans]    Script Date: 03/24/2017 11:36:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[rptSessionTrans]
@SessionNumber int
as
--=========================
--Author:		Karlo Camacho
--Description:	Initial implementation for Session Transaction Report
-- 2017.03.24 tmp: DE13541 Wagers included bets that were made but had a 
--                 malfunction before the game was played. Added a check to 
--                 see if a bet was placed on atleast one card.
--=========================
begin


declare @ResultSet table
(
CreditAcctNum varchar(50),
ReceiptNo int,
LoginID int,
UserName varchar(100),
TransDate datetime,
TransDesc varchar(50),
Credits money,
Wins money,
WinBonus money,
Redeem Money,
Wagers Money,
operatorname varchar(100),
sessnum int,
sessstart datetime,
sessend datetime
)

;With CreditAmount as 
(
	select Id,creditamt, TransDesc 
	from B3_ActivityLog 
	where TransDesc = 'Credit Sale' and sessNum = @SessionNumber
) 
, StartingCreditAmount as 
(
	select CreditAcctNum, ReceiptNo ,Id,creditamt, TransDesc 
	from B3_ActivityLog 
	where TransDesc = 'Credit Sale' and sessNum = @SessionNumber

)
, CreditRedemption as 
(
	select  CreditAcctNum, ReceiptNo, Id, creditamt redeem, TransDesc 
	from B3_ActivityLog 
	where TransDesc = 'Credit Redemption' and sessNum = @SessionNumber

)
,WinAmount as
(
	select crdtSale.Id, (crdtSale.CreditAmt - crdtRedeem.CreditAmt) as WinAmount 
	from B3_ActivityLog crdtSale
	join (	select CreditAcctNum ,creditamt, TransDesc 
	from B3_ActivityLog 
	where TransDesc = 'Credit Sale' and sessNum = @SessionNumber
	) crdtRedeem on crdtRedeem.CreditAcctNum = crdtSale.CreditAcctNum											
	where crdtSale.TransDesc = 'Credit Redemption' and crdtSale.sessNum = @SessionNumber
)
,Wager as --TotalWager and TotalBonus
(
	select al.Id, al.CreditAcctNum , sum(Wgr.betamt) TotalWager, SUM(bonuswinamt) as tBonusWinAmount, SUM(gamewinamt) tGameWinAmount
	from B3_ActivityLog al
	join 
	(
			select	creditacctnum, betamt ,bonuswinamt, gamewinamt 
			from	dbo.CrazyBout_GameJournal 
			where	sessnum = @SessionNumber
					and ( betplaced_card_1 <> 'F'
						  or betplaced_card_2 <> 'F'
						  or betplaced_card_3 <> 'F'
						  or betplaced_card_4 <> 'F'
						  or betplaced_card_5 <> 'F'
						  or betplaced_card_6 <> 'F'
						 )
			union all
			select	creditacctnum, betamt ,bonuswinamt ,gamewinamt 
			from	dbo.JailBreak_GameJournal 
			where	sessnum = @SessionNumber
					and ( betplaced_card_1 <> 'F'
						  or betplaced_card_2 <> 'F'
						  or betplaced_card_3 <> 'F'
						  or betplaced_card_4 <> 'F'
						  or betplaced_card_5 <> 'F'
						  or betplaced_card_6 <> 'F'
						 )
			union all
			select	creditacctnum, betamt ,0 bonuswinamt  ,gamewinamt 
			from	dbo.MayaMoney_GameJournal 
			where	sessnum = @SessionNumber
					and ( betplaced_card_1 <> 'F'
						  or betplaced_card_2 <> 'F'
						  or betplaced_card_3 <> 'F'
						  or betplaced_card_4 <> 'F'
						  or betplaced_card_5 <> 'F'
						  or betplaced_card_6 <> 'F'
						 )
			union all
			select	creditacctnum, betamt ,0 bonuswinamt  ,gamewinamt 
			from	dbo.Slingo_GameJournal 
			where	sessnum = @SessionNumber
			union all
			select	creditacctnum, betamt ,bonuswinamt  ,gamewinamt 
			from	dbo.Spirit76_GameJournal 
			where	sessnum = @SessionNumber
					and ( betplaced_card_1 <> 'F'
						  or betplaced_card_2 <> 'F'
						  or betplaced_card_3 <> 'F'
						  or betplaced_card_4 <> 'F'
						  or betplaced_card_5 <> 'F'
						  or betplaced_card_6 <> 'F'
						 )
			union all
			select	creditacctnum, betamt ,0 bonuswinamt  ,gamewinamt 
			from	dbo.TimeBomb_GameJournal 
			where	sessnum = @SessionNumber
					and ( betplaced_card_1 <> 'F'
						  or betplaced_card_2 <> 'F'
						  or betplaced_card_3 <> 'F'
						  or betplaced_card_4 <> 'F'
						 )
			union all
			select	creditacctnum, betamt  ,0 bonuswinamt , totalpaidamt as gamewinamt  
			from	dbo.UKickEm_GameJournal 
			where	sessnum = @SessionNumber
			union all
			select	creditacctnum, betamt ,bonuswinamt, gamewinamt 
			from	dbo.WildBall_GameJournal 
			where	sessnum = @SessionNumber
					and ( betplaced_card_1 <> 'F'
						  or betplaced_card_2 <> 'F'
						  or betplaced_card_3 <> 'F'
						  or betplaced_card_4 <> 'F'
						  or betplaced_card_5 <> 'F'
						  or betplaced_card_6 <> 'F'
						 )
			union all
			select	creditacctnum, betamt ,0 bonuswinamt, gamewinamt 
			from	dbo.WildFire_GameJournal 
			where	sessnum = @SessionNumber
					and ( betplaced_card_1 <> 'F'
						  or betplaced_card_2 <> 'F'
						  or betplaced_card_3 <> 'F'
						  or betplaced_card_4 <> 'F'
						  or betplaced_card_5 <> 'F'
						  or betplaced_card_6 <> 'F'
						 )
	) Wgr on Wgr.creditacctnum = al.CreditAcctNum
	where al.sessNum = @SessionNumber 
	and al.TransDesc = 'Credit Redemption' 
	group by al.CreditAcctNum, al.Id
)
,VoidAccount as
(
	select creditacctnum, receiptnum ,acctstatus  
	from dbo.B3_CreditJournal 
	where sessnum = @SessionNumber
	and acctstatus = 'EXPIRED'
)
	--FINAL RESULT SET
	insert into @ResultSet
	select 	
	case 
	when LEN(al.CreditAcctNum) = 1 then '0000000'  + cast(al.CreditAcctNum as varchar(8))
	when LEN(al.CreditAcctNum) = 2 then '000000'  + cast(al.CreditAcctNum as varchar(8))
	when LEN(al.CreditAcctNum) = 3 then '00000'  + cast(al.CreditAcctNum as varchar(8))
	when LEN(al.CreditAcctNum) = 4 then '0000'  + cast(al.CreditAcctNum as varchar(8))
	when LEN(al.CreditAcctNum) = 5 then '000'  + cast(al.CreditAcctNum as varchar(8))
	when LEN(al.CreditAcctNum) = 6 then '00'  + cast(al.CreditAcctNum as varchar(8))
	when LEN(al.CreditAcctNum) = 7 then '0'  + cast(al.CreditAcctNum as varchar(8))
	else
	cast(al.CreditAcctNum as varchar(8))
	end as CreditAcctNum,
	al.ReceiptNo,
	cdj.LoginID ,
	cdj.UserName,
	al.TransDate,
	al.TransDesc,
	case when al.TransDesc = 'Unlock Account' then cdj.CreditAmt
	else
	ISNULL (CreditAmount.CreditAmt, StartingCreditAmount.CreditAmt -  ISNULL (Wager.TotalWager,0))
	end as Credits,
	case when al.TransDesc = 'Unlock Account' then cdj.WinCreditAmt
	else
	ISNULL(Wager.tGameWinAmount, 0) end as [Wins],
	ISNULL( Wager.tBonusWinAmount, 0)  as [Win Bonus], 
	ISNULL (CreditRedemption.redeem ,0) as [Redeem],	
	ISNULL ( wager.TotalWager,0) as Wagers, --0.00 as [Wager Amount], 
	sj.operatorname	,
	sj.sessnum,
	sj.sessstart,
	sj.sessend
	from B3_ActivityLog  al
	join dbo.B3_CashDrawerJournal cdj on cdj.ReceiptNum = al.ReceiptNo
	left join VoidAccount on VoidAccount.creditacctnum = al.CreditAcctNum and VoidAccount.receiptnum = al.ReceiptNo
	left join CreditAmount on CreditAmount.TransDesc = al.TransDesc and CreditAmount.Id = al.Id
	left join CreditRedemption on CreditRedemption.TransDesc = al.TransDesc and CreditRedemption.Id = al.Id
	left join Wager on Wager.Id = al.Id
	left join WinAmount on WinAmount.Id = al.Id
	left join StartingCreditAmount on StartingCreditAmount.CreditAcctNum = CreditRedemption.CreditAcctNum
	join B3_SessionsJournal sj on sj.sessnum = al.sessNum
	where al.sessNum = @SessionNumber
	and al.TransType = 0
	order by al.CreditAcctNum, al.TransDate;
	
	
	if ((select IsNorthDakota from B3_SystemConfig ) = 'T')
	begin
		select 
		CreditAcctNum ,
		ReceiptNo ,
		LoginID ,
		UserName ,
		TransDate,
		TransDesc ,
		Credits ,
		Wins ,
		WinBonus ,
		Redeem ,
		Wagers ,
		operatorname ,
		sessnum ,
		sessstart ,
		sessend 
		from @ResultSet
	end
	else 
	begin
	select 
		'xxxx' + substring(CreditAcctNum ,5,8) as CreditAcctNum,
		ReceiptNo ,
		LoginID ,
		UserName ,
		TransDate,
		TransDesc ,
		Credits ,
		Wins ,
		WinBonus ,
		Redeem ,
		Wagers ,
		operatorname ,
		sessnum ,
		sessstart ,
		sessend 
		from @ResultSet
	end
	

end







GO

