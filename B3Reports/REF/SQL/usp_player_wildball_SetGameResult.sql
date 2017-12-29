USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_player_wildball_SetGameResult]    Script Date: 10/10/2017 14:06:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_player_wildball_SetGameResult]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_player_wildball_SetGameResult]
GO

USE [B3]
GO

/****** Object:  StoredProcedure [dbo].[usp_player_wildball_SetGameResult]    Script Date: 10/10/2017 14:06:20 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_player_wildball_SetGameResult]
	@nSessNum int,
	@cCreditAcctNum char(8),
	@cMacAddress char(12) , 
	@cClientName char(11) ,
	@nGameNum int,
	@nGameWinAmt int,
	@nTotalPaidAmt int,
	@cBetPlacedCard_1 char(1) ,
	@cBetPlacedCard_2 char(1) ,
	@cBetPlacedCard_3 char(1) ,
	@cBetPlacedCard_4 char(1) ,
	@cBetPlacedCard_5 char(1) ,
	@cBetPlacedCard_6 char(1) ,
	@nNumOfWins_Patt_1 tinyint,
	@nNumOfWins_Patt_2 tinyint,
	@nNumOfWins_Patt_3 tinyint,
	@nNumOfWins_Patt_4 tinyint,
	@nNumOfWins_Patt_5 tinyint,
	@nNumOfWins_Patt_6 tinyint,
	@nNumOfWins_Patt_7 tinyint,
	@nNumOfWins_Patt_8 tinyint,
	@nNumOfWins_Patt_9 tinyint,
	@nNumOfWins_Patt_10 tinyint,
	@nNumOfWins_Patt_11 tinyint,
	@nNumOfWins_Patt_12 tinyint,
	@nWinAmt_Patt_1 int,
	@nWinAmt_Patt_2 int,
	@nWinAmt_Patt_3 int,
	@nWinAmt_Patt_4 int,
	@nWinAmt_Patt_5 int,
	@nWinAmt_Patt_6 int,
	@nWinAmt_Patt_7 int,
	@nWinAmt_Patt_8 int,
	@nWinAmt_Patt_9 int,
	@nWinAmt_Patt_10 int,
	@nWinAmt_Patt_11 int,
	@nWinAmt_Patt_12 int,
	@nHotBall int,
	@nHandPayAmt int OUTPUT,
	@nW2JackpotAmt int OUTPUT
AS
	SET NOCOUNT ON

	DECLARE @nHandPayTrigger int, @nW2Trigger int
	DECLARE @cUK char(1)

	SELECT TOP 1 @nHandPayTrigger = ISNULL(handpaytrigger, 0), @nW2Trigger = ISNULL(w2trigger, 0), @cUK = UK
		FROM B3_SystemConfig

	IF ( @nHandPayTrigger > 0 AND
		 @nTotalPaidAmt >= @nHandPayTrigger )
			SET @nHandPayAmt = @nTotalPaidAmt
	ELSE
		SET @nHandPayAmt = 0

	IF ( @nW2Trigger > 0 AND
		 @nTotalPaidAmt >= @nW2Trigger )
		SET @nW2JackpotAmt = @nTotalPaidAmt
	ELSE
		SET @nW2JackpotAmt = 0

	UPDATE WildBall_GameJournal SET gamewinamt = @nGameWinAmt
					          , totalpaidamt = @nTotalPaidAmt
					          , betplaced_card_1 = @cBetPlacedCard_1
					          , betplaced_card_2 = @cBetPlacedCard_2
					          , betplaced_card_3 = @cBetPlacedCard_3
					          , betplaced_card_4 = @cBetPlacedCard_4
					          , betplaced_card_5 = @cBetPlacedCard_5
					          , betplaced_card_6 = @cBetPlacedCard_6
					          , numofwins_patt_1 =  @nNumOfWins_Patt_1
					          , numofwins_patt_2 =  @nNumOfWins_Patt_2
					          , numofwins_patt_3 =  @nNumOfWins_Patt_3
					          , numofwins_patt_4 =  @nNumOfWins_Patt_4
					          , numofwins_patt_5 =  @nNumOfWins_Patt_5
					          , numofwins_patt_6 =  @nNumOfWins_Patt_6
					          , numofwins_patt_7 =  @nNumOfWins_Patt_7
					          , numofwins_patt_8 =  @nNumOfWins_Patt_8
					          , numofwins_patt_9 =  @nNumOfWins_Patt_9
					          , numofwins_patt_10 =  @nNumOfWins_Patt_10
					          , numofwins_patt_11 =  @nNumOfWins_Patt_11
					          , numofwins_patt_12 =  @nNumOfWins_Patt_12
					          , winamt_patt_1 = @nWinAmt_Patt_1
					          , winamt_patt_2 = @nWinAmt_Patt_2
					          , winamt_patt_3 = @nWinAmt_Patt_3
					          , winamt_patt_4 = @nWinAmt_Patt_4
					          , winamt_patt_5 = @nWinAmt_Patt_5
					          , winamt_patt_6 = @nWinAmt_Patt_6
					          , winamt_patt_7 = @nWinAmt_Patt_7
					          , winamt_patt_8 = @nWinAmt_Patt_8
					          , winamt_patt_9 = @nWinAmt_Patt_9
					          , winamt_patt_10 = @nWinAmt_Patt_10
					          , winamt_patt_11 = @nWinAmt_Patt_11
					          , winamt_patt_12 = @nWinAmt_Patt_12
					          , hotball = @nHotBall
					          , handpayamt = @nHandPayAmt
					          , w2jackpotamt = @nW2JackpotAmt
		WHERE gamenum = @nGameNum;

	IF ( @nHandPayAmt >= @nHandPayTrigger )
		UPDATE B3_CreditJournal 
			SET handpayamt = @nHandPayAmt
				WHERE creditacctnum = @cCreditAcctNum AND sessnum = @nSessNum

	IF ( @nW2JackpotAmt >= @nW2Trigger )
		UPDATE B3_CreditJournal 
			SET taxableamt = @nW2JackpotAmt
				WHERE creditacctnum = @cCreditAcctNum AND sessnum = @nSessNum

	IF ( @cUK = 'T' )
		SET @nW2JackpotAmt = 0

	IF ( @nTotalPaidAmt > 0 )
		BEGIN
		DECLARE @cSessActive char(1)
		DECLARE @dtSessStart datetime, @dtSessEnd datetime
		DECLARE @cOperatorName varchar(18)
		DECLARE @nJackpotLimit int, @nJackpotAmt_1 int, @nJackpotAmt_2 int, @nJackpotAmt_3 int

		SELECT TOP 1 @nJackpotLimit = jackpotlimit, @nJackpotAmt_1 = jackpot_1_amt, @nJackpotAmt_2 = jackpot_2_amt, @nJackpotAmt_3 = jackpot_3_amt
			FROM B3_Session

		BEGIN TRAN

		IF ( @nTotalPaidAmt >= @nJackpotLimit )
			BEGIN

			DECLARE @cGameName varchar(32)
	
			SET @cGameName = 'WILDBALL'

			IF ( @nJackpotAmt_1 = 0 )
				BEGIN
				UPDATE B3_Session 
					SET jackpot_1_amt = @nTotalPaidAmt
				UPDATE B3_SessionsJournal 
					SET jackpot_1_clientmac = @cMacAddress, jackpot_1_clientname = @cClientName, jackpot_1_acctnum = @cCreditAcctNum, jackpot_1_gamenum = @nGameNum, jackpot_1_amt = @nTotalPaidAmt, jackpot_1_dt = GETDATE()
						WHERE sessnum = @nSessNum
				SELECT @nJackpotLimit = jackpotlimit, @nJackpotAmt_1 = jackpot_1_amt, @nJackpotAmt_2 = jackpot_2_amt, @nJackpotAmt_3 = jackpot_3_amt
					FROM B3_Session
				END
			ELSE IF ( @nJackpotAmt_2 = 0 )
				BEGIN
				UPDATE B3_Session 
					SET jackpot_2_amt = @nTotalPaidAmt
				UPDATE B3_SessionsJournal 
					SET jackpot_2_clientmac = @cMacAddress, jackpot_2_clientname = @cClientName, jackpot_2_acctnum = @cCreditAcctNum, jackpot_2_gamenum = @nGameNum, jackpot_2_amt = @nTotalPaidAmt, jackpot_2_dt = GETDATE()
						WHERE sessnum = @nSessNum
				SELECT @nJackpotLimit = jackpotlimit, @nJackpotAmt_1 = jackpot_1_amt, @nJackpotAmt_2 = jackpot_2_amt, @nJackpotAmt_3 = jackpot_3_amt
					FROM B3_Session
				END
			ELSE IF ( @nJackpotAmt_3 = 0 )
				BEGIN
				UPDATE B3_Session 
					SET jackpot_3_amt = @nTotalPaidAmt
				UPDATE B3_SessionsJournal 
					SET jackpot_3_clientmac = @cMacAddress, jackpot_3_clientname = @cClientName, jackpot_3_acctnum = @cCreditAcctNum, jackpot_3_gamenum = @nGameNum, jackpot_3_amt = @nTotalPaidAmt, jackpot_3_dt = GETDATE()
						WHERE sessnum = @nSessNum
				SELECT @nJackpotLimit = jackpotlimit, @nJackpotAmt_1 = jackpot_1_amt, @nJackpotAmt_2 = jackpot_2_amt, @nJackpotAmt_3 = jackpot_3_amt
					FROM B3_Session
				END

			SELECT @cSessActive = sessactive, @dtSessStart = sessstart, @dtSessEnd = sessend, @cOperatorName= operatorname
				FROM B3_SessionsJournal 
					WHERE sessnum = @nSessNum

			INSERT INTO B3_JackpotJournal(sessnum, sessactive, sessstart, sessend, operatorname, clientmac, clientname, acctnum, gamename, gamenum, jackpotlimit, jackpotamt, jackpotevent)
		 		VALUES(@nSessNum, @cSessActive, @dtSessStart, @dtSessEnd, @cOperatorName, @cMacAddress, @cClientName, @cCreditAcctNum,@cGameName, @nGameNum, @nJackpotLimit, @nTotalPaidAmt, GETDATE())

			END

		COMMIT TRAN

		END

GO


