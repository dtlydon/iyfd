CREATE PROCEDURE dbo.GetCurrentTeams
AS 
	SET NOCOUNT ON;
	SELECT
		id,
		name
	FROM
		Team
GO