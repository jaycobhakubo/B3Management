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





----=============================================================================
---- 2017.11.10 DE13851 Fixing issue with not calculating account history
----  properly. Added support for calculating the Wild ball as well
----=============================================================================
CREATE proc [dbo].[usp_management_rptAccountHistory]
(
    @P_Date_ datetime,
    @SessionID_ int,
    @AccountNumber int
)
AS
--==========TEST==============
--declare 
--    @P_Date_ datetime,
--    @SessionID_ int,
--    @AccountNumber int

--set @P_Date_ = '12/27/2017 00:00:00'
--set @SessionID_ = 1013
--set @AccountNumber = 85597090

--============================

    DECLARE @doubleAccounting int; SET @doubleAccounting = 0;
    DECLARE @NDMode int; SET @NDMode = 0;
    DECLARE @IsServerGame bit 
    
SELECT @IsServerGame =
 Case when MinPlayer > 1 then  1
 else 0 end 
 from Server_GameSettings 
 
 --select * from Server_GameJournal where ServerGameNumber = 190
 --select * from Server_Game where ServerGame = 190


    -- Check to see if the system is using double accounting where
    --  all wins go into a separate account
    SELECT @doubleAccounting = CASE WHEN doubleaccount = 'T' THEN 1 ELSE 0 END
        , @NDMode = CASE WHEN IsNorthDakota = 'T' THEN 1 ELSE 0 END
    FROM B3_SystemConfig

	DECLARE @FinalResult TABLE
	(	DateTimeTransaction datetime,
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

	DECLARE @TransactionDetailReport TABLE
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
           
	DECLARE	@start datetime,
	    @SessionID int

	SET @start = @P_Date_
	SET @SessionID = @SessionID_
                      
	;WITH x AS
	(  SELECT al.TransNo
             ,al.ReceiptNo
             ,al.TransDesc
             ,al.CreditAcctNum
             ,ISNULL (al.CreditAmt, 0.00) AS CreditAmt
             ,ISNULL (al.WinsAmt, 0.00) AS WinsAmt
		FROM B3_ActivityLog al 
            LEFT JOIN (SELECT sessnum, sessstart, sessend, operatorname, sessactive FROM [dbo].[B3_SessionsJournal]) sj ON sj.sessnum = al.sessnum         
		WHERE al.sessNum = @SessionID 	
		    AND al.CreditAcctNum = @AccountNumber 
		    AND CAST(CONVERT(varchar(12), al.TransDate, 101) AS SMALLDATETIME) = CAST(CONVERT(varchar(12), @start, 101) AS SMALLDATETIME)
		    AND al.TransDesc NOT IN ('Game Start')
		    AND TransDesc = CASE WHEN TransDesc != 'Cash Out' THEN 'Unlock Account' ELSE 'Cash Out' END
		    AND ReceiptNo = (SELECT MAX(ReceiptNo) from B3_ActivityLog where CreditAcctNum = @AccountNumber and TransDesc = case when TransDesc != 'Cash Out' then 'Unlock Account' else 'Cash Out' end))
				  
					
		INSERT INTO @TransactionDetailReport
		SELECT 
			al.TransType [TransType], 
			al.MAC, 
			al.TransNo, 
			al.ReceiptNo, 
			al.TransDate, 
			al.TransDesc, 
            RIGHT('00000000' + CAST(al.CreditAcctNum AS varchar(8)), 8) AS CreditAcctNum, -- ensure that the account is padded with 0's
			--case 
			--when LEN(al.CreditAcctNum) = 1 then '0000000'  + cast(al.CreditAcctNum as varchar(8))
			--when LEN(al.CreditAcctNum) = 2 then '000000'  + cast(al.CreditAcctNum as varchar(8))
			--when LEN(al.CreditAcctNum) = 3 then '00000'   + cast(al.CreditAcctNum as varchar(8))
			--when LEN(al.CreditAcctNum) = 4 then '0000'  + cast(al.CreditAcctNum as varchar(8))
			--when LEN(al.CreditAcctNum) = 5 then '000'  + cast(al.CreditAcctNum as varchar(8))
			--when LEN(al.CreditAcctNum) = 6 then '00'  + cast(al.CreditAcctNum as varchar(8))
			--when LEN(al.CreditAcctNum) = 7 then '0'  + cast(al.CreditAcctNum as varchar(8))
			--else
			ISNULL (z.CreditAmt, al.CreditAmt) CreditAmt,   
			ISNULL (z.WinsAmt, al.WinsAmt)  WinsAmt,   
			al.UserName,
			al.SessNum, 
			sj.sessstart SessStart,
			CASE sessactive
				WHEN 'T' THEN NULL 
				ELSE   sj.sessend END SessEnd,			  
			sj.operatorname,
            sessactive, --into #T_TransactionDetail  
			MachineName        
		FROM B3_ActivityLog al 
		LEFT JOIN	(SELECT sessnum, sessstart, sessend, operatorname, sessactive FROM  [dbo].[B3_SessionsJournal]) sj
					ON sj.sessnum = al.sessnum
		LEFT JOIN (	SELECT y.* FROM x y
					INNER JOIN ( SELECT MAX(TransNo) TransNo, ReceiptNo FROM x GROUP BY ReceiptNo) x on x.TransNo = y.TransNo AND x.ReceiptNo = y.ReceiptNo ) z
		            ON (z.CreditAcctNum = al.CreditAcctNum and AL.TransDesc = 'Credit Redemption')
		WHERE al.sessNum = @SessionID
		    AND al.CreditAcctNum = @AccountNumber  
		    AND CAST(CONVERT(varchar(12), al.TransDate, 101) AS SMALLDATETIME)  = CAST(CONVERT(varchar(12), @start, 101) AS SMALLDATETIME)
		    AND al.TransDesc not in ('Game Start')
		ORDER BY al.MAC, al.TransNo, al.TransType ;
				
		DECLARE @TransactionDetailReport2 TABLE
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
				
		--IF ((SELECT IsNorthDakota FROM B3_SystemConfig ) = 'T')
		--BEGIN
		--INSERT INTO @TransactionDetailReport2
		--	SELECT 
		--	    TransType,
		--	    MAC ,
		--	    TransNo ,
		--	    ReceiptNo ,
		--	    TransDate ,				
		--	    TransDesc ,
		--	    CreditAcctNum ,
		--	    CreditAmt ,
		--	    WinsAmt ,
		--	    UserName,
		--	    SessNum ,
		--	    SessStart ,
		--	    SessEnd ,
		--	    operatorname ,
		--	    sessactive ,
		--	    TransactionLocation
		--	FROM @TransactionDetailReport
  --          ORDER BY TransDate ASC
		--END
		--ELSE 
		--BEGIN
		--INSERT INTO @TransactionDetailReport2
		--	SELECT 
		--	    TransType,
		--	    MAC ,
		--	    TransNo ,
		--	    ReceiptNo ,
		--	    TransDate ,				
		--	    TransDesc ,
  --              'xxxx' + substring(CreditAcctNum ,5,8) as CreditAcctNum,
		--	    CreditAmt ,
		--	    WinsAmt ,
		--	    UserName,
		--	    SessNum ,
		--	    SessStart ,
		--	    SessEnd ,
		--	    operatorname ,
		--	    sessactive ,
		--	    TransactionLocation
		--	FROM @TransactionDetailReport ORDER BY TransDate ASC
		--end

		INSERT INTO @TransactionDetailReport2
			SELECT 
			    TransType,
			    MAC ,
			    TransNo ,
			    ReceiptNo ,
			    TransDate ,				
			    TransDesc ,
                CASE WHEN @NDMode = 1
                    THEN CreditAcctNum
                    ELSE 'xxxx' + substring(CreditAcctNum ,5,8) END as CreditAcctNum,
			    CreditAmt ,
			    WinsAmt ,
			    UserName,
			    SessNum ,
			    SessStart ,
			    SessEnd ,
			    operatorname ,
			    sessactive ,
			    TransactionLocation
			FROM @TransactionDetailReport ORDER BY TransDate ASC

			DELETE FROM @TransactionDetailReport
				
	--INSERT OUR FIRST RESULT SET
				
		INSERT INTO @FinalResult 
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
		SELECT TransDate, ReceiptNo, TransDesc, TransactionLocation, Null, Null, CreditAmt, 0.00, 0.00,0,null, WinsAmt, 0.00, 0.00 
        FROM @TransactionDetailReport2
				

        DECLARE @Result table
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
        




        INSERT @Result
        SELECT 
            a.recdatetime, 
            NULL,
            'Game' ,
            a.clientname,
            a.gamenum,
            'Maya Money',
            a.creditamt,
            a.betamt,
            a.denom,
   
            CASE WHEN a.betplaced_card_1 = 'T' THEN 1 ELSE 0 END + 
            CASE WHEN a.betplaced_card_2 = 'T' THEN 1 ELSE 0 END + 
            CASE WHEN a.betplaced_card_3 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_4 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_5 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_6 = 'T' THEN 1 ELSE 0 END AS [NumberOfCardsWagered],
           -- CASE WHEN 
         CASE 
			(
				CASE WHEN betplaced_card_1 = 'T' THEN 1 ELSE 0 END + 
				CASE WHEN betplaced_card_2 = 'T' THEN 1 ELSE 0 END + 
				CASE WHEN betplaced_card_3 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_4 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_5 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_6 = 'T' THEN 1 ELSE 0 END
			) 
			WHEN 1 THEN CAST(cardsn_1 AS varchar(10))         
			WHEN 6 THEN CAST(cardsn_1 AS varchar(10)) +' to '+ CAST(cardsn_6 AS varchar(10)) 
			ELSE 
			(
				select dbo.B3_fnRptDisplayCardnumber
				(
					(case when betplaced_card_1 = 'T' then cast(cardsn_1 as varchar(10)) + ',' else '' END ) +
					(case when betplaced_card_2 = 'T' then ' '+ cast(cardsn_2 as varchar(10))+ ',' else '' END )  +
					(case when betplaced_card_3 = 'T' then ' '+cast(cardsn_3 as varchar(10))+ ',' else '' END ) +
					(case when betplaced_card_4 = 'T' then ' '+cast(cardsn_4 as varchar(10))+ ',' else '' END)  +
					(case when betplaced_card_5 = 'T' then ' '+cast(cardsn_5 as varchar(10))+ ',' else '' END )  +
					(case when betplaced_card_6 = 'T' then ' '+cast(cardsn_6 as varchar(10))+ ',' else '' END ) 
				)
			)				
			END AS [SerialNumberPlayed],
            a.totalpaidamt,
            0.00 as WinBalance,
            a.creditamt
        FROM dbo.MayaMoney_GameJournal a 
        WHERE a.creditacctnum = @AccountNumber


--declare @MinPlayer int 
--select  @MinPlayer  = MinPlayer  from Server_GameSettings


        INSERT @Result
        SELECT 
            a.recdatetime, 
            NULL,
            'Game' ,
            a.clientname,
            a.gamenum,
            'Jail Break',
            a.creditamt,
            a.betamt,
            a.denom,
            CASE WHEN a.betplaced_card_1 = 'T' THEN 1 ELSE 0 END + 
            CASE WHEN a.betplaced_card_2 = 'T' THEN 1 ELSE 0 END + 
            CASE WHEN a.betplaced_card_3 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_4 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_5 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_6 = 'T' THEN 1 ELSE 0 END AS [NumberOfCardsWagered],
            			CASE 
			(
				CASE WHEN betplaced_card_1 = 'T' THEN 1 ELSE 0 END + 
				CASE WHEN betplaced_card_2 = 'T' THEN 1 ELSE 0 END + 
				CASE WHEN betplaced_card_3 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_4 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_5 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_6 = 'T' THEN 1 ELSE 0 END
			) 
			WHEN 1 THEN CAST(cardsn_1 AS varchar(10))         
			WHEN 6 THEN CAST(cardsn_1 AS varchar(10)) +' to '+ CAST(cardsn_6 AS varchar(10)) 
			ELSE 
			(
				select dbo.B3_fnRptDisplayCardnumber
				(
					(case when betplaced_card_1 = 'T' then cast(cardsn_1 as varchar(10)) + ',' else '' END ) +
					(case when betplaced_card_2 = 'T' then ' '+ cast(cardsn_2 as varchar(10))+ ',' else '' END )  +
					(case when betplaced_card_3 = 'T' then ' '+cast(cardsn_3 as varchar(10))+ ',' else '' END ) +
					(case when betplaced_card_4 = 'T' then ' '+cast(cardsn_4 as varchar(10))+ ',' else '' END)  +
					(case when betplaced_card_5 = 'T' then ' '+cast(cardsn_5 as varchar(10))+ ',' else '' END )  +
					(case when betplaced_card_6 = 'T' then ' '+cast(cardsn_6 as varchar(10))+ ',' else '' END ) 
				)
			)				
			END AS [SerialNumberPlayed],
            a.totalpaidamt,
            0.00 as WinBalance,
            a.creditamt
        FROM dbo.JailBreak_GameJournal a 
        WHERE a.creditacctnum = @AccountNumber


     --   select * from Server_GameJournal where GameNumber = 
     
    

        INSERT @Result
       SELECT 
            a.recdatetime, 
            NULL,
            'Game' ,
            a.clientname,
            a.gamenum,
            'Crazy Bout',
            a.creditamt,
            a.betamt,
            a.denom,
            CASE WHEN a.betplaced_card_1 = 'T' THEN 1 ELSE 0 END + 
            CASE WHEN a.betplaced_card_2 = 'T' THEN 1 ELSE 0 END + 
            CASE WHEN a.betplaced_card_3 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_4 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_5 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_6 = 'T' THEN 1 ELSE 0 END AS [NumberOfCardsWagered],
			CASE 
			(
				CASE WHEN betplaced_card_1 = 'T' THEN 1 ELSE 0 END + 
				CASE WHEN betplaced_card_2 = 'T' THEN 1 ELSE 0 END + 
				CASE WHEN betplaced_card_3 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_4 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_5 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_6 = 'T' THEN 1 ELSE 0 END
			) 
			WHEN 1 THEN CAST(cardsn_1 AS varchar(10))         
			WHEN 6 THEN CAST(cardsn_1 AS varchar(10)) +' to '+ CAST(cardsn_6 AS varchar(10)) 
			ELSE 
			(
				select dbo.B3_fnRptDisplayCardnumber
				(
					(case when betplaced_card_1 = 'T' then cast(cardsn_1 as varchar(10)) + ',' else '' END ) +
					(case when betplaced_card_2 = 'T' then ' '+ cast(cardsn_2 as varchar(10))+ ',' else '' END )  +
					(case when betplaced_card_3 = 'T' then ' '+cast(cardsn_3 as varchar(10))+ ',' else '' END ) +
					(case when betplaced_card_4 = 'T' then ' '+cast(cardsn_4 as varchar(10))+ ',' else '' END)  +
					(case when betplaced_card_5 = 'T' then ' '+cast(cardsn_5 as varchar(10))+ ',' else '' END )  +
					(case when betplaced_card_6 = 'T' then ' '+cast(cardsn_6 as varchar(10))+ ',' else '' END ) 
				)
			)				
			END AS [SerialNumberPlayed],
            a.totalpaidamt,
            0.00 as WinBalance,
            a.creditamt
        FROM dbo.CrazyBout_GameJournal a 
        WHERE a.creditacctnum = @AccountNumber
     




        INSERT @Result
        SELECT 
            a.recdatetime, 
            NULL,
            'Game' ,
            a.clientname,
            a.gamenum,
            'Wild Ball',
            a.creditamt,
            a.betamt,
            a.denom,
            CASE WHEN a.betplaced_card_1 = 'T' THEN 1 ELSE 0 END + 
            CASE WHEN a.betplaced_card_2 = 'T' THEN 1 ELSE 0 END + 
            CASE WHEN a.betplaced_card_3 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_4 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_5 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_6 = 'T' THEN 1 ELSE 0 END AS [NumberOfCardsWagered],
           CASE 
			(
				CASE WHEN betplaced_card_1 = 'T' THEN 1 ELSE 0 END + 
				CASE WHEN betplaced_card_2 = 'T' THEN 1 ELSE 0 END + 
				CASE WHEN betplaced_card_3 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_4 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_5 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_6 = 'T' THEN 1 ELSE 0 END
			) 
			WHEN 1 THEN CAST(cardsn_1 AS varchar(10))         
			WHEN 6 THEN CAST(cardsn_1 AS varchar(10)) +' to '+ CAST(cardsn_6 AS varchar(10)) 
			ELSE 
			(
				select dbo.B3_fnRptDisplayCardnumber
				(
					(case when betplaced_card_1 = 'T' then cast(cardsn_1 as varchar(10)) + ',' else '' END ) +
					(case when betplaced_card_2 = 'T' then ' '+ cast(cardsn_2 as varchar(10))+ ',' else '' END )  +
					(case when betplaced_card_3 = 'T' then ' '+cast(cardsn_3 as varchar(10))+ ',' else '' END ) +
					(case when betplaced_card_4 = 'T' then ' '+cast(cardsn_4 as varchar(10))+ ',' else '' END)  +
					(case when betplaced_card_5 = 'T' then ' '+cast(cardsn_5 as varchar(10))+ ',' else '' END )  +
					(case when betplaced_card_6 = 'T' then ' '+cast(cardsn_6 as varchar(10))+ ',' else '' END ) 
				)
			)				
			END AS [SerialNumberPlayed],
            a.totalpaidamt,
            0.00 as WinBalance,
            a.creditamt
        FROM dbo.WildBall_GameJournal a 
        WHERE a.creditacctnum = @AccountNumber




        INSERT @Result
        SELECT 
            a.recdatetime, 
            NULL,
            'Game' ,
            a.clientname,
            a.gamenum,
            'Spirit of 76',
            a.creditamt,
            a.betamt,
            a.denom,
            CASE WHEN a.betplaced_card_1 = 'T' THEN 1 ELSE 0 END + 
            CASE WHEN a.betplaced_card_2 = 'T' THEN 1 ELSE 0 END + 
            CASE WHEN a.betplaced_card_3 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_4 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_5 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_6 = 'T' THEN 1 ELSE 0 END AS [NumberOfCardsWagered],
           CASE 
			(
				CASE WHEN betplaced_card_1 = 'T' THEN 1 ELSE 0 END + 
				CASE WHEN betplaced_card_2 = 'T' THEN 1 ELSE 0 END + 
				CASE WHEN betplaced_card_3 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_4 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_5 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_6 = 'T' THEN 1 ELSE 0 END
			) 
			WHEN 1 THEN CAST(cardsn_1 AS varchar(10))         
			WHEN 6 THEN CAST(cardsn_1 AS varchar(10)) +' to '+ CAST(cardsn_6 AS varchar(10)) 
			ELSE 
			(
				select dbo.B3_fnRptDisplayCardnumber
				(
					(case when betplaced_card_1 = 'T' then cast(cardsn_1 as varchar(10)) + ',' else '' END ) +
					(case when betplaced_card_2 = 'T' then ' '+ cast(cardsn_2 as varchar(10))+ ',' else '' END )  +
					(case when betplaced_card_3 = 'T' then ' '+cast(cardsn_3 as varchar(10))+ ',' else '' END ) +
					(case when betplaced_card_4 = 'T' then ' '+cast(cardsn_4 as varchar(10))+ ',' else '' END)  +
					(case when betplaced_card_5 = 'T' then ' '+cast(cardsn_5 as varchar(10))+ ',' else '' END )  +
					(case when betplaced_card_6 = 'T' then ' '+cast(cardsn_6 as varchar(10))+ ',' else '' END ) 
				)
			)				
			END AS [SerialNumberPlayed],
            a.totalpaidamt,
            0.00 as WinBalance,
            a.creditamt
        FROM dbo.Spirit76_GameJournal a
        WHERE a.creditacctnum = @AccountNumber


        INSERT @Result
        SELECT 
            a.recdatetime, 
            NULL,
            'Game' ,
            a.clientname,
            a.gamenum,
            'Time Bomb',
            a.creditamt,
            a.betamt,
            a.denom,
            CASE WHEN a.betplaced_card_1 = 'T' THEN 1 ELSE 0 END + 
            CASE WHEN a.betplaced_card_2 = 'T' THEN 1 ELSE 0 END + 
            CASE WHEN a.betplaced_card_3 = 'T' THEN 1 ELSE 0 END +
            CASE WHEN a.betplaced_card_4 = 'T' THEN 1 ELSE 0 END 
            AS [NumberOfCardsWagered],
           CASE 
			(
				CASE WHEN betplaced_card_1 = 'T' THEN 1 ELSE 0 END + 
				CASE WHEN betplaced_card_2 = 'T' THEN 1 ELSE 0 END + 
				CASE WHEN betplaced_card_3 = 'T' THEN 1 ELSE 0 END +
				CASE WHEN betplaced_card_4 = 'T' THEN 1 ELSE 0 END 
			) 
			WHEN 1 THEN CAST(cardsn_1 AS varchar(10))         
			WHEN 4 THEN CAST(cardsn_1 AS varchar(10)) +' to '+ CAST(cardsn_4 AS varchar(10)) 
			ELSE 
			(
				select dbo.B3_fnRptDisplayCardnumber
				(
					(case when betplaced_card_1 = 'T' then cast(cardsn_1 as varchar(10)) + ',' else '' END ) +
					(case when betplaced_card_2 = 'T' then ' '+ cast(cardsn_2 as varchar(10))+ ',' else '' END )  +
					(case when betplaced_card_3 = 'T' then ' '+cast(cardsn_3 as varchar(10))+ ',' else '' END ) +
					(case when betplaced_card_4 = 'T' then ' '+cast(cardsn_4 as varchar(10))+ ',' else '' END)  					
				)
			)				
			END AS [SerialNumberPlayed],
            a.totalpaidamt,
            0.00 as WinBalance,
            a.creditamt
        FROM dbo.TimeBomb_GameJournal a
        WHERE a.creditacctnum = @AccountNumber

        DECLARE @Result2 TABLE
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
        INSERT INTO @Result2
        SELECT DateTimeTransaction, 
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
            CreditBalance
        FROM @Result a 
 

 
        DELETE FROM @Result
 
         INSERT INTO @FinalResult 
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
        SELECT * FROM @Result2
				
		UPDATE @FinalResult
		SET GameSite = (SELECT sitename FROM B3_SystemConfig),
        OperatorName = (SELECT operatorname FROM B3_SessionsJournal WHERE sessnum = @SessionID_),
        Credits = Credits + BetAmount 
				
		SELECT 	DateTimeTransaction ,
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
            CASE WHEN @doubleAccounting = 1 THEN CreditBalance ELSE CreditBalance + Win END AS CreditBalance,
			OperatorName,
			GameSite
        FROM @FinalResult
        ORDER BY DateTimeTransaction ASC
				



GO


