CREATE PROCEDURE dbo.GetUserScore
	@userID int
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
	WHERE
		[User].id = @userID
	GROUP BY
		username, regionID
GO