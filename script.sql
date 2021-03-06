USE [master]
GO
/****** Object:  Database [IYFD]    Script Date: 03/07/2014 17:32:16 ******/
--CREATE DATABASE [IYFD] ON  PRIMARY 
--( NAME = N'IYFD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\IYFD.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
-- LOG ON 
--( NAME = N'IYFD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\IYFD_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
--GO
ALTER DATABASE [IYFD] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IYFD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [IYFD] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [IYFD] SET ANSI_NULLS OFF
GO
ALTER DATABASE [IYFD] SET ANSI_PADDING OFF
GO
ALTER DATABASE [IYFD] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [IYFD] SET ARITHABORT OFF
GO
ALTER DATABASE [IYFD] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [IYFD] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [IYFD] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [IYFD] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [IYFD] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [IYFD] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [IYFD] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [IYFD] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [IYFD] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [IYFD] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [IYFD] SET  DISABLE_BROKER
GO
ALTER DATABASE [IYFD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [IYFD] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [IYFD] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [IYFD] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [IYFD] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [IYFD] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [IYFD] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [IYFD] SET  READ_WRITE
GO
ALTER DATABASE [IYFD] SET RECOVERY SIMPLE
GO
ALTER DATABASE [IYFD] SET  MULTI_USER
GO
ALTER DATABASE [IYFD] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [IYFD] SET DB_CHAINING OFF
GO
USE [IYFD]
GO
/****** Object:  Table [dbo].[User]    Script Date: 03/07/2014 17:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](100) NOT NULL,
	[password] [varchar](100) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TimesGamesArePlaying]    Script Date: 03/07/2014 17:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimesGamesArePlaying](
	[startTime] [datetime] NOT NULL,
	[endTime] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Team]    Script Date: 03/07/2014 17:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Team](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](1000) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Round]    Script Date: 03/07/2014 17:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Round](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[roundNo] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 03/07/2014 17:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Region]    Script Date: 03/07/2014 17:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Region](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[region] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Rank]    Script Date: 03/07/2014 17:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rank](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[rank] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Content]    Script Date: 03/07/2014 17:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Content](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[content] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[AddGameTimes]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddGameTimes]
	@startTime datetime,
	@endTime datetime
AS
	INSERT INTO dbo.TimesGamesArePlaying (startTime, endTime)
	SELECT TOP 1 @startTime, @endTime

--EXEC IsItTimeToPlay
GO
/****** Object:  StoredProcedure [dbo].[ActivateUser]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActivateUser]
	@userId INT
AS
	UPDATE
		[User]
	SET
		Active = 1
	WHERE
		id = @userId
GO
/****** Object:  StoredProcedure [dbo].[CheckTeamName]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckTeamName]
    @name varchar(100)
AS 
	SET NOCOUNT ON;
	
    SELECT 
		*
	FROM
		Team
	WHERE
		name = @name
GO
/****** Object:  StoredProcedure [dbo].[GetAllRounds]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllRounds]
AS 
	SELECT 
		id,
		roundNo
	FROM
		[Round]
GO
/****** Object:  StoredProcedure [dbo].[GetAllRoles]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllRoles]	
AS 
	SET NOCOUNT ON;
	SELECT
		id,
		[role]
	FROM
		[Role]
GO
/****** Object:  StoredProcedure [dbo].[GetAllRegions]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllRegions]
AS 
	SELECT 
		id,
		region
	FROM
		Region
GO
/****** Object:  StoredProcedure [dbo].[GetAllRanks]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllRanks]
AS 
	SELECT 
		id,
		[rank]
	FROM
		[rank]
GO
/****** Object:  StoredProcedure [dbo].[GetTimesGamesArePlaying]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTimesGamesArePlaying]
AS
	SELECT 
		startTime,
		endTime
	FROM 
		TimesGamesArePlaying
GO
/****** Object:  StoredProcedure [dbo].[GetTeamById]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTeamById]
	@teamId int
AS 
	SELECT
		id,
		name
	FROM
		Team
	WHERE
		id = @teamId
GO
/****** Object:  StoredProcedure [dbo].[GetCurrentUsers]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCurrentUsers]
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
/****** Object:  StoredProcedure [dbo].[GetCurrentTeams]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCurrentTeams]
AS 
	SET NOCOUNT ON;
	SELECT
		id,
		name
	FROM
		Team
GO
/****** Object:  StoredProcedure [dbo].[GetAllUsers]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllUsers]
AS 
	SELECT 
		id,
		username,
		active
	FROM
		[User]
GO
/****** Object:  StoredProcedure [dbo].[IsItTimeToPlay]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IsItTimeToPlay]
AS
	IF EXISTS(SELECT * FROM TimesGamesArePlaying WHERE getdate() BETWEEN startTime AND endTime)
		SELECT 0
	ELSE
		SELECT 1
GO
/****** Object:  StoredProcedure [dbo].[GetUserById]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserById]
    @userID int
AS 
	SET NOCOUNT ON;
	
    SELECT 
		username,
		email
    FROM 
		[User]
    WHERE 
		[User].id = @userID
GO
/****** Object:  StoredProcedure [dbo].[OverriedUserPass]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OverriedUserPass]
	@userId INT,
	@password varchar(100)
AS
	UPDATE
		[User]
	SET
		password = @password
	WHERE
		id = @userId
GO
/****** Object:  Table [dbo].[RoleContent]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleContent](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[roleID] [int] NOT NULL,
	[contentID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[UpsertTeam]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertTeam]
	@id int = 0,
	@name varchar(100)
AS 
	SET NOCOUNT ON;
	IF EXISTS(SELECT * FROM Team WHERE id = @id)
	BEGIN
		UPDATE Team
		SET name = @name
		WHERE id = @id
	END
	ELSE
	BEGIN		
		INSERT INTO Team (name)
		SELECT @name	
	END
GO
/****** Object:  StoredProcedure [dbo].[UpsertRound]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertRound]
	@id int = 0,
	@round int
AS 
	SET NOCOUNT ON;
	IF EXISTS(SELECT * FROM [Round] WHERE id = @id)
	BEGIN
		UPDATE [Round]
		SET [roundNo] = @round
		WHERE id = @id
	END
	ELSE
	BEGIN		
		INSERT INTO [Round] ([roundNo])
		SELECT @round	
	END
GO
/****** Object:  StoredProcedure [dbo].[UpsertRole]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertRole]	
	@roleId int = 0,
	@role varchar(100)
AS 
	IF @roleId = 0
	BEGIN
		UPDATE [Role] SET [role] = @role WHERE id = @roleId
	END
	ELSE
	BEGIN
		INSERT INTO [Role] ([role])
		SELECT TOP 1 @role
	END
GO
/****** Object:  StoredProcedure [dbo].[UpsertRegion]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertRegion]
	@id int = 0,
	@name varchar(100)
AS 
	SET NOCOUNT ON;
	IF EXISTS(SELECT * FROM Region WHERE id = @id)
	BEGIN
		UPDATE Region
		SET region = @name
		WHERE id = @id
	END
	ELSE
	BEGIN		
		INSERT INTO Region (region)
		SELECT @name	
	END
GO
/****** Object:  StoredProcedure [dbo].[UpsertRank]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertRank]
	@id int = 0,
	@rank int
AS 
	SET NOCOUNT ON;
	IF EXISTS(SELECT * FROM [Rank] WHERE id = @id)
	BEGIN
		UPDATE [Rank]
		SET [rank] = @rank
		WHERE id = @id
	END
	ELSE
	BEGIN		
		INSERT INTO [Rank] ([rank])
		SELECT @rank	
	END
GO
/****** Object:  Table [dbo].[Tourny]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tourny](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[teamId] [int] NOT NULL,
	[regionId] [int] NOT NULL,
	[rankId] [int] NOT NULL,
 CONSTRAINT [PK_Tourny] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[roleID] [int] NOT NULL,
	[userID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[UpsertUser]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpsertUser]
	@ID int = 0,
    @username varchar(100), 
    @password varchar(100) = null,
    @email varchar(100),
    @active bit = 0
AS 
	SET NOCOUNT ON;
	DECLARE @userId INT
	
	IF @ID != 0 AND @password is null
	BEGIN
		SET @password = (SELECT password FROM [User] WHERE id = @ID)
	END
	
    IF @ID = 0
    BEGIN
		INSERT INTO [User] (username, password, email, active)
		SELECT	@username, @password, @email, 0	
		
		SET @userId = (SELECT @@IDENTITY)
		
		INSERT INTO UserRole (userId, roleId)
		SELECT @userId, 2
		
		SELECT @userId as ID
	END
    ELSE
    BEGIN
		UPDATE
			[User]
		SET
			username = @username,
			password = @password,
			email = @email
		WHERE
			id = @ID
			
		SELECT @ID as ID
	END
GO
/****** Object:  Table [dbo].[MatchUp]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchUp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tourny1Id] [int] NOT NULL,
	[tourny2Id] [int] NOT NULL,
	[winnerId] [int] NULL,
	[year] [int] NOT NULL,
	[roundId] [int] NULL,
	[seed] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[LogonUser]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LogonUser]
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
/****** Object:  StoredProcedure [dbo].[CreateTourny]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateTourny]
	@teamID int,
	@regionID int,
	@rankID int
AS 
	INSERT INTO Tourny (teamId, regionID, rankID)
	SELECT @teamID, @regionID, @rankID
	FROM [round]
	WHERE roundno = 1
GO
/****** Object:  StoredProcedure [dbo].[CheckUser]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckUser]
    @userID int, 
    @contentID int 
AS 
	SET NOCOUNT ON;
	
    SELECT 
		[User].id
    FROM 
		[User]
		INNER JOIN UserRole ON UserRole.userId = [User].id
		INNER JOIN RoleContent ON RoleContent.roleId = UserRole.roleId
		INNER JOIN Content ON Content.id = RoleContent.contentID
    WHERE 
		[User].id = @userID
		AND Content.id = @contentID
		AND [User].active = 1
GO
/****** Object:  StoredProcedure [dbo].[InsertRoleContent]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertRoleContent]	
	@roleId int,
	@contentId int
AS 
	IF NOT EXISTS (SELECT * FROM RoleContent WHERE roleId = @roleId AND contentId = @contentId)
	BEGIN
		INSERT INTO RoleContent(roleId, contentId)
		SELECT TOP 1 @roleId, @contentId
	END
GO
/****** Object:  StoredProcedure [dbo].[GetAllTournies]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllTournies]
AS 
	SET NOCOUNT ON;
	SELECT 
		[Rank].[rank], 
		Region.id as regionId, 
		Region.region, 
		Team.id as teamId, 
		Team.name as team,
		Tourny.id as tournyId
	FROM
		Tourny
		JOIN Team
			ON Team.id = Tourny.teamId
		JOIN Region
			ON Region.id = Tourny.regionId
		JOIN [Rank]
			ON [Rank].id = Tourny.rankId
GO
/****** Object:  StoredProcedure [dbo].[GetAllContent]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllContent]	
	@roleId int = 0
AS 
	SET NOCOUNT ON;
	IF @roleId = 0
	BEGIN
		SELECT
			id,
			content
		FROM
			Content
	END
	ELSE
	BEGIN
		SELECT DISTINCT
			Content.id,
			content
		FROM
			Content
			JOIN RoleContent
				ON RoleContent.contentId = Content.id
		WHERE
			roleId = @roleId			
	END
GO
/****** Object:  StoredProcedure [dbo].[GetAllMatchups]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllMatchups]
	@roundId INT = 0
AS 
	SET NOCOUNT ON;
	SELECT
		M.id as id,
		T1.id as tourny1id,
		Team1.id as team1id,
		Team1.name as team1name,
		Region1.id as region1id,
		Region1.region as region1,
		T1.rankId as rank1id,
		T2.id as tourny2id,
		Team2.id as team2id,
		Team2.name as team2name,
		Region2.id as region2id,
		Region2.region as region2,
		T2.rankId as rank2id,
		W.id as winnerId,
		Winner.id as winnerTeamId,
		Winner.name as winnerName,
		W.rankId as rankWinnerid,
		M.roundId
	FROM
		Matchup M
		INNER JOIN Tourny T1
			ON M.tourny1id = T1.id
		INNER JOIN Tourny T2
			ON M.tourny2id = T2.id
		LEFT JOIN Tourny W
			ON M.winnerId = W.id
		INNER JOIN Team Team1
			ON Team1.id = T1.teamId
		INNER JOIN Team Team2
			ON Team2.id = T2.teamId
		LEFT JOIN Team Winner
			ON Winner.id = W.teamId
		INNER JOIN Region Region1
			ON Region1.id = T1.regionId
		INNER JOIN Region Region2
			ON Region2.id = T2.regionId
	WHERE
		M.roundId = @roundId
		OR @roundId = 0
GO
/****** Object:  StoredProcedure [dbo].[GenerateMatchup]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenerateMatchup]
	@regionID int,
	@roundId int,
	@numOfSeed int,
	@seed int
AS 	
	INSERT INTO MatchUp (tourny1Id, tourny2Id, [year], roundId, seed)
	SELECT DISTINCT
		M1.winnerId,
		M2.winnerId,
		YEAR(getdate()),
		@roundId,
		@seed
	FROM
		MatchUp M1
		JOIN Tourny T1 ON T1.id = M1.winnerId,
		MatchUp M2
		JOIN Tourny T2 ON T2.id = M2.winnerId
	WHERE
		T1.regionId = @regionId AND M1.seed = @seed
		AND T2.regionId = @regionId AND m2.seed = (@numOfSeed + 1) - @seed
GO
/****** Object:  StoredProcedure [dbo].[GenerateFirstMatchup]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenerateFirstMatchup]
	@regionID int,
	@rank int
AS 
	INSERT INTO MatchUp (tourny1Id, tourny2Id, [year], roundId, seed)
	SELECT
		T1.id,
		T2.id,
		YEAR(getdate()),
		(SELECT TOP 1 id FROM [Round] WHERE [roundNo] = 1) as roundid,
		T1.[rankId]
	FROM
		Tourny T1,
		Tourny T2
	WHERE
		T1.regionID = @regionID and T1.rankID = (select id from [rank] where [rank] = @rank) AND		
		T2.regionID = @regionID and T2.rankID = (select id from [rank] where [rank] = 17 - @rank)
GO
/****** Object:  StoredProcedure [dbo].[GenerateFinalFour]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[CheckPreviousRound]    Script Date: 02/07/2014 13:37:47 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO




CREATE PROCEDURE [dbo].[GenerateFinalFour]
	@roundId INT,
	@region1 INT,
	@region2 INT
AS 
	DECLARE @roundNo INT
	DECLARE @prevRoundId INT
	SET @roundNo =  (SELECT TOP 1 roundNo FROM [Round] WHERE id = @roundId) 
	SET @prevRoundId = (SELECT TOP 1 id FROM [Round] WHERE roundNo = (@roundNo - 1))
	
	INSERT INTO MatchUp (tourny1id, tourny2id, [year], roundId, seed)
	SELECT
		T1.id,
		T2.id,
		YEAR(getdate()),
		@roundId,
		1
	FROM
		Tourny T1,
		Tourny T2
	WHERE
		T1.id = 
		(
			SELECT DISTINCT
				winnerId 
			FROM 
				MatchUp M 
				JOIN Tourny W 
					ON W.id = M.winnerId 
			WHERE 
				W.regionId = @region1
				AND M.roundId = @prevRoundId
		)
		AND		
		T2.id = 
		(
			SELECT DISTINCT
				winnerId 
			FROM 
				MatchUp M 
				JOIN Tourny W 
					ON W.id = M.winnerId 
			WHERE 
				W.regionId = @region2
				AND M.roundId = @prevRoundId				
		)
	UNION ALL
	SELECT
		T1.id,
		T2.id,
		YEAR(getdate()),
		@roundId,
		1
	FROM
		Tourny T1,
		Tourny T2
	WHERE
		T1.id = 
		(
			SELECT DISTINCT
				winnerId 
			FROM 
				MatchUp M 
				JOIN Tourny W 
					ON W.id = M.winnerId 
			WHERE 
				W.regionId = (SELECT TOP 1 id FROM Region WHERE id not in (@region1, @region2) ORDER BY id DESC)
				AND M.roundId = @prevRoundId
		)
		AND		
		T2.id = 
		(
			SELECT DISTINCT
				winnerId 
			FROM 
				MatchUp M 
				JOIN Tourny W 
					ON W.id = M.winnerId 
			WHERE 
				W.regionId = (SELECT TOP 1 id FROM Region WHERE id not in (@region1, @region2) ORDER BY id ASC)
				AND M.roundId = @prevRoundId				
		)
GO
/****** Object:  StoredProcedure [dbo].[GenerateFinal]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[CheckPreviousRound]    Script Date: 02/07/2014 13:37:47 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO




CREATE PROCEDURE [dbo].[GenerateFinal]
	@roundId INT
AS 
	DECLARE @roundNo INT
	DECLARE @prevRoundId INT
	SET @roundNo =  (SELECT TOP 1 roundNo FROM [Round] WHERE id = @roundId) 
	SET @prevRoundId = (SELECT TOP 1 id FROM [Round] WHERE roundNo = (@roundNo - 1))
	
	INSERT INTO MatchUp (tourny1id, tourny2id, [year], roundId, seed)
	SELECT
		T1.id,
		T2.id,
		YEAR(getdate()),
		@roundId,
		1
	FROM
		Tourny T1,
		Tourny T2
	WHERE
		T1.id = 
		(
			SELECT TOP 1
				winnerId 
			FROM 
				MatchUp M 
				JOIN Tourny W 
					ON W.id = M.winnerId 
			WHERE 
				M.roundId = @prevRoundId
			ORDER BY
				winnerId DESC
		)
		AND		
		T2.id = 
		(
			SELECT TOP 1
				winnerId 
			FROM 
				MatchUp M 
				JOIN Tourny W 
					ON W.id = M.winnerId 
			WHERE 
				M.roundId = @prevRoundId
			ORDER BY
				winnerId DESC			
		)
GO
/****** Object:  StoredProcedure [dbo].[ChooseMatchUpWinner]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ChooseMatchUpWinner]
	@matchUpID INT,
	@winnerID INT
AS 
	UPDATE
		MatchUp
	SET
		winnerId = @winnerId
	WHERE
		id = @matchUpID
		
	SELECT roundId FROM MatchUp WHERE id = @matchUpID
GO
/****** Object:  StoredProcedure [dbo].[CheckPreviousRound]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckPreviousRound]
	@roundId INT
AS 
	DECLARE @roundNo INT
	SET @roundNo = (SELECT roundNo - 1 FROM [Round] WHERE id = @roundId)
	SELECT
		CASE count(id)
			WHEN count(winnerId) THEN 1
			ELSE 0
		END as complete
	FROM
		MatchUp
	WHERE
		roundId = (SELECT TOP 1 id FROM [round] WHERE roundNo = @roundNo)
GO
/****** Object:  StoredProcedure [dbo].[GetAllRoundsNotInMatchup]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllRoundsNotInMatchup]
AS 
	SELECT 
		id,
		roundNo
	FROM
		[Round] R
	WHERE
		id not in (SELECT DISTINCT roundId FROM MatchUp)
GO
/****** Object:  StoredProcedure [dbo].[GetMatchupById]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMatchupById]
	@matchupId INT
AS 
	SET NOCOUNT ON;
	SELECT
		M.id as id,
		T1.id as tourny1id,
		Team1.id as team1id,
		Team1.name as team1name,
		Region1.id as region1id,
		Region1.region as region1,
		T1.rankId as rank1id,
		T2.id as tourny2id,
		Team2.id as team2id,
		Team2.name as team2name,
		Region2.id as region2id,
		Region2.region as region2,
		T2.rankId as rank2id,
		M.roundId
	FROM
		Matchup M
		INNER JOIN Tourny T1
			ON M.tourny1id = T1.id
		INNER JOIN Tourny T2
			ON M.tourny2id = T2.id
		INNER JOIN Team Team1
			ON Team1.id = T1.teamId
		INNER JOIN Team Team2
			ON Team2.id = T2.teamId
		INNER JOIN Region Region1
			ON Region1.id = T1.regionId
		INNER JOIN Region Region2
			ON Region2.id = T2.regionId
	WHERE
		M.id = @matchupId
GO
/****** Object:  Table [dbo].[UserChoice]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserChoice](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[matchupID] [int] NOT NULL,
	[tournyIDChoice] [int] NOT NULL,
	[userId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SubmitUserChoice]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SubmitUserChoice]
	@tournyId INT,
	@roundId INT,
	@userId INT
AS
	IF NOT EXISTS(SELECT * FROM UserChoice UC JOIN MatchUp M ON M.id = UC.matchUpId WHERE userId = @userId AND
		M.roundId = @roundId AND (M.tourny1Id = @tournyId OR M.tourny2Id = @tournyId))
	BEGIN
		INSERT INTO UserChoice(matchUpId, tournyIdChoice, userId)
		SELECT
			M.id,
			@tournyId,
			@userId
		FROM
			MatchUp M
		WHERE
			M.roundId = @roundId
			AND 
			(
				M.tourny1Id = @tournyId
				OR M.tourny2Id = @tournyId
			)
	END
	ELSE
	BEGIN
		UPDATE
			UC
		SET
			tournyIdChoice = @tournyId
		FROM
			UserChoice UC
			JOIN MatchUp M
				ON M.id = UC.matchUpId
		WHERE
			M.roundId = @roundId
			AND 
			(
				M.tourny1Id = @tournyId
				OR M.tourny2Id = @tournyId
			)
	END
GO
/****** Object:  StoredProcedure [dbo].[GetUserScore]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserScore]
	@userID int
AS 
	SET NOCOUNT ON;
	
	SELECT		
		username,
		SUM(
			CASE 
				WHEN winnerID = tournyIdChoice THEN 1
				ELSE 0
			END
		)* regionId as points
	FROM
		[User]
		INNER JOIN UserChoice ON UserChoice.userId = [User].id
		INNER JOIN MatchUp ON MatchUp.id = UserChoice.matchupID
		INNER JOIN Tourny ON Tourny.id = MatchUp.tourny1Id
	WHERE
		[User].id = @userID
	GROUP BY
		username, regionID
GO
/****** Object:  StoredProcedure [dbo].[GetUserChoiceMatchupsByRound]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserChoiceMatchupsByRound]
	@roundId INT,
	@userId INT
AS 
	SET NOCOUNT ON;
	SELECT
		M.id as id,
		T1.id as tourny1id,
		Team1.id as team1id,
		Team1.name as team1name,
		Region1.id as region1id,
		Region1.region as region1,
		T1.rankId as rank1id,
		T2.id as tourny2id,
		Team2.id as team2id,
		Team2.name as team2name,
		Region2.id as region2id,
		Region2.region as region2,
		T2.rankId as rank2id,
		W.id as winnerId,
		Winner.id as winnerTeamId,
		Winner.name as winnerName,
		W.rankId as rankWinnerid,
		M.roundId,
		UC.tournyIDChoice as userChoice
	FROM
		Matchup M
		INNER JOIN Tourny T1
			ON M.tourny1id = T1.id
		INNER JOIN Tourny T2
			ON M.tourny2id = T2.id
		LEFT JOIN Tourny W
			ON M.winnerId = W.id
		INNER JOIN Team Team1
			ON Team1.id = T1.teamId
		INNER JOIN Team Team2
			ON Team2.id = T2.teamId
		LEFT JOIN Team Winner
			ON Winner.id = W.teamId
		INNER JOIN Region Region1
			ON Region1.id = T1.regionId
		INNER JOIN Region Region2
			ON Region2.id = T2.regionId
		LEFT JOIN UserChoice UC
			ON UC.matchUpId = M.id
			AND UC.userId = @userId
	WHERE
		M.roundId = @roundId
GO
/****** Object:  StoredProcedure [dbo].[GetUserBracket]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserBracket]
	@userID int
AS 
	SET NOCOUNT ON;
	
	SELECT
		T1.ID as tourny1Id,
		Team1.name as team1,
		T2.ID as tourny2Id,
		Team2.name as team2,
		Winner.id as winnerId,
		TeamWin.name as 'winner',
		Region.id as regionId,
		UserChoice.tournyIdChoice as userTeam
	FROM
		MatchUp
		INNER JOIN Tourny T1 ON T1.id = Matchup.tourny1Id
		INNER JOIN Team Team1 ON Team1.id = T1.teamId
		INNER JOIN Tourny T2 ON T2.id = Matchup.tourny2Id
		INNER JOIN Team Team2 ON Team2.id = T2.teamId
		INNER JOIN Tourny Winner ON Winner.id = Matchup.winnerID
		INNER JOIN Team TeamWin ON TeamWin.id = Winner.teamId
		INNER JOIN Region ON Region.id = T1.regionID
		INNER JOIN [Round] ON [Round].id = MatchUp.roundId
		LEFT JOIN UserChoice ON UserChoice.matchupId = Matchup.id		
	WHERE
		userId = @userID
GO
/****** Object:  StoredProcedure [dbo].[GetLeaderBoard]    Script Date: 03/07/2014 17:32:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLeaderBoard]
AS 
	SET NOCOUNT ON;
	
	SELECT
		username,
		SUM(
			CASE 
				WHEN winnerID = tournyIdChoice THEN 1
				ELSE 0
			END
		 * roundNo) as points
	FROM
		[User]
		INNER JOIN UserChoice ON UserChoice.userId = [User].id
		INNER JOIN MatchUp ON MatchUp.id = UserChoice.matchupID
		INNER JOIN [Round] ON [Round].id = MatchUp.roundId 
		INNER JOIN Tourny ON MatchUp.tourny1Id = Tourny.id
	GROUP BY
		username
	ORDER BY
		points DESC
GO
/****** Object:  Default [DF__User__active__0E6E26BF]    Script Date: 03/07/2014 17:32:18 ******/
ALTER TABLE [dbo].[User] ADD  DEFAULT ((0)) FOR [active]
GO
/****** Object:  Default [DF__MatchUp__year__0F2D40CE]    Script Date: 03/07/2014 17:32:32 ******/
ALTER TABLE [dbo].[MatchUp] ADD  DEFAULT (datepart(year,getdate())) FOR [year]
GO
/****** Object:  ForeignKey [FK_RoleContentRole_Content]    Script Date: 03/07/2014 17:32:32 ******/
ALTER TABLE [dbo].[RoleContent]  WITH CHECK ADD  CONSTRAINT [FK_RoleContentRole_Content] FOREIGN KEY([contentID])
REFERENCES [dbo].[Content] ([id])
GO
ALTER TABLE [dbo].[RoleContent] CHECK CONSTRAINT [FK_RoleContentRole_Content]
GO
/****** Object:  ForeignKey [FK_RoleContentRole_Role]    Script Date: 03/07/2014 17:32:32 ******/
ALTER TABLE [dbo].[RoleContent]  WITH CHECK ADD  CONSTRAINT [FK_RoleContentRole_Role] FOREIGN KEY([roleID])
REFERENCES [dbo].[Role] ([id])
GO
ALTER TABLE [dbo].[RoleContent] CHECK CONSTRAINT [FK_RoleContentRole_Role]
GO
/****** Object:  ForeignKey [FK_Tourny_Rank]    Script Date: 03/07/2014 17:32:32 ******/
ALTER TABLE [dbo].[Tourny]  WITH CHECK ADD  CONSTRAINT [FK_Tourny_Rank] FOREIGN KEY([rankId])
REFERENCES [dbo].[Rank] ([id])
GO
ALTER TABLE [dbo].[Tourny] CHECK CONSTRAINT [FK_Tourny_Rank]
GO
/****** Object:  ForeignKey [FK_Tourny_Region]    Script Date: 03/07/2014 17:32:32 ******/
ALTER TABLE [dbo].[Tourny]  WITH CHECK ADD  CONSTRAINT [FK_Tourny_Region] FOREIGN KEY([regionId])
REFERENCES [dbo].[Region] ([id])
GO
ALTER TABLE [dbo].[Tourny] CHECK CONSTRAINT [FK_Tourny_Region]
GO
/****** Object:  ForeignKey [FK_Tourny_Team]    Script Date: 03/07/2014 17:32:32 ******/
ALTER TABLE [dbo].[Tourny]  WITH CHECK ADD  CONSTRAINT [FK_Tourny_Team] FOREIGN KEY([teamId])
REFERENCES [dbo].[Team] ([id])
GO
ALTER TABLE [dbo].[Tourny] CHECK CONSTRAINT [FK_Tourny_Team]
GO
/****** Object:  ForeignKey [FK_UserRoleRole_Role]    Script Date: 03/07/2014 17:32:32 ******/
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRoleRole_Role] FOREIGN KEY([roleID])
REFERENCES [dbo].[Role] ([id])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRoleRole_Role]
GO
/****** Object:  ForeignKey [FK_UserRoleUser_User]    Script Date: 03/07/2014 17:32:32 ******/
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRoleUser_User] FOREIGN KEY([userID])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRoleUser_User]
GO
/****** Object:  ForeignKey [FK_Matchup_round]    Script Date: 03/07/2014 17:32:32 ******/
ALTER TABLE [dbo].[MatchUp]  WITH CHECK ADD  CONSTRAINT [FK_Matchup_round] FOREIGN KEY([roundId])
REFERENCES [dbo].[Round] ([id])
GO
ALTER TABLE [dbo].[MatchUp] CHECK CONSTRAINT [FK_Matchup_round]
GO
/****** Object:  ForeignKey [FK_MatchUp_Tourny1]    Script Date: 03/07/2014 17:32:32 ******/
ALTER TABLE [dbo].[MatchUp]  WITH CHECK ADD  CONSTRAINT [FK_MatchUp_Tourny1] FOREIGN KEY([tourny1Id])
REFERENCES [dbo].[Tourny] ([id])
GO
ALTER TABLE [dbo].[MatchUp] CHECK CONSTRAINT [FK_MatchUp_Tourny1]
GO
/****** Object:  ForeignKey [FK_MatchUp_Tourny2]    Script Date: 03/07/2014 17:32:32 ******/
ALTER TABLE [dbo].[MatchUp]  WITH CHECK ADD  CONSTRAINT [FK_MatchUp_Tourny2] FOREIGN KEY([tourny2Id])
REFERENCES [dbo].[Tourny] ([id])
GO
ALTER TABLE [dbo].[MatchUp] CHECK CONSTRAINT [FK_MatchUp_Tourny2]
GO
/****** Object:  ForeignKey [FK_MatchUp_Winner]    Script Date: 03/07/2014 17:32:32 ******/
ALTER TABLE [dbo].[MatchUp]  WITH CHECK ADD  CONSTRAINT [FK_MatchUp_Winner] FOREIGN KEY([winnerId])
REFERENCES [dbo].[Tourny] ([id])
GO
ALTER TABLE [dbo].[MatchUp] CHECK CONSTRAINT [FK_MatchUp_Winner]
GO
/****** Object:  ForeignKey [fk_teamChoice_team]    Script Date: 03/07/2014 17:32:32 ******/
ALTER TABLE [dbo].[UserChoice]  WITH CHECK ADD  CONSTRAINT [fk_teamChoice_team] FOREIGN KEY([tournyIDChoice])
REFERENCES [dbo].[Tourny] ([id])
GO
ALTER TABLE [dbo].[UserChoice] CHECK CONSTRAINT [fk_teamChoice_team]
GO
/****** Object:  ForeignKey [fk_userChoiceMatchUp_matchup]    Script Date: 03/07/2014 17:32:32 ******/
ALTER TABLE [dbo].[UserChoice]  WITH CHECK ADD  CONSTRAINT [fk_userChoiceMatchUp_matchup] FOREIGN KEY([matchupID])
REFERENCES [dbo].[MatchUp] ([id])
GO
ALTER TABLE [dbo].[UserChoice] CHECK CONSTRAINT [fk_userChoiceMatchUp_matchup]
GO
/****** Object:  ForeignKey [fk_userChoiceMatchUp_user]    Script Date: 03/07/2014 17:32:32 ******/
ALTER TABLE [dbo].[UserChoice]  WITH CHECK ADD  CONSTRAINT [fk_userChoiceMatchUp_user] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[UserChoice] CHECK CONSTRAINT [fk_userChoiceMatchUp_user]
GO
