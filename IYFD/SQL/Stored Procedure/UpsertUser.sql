CREATE PROCEDURE dbo.UpsertUser
	@ID int = 0,
    @username varchar(100), 
    @password varchar(100),
    @email varchar(100),
    @active bit = 0
AS 
	SET NOCOUNT ON;
	
    IF @ID = 0
		INSERT INTO [User] (username, password, email, active)
		SELECT	@username, @password, @email, 0	
    ELSE
		UPDATE
			[User]
		SET
			username = @username,
			password = @password,
			email = @email,
			active = @active
		WHERE
			id = @ID
GO