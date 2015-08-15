USE [IYFD]
GO

/****** Object:  Table [dbo].[RoleContent]    Script Date: 02/18/2013 09:28:24 ******/
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

ALTER TABLE [dbo].[RoleContent]  WITH CHECK ADD  CONSTRAINT [FK_RoleContentRole_Content] FOREIGN KEY([contentID])
REFERENCES [dbo].[Content] ([id])
GO

ALTER TABLE [dbo].[RoleContent] CHECK CONSTRAINT [FK_RoleContentRole_Content]
GO

ALTER TABLE [dbo].[RoleContent]  WITH CHECK ADD  CONSTRAINT [FK_RoleContentRole_Role] FOREIGN KEY([roleID])
REFERENCES [dbo].[Role] ([id])
GO

ALTER TABLE [dbo].[RoleContent] CHECK CONSTRAINT [FK_RoleContentRole_Role]
GO


