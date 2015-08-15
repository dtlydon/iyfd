CREATE PROCEDURE dbo.GetCurrentUsers
	@name varchar(100)
AS 
	SET NOCOUNT ON;
	SELECT
		id,
		username,
		active
	FROM
		[User]
GO