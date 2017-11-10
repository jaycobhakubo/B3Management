

alter PROCEDURE [dbo].[usp_management_rptGetJackpotSummary]
	@nDate datetime
	,@nSessNum int
AS
	SET NOCOUNT ON

--set @nDate = 	(SELECT CONVERT(VARCHAR(10), @nDate, 101)) --Date only no time

		SELECT 
	jj.recnum, 
	jj.sessnum, 
	sessactive, 
	sessstart, 
	sessend, 
	operatorname, 
	jj.clientmac, 
	jj.clientname
	, acctnum, 
	gamename, 
	jj.gamenum, 
	jackpotlimit, 
	jackpotamt, 
	jackpotevent,
	cn.CardNumbers as CardNum
	FROM b3.dbo.B3_JackpotJournal jj 
	left join b3.dbo.B3_fnGetJackpotWinningCardNumber(@nSessNum) cn on cn.GameNum = jj.gamenum
	WHERE jj.sessnum = @nSessNum
	--and  @nDate between sessstart and sessend
	ORDER BY jackpotevent DESC



GO


