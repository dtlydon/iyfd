USE [IYFD]
GO

/****** Object:  Table [dbo].[MatchUp]    Script Date: 02/18/2013 09:25:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MatchUp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[team1ID] [int] NOT NULL,
	[team2ID] [int] NOT NULL,
	[winnerID] [int] NOT NULL,
	[regionID] int NOT NULL,
	[year] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[MatchUp]  WITH CHECK ADD  CONSTRAINT [fk_team1_team] FOREIGN KEY([team1ID])
REFERENCES [dbo].[Team] ([id])
GO

ALTER TABLE [dbo].[MatchUp] CHECK CONSTRAINT [fk_team1_team]
GO

ALTER TABLE [dbo].[MatchUp]  WITH CHECK ADD  CONSTRAINT [fk_team2_team] FOREIGN KEY([team2ID])
REFERENCES [dbo].[Team] ([id])
GO

ALTER TABLE [dbo].[MatchUp] CHECK CONSTRAINT [fk_team2_team]
GO

ALTER TABLE [dbo].[MatchUp]  WITH CHECK ADD  CONSTRAINT [fk_winner_team] FOREIGN KEY([winnerID])
REFERENCES [dbo].[Team] ([id])
GO

ALTER TABLE [dbo].[MatchUp] CHECK CONSTRAINT [fk_winner_team]
GO

ALTER TABLE [dbo].[MatchUp] ADD  DEFAULT (datepart(year,getdate())) FOR [year]
GO


ALTER TABLE [dbo].[MatchUp]  
ADD Constraint fk_matchup_region FOREIGN KEY (regionID)
REFERENCES [dbo].[Region] ([id])
GO

