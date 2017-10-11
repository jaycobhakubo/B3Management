USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_management_rptAccountHistory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_management_rptAccountHistory]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[usp_management_rptAccountHistory]
(
--declare
@P_Date_ datetime,
@SessionID_ int,
@AccountNumber int
--set @P_Date_ = '03/14/2016 00:00:00'
--set @SessionID_ = 1011
--set @AccountNumber = 80308909

)

as

	declare @FinalResult table
	(


	DateTimeTransaction datetime,
	ReceiptNumber int,
	TransactionType varchar(100),
	TransactionLocation varchar(100),
	GameNumber int,
	GameName varchar(100),
	Credits int,
	BetAmount int,
	Denom int,
	NumberOfCardsWagered int,
	SerialCardNumberPlayed varchar(100),
	Win int , -- (Win + Bonus)
	WinBalance int, -- For dual Accounting
	CreditBalance int,
	GameSite varchar(50),
	OperatorName varchar(50)

	)


	declare @TransactionDetailReport table
	(
		TransType varchar(50),
		MAC varchar(50),
		TransNo varchar(50),
		ReceiptNo int,
		TransDate datetime,				
		TransDesc varchar(50),
		CreditAcctNum varchar(100),
		CreditAmt Money,
		WinsAmt money,
		UserName varchar(100),
		SessNum int,
		SessStart datetime,
		SessEnd datetime,
		operatorname varchar(100),
		sessactive varchar(2),
		TransactionLocation Varchar(100)
	)
           
				declare
				@start datetime,
				@SessionID int

				set @start = @P_Date_
				set @SessionID = @SessionID_
                      
               
                      
				;with x as
				(  select
					al.TransNo, 
					al.ReceiptNo, 
					AL.TransDesc, 
					al.CreditAcctNum,
					isnull( al.CreditAmt,0.00) CreditAmt, 
					isnull(al.WinsAmt,0.00)  WinsAmt  
					from B3_ActivityLog al 
					left join (select sessnum, sessstart, sessend, operatorname, sessactive from  [dbo].[B3_SessionsJournal]) sj
					on sj.sessnum = al.sessnum         
					where al.sessNum = @SessionID 	
					and al.CreditAcctNum = @AccountNumber 
					and CAST(CONVERT(varchar(12), al.TransDate, 101) AS SMALLDATETIME)  = CAST(CONVERT(varchar(12), @start, 101) AS SMALLDATETIME)
					and al.TransDesc not in ('Game Start')
				    and TransDesc =   case when TransDesc != 'Cash Out' then 'Unlock Account' else 'Cash Out' end
				    --and TransNo = (     select MAX(TransNo) from B3_ActivityLog where CreditAcctNum = @AccountNumber and TransDesc = case when TransDesc != 'Cash Out' then 'Unlock Account' else 'Cash Out' end)
				    and ReceiptNo = (     select MAX(ReceiptNo) from B3_ActivityLog where CreditAcctNum = @AccountNumber and TransDesc = case when TransDesc != 'Cash Out' then 'Unlock Account' else 'Cash Out' end))
				  
					
					insert into @TransactionDetailReport
					select 
					al.TransType [TransType], 
					al.MAC, 
					al.TransNo, 
					al.ReceiptNo, 
					al.TransDate, 
					AL.TransDesc, 
					case 
					when LEN(al.CreditAcctNum) = 1 then '0000000'  + cast(al.CreditAcctNum as varchar(8))
					when LEN(al.CreditAcctNum) = 2 then '000000'  + cast(al.CreditAcctNum as varchar(8))
					when LEN(al.CreditAcctNum) = 3 then '00000'   + cast(al.CreditAcctNum as varchar(8))
					when LEN(al.CreditAcctNum) = 4 then '0000'  + cast(al.CreditAcctNum as varchar(8))
					when LEN(al.CreditAcctNum) = 5 then '000'  + cast(al.CreditAcctNum as varchar(8))
					when LEN(al.CreditAcctNum) = 6 then '00'  + cast(al.CreditAcctNum as varchar(8))
					when LEN(al.CreditAcctNum) = 7 then '0'  + cast(al.CreditAcctNum as varchar(8))
					else
					cast(al.CreditAcctNum as varchar(8)) end as CreditAcctNum,      
					isnull( z.CreditAmt ,al.CreditAmt) CreditAmt,   
					isnull( z.WinsAmt, al.WinsAmt)  WinsAmt,   
					/*al.WinsAmt,*/ al.UserName
					,al.SessNum, 
					sj.sessstart SessStart,
					case sessactive
						when 'T' then null 
						else   sj.sessend end SessEnd ,			  
					sj.operatorname, sessactive --into #T_TransactionDetail  
					,MachineName        
				from B3_ActivityLog al 
				left join	(select sessnum, sessstart, sessend, operatorname, sessactive from  [dbo].[B3_SessionsJournal]) sj
							on sj.sessnum = al.sessnum
				left join (	select y.* from x y
							inner join ( select max(TransNo) TransNo, ReceiptNo from x group by ReceiptNo) x on x.TransNo = y.TransNo AND x.ReceiptNo = y.ReceiptNo ) z
				on (z.CreditAcctNum = al.CreditAcctNum and AL.TransDesc = 'Credit Redemption')
				where al.sessNum = @SessionID
				and al.CreditAcctNum = @AccountNumber  
				and   
				CAST(CONVERT(varchar(12), al.TransDate, 101) AS SMALLDATETIME)  = CAST(CONVERT(varchar(12), @start, 101) AS SMALLDATETIME)
				and al.TransDesc not in ('Game Start')
				order by al.MAC,  al.TransNo, al.TransType ;
				
				
			
				
				declare @TransactionDetailReport2 table
				(
					TransType varchar(50),
					MAC varchar(50),
					TransNo varchar(50),
					ReceiptNo int,
					TransDate datetime,				
					TransDesc varchar(50),
					CreditAcctNum varchar(100),
					CreditAmt Money,
					WinsAmt money,
					UserName varchar(100),
					SessNum int,
					SessStart datetime,
					SessEnd datetime,
					operatorname varchar(100),
					sessactive varchar(2),
					TransactionLocation varchar(100)
				)
				
				if ((select IsNorthDakota from B3_SystemConfig ) = 'T')
				begin
				insert into @TransactionDetailReport2
					select 
					TransType,
					MAC ,
					TransNo ,
					ReceiptNo ,
					TransDate ,				
					TransDesc ,
					CreditAcctNum ,
					CreditAmt ,
					WinsAmt ,
					UserName,
					SessNum ,
					SessStart ,
					SessEnd ,
					operatorname ,
					sessactive ,
					TransactionLocation
					from @TransactionDetailReport order by TransDate asc
				end
				else 
				begin
				insert into @TransactionDetailReport2
					select 
					TransType,
					MAC ,
					TransNo ,
					ReceiptNo ,
					TransDate ,				
					TransDesc ,
					'xxxx' + substring(CreditAcctNum ,5,8) as CreditAcctNum,
					CreditAmt ,
					WinsAmt ,
					UserName,
					SessNum ,
					SessStart ,
					SessEnd ,
					operatorname ,
					sessactive ,
					TransactionLocation
					from @TransactionDetailReport order by TransDate asc
				end

				delete from @TransactionDetailReport
				
	--INSERT OUR FIRST RESULT SET
				
				insert into @FinalResult 
				(
					DateTimeTransaction ,
					ReceiptNumber ,
					TransactionType, 
					TransactionLocation, 
					GameNumber ,
					GameName,
					Credits ,
					BetAmount, 
					Denom ,
					NumberOfCardsWagered, 
					SerialCardNumberPlayed, 
					Win ,
					WinBalance,
					CreditBalance
				)
				select TransDate, ReceiptNo, TransDesc, TransactionLocation, Null, Null, CreditAmt, 0.00, 0.00,0,null, WinsAmt, 0.00, 0.00  from @TransactionDetailReport2
				
				--select * from @FinalResult


declare @Result table
(
DateTimeTransaction datetime,
ReceiptNumber int,
TransactionType varchar(100),
TransactionLocation varchar(100),
GameNumber int,
GameName varchar(100),
Credits int,
BetAmount int,
Denom int,
NumberOfCardsWagered int,
SerialCardNumberPlayed varchar(100),
Win int , -- (Win + Bonus)
WinBalance int, -- For dual Accounting
CreditBalance int
)



insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'Maya Money',
a.creditamt,
a.betamt,
 a.denom,
 case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end as [NumberOfCardsWagered],

 case  (case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end) 
 when 1 then cast(a.cardsn_1 AS varchar(10)) 
 when 2 then cast(a.cardsn_1 AS varchar(10)) +' to '+ cast(a.cardsn_2 AS varchar(10))
 when 3 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '*/+ cast(a.cardsn_3 AS varchar(10))
when 4 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '*/+ cast(a.cardsn_4 AS varchar(10))
when 5  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '*/+ cast(a.cardsn_5 AS varchar(10))
when 6  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '+ cast(a.cardsn_5 AS varchar(10)) +', '*/+ cast(a.cardsn_6 AS varchar(10))
end as [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.MayaMoney_GameJournal a 
where a.creditacctnum = @AccountNumber

insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'Jail Break',
a.creditamt,
a.betamt,
 a.denom,
 case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end as [NumberOfCardsWagered],

 case  (case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end) 
 when 1 then cast(a.cardsn_1 AS varchar(10)) 
 when 2 then cast(a.cardsn_1 AS varchar(10)) +' to '+ cast(a.cardsn_2 AS varchar(10))
 when 3 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '*/+ cast(a.cardsn_3 AS varchar(10))
when 4 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '*/+ cast(a.cardsn_4 AS varchar(10))
when 5  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '*/+ cast(a.cardsn_5 AS varchar(10))
when 6  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '+ cast(a.cardsn_5 AS varchar(10)) +', '*/+ cast(a.cardsn_6 AS varchar(10))
end as [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.JailBreak_GameJournal a 
where a.creditacctnum = @AccountNumber

insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'UkickEm',
a.creditamt,
a.betamt,
 a.denom,
1 [NumberOfCardsWagered],

'NA' [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.UKickEm_GameJournal a 
where a.creditacctnum = @AccountNumber


insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'Wild Ball',
a.creditamt,
a.betamt,
 a.denom,
 case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end as [NumberOfCardsWagered],

 case  (case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end) 
 when 1 then cast(a.cardsn_1 AS varchar(10)) 
 when 2 then cast(a.cardsn_1 AS varchar(10)) +' to '+ cast(a.cardsn_2 AS varchar(10))
 when 3 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '*/+ cast(a.cardsn_3 AS varchar(10))
when 4 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '*/+ cast(a.cardsn_4 AS varchar(10))
when 5  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '*/+ cast(a.cardsn_5 AS varchar(10))
when 6  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '+ cast(a.cardsn_5 AS varchar(10)) +', '*/+ cast(a.cardsn_6 AS varchar(10))
end as [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.WildBall_GameJournal a 
where a.creditacctnum = @AccountNumber


insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'Wild Fire',
a.creditamt,
a.betamt,
 a.denom,
 case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end as [NumberOfCardsWagered],

 case  (case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end) 
 when 1 then cast(a.cardsn_1 AS varchar(10)) 
 when 2 then cast(a.cardsn_1 AS varchar(10)) +' to '+ cast(a.cardsn_2 AS varchar(10))
 when 3 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '*/+ cast(a.cardsn_3 AS varchar(10))
when 4 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '*/+ cast(a.cardsn_4 AS varchar(10))
when 5  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '*/+ cast(a.cardsn_5 AS varchar(10))
when 6  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '+ cast(a.cardsn_5 AS varchar(10)) +', '*/+ cast(a.cardsn_6 AS varchar(10))
end as [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.WildFire_GameJournal a 
where a.creditacctnum = @AccountNumber

insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'Spirit76',
a.creditamt,
a.betamt,
 a.denom,
 case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end as [NumberOfCardsWagered],

 case  (case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end) 
 when 1 then cast(a.cardsn_1 AS varchar(10)) 
 when 2 then cast(a.cardsn_1 AS varchar(10)) +' to '+ cast(a.cardsn_2 AS varchar(10))
 when 3 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '*/+ cast(a.cardsn_3 AS varchar(10))
when 4 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '*/+ cast(a.cardsn_4 AS varchar(10))
when 5  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '*/+ cast(a.cardsn_5 AS varchar(10))
when 6  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '+ cast(a.cardsn_5 AS varchar(10)) +', '*/+ cast(a.cardsn_6 AS varchar(10))
end as [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.Spirit76_GameJournal a 
where a.creditacctnum = @AccountNumber


insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'Time Bomb',
a.creditamt,
a.betamt,
 a.denom,
 case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end as [NumberOfCardsWagered],
 --case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 --case when a.betplaced_card_6 = 'T' then 1 else 0 end as [NumberOfCardsWagered],

 case  (case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end )
 --case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 --case when a.betplaced_card_6 = 'T' then 1 else 0 end) 
 when 1 then cast(a.cardsn_1 AS varchar(10)) 
 when 2 then cast(a.cardsn_1 AS varchar(10)) +' to '+ cast(a.cardsn_2 AS varchar(10))
 when 3 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '*/+ cast(a.cardsn_3 AS varchar(10))
when 4 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '*/+ cast(a.cardsn_4 AS varchar(10))
--when 5  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '*/+ cast(a.cardsn_5 AS varchar(10))
--when 6  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '+ cast(a.cardsn_5 AS varchar(10)) +', '*/+ cast(a.cardsn_6 AS varchar(10))
end as [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.TimeBomb_GameJournal a 
where a.creditacctnum = @AccountNumber


insert @Result
select 
a.recdatetime, 
null,
'Game' ,
--a.clientmac, 
a.clientname,
a.gamenum,
'Crazy Bout',
a.creditamt,
a.betamt,
 a.denom,
 case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end as [NumberOfCardsWagered],

 case  (case when a.betplaced_card_1 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_2 = 'T' then 1 else 0 end + 
 case when a.betplaced_card_3 = 'T' then 1 else 0 end +
 case when a.betplaced_card_4 = 'T' then 1 else 0 end +
 case when a.betplaced_card_5 = 'T' then 1 else 0 end +
 case when a.betplaced_card_6 = 'T' then 1 else 0 end) 
 when 1 then cast(a.cardsn_1 AS varchar(10)) 
 when 2 then cast(a.cardsn_1 AS varchar(10)) +' to '+ cast(a.cardsn_2 AS varchar(10))
 when 3 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '*/+ cast(a.cardsn_3 AS varchar(10))
when 4 then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '*/+ cast(a.cardsn_4 AS varchar(10))
when 5  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '*/+ cast(a.cardsn_5 AS varchar(10))
when 6  then cast(a.cardsn_1 AS varchar(10)) +' to '/*+ cast(a.cardsn_2 AS varchar(10)) +', '+ cast(a.cardsn_3 AS varchar(10))  +', '+ cast(a.cardsn_4 AS varchar(10)) +', '+ cast(a.cardsn_5 AS varchar(10)) +', '*/+ cast(a.cardsn_6 AS varchar(10))
end as [SerialNumberPlayed],

a.totalpaidamt,
0.00 as WinBalance,
--(select SUM(a.totalpaidamt) from dbo.MayaMoney_GameJournal b where b.gamenum <= a.gamenum), --RunningTotal of totalpaid untill redeem
a.creditamt
from dbo.CrazyBout_GameJournal a 
where a.creditacctnum = @AccountNumber

declare @Result2 table
(
DateTimeTransaction datetime,
ReceiptNumber int,
TransactionType varchar(100),
TransactionLocation varchar(100),
GameNumber int,
GameName varchar(100),
Credits int,
BetAmount int,
Denom int,
NumberOfCardsWagered int,
SerialCardNumberPlayed varchar(100),
Win int , -- (Win + Bonus)
WinBalance int, -- For dual Accounting
CreditBalance int
)
insert into @Result2
select DateTimeTransaction, 
ReceiptNumber ,
TransactionType, 
TransactionLocation, 
GameNumber ,
GameName ,
Credits ,
BetAmount, 
Denom ,
NumberOfCardsWagered ,
--substring(SerialCardNumberPlayed, 0 ,len(SerialCardNumberPlayed)),
SerialCardNumberPlayed,
Win ,
 (select SUM(b.Win) from @Result b where b.DateTimeTransaction <= a.DateTimeTransaction),
 CreditBalance from @Result a 
 
 delete from @Result
 
 insert into @FinalResult 
				(
					DateTimeTransaction ,
					ReceiptNumber ,
					TransactionType, 
					TransactionLocation, 
					GameNumber ,
					GameName,
					Credits ,
					BetAmount, 
					Denom ,
					NumberOfCardsWagered, 
					SerialCardNumberPlayed, 
					Win ,
					WinBalance,
					CreditBalance
				)select * from @Result2
				
				update @FinalResult
				set GameSite = (select sitename FROM B3_SystemConfig)
				,OperatorName = (select operatorname from B3_SessionsJournal where sessnum = @SessionID_)
				,Credits = Credits + BetAmount 
				
				select 	DateTimeTransaction ,
					ReceiptNumber ,
					TransactionType, 
					TransactionLocation, 
					GameNumber ,
					GameName,
					Credits ,
					BetAmount, 
					Denom ,
					NumberOfCardsWagered, 
					SerialCardNumberPlayed, 
					Win ,
					WinBalance,
					CreditBalance,
					OperatorName,
					GameSite from @FinalResult order by DateTimeTransaction asc
				
				






GO


