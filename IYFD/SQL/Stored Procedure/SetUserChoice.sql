CREATE PROCEDURE dbo.SetUserChoice
	@userID int,
	@matchUpID int,
	@choice int
AS 
	SET NOCOUNT ON;
	
	IF EXISTS ( SELECT * FROM UserChoice WHERE matchUpId = @matchUpID AND userId = @userID)
		UPDATE
			UserChoice
		SET
			teamIDChoice = @choice
		WHERE
			matchUpId = @matchUpID AND userId = @userID
	ELSE
		INSERT INTO UserChoice (matchupID, teamIDChoice, userID)
		SELECT @matchUpID, @choice, @userID
GO