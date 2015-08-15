CREATE PROCEDURE dbo.GenerateMatchup
	@regionID int,
	@rank int
AS 
	IF NOT EXISTS(SELECT * FROM MatchUp WHERE [year] = YEAR(getdate()))
		INSERT INTO MatchUp (team1ID, team2ID, regionID)
		SELECT
			T1.teamId,
			T2.teamId,
			@regionID
		FROM
			Tourny T1,
			Tourny T2
		WHERE
			T1.regionID = @regionID and rankID = (select id from [rank] where [rank] = @rank) AND		
			T2.regionID = @regionID and rankID = (select id from [rank] where [rank] = 17 - @rank)
GO