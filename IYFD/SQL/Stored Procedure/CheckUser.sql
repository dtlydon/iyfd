CREATE PROCEDURE dbo.CheckUser
    @userID int, 
    @contentID int 
AS 
	SET NOCOUNT ON;
	
    SELECT 
		CASE
			WHEN [User].id > 0 THEN 1
			ELSE 0
		END
    FROM 
		[User]
		INNER JOIN UserRole ON UserRole.userId = [User].id
		INNER JOIN RoleContent ON RoleContent.roleId = UserRole.userID
		INNER JOIN Content ON Content.id = RoleContent.contentID
    WHERE 
		[User].id = @userID
		AND Content.id = @contentID
		AND [User].active = 1
GO