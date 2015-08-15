CREATE PROCEDURE dbo.GetUserByID
	@userID int
AS 
	SET NOCOUNT ON;
	
	SELECT
		username,
		email,
		active
	FROM
		[User]
	WHERE
		id = @userID
GO