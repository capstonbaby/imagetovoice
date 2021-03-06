USE [master]
GO
/****** Object:  Database [Capstone]    Script Date: 03/14/2017 11:00:43 AM ******/
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
/****** Object:  User [IIS APPPOOL\DefaultAppPool]    Script Date: 03/14/2017 11:00:43 AM ******/
CREATE USER [IIS APPPOOL\DefaultAppPool] FOR LOGIN [IIS APPPOOL\DefaultAppPool] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 03/14/2017 11:00:43 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 03/14/2017 11:00:43 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 03/14/2017 11:00:43 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 03/14/2017 11:00:43 AM ******/
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
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 03/14/2017 11:00:43 AM ******/
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
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Concept]    Script Date: 03/14/2017 11:00:43 AM ******/
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
/****** Object:  Table [dbo].[Face]    Script Date: 03/14/2017 11:00:43 AM ******/
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
/****** Object:  Table [dbo].[Log]    Script Date: 03/14/2017 11:00:43 AM ******/
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
/****** Object:  Table [dbo].[LogObject]    Script Date: 03/14/2017 11:00:43 AM ******/
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
/****** Object:  Table [dbo].[Person]    Script Date: 03/14/2017 11:00:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[PersonId] [nvarchar](36) NOT NULL,
	[PersonGroupId] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[IsTrained] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersonGroup]    Script Date: 03/14/2017 11:00:43 AM ******/
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
/****** Object:  Table [dbo].[Picture]    Script Date: 03/14/2017 11:00:43 AM ******/
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
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'661d39a3-ad8f-45e3-8c35-057298d16da6', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'7013fc3c-0891-480f-9fc5-7561077e473b', N'1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'2')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'661d39a3-ad8f-45e3-8c35-057298d16da6', N'quanha@gmail.com', 0, N'APtyxKiousFLxXIxxL0BYD6j7TK0/pSgKwAFseVrHWA5M415qDu8aqwlcT9la0xfdg==', N'4cbf4698-3582-42c9-86d2-f75d8072650d', NULL, 0, 0, NULL, 1, 0, N'quanha@gmail.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'7013fc3c-0891-480f-9fc5-7561077e473b', N'admin@gmail.com', 0, N'ADbndu0oVXnB2VHiXMjUEM80esofb0AT0mn+vh6/Rq1DD3UF4ozC+/28YZT1htFfgg==', N'730124ec-8217-4dc2-b1de-86d0d2b4c15b', NULL, 0, 0, NULL, 1, 0, N'admin@gmail.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'son@gmail.com', 0, N'ANvczCT6MDZM2L8WP1KB8VQCkEaWz2WjywjOQkIdU9a1JnFJYHlPWPfFBDVul1WtsA==', N'1e10e5a0-45ef-4443-94bf-97f529d0819e', NULL, 0, 0, NULL, 1, 0, N'son@gmail.com')
SET IDENTITY_INSERT [dbo].[Concept] ON 

INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (7, N'clock', N'đồng hồ', CAST(N'2017-03-08 13:46:19.197' AS DateTime), 0)
INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (8, N'balo', N'balo puma đen', CAST(N'2017-03-08 22:40:57.880' AS DateTime), 1)
INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (9, N'bút viết bảng', N'bút lông', CAST(N'2017-03-09 09:49:38.757' AS DateTime), 1)
INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (10, N'đồ bấm casio', N'bấm máy chiếu', CAST(N'2017-03-09 09:59:08.720' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Concept] OFF
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'1ab5b70b-c809-4977-9f31-531d810e389d', N'0fd330ec-cb52-4cf3-9405-5bde3bf3e378', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489419572/b86ipqwc7xnnbkemq2yr.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'22fb3896-19a0-4d09-80ee-cd3b9ff01738', N'45103895-8b7a-445c-ad87-0d5e6869479c', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489392380/cmtj4uhxnt7xbda2fewv.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'2acce4e0-3f2f-46f7-875a-425cbfef54d9', N'20893547-b5ba-4c12-aa93-9c1fc4e63ef5', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489419623/hcmwbwngz5iaiqdzhfmh.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'3bfa93d6-d0df-4530-987b-27c30e208344', N'0fd330ec-cb52-4cf3-9405-5bde3bf3e378', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489419568/zshopbxc1bi1hqejoviu.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'49096a03-0995-4b75-9f12-5719db93c39c', N'45103895-8b7a-445c-ad87-0d5e6869479c', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489392511/bgm5rswaelafn840iebm.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'9a93f577-a17b-4e16-a6c6-dab3b97396b0', N'45103895-8b7a-445c-ad87-0d5e6869479c', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489392512/zwfgx0wxmp88ikvnoicm.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'9c7d1e9f-168d-4e6d-9d1c-f02bee3b981f', N'0fd330ec-cb52-4cf3-9405-5bde3bf3e378', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489419565/etoh33two4fjmry2ya2s.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'a2e80822-6b75-444c-a574-21c8528f1dcf', N'20893547-b5ba-4c12-aa93-9c1fc4e63ef5', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489419627/tdzeinn55igvxhoiaodr.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'aeea16cb-9fbc-4ac6-a9a9-7457a0514e06', N'20893547-b5ba-4c12-aa93-9c1fc4e63ef5', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489419620/pi1witghlblx8sksjhu6.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'f578fdba-0a2b-43c3-8683-73aae2118b9f', N'45103895-8b7a-445c-ad87-0d5e6869479c', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489420525/zefcscksoqwuym1tzo8q.jpg', 0)
SET IDENTITY_INSERT [dbo].[Log] ON 

INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (7, CAST(N'2017-03-11 13:49:06.430' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489214929/lfc2x8epj2tdh5i4wwol.jpg', N'hoàng sơn', 1)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (10, CAST(N'2017-03-11 13:49:06.430' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489214929/lfc2x8epj2tdh5i4wwol.jpg', N'hoàng sơn', 1)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (11, CAST(N'2017-03-11 13:49:06.430' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489214929/lfc2x8epj2tdh5i4wwol.jpg', N'hoàng sơn', 1)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (12, CAST(N'2017-03-11 13:49:06.430' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489214929/lfc2x8epj2tdh5i4wwol.jpg', N'hoàng sơn', 1)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (13, CAST(N'2017-03-11 13:49:06.430' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489214929/lfc2x8epj2tdh5i4wwol.jpg', N'hoàng sơn', 1)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (14, CAST(N'2017-03-11 13:49:06.430' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489214929/lfc2x8epj2tdh5i4wwol.jpg', N'hoàng sơn', 1)
SET IDENTITY_INSERT [dbo].[Log] OFF
SET IDENTITY_INSERT [dbo].[LogObject] ON 

INSERT [dbo].[LogObject] ([ID], [CreatedDate], [UserID], [ImageURL], [Active]) VALUES (5, CAST(N'2017-03-14 00:04:06.827' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489424642/bq9o4ujdfqr1su1dingq.jpg', 1)
INSERT [dbo].[LogObject] ([ID], [CreatedDate], [UserID], [ImageURL], [Active]) VALUES (6, CAST(N'2017-03-14 00:08:14.587' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489424889/fgmkbltnklajcjjfxfd2.jpg', 1)
INSERT [dbo].[LogObject] ([ID], [CreatedDate], [UserID], [ImageURL], [Active]) VALUES (7, CAST(N'2017-03-14 00:08:33.757' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489424908/lttdwxjkezeityz7hvun.jpg', 1)
SET IDENTITY_INSERT [dbo].[LogObject] OFF
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [IsTrained], [Active]) VALUES (N'0fd330ec-cb52-4cf3-9405-5bde3bf3e378', N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'Hà Quân', N'team m8 #3', 1, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [IsTrained], [Active]) VALUES (N'20893547-b5ba-4c12-aa93-9c1fc4e63ef5', N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'Nguyễn Vũ Hoàng Sơn', N'team m8 #2', 1, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [IsTrained], [Active]) VALUES (N'45103895-8b7a-445c-ad87-0d5e6869479c', N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'anh Thành updated', N'team lead', 0, 1)
INSERT [dbo].[PersonGroup] ([PersonGroupId], [PersonGroupName], [Description], [Active]) VALUES (N'661d39a3-ad8f-45e3-8c35-057298d16da6', N'quanha@gmail.com', N'', 1)
INSERT [dbo].[PersonGroup] ([PersonGroupId], [PersonGroupName], [Description], [Active]) VALUES (N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'son@gmail.com', NULL, 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'a056dd7cf20148199940ad66cefc17ae', 8, N'balo puma đen', N'http://res.cloudinary.com/trains/image/upload/v1488987689/uwkarcc4acacjiref2wf.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'b07aa8d80ac8433f93f2072ce5313283', 9, N'bút lông', N'http://res.cloudinary.com/trains/image/upload/v1489027794/yt1ykdsobkuysnvlrfk2.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'b07dceb2efe84a429d51e6f07039050c', 9, N'bút lông', N'http://res.cloudinary.com/trains/image/upload/v1489027816/rgolqmfqeztdjibsd79z.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'c730fa63509a488bb4c5fe27d6715a1b', 9, N'bút lông', N'http://res.cloudinary.com/trains/image/upload/v1489027784/phnbshkjomhvkyjyd6tf.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'c9b8d81107bc4ee7afc4b39f63599f9b', 8, N'balo puma đen', N'http://res.cloudinary.com/trains/image/upload/v1488987760/y5dp7rrfjanslsjwadeo.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'ce95f5be957d4666bcc4a085ff4a602f', 10, N'bấm máy chiếu', N'http://res.cloudinary.com/trains/image/upload/v1489028370/jrex3nazdy1mddbkhap1.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'd2f8cd2f2a01415e8ed52eca6ef08895', 9, N'bút lông', N'http://res.cloudinary.com/trains/image/upload/v1489027842/wjswe98cz3zezfcusinm.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'd318cbdf9fec4b14858c8212dca6b35a', 10, N'bấm máy chiếu', N'http://res.cloudinary.com/trains/image/upload/v1489028358/rkjavamlcrgfzsvoehzm.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'da738349e1e6471cb6a8511acfdbb514', 7, N'đồng hồ', N'http://res.cloudinary.com/trains/image/upload/v1488955599/mgxy52gzsg1suvycawfc.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'e039782059464af1bed7e70bfcd8d2ef', 9, N'bút lông', N'http://res.cloudinary.com/trains/image/upload/v1489027804/fpownckeht0hnw3qgjpm.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'e7285f83d144473f8a795a097a812ef3', 7, N'đồng hồ', N'http://res.cloudinary.com/trains/image/upload/v1488955583/fwoskdazrqufjwlwp5v9.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'e91598fe30a14d37baff0af82419ddc8', 9, N'bút lông', N'http://res.cloudinary.com/trains/image/upload/v1489027831/veqgjorkmnm4ga1ftpms.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'ecc1fb273e9c4557861cde37bd3104b5', 7, N'đồng hồ', N'http://res.cloudinary.com/trains/image/upload/v1488955591/fh09g7ahtbddvtf2nxgb.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'f015fef1ce02402dbd91bfef6dd7d88f', 8, N'balo puma đen', N'http://res.cloudinary.com/trains/image/upload/v1488987664/dyvym1rastmr2sttvpgo.jpg', 1)
ALTER TABLE [dbo].[Concept] ADD  CONSTRAINT [DF_Concept_Active]  DEFAULT ((1)) FOR [Active]
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
ALTER TABLE [dbo].[Picture]  WITH CHECK ADD  CONSTRAINT [FK_Picture_Concept] FOREIGN KEY([ConceptId])
REFERENCES [dbo].[Concept] ([ConceptId])
GO
ALTER TABLE [dbo].[Picture] CHECK CONSTRAINT [FK_Picture_Concept]
GO
USE [master]
GO
ALTER DATABASE [Capstone] SET  READ_WRITE 
GO
