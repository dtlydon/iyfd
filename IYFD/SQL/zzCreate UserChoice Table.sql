USE [IYFD]
GO

/****** Object:  Table [dbo].[UserChoice]    Script Date: 02/18/2013 09:30:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserChoice](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[matchupID] [int] NOT NULL,
	[teamIDChoice] [int] NOT NULL,
	[userId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[UserChoice]  WITH CHECK ADD  CONSTRAINT [fk_teamChoice_team] FOREIGN KEY([teamIDChoice])
REFERENCES [dbo].[Team] ([id])
GO

ALTER TABLE [dbo].[UserChoice] CHECK CONSTRAINT [fk_teamChoice_team]
GO

ALTER TABLE [dbo].[UserChoice]  WITH CHECK ADD  CONSTRAINT [fk_userChoiceMatchUp_matchUp] FOREIGN KEY([matchupID])
REFERENCES [dbo].[MatchUp] ([id])
GO

ALTER TABLE [dbo].[UserChoice] CHECK CONSTRAINT [fk_userChoiceMatchUp_matchUp]
GO

ALTER TABLE [dbo].[UserChoice]  WITH CHECK ADD  CONSTRAINT [fk_userChoiceMatchUp_user] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO

ALTER TABLE [dbo].[UserChoice] CHECK CONSTRAINT [fk_userChoiceMatchUp_user]
GO


