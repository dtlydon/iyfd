CREATE PROCEDURE dbo.UpsertTeam
	@name varchar(100)
AS 
	SET NOCOUNT ON;
	INSERT INTO Team (name)
	SELECT @name	
GO