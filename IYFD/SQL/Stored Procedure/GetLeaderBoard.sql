CREATE PROCEDURE dbo.GetLeaderBoard
AS 
	SET NOCOUNT ON;
	
	SELECT
		username,
		SUM(
			CASE 
				WHEN winnerID = teamIDCHoice THEN 1
				ELSE 0
			END
		)* regionId as points
	FROM
		[User]
		INNER JOIN UserChoice ON UserChoice.userId = [User].id
		INNER JOIN MatchUp ON MatchUp.id = UserChoice.matchupID
	GROUP BY
		username, regionID
GO