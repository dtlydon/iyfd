CREATE PROCEDURE dbo.GetAllRegions
AS 
	SELECT 
		id,
		region
	FROM
		Region		
GO