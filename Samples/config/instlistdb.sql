-- Copyright © Microsoft Corporation. All rights reserved.

-- Microsoft Limited Permissive License (Ms-LPL)

-- This license governs use of the accompanying software. If you use the software, you accept this license. If you do not accept the license, do not use the software.

-- 1. Definitions
-- The terms “reproduce,” “reproduction,” “derivative works,” and “distribution” have the same meaning here as under U.S. copyright law.
-- A “contribution” is the original software, or any additions or changes to the software.
-- A “contributor” is any person that distributes its contribution under this license.
-- “Licensed patents” are a contributor’s patent claims that read directly on its contribution.

-- 2. Grant of Rights
-- (A) Copyright Grant- Subject to the terms of this license, including the license conditions and limitations in section 3, each contributor grants you a non-exclusive, worldwide, royalty-free copyright license to reproduce its contribution, prepare derivative works of its contribution, and distribute its contribution or any derivative works that you create.
-- (B) Patent Grant- Subject to the terms of this license, including the license conditions and limitations in section 3, each contributor grants you a non-exclusive, worldwide, royalty-free license under its licensed patents to make, have made, use, sell, offer for sale, import, and/or otherwise dispose of its contribution in the software or derivative works of the contribution in the software.

-- 3. Conditions and Limitations
-- (A) No Trademark License- This license does not grant you rights to use any contributors’ name, logo, or trademarks.
-- (B) If you bring a patent claim against any contributor over patents that you claim are infringed by the software, your patent license from such contributor to the software ends automatically.
-- (C) If you distribute any portion of the software, you must retain all copyright, patent, trademark, and attribution notices that are present in the software.
-- (D) If you distribute any portion of the software in source code form, you may do so only under this license by including a complete copy of this license with your distribution. If you distribute any portion of the software in compiled or object code form, you may only do so under a license that complies with this license.
-- (E) The software is licensed “as-is.” You bear the risk of using it. The contributors give no express warranties, guarantees or conditions. You may have additional consumer rights under your local laws which this license cannot change. To the extent permitted under your local laws, the contributors exclude the implied warranties of merchantability, fitness for a particular purpose and non-infringement.
-- (F) Platform Limitation- The licenses granted in sections 2(A) & 2(B) extend only to the software or derivative works that you create that run on a Microsoft Windows operating system product.

-- Note: When executing this script on SQL Azure, please comment the 
-- CREATE DATABASE statement and manually create the database and then run the script.
-- This is because SQL Azure does not allow switching databases without opening a new
-- connection

-- COMMENT LINES BELOW FOR SQL AZURE
CREATE DATABASE [listdb]
GO
USE [listdb]
GO
-- END COMMENT FOR SQL AZURE


CREATE TABLE [dbo].[User](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)
)
GO

CREATE TABLE [dbo].[Tag](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)
)
GO

CREATE TABLE [dbo].[Status](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)
)
GO

CREATE TABLE [dbo].[Priority](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Priority] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)
)
GO

CREATE TABLE [dbo].[List](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_List] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)
)
GO

CREATE TABLE [dbo].[Item](
	[ID] [uniqueidentifier] NOT NULL,
	[ListID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Priority] [int] NULL,
	[Status] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)
)
GO

CREATE TABLE [dbo].[TagItemMapping](
	[TagID] [int] NOT NULL,
	[ItemID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_TagItemMapping] PRIMARY KEY CLUSTERED 
(
	[TagID] ASC,
	[ItemID] ASC,
	[UserID] ASC
)
)
GO

ALTER TABLE [dbo].[List] ADD  CONSTRAINT [DF_List_ID]  DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[List] ADD  CONSTRAINT [DF_List_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_ID]  DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_List] FOREIGN KEY([ListID])
REFERENCES [dbo].[List] ([ID])
GO

ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_List]
GO

ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Priority] FOREIGN KEY([Priority])
REFERENCES [dbo].[Priority] ([ID])
GO

ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_Priority]
GO

ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[Status] ([ID])
GO

ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_Status]
GO

ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO

ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_User]
GO

ALTER TABLE [dbo].[List]  WITH CHECK ADD  CONSTRAINT [FK_List_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO

ALTER TABLE [dbo].[List] CHECK CONSTRAINT [FK_List_User]
GO

ALTER TABLE [dbo].[TagItemMapping]  WITH CHECK ADD  CONSTRAINT [FK_TagItemMapping_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([ID])
GO

ALTER TABLE [dbo].[TagItemMapping] CHECK CONSTRAINT [FK_TagItemMapping_Item]
GO

ALTER TABLE [dbo].[TagItemMapping]  WITH CHECK ADD  CONSTRAINT [FK_TagItemMapping_Tag] FOREIGN KEY([TagID])
REFERENCES [dbo].[Tag] ([ID])
GO

ALTER TABLE [dbo].[TagItemMapping] CHECK CONSTRAINT [FK_TagItemMapping_Tag]
GO

ALTER TABLE [dbo].[TagItemMapping]  WITH CHECK ADD  CONSTRAINT [FK_TagItemMapping_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO

ALTER TABLE [dbo].[TagItemMapping] CHECK CONSTRAINT [FK_TagItemMapping_User]
GO

INSERT INTO [Priority] ([Name]) VALUES ('Low')
INSERT INTO [Priority] ([Name]) VALUES ('Medium')
INSERT INTO [Priority] ([Name]) VALUES ('High')
GO

INSERT INTO [Status] ([Name]) VALUES ('Not Started')
INSERT INTO [Status] ([Name]) VALUES ('Planning')
INSERT INTO [Status] ([Name]) VALUES ('In Progress')
INSERT INTO [Status] ([Name]) VALUES ('Completed')
INSERT INTO [Status] ([Name]) VALUES ('Abandoned')
GO

INSERT INTO dbo.Tag (Name) VALUES ('ToDo')
INSERT INTO dbo.Tag (Name) VALUES ('Shopping')
INSERT INTO dbo.Tag (Name) VALUES ('Family')
INSERT INTO dbo.Tag (Name) VALUES ('Work')
INSERT INTO dbo.Tag (Name) VALUES ('Produce')
INSERT INTO dbo.Tag (Name) VALUES ('Groceries')
INSERT INTO dbo.Tag (Name) VALUES ('Clothing')
INSERT INTO dbo.Tag (Name) VALUES ('Entertainment')
INSERT INTO dbo.Tag (Name) VALUES ('Travel')
INSERT INTO dbo.Tag (Name) VALUES ('Vacation')
INSERT INTO dbo.Tag (Name) VALUES ('Tickets')
INSERT INTO dbo.Tag (Name) VALUES ('Restaurant')
INSERT INTO dbo.Tag (Name) VALUES ('Friends')
INSERT INTO dbo.Tag (Name) VALUES ('Homework')
INSERT INTO dbo.Tag (Name) VALUES ('Bills')
INSERT INTO dbo.Tag (Name) VALUES ('Mortgage')
GO