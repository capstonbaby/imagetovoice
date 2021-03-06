USE [master]
GO
/****** Object:  Database [Capstone]    Script Date: 03/28/2017 12:29:36 PM ******/
CREATE DATABASE [Capstone]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Capstone', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Capstone.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Capstone_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Capstone_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Capstone] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Capstone].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Capstone] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Capstone] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Capstone] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Capstone] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Capstone] SET ARITHABORT OFF 
GO
ALTER DATABASE [Capstone] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Capstone] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Capstone] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Capstone] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Capstone] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Capstone] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Capstone] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Capstone] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Capstone] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Capstone] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Capstone] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Capstone] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Capstone] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Capstone] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Capstone] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Capstone] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Capstone] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Capstone] SET RECOVERY FULL 
GO
ALTER DATABASE [Capstone] SET  MULTI_USER 
GO
ALTER DATABASE [Capstone] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Capstone] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Capstone] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Capstone] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Capstone] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Capstone', N'ON'
GO
USE [Capstone]
GO
/****** Object:  User [IIS APPPOOL\DefaultAppPool]    Script Date: 03/28/2017 12:29:36 PM ******/
CREATE USER [IIS APPPOOL\DefaultAppPool] FOR LOGIN [IIS APPPOOL\DefaultAppPool] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 03/28/2017 12:29:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 03/28/2017 12:29:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 03/28/2017 12:29:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 03/28/2017 12:29:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 03/28/2017 12:29:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Concept]    Script Date: 03/28/2017 12:29:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Concept](
	[ConceptId] [int] IDENTITY(1,1) NOT NULL,
	[ConceptName] [nvarchar](100) NULL,
	[ConceptDescription] [nvarchar](100) NULL,
	[CreateDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Concept] PRIMARY KEY CLUSTERED 
(
	[ConceptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Face]    Script Date: 03/28/2017 12:29:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Face](
	[PersistedFaceId] [nvarchar](36) NOT NULL,
	[PersonID] [nvarchar](36) NOT NULL,
	[ImageURL] [nvarchar](max) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Face] PRIMARY KEY CLUSTERED 
(
	[PersistedFaceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Log]    Script Date: 03/28/2017 12:29:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UserID] [nvarchar](128) NOT NULL,
	[ImageURL] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](128) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_tbl_Log] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LogObject]    Script Date: 03/28/2017 12:29:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogObject](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UserID] [nvarchar](128) NOT NULL,
	[ImageURL] [nvarchar](max) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_LogObject] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Person]    Script Date: 03/28/2017 12:29:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[PersonId] [nvarchar](36) NOT NULL,
	[PersonGroupId] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersonGroup]    Script Date: 03/28/2017 12:29:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonGroup](
	[PersonGroupId] [nvarchar](128) NOT NULL,
	[PersonGroupName] [nvarchar](128) NULL,
	[Description] [nvarchar](250) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_PersonGroup_1] PRIMARY KEY CLUSTERED 
(
	[PersonGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Picture]    Script Date: 03/28/2017 12:29:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Picture](
	[PictureId] [varchar](32) NOT NULL,
	[ConceptId] [int] NULL,
	[Description] [nvarchar](50) NULL,
	[ImageURL] [nvarchar](max) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Picture] PRIMARY KEY CLUSTERED 
(
	[PictureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'1', N'Admin')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'2', N'User')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'661d39a3-ad8f-45e3-8c35-057298d16da6', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'7013fc3c-0891-480f-9fc5-7561077e473b', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fd01e548-114c-426d-9c7a-948f477e3152', N'2')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Active]) VALUES (N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'test@gmail.com', 0, N'AGpAPKRIFhu+OvkPIwE8SlT8gh20CRuqbgFjEfXNktPGb+q8TDrrcIZFC0Ko7CUotA==', N'e995d0ee-3773-4757-8ba1-976e08106520', NULL, 0, 0, NULL, 1, 0, N'test@gmail.com', 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Active]) VALUES (N'661d39a3-ad8f-45e3-8c35-057298d16da6', N'quanha@gmail.com', 0, N'APtyxKiousFLxXIxxL0BYD6j7TK0/pSgKwAFseVrHWA5M415qDu8aqwlcT9la0xfdg==', N'4cbf4698-3582-42c9-86d2-f75d8072650d', NULL, 0, 0, NULL, 1, 0, N'quanha@gmail.com', 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Active]) VALUES (N'7013fc3c-0891-480f-9fc5-7561077e473b', N'admin@gmail.com', 0, N'ADbndu0oVXnB2VHiXMjUEM80esofb0AT0mn+vh6/Rq1DD3UF4ozC+/28YZT1htFfgg==', N'730124ec-8217-4dc2-b1de-86d0d2b4c15b', NULL, 0, 0, NULL, 1, 0, N'admin@gmail.com', 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Active]) VALUES (N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'son@gmail.com', 0, N'ANvczCT6MDZM2L8WP1KB8VQCkEaWz2WjywjOQkIdU9a1JnFJYHlPWPfFBDVul1WtsA==', N'1e10e5a0-45ef-4443-94bf-97f529d0819e', NULL, 0, 0, NULL, 1, 0, N'son@gmail.com', 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Active]) VALUES (N'fd01e548-114c-426d-9c7a-948f477e3152', N'haquan145@gmail.com', 0, N'AGxLgQtQ+m1f4Ors1UsQZce0loLkwD4PIzMzTuPkOGwqUw+vG3e2Cbt7hC0upwpDFA==', N'12503833-7635-46de-8ceb-d4d4ddb698da', NULL, 0, 0, NULL, 1, 0, N'haquan145@gmail.com', 1)
SET IDENTITY_INSERT [dbo].[Concept] ON 

INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (15, N'balo', N'ba lô puma đen', CAST(N'2017-03-21 10:39:29.287' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Concept] OFF
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'02ffe9b1-06b6-43ee-b93a-a532e98459f7', N'93803b77-323f-4eac-97f8-8034746e1b48', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490669816/zurasongd5x9gnztwbvm.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'041af534-f277-47e1-8744-900e87c451a9', N'93803b77-323f-4eac-97f8-8034746e1b48', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490669824/z6unnt8jaivs9rzmltsm.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'04649add-9a93-4132-9161-caf0549277c4', N'fdf7825d-e2a9-484b-8629-a0885c6e70ae', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490154420/kosah60yvl78jxaxinjn.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'0ad09def-e8ac-41e5-a854-d32f95230f81', N'9103199a-d394-470a-b459-98f42cdb5c59', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490199046/nombvmt5ulfdchafwlix.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'11203236-4dd0-4f9c-b702-11f2117032c5', N'96de2687-ffea-4132-ae6d-5919560a8959', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490629819/jyqib8gyata0wy6lbyct.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'11396d42-37b2-4cf3-9163-3ad66ba26f9f', N'3cb83986-e9a0-4c6b-8d65-3c77e3cddda1', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348472/xcft9dlsxao0klxlipyj.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'135396e4-495e-47c2-9070-0615f43bc217', N'1ccca00c-3087-4b1f-939c-11b632b7d0d2', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349703/yvucotkztcma93kmufuo.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'15d578e3-e4e6-4349-b157-fec858d1229b', N'3a88ceff-a223-46a4-97f7-a29036d689d7', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348543/xvmvkhjgsf1ladmzwmk1.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'18b0962d-2c51-44be-bc1d-d61e047ea6f9', N'e444120b-b5e6-4592-9602-78b3aa7f29eb', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349036/rnf81rb3uwais832wuib.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'22adafd9-7c23-4073-91b7-1862c240abb5', N'390bf51b-6cde-420b-9344-f012dab3b919', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490675042/jsqnjp6wo83g85qzcr8j.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'28f6ebda-00a6-4116-a818-0eabccefc523', N'b695c182-5613-42d2-894c-e2a75e4ad75d', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348589/b18t95ekoei85wudxkgw.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'295f8a27-fe9b-4461-9daa-a6d2df3537ff', N'fdf7825d-e2a9-484b-8629-a0885c6e70ae', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490155865/wk18sjdfdsy2zczaoyhz.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'2e7b16d5-5c35-46f6-bc07-133ededf2703', N'3cb83986-e9a0-4c6b-8d65-3c77e3cddda1', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348589/b18t95ekoei85wudxkgw.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'357ecc90-3487-4543-8eec-63daf2d9da57', N'e444120b-b5e6-4592-9602-78b3aa7f29eb', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490629817/itmxzldov25crem9hv5c.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'37df5baf-a014-4ca9-aaf8-4a63933411a3', N'e48a5e3b-a995-4b97-99da-59bd4faf713d', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490672763/z9jqfwfjq0runoiot4uc.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'39c1c9ee-f948-42ee-8a28-f2b441aa49d5', N'16144c81-f0ed-44a7-93f2-d3becc16aa9f', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490672767/vptztisrbpeoizr1i1au.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'420e6591-01ff-474e-9687-ff9eefd6df79', N'6c729f04-06c2-42e8-8990-37b0134ae8fd', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349705/ker4hsho3hmbki4afzyd.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'44423fe2-b545-4a84-a8e7-c84893ea1a82', N'5973a350-2940-4fb9-9220-3d1753825789', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349037/bvnculerqcxqpqzmdqam.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'46712dcd-ebf3-4d25-9040-2710b300d9fd', N'e444120b-b5e6-4592-9602-78b3aa7f29eb', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349037/bvnculerqcxqpqzmdqam.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'47777c4a-9432-4384-9791-a37e41b6d327', N'1ccca00c-3087-4b1f-939c-11b632b7d0d2', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490669816/zurasongd5x9gnztwbvm.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'54046b08-2bb7-452e-93f5-d7baec8bad3c', N'fdf7825d-e2a9-484b-8629-a0885c6e70ae', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490154417/sdwr6rmf5c65iqe9djgz.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'55fc29c9-85c3-425d-b7a8-dd9616104b53', N'fdf7825d-e2a9-484b-8629-a0885c6e70ae', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490154412/ypjfoxk599lsywjvoxpf.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'57eca966-5673-40f5-a795-f130453e634b', N'96de2687-ffea-4132-ae6d-5919560a8959', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490629817/itmxzldov25crem9hv5c.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'57fa2611-a2f8-4a67-82da-0aae4a5d3700', N'16144c81-f0ed-44a7-93f2-d3becc16aa9f', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348203/tqpvmp1ygc2fbkbow6ue.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'59432050-f65b-485f-8893-cec1ecb99553', N'3cb83986-e9a0-4c6b-8d65-3c77e3cddda1', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348543/xvmvkhjgsf1ladmzwmk1.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'5d6e76ca-cb19-472d-8756-45b65e77aa18', N'3a88ceff-a223-46a4-97f7-a29036d689d7', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490346860/biuwzttqszcg2xgi9yfs.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'6390c5fe-4fcd-4943-93cc-937fda737c84', N'8ffdc4d0-9ad0-4af3-babd-09bcec98df42', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349705/ker4hsho3hmbki4afzyd.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'65d854a4-1c8f-4b71-b0e1-44ebb92c40bf', N'b695c182-5613-42d2-894c-e2a75e4ad75d', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348472/xcft9dlsxao0klxlipyj.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'6a3b539c-d07d-4096-b044-20333093704f', N'3c34f3c3-272f-4c2c-bef0-df5268dabfb5', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349666/ap8o5rj9k7p10e4wgvnd.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'6cf8aa3c-627e-4ed5-b1ec-2ddb2472ab10', N'7b4009de-743b-42a7-9842-67e43a1c681d', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490624727/tvofwotwixlqj0f9nc9r.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'6fb3626a-4bf3-4903-8cde-a3a06e7cf41f', N'e444120b-b5e6-4592-9602-78b3aa7f29eb', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349038/i7yqnfnuyyykdovho1di.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'71bfc632-4f5d-47e3-80df-70f4eab4916d', N'16144c81-f0ed-44a7-93f2-d3becc16aa9f', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348543/xvmvkhjgsf1ladmzwmk1.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'7c253e43-22f5-4b4f-a1f6-28792085a253', N'16144c81-f0ed-44a7-93f2-d3becc16aa9f', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490626180/hkiabtqxsrdtztukjfqh.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'7c4b8d55-dc19-4111-9f19-5462da5acde8', N'3cb83986-e9a0-4c6b-8d65-3c77e3cddda1', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348203/tqpvmp1ygc2fbkbow6ue.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'7cd1930f-ef9b-4bec-a63c-b606d9d95bf9', N'b695c182-5613-42d2-894c-e2a75e4ad75d', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490626180/hkiabtqxsrdtztukjfqh.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'7ce7c025-1a21-468c-8423-25c34b6a1789', N'6c729f04-06c2-42e8-8990-37b0134ae8fd', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349703/yvucotkztcma93kmufuo.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'7f8f43f4-bec5-4f33-98ed-befb4b0ffc12', N'1ccca00c-3087-4b1f-939c-11b632b7d0d2', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490669824/z6unnt8jaivs9rzmltsm.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'80d2d3e5-779b-4f40-bcb3-34da525d4a92', N'c0065e67-ee01-4706-a421-d055f3f8ff1e', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490670321/cnywjxxnknvwsrlliqyk.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'8264bad8-184f-4ec0-b105-a2624c5964e0', N'6c729f04-06c2-42e8-8990-37b0134ae8fd', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490624727/tvofwotwixlqj0f9nc9r.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'832d69e5-ab41-4f93-85ec-46dada08b636', N'd8a12348-4fc6-4df6-a115-66a533d32083', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348203/tqpvmp1ygc2fbkbow6ue.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'8969d93f-a316-435a-b60f-c8d323fa09bd', N'2c8a3aa2-552e-4812-b14c-fe001b72dc40', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490237093/xv6g54lsjgldv44hpydb.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'8c98d1a8-ec52-49d3-b92c-2f6d778bffa1', N'e48a5e3b-a995-4b97-99da-59bd4faf713d', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490672767/vptztisrbpeoizr1i1au.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'8d5a6a64-b95f-4673-afb9-a8dede7efb86', N'1ccca00c-3087-4b1f-939c-11b632b7d0d2', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349705/ker4hsho3hmbki4afzyd.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'903510e7-30cc-47f6-ac37-6bc9131282bd', N'16144c81-f0ed-44a7-93f2-d3becc16aa9f', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348472/xcft9dlsxao0klxlipyj.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'9d85daef-aa93-4373-bf6b-b5080ab29d32', N'e444120b-b5e6-4592-9602-78b3aa7f29eb', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490629818/pc82xqacdogputpgxfhu.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'a0cac4cd-9e7b-44db-8cea-925c4e0da32a', N'd8a12348-4fc6-4df6-a115-66a533d32083', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348589/b18t95ekoei85wudxkgw.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'a70f1b97-d778-4e65-a51a-cc492be920f2', N'b915b1d3-824f-44a5-972d-209ee84a66ea', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490626180/hkiabtqxsrdtztukjfqh.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'a8396a2e-a735-486b-bcc8-83f5e92f2c8e', N'77150214-aa6b-486a-a57d-aea9a8b23505', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490341001/mcjofukaayeo8islnebt.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'a9955c3b-dbbd-44e3-b818-0703d3e32847', N'b5bdcb04-6fc0-4b29-9af6-3770d0b8aeb8', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349666/ap8o5rj9k7p10e4wgvnd.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'ae67e1b4-e484-4ddf-8889-516d75d6b3c1', N'c577c57a-8faa-4f9e-b187-08b0dded5557', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349663/mkzevuzj6bqp6k4mfu8h.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'b2f389f5-99a5-46bc-835e-f81e9c38addd', N'9103199a-d394-470a-b459-98f42cdb5c59', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490199545/sv3t1nkhhd6byvh8vbcs.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'b315eae6-d53c-407e-a93c-188ef1a71db6', N'b5bdcb04-6fc0-4b29-9af6-3770d0b8aeb8', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490341001/mcjofukaayeo8islnebt.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'b4be77cd-6d80-4257-abd7-2a2521046172', N'0e91c42c-c872-4914-b25c-320b696e3534', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490675065/os67zqiwieavinrtuabc.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'ba1b6eb7-4907-43ec-abd5-c42ef2fa7dc0', N'b695c182-5613-42d2-894c-e2a75e4ad75d', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490346860/biuwzttqszcg2xgi9yfs.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'baf19a8f-8350-4cb7-aabf-c876a21c596e', N'd8a12348-4fc6-4df6-a115-66a533d32083', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348472/xcft9dlsxao0klxlipyj.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'c295290a-1584-4158-874f-67e215c89f1c', N'8ffdc4d0-9ad0-4af3-babd-09bcec98df42', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349703/yvucotkztcma93kmufuo.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'c2bf4fbf-e12f-4c28-bf9a-cb166a6976a4', N'16144c81-f0ed-44a7-93f2-d3becc16aa9f', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490346860/biuwzttqszcg2xgi9yfs.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'c756202e-692b-496e-beee-499f9e0e9c09', N'b5bdcb04-6fc0-4b29-9af6-3770d0b8aeb8', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349663/mkzevuzj6bqp6k4mfu8h.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'd71929e8-f9f2-48ce-80d0-11273ce9befb', N'3cb83986-e9a0-4c6b-8d65-3c77e3cddda1', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490346860/biuwzttqszcg2xgi9yfs.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'd9330531-ae59-4ea1-a577-5249279c0b95', N'b5bdcb04-6fc0-4b29-9af6-3770d0b8aeb8', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490675042/jsqnjp6wo83g85qzcr8j.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'd96fe0bd-79ef-4060-98f1-6b8f5c33dfe4', N'b695c182-5613-42d2-894c-e2a75e4ad75d', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348543/xvmvkhjgsf1ladmzwmk1.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'dc2fa8f3-95a7-4da9-9c5f-e0ef6dc0229c', N'3c34f3c3-272f-4c2c-bef0-df5268dabfb5', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349663/mkzevuzj6bqp6k4mfu8h.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'deb70349-494e-46f5-97ae-67aceb24c911', N'5973a350-2940-4fb9-9220-3d1753825789', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349038/i7yqnfnuyyykdovho1di.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'e1aae53f-dc4e-4e01-bc45-e878fe708481', N'16144c81-f0ed-44a7-93f2-d3becc16aa9f', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348589/b18t95ekoei85wudxkgw.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'e403a379-b0bf-4669-a93d-92374a6bf0fe', N'c577c57a-8faa-4f9e-b187-08b0dded5557', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349666/ap8o5rj9k7p10e4wgvnd.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'e72663c6-cc8c-44a8-9919-8ae06d1463d4', N'16144c81-f0ed-44a7-93f2-d3becc16aa9f', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490672763/z9jqfwfjq0runoiot4uc.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'e825d91e-f903-4dde-8924-c8fa3ff7b12b', N'16144c81-f0ed-44a7-93f2-d3becc16aa9f', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490670321/cnywjxxnknvwsrlliqyk.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'e90030b7-6579-48bf-953b-ba4cd4ba6ca7', N'b695c182-5613-42d2-894c-e2a75e4ad75d', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490348203/tqpvmp1ygc2fbkbow6ue.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'e95e1f23-0a23-4d61-afad-06d693672c9e', N'abf6739b-ccd7-497c-88c0-43fa5d6effa8', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490201953/manzdh5q3tpipsu6m5sy.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'ebc99586-26d8-46e2-b1e8-8ca725cb60f2', N'1ccca00c-3087-4b1f-939c-11b632b7d0d2', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490624727/tvofwotwixlqj0f9nc9r.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'edb5f1c1-d8a5-461b-bec1-83d491671570', N'abf6739b-ccd7-497c-88c0-43fa5d6effa8', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490200268/bzauxwtuolfy2883xagc.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'f002895d-c01d-4b0d-8a63-94c01a435987', N'd04bd351-794d-4aa8-ae92-e02f6d8c4da2', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490670381/go4epusxiinwzubumjgo.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'f13a4657-e6c3-4256-b1a1-d14c84608114', N'e444120b-b5e6-4592-9602-78b3aa7f29eb', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490629819/jyqib8gyata0wy6lbyct.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'f5cb46aa-9097-4bd2-ac19-26b6689d7383', N'16144c81-f0ed-44a7-93f2-d3becc16aa9f', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490670381/go4epusxiinwzubumjgo.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'f92c6c17-d083-4566-8d50-26ae0a91fd0e', N'5973a350-2940-4fb9-9220-3d1753825789', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490349036/rnf81rb3uwais832wuib.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'fa740a83-3872-47e4-b72c-744a23907d4f', N'96de2687-ffea-4132-ae6d-5919560a8959', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490629818/pc82xqacdogputpgxfhu.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'fc13557a-acf5-407c-b908-3d8cbcf782fd', N'c577c57a-8faa-4f9e-b187-08b0dded5557', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490341001/mcjofukaayeo8islnebt.jpg', 0)
SET IDENTITY_INSERT [dbo].[Log] ON 

INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (1027, CAST(N'2017-03-22 23:11:11.743' AS DateTime), N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490199046/nombvmt5ulfdchafwlix.jpg', N'hoàng sơn', 0)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (1028, CAST(N'2017-03-22 23:19:19.977' AS DateTime), N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490199545/sv3t1nkhhd6byvh8vbcs.jpg', N'hoàng sơn', 0)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (1029, CAST(N'2017-03-22 23:31:27.697' AS DateTime), N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490200268/bzauxwtuolfy2883xagc.jpg', N'hoàng sơn', 0)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (1030, CAST(N'2017-03-22 23:59:32.347' AS DateTime), N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490201953/manzdh5q3tpipsu6m5sy.jpg', N'hoàng sơn', 0)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (1031, CAST(N'2017-03-23 09:45:10.287' AS DateTime), N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490237093/xv6g54lsjgldv44hpydb.jpg', N'anh duy', 0)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (1032, CAST(N'2017-03-24 14:38:50.180' AS DateTime), N'fd01e548-114c-426d-9c7a-948f477e3152', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490341001/mcjofukaayeo8islnebt.jpg', N'trung thành', 1)
SET IDENTITY_INSERT [dbo].[Log] OFF
SET IDENTITY_INSERT [dbo].[LogObject] ON 

INSERT [dbo].[LogObject] ([ID], [CreatedDate], [UserID], [ImageURL], [Active]) VALUES (12, CAST(N'2017-03-28 00:13:01.093' AS DateTime), N'fd01e548-114c-426d-9c7a-948f477e3152', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490634776/b73womxcin7urb4au4qa.jpg', 1)
SET IDENTITY_INSERT [dbo].[LogObject] OFF
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'0e91c42c-c872-4914-b25c-320b696e3534', N'fd01e548-114c-426d-9c7a-948f477e3152', N'trung thành', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'123', N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'Hoàng Sơ', NULL, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'16144c81-f0ed-44a7-93f2-d3becc16aa9f', N'fd01e548-114c-426d-9c7a-948f477e3152', N'hoàng sơn', NULL, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'1ccca00c-3087-4b1f-939c-11b632b7d0d2', N'fd01e548-114c-426d-9c7a-948f477e3152', N'Hà Quân', NULL, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'2c8a3aa2-552e-4812-b14c-fe001b72dc40', N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'anh duy', NULL, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'31e447e3-5666-411c-8286-821407e70e1f', N'fd01e548-114c-426d-9c7a-948f477e3152', N'Hoàng Sơn', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'390bf51b-6cde-420b-9344-f012dab3b919', N'fd01e548-114c-426d-9c7a-948f477e3152', N'trung thành', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'3a88ceff-a223-46a4-97f7-a29036d689d7', N'fd01e548-114c-426d-9c7a-948f477e3152', N'hoàng sơn', N'team mate #2', 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'3c34f3c3-272f-4c2c-bef0-df5268dabfb5', N'fd01e548-114c-426d-9c7a-948f477e3152', N'Trung Thành', N'leader', 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'3cb83986-e9a0-4c6b-8d65-3c77e3cddda1', N'fd01e548-114c-426d-9c7a-948f477e3152', N'hoàng sơn', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'5973a350-2940-4fb9-9220-3d1753825789', N'fd01e548-114c-426d-9c7a-948f477e3152', N'Trúc Diễm', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'6c729f04-06c2-42e8-8990-37b0134ae8fd', N'fd01e548-114c-426d-9c7a-948f477e3152', N'Hà Quân', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'77150214-aa6b-486a-a57d-aea9a8b23505', N'fd01e548-114c-426d-9c7a-948f477e3152', N'Trung Thành', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'7b4009de-743b-42a7-9842-67e43a1c681d', N'fd01e548-114c-426d-9c7a-948f477e3152', N'Hà Quân', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'8ffdc4d0-9ad0-4af3-babd-09bcec98df42', N'fd01e548-114c-426d-9c7a-948f477e3152', N'Hà Quân', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'9103199a-d394-470a-b459-98f42cdb5c59', N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'hoàng sơn', NULL, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'93803b77-323f-4eac-97f8-8034746e1b48', N'fd01e548-114c-426d-9c7a-948f477e3152', N'Hà Quân', N'test', 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'96de2687-ffea-4132-ae6d-5919560a8959', N'fd01e548-114c-426d-9c7a-948f477e3152', N'Trúc Diễm', N'team member', 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'abf6739b-ccd7-497c-88c0-43fa5d6effa8', N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'hoàng sơn', NULL, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'b5bdcb04-6fc0-4b29-9af6-3770d0b8aeb8', N'fd01e548-114c-426d-9c7a-948f477e3152', N'trung thành', NULL, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'b695c182-5613-42d2-894c-e2a75e4ad75d', N'fd01e548-114c-426d-9c7a-948f477e3152', N'hoàng sơn', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'b915b1d3-824f-44a5-972d-209ee84a66ea', N'fd01e548-114c-426d-9c7a-948f477e3152', N'hoàng sơn', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'c0065e67-ee01-4706-a421-d055f3f8ff1e', N'fd01e548-114c-426d-9c7a-948f477e3152', N'hoàng sơn', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'c577c57a-8faa-4f9e-b187-08b0dded5557', N'fd01e548-114c-426d-9c7a-948f477e3152', N'Trung Thành', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'd04bd351-794d-4aa8-ae92-e02f6d8c4da2', N'fd01e548-114c-426d-9c7a-948f477e3152', N'HOÀNG SƠN', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'd8a12348-4fc6-4df6-a115-66a533d32083', N'fd01e548-114c-426d-9c7a-948f477e3152', N'hoàng sơn', N'best mate', 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'e444120b-b5e6-4592-9602-78b3aa7f29eb', N'fd01e548-114c-426d-9c7a-948f477e3152', N'Trúc Diễm', NULL, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'e48a5e3b-a995-4b97-99da-59bd4faf713d', N'fd01e548-114c-426d-9c7a-948f477e3152', N'hoàng Sơn', N'check dup #4', 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'eb357d7e-583c-4fe1-a0c6-4dd3a7ac0895', N'fd01e548-114c-426d-9c7a-948f477e3152', N'Hoàng Sơn update ', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'fdf7825d-e2a9-484b-8629-a0885c6e70ae', N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'Hoàng Sơ', N'team mate #2', 1)
INSERT [dbo].[PersonGroup] ([PersonGroupId], [PersonGroupName], [Description], [Active]) VALUES (N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'test@gmail.com', N'test@gmail.com person group', 1)
INSERT [dbo].[PersonGroup] ([PersonGroupId], [PersonGroupName], [Description], [Active]) VALUES (N'661d39a3-ad8f-45e3-8c35-057298d16da6', N'quanha@gmail.com', N'', 1)
INSERT [dbo].[PersonGroup] ([PersonGroupId], [PersonGroupName], [Description], [Active]) VALUES (N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'son@gmail.com', NULL, 1)
INSERT [dbo].[PersonGroup] ([PersonGroupId], [PersonGroupName], [Description], [Active]) VALUES (N'fd01e548-114c-426d-9c7a-948f477e3152', N'haquan145@gmail.com', N'haquan145@gmail.com person group', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'd5c197b50b06464da004ab7b11504c35', 15, N'ba lô puma đen', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490042900/szxbvckcunh8murpfqqp.jpg', 1)
ALTER TABLE [dbo].[AspNetUsers] ADD  CONSTRAINT [DF_AspNetUsers_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Concept] ADD  CONSTRAINT [DF_Concept_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_PersonId]  DEFAULT ((0)) FOR [PersonId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Face]  WITH CHECK ADD  CONSTRAINT [FK_Face_Person] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[Face] CHECK CONSTRAINT [FK_Face_Person]
GO
ALTER TABLE [dbo].[Log]  WITH CHECK ADD  CONSTRAINT [FK_Log_AspNetUsers] FOREIGN KEY([UserID])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Log] CHECK CONSTRAINT [FK_Log_AspNetUsers]
GO
ALTER TABLE [dbo].[LogObject]  WITH CHECK ADD  CONSTRAINT [FK_LogObject_AspNetUsers] FOREIGN KEY([UserID])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[LogObject] CHECK CONSTRAINT [FK_LogObject_AspNetUsers]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_PersonGroup] FOREIGN KEY([PersonGroupId])
REFERENCES [dbo].[PersonGroup] ([PersonGroupId])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_PersonGroup]
GO
ALTER TABLE [dbo].[PersonGroup]  WITH CHECK ADD  CONSTRAINT [FK_PersonGroup_AspNetUsers] FOREIGN KEY([PersonGroupId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[PersonGroup] CHECK CONSTRAINT [FK_PersonGroup_AspNetUsers]
GO
ALTER TABLE [dbo].[Picture]  WITH CHECK ADD  CONSTRAINT [FK_Picture_Concept] FOREIGN KEY([ConceptId])
REFERENCES [dbo].[Concept] ([ConceptId])
GO
ALTER TABLE [dbo].[Picture] CHECK CONSTRAINT [FK_Picture_Concept]
GO
USE [master]
GO
ALTER DATABASE [Capstone] SET  READ_WRITE 
GO
