DROP PROCEDURE GetUserBracket
GO

CREATE PROCEDURE dbo.GetUserBracket
	@userID int
AS 
	SET NOCOUNT ON;
	
	SELECT
		T1.ID as team1id,
		T1.name as team1,
		T2.ID as team2id,
		T2.name as team2,
		Winner.id as winnerId,
		Winner.name as winner,
		Region.id as regionId,
		UserChoice.teamIDChoice as userTeam
	FROM
		MatchUp
		INNER JOIN Team T1 ON T1.id = Matchup.team1ID
		INNER JOIN Team T2 ON T2.id = Matchup.team2ID
		INNER JOIN Team Winner ON Winner.id = Matchup.winnerID
		INNER JOIN Region ON Region.id = MatchUp.regionID
		LEFT JOIN UserChoice ON UserChoice.matchupId = Matchup.id		
	WHERE
		userId = @userID
GO