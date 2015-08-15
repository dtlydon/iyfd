CREATE PROCEDURE dbo.CreateTourny
	@roundID int,
	@teamID int,
	@regionID int,
	@rankID int
AS 
	SET NOCOUNT ON;
	INSERT INTO Tourny (teamId, regionID, rankID, roundID)
	SELECT @roundID, @teamID, @regionID, @rankID
GO