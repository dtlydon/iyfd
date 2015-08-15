CREATE PROCEDURE dbo.LogonUser
    @username nvarchar(100), 
    @password nvarchar(100) 
AS 
	SET NOCOUNT ON;
	
    SELECT 
		[User].id
    FROM 
		[User]
		INNER JOIN UserRole ON UserRole.userId = [User].id
		
    WHERE 
		@username = username AND @password = password
GO