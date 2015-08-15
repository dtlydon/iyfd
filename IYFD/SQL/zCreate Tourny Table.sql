USE [IYFD]
GO

/****** Object:  Table [dbo].[Toury]    Script Date: 02/18/2013 09:29:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Toury](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[teamID] [int] NOT NULL,
	[regionID] [int] NOT NULL,
	[rankID] [int] NOT NULL,
	[roundID] [int] NOT NULL,
	[year] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Toury]  WITH CHECK ADD  CONSTRAINT [fk_tournyRank_rank] FOREIGN KEY([rankID])
REFERENCES [dbo].[Rank] ([id])
GO

ALTER TABLE [dbo].[Toury] CHECK CONSTRAINT [fk_tournyRank_rank]
GO

ALTER TABLE [dbo].[Toury]  WITH CHECK ADD  CONSTRAINT [fk_tournyRegion_region] FOREIGN KEY([regionID])
REFERENCES [dbo].[Region] ([id])
GO

ALTER TABLE [dbo].[Toury] CHECK CONSTRAINT [fk_tournyRegion_region]
GO

ALTER TABLE [dbo].[Toury]  WITH CHECK ADD  CONSTRAINT [fk_tournyRound_round] FOREIGN KEY([roundID])
REFERENCES [dbo].[Round] ([id])
GO

ALTER TABLE [dbo].[Toury] CHECK CONSTRAINT [fk_tournyRound_round]
GO

ALTER TABLE [dbo].[Toury]  WITH CHECK ADD  CONSTRAINT [fk_tournyTeam_team] FOREIGN KEY([teamID])
REFERENCES [dbo].[Team] ([id])
GO

ALTER TABLE [dbo].[Toury] CHECK CONSTRAINT [fk_tournyTeam_team]
GO

ALTER TABLE [dbo].[Toury] ADD  DEFAULT (datepart(year,getdate())) FOR [year]
GO


