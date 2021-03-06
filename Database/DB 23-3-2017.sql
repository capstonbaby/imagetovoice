USE [master]
GO
/****** Object:  Database [Capstone]    Script Date: 03/23/2017 10:36:53 AM ******/
CREATE DATABASE [Capstone]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Capstone', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.QUANVHSE61254\MSSQL\DATA\Capstone.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Capstone_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.QUANVHSE61254\MSSQL\DATA\Capstone_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  User [IIS APPPOOL\DefaultAppPool]    Script Date: 03/23/2017 10:36:53 AM ******/
CREATE USER [IIS APPPOOL\DefaultAppPool] FOR LOGIN [IIS APPPOOL\DefaultAppPool] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 03/23/2017 10:36:54 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 03/23/2017 10:36:54 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 03/23/2017 10:36:54 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 03/23/2017 10:36:54 AM ******/
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
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 03/23/2017 10:36:54 AM ******/
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
/****** Object:  Table [dbo].[Concept]    Script Date: 03/23/2017 10:36:54 AM ******/
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
/****** Object:  Table [dbo].[Face]    Script Date: 03/23/2017 10:36:54 AM ******/
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
/****** Object:  Table [dbo].[Log]    Script Date: 03/23/2017 10:36:54 AM ******/
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
/****** Object:  Table [dbo].[LogObject]    Script Date: 03/23/2017 10:36:54 AM ******/
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
/****** Object:  Table [dbo].[Person]    Script Date: 03/23/2017 10:36:54 AM ******/
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
/****** Object:  Table [dbo].[PersonGroup]    Script Date: 03/23/2017 10:36:54 AM ******/
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
/****** Object:  Table [dbo].[Picture]    Script Date: 03/23/2017 10:36:54 AM ******/
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
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Active]) VALUES (N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'test@gmail.com', 0, N'AGpAPKRIFhu+OvkPIwE8SlT8gh20CRuqbgFjEfXNktPGb+q8TDrrcIZFC0Ko7CUotA==', N'e995d0ee-3773-4757-8ba1-976e08106520', NULL, 0, 0, NULL, 1, 0, N'test@gmail.com', 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Active]) VALUES (N'661d39a3-ad8f-45e3-8c35-057298d16da6', N'quanha@gmail.com', 0, N'APtyxKiousFLxXIxxL0BYD6j7TK0/pSgKwAFseVrHWA5M415qDu8aqwlcT9la0xfdg==', N'4cbf4698-3582-42c9-86d2-f75d8072650d', NULL, 0, 0, NULL, 1, 0, N'quanha@gmail.com', 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Active]) VALUES (N'7013fc3c-0891-480f-9fc5-7561077e473b', N'admin@gmail.com', 0, N'ADbndu0oVXnB2VHiXMjUEM80esofb0AT0mn+vh6/Rq1DD3UF4ozC+/28YZT1htFfgg==', N'730124ec-8217-4dc2-b1de-86d0d2b4c15b', NULL, 0, 0, NULL, 1, 0, N'admin@gmail.com', 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Active]) VALUES (N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'son@gmail.com', 0, N'ANvczCT6MDZM2L8WP1KB8VQCkEaWz2WjywjOQkIdU9a1JnFJYHlPWPfFBDVul1WtsA==', N'1e10e5a0-45ef-4443-94bf-97f529d0819e', NULL, 0, 0, NULL, 1, 0, N'son@gmail.com', 1)
SET IDENTITY_INSERT [dbo].[Concept] ON 

INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (15, N'balo', N'ba lô puma đen', CAST(N'2017-03-21 10:39:29.287' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Concept] OFF
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'04649add-9a93-4132-9161-caf0549277c4', N'fdf7825d-e2a9-484b-8629-a0885c6e70ae', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490154420/kosah60yvl78jxaxinjn.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'0ad09def-e8ac-41e5-a854-d32f95230f81', N'9103199a-d394-470a-b459-98f42cdb5c59', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490199046/nombvmt5ulfdchafwlix.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'295f8a27-fe9b-4461-9daa-a6d2df3537ff', N'fdf7825d-e2a9-484b-8629-a0885c6e70ae', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490155865/wk18sjdfdsy2zczaoyhz.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'54046b08-2bb7-452e-93f5-d7baec8bad3c', N'fdf7825d-e2a9-484b-8629-a0885c6e70ae', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490154417/sdwr6rmf5c65iqe9djgz.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'55fc29c9-85c3-425d-b7a8-dd9616104b53', N'fdf7825d-e2a9-484b-8629-a0885c6e70ae', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1490154412/ypjfoxk599lsywjvoxpf.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'8969d93f-a316-435a-b60f-c8d323fa09bd', N'2c8a3aa2-552e-4812-b14c-fe001b72dc40', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490237093/xv6g54lsjgldv44hpydb.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'b2f389f5-99a5-46bc-835e-f81e9c38addd', N'9103199a-d394-470a-b459-98f42cdb5c59', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490199545/sv3t1nkhhd6byvh8vbcs.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'e95e1f23-0a23-4d61-afad-06d693672c9e', N'abf6739b-ccd7-497c-88c0-43fa5d6effa8', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490201953/manzdh5q3tpipsu6m5sy.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'edb5f1c1-d8a5-461b-bec1-83d491671570', N'abf6739b-ccd7-497c-88c0-43fa5d6effa8', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490200268/bzauxwtuolfy2883xagc.jpg', 1)
SET IDENTITY_INSERT [dbo].[Log] ON 

INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (1027, CAST(N'2017-03-22 23:11:11.743' AS DateTime), N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490199046/nombvmt5ulfdchafwlix.jpg', N'hoàng sơn', 1)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (1028, CAST(N'2017-03-22 23:19:19.977' AS DateTime), N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490199545/sv3t1nkhhd6byvh8vbcs.jpg', N'hoàng sơn', 1)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (1029, CAST(N'2017-03-22 23:31:27.697' AS DateTime), N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490200268/bzauxwtuolfy2883xagc.jpg', N'hoàng sơn', 1)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (1030, CAST(N'2017-03-22 23:59:32.347' AS DateTime), N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490201953/manzdh5q3tpipsu6m5sy.jpg', N'hoàng sơn', 1)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (1031, CAST(N'2017-03-23 09:45:10.287' AS DateTime), N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'http://res.cloudinary.com/debwqzo2g/image/upload/c_thumb,g_faces,h_400,w_400/v1490237093/xv6g54lsjgldv44hpydb.jpg', N'anh duy', 1)
SET IDENTITY_INSERT [dbo].[Log] OFF
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'2c8a3aa2-552e-4812-b14c-fe001b72dc40', N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'anh duy', NULL, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'9103199a-d394-470a-b459-98f42cdb5c59', N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'hoàng sơn', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'abf6739b-ccd7-497c-88c0-43fa5d6effa8', N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'hoàng sơn', NULL, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Active]) VALUES (N'fdf7825d-e2a9-484b-8629-a0885c6e70ae', N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'Hoàng Sơn', N'team mate #2', 0)
INSERT [dbo].[PersonGroup] ([PersonGroupId], [PersonGroupName], [Description], [Active]) VALUES (N'20cd3969-c372-42ec-a117-87a654d2f2b5', N'test@gmail.com', N'test@gmail.com person group', 1)
INSERT [dbo].[PersonGroup] ([PersonGroupId], [PersonGroupName], [Description], [Active]) VALUES (N'661d39a3-ad8f-45e3-8c35-057298d16da6', N'quanha@gmail.com', N'', 1)
INSERT [dbo].[PersonGroup] ([PersonGroupId], [PersonGroupName], [Description], [Active]) VALUES (N'capstone', N'capstone', N'capstone', 1)
INSERT [dbo].[PersonGroup] ([PersonGroupId], [PersonGroupName], [Description], [Active]) VALUES (N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'son@gmail.com', NULL, 1)
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
ALTER TABLE [dbo].[Picture]  WITH CHECK ADD  CONSTRAINT [FK_Picture_Concept] FOREIGN KEY([ConceptId])
REFERENCES [dbo].[Concept] ([ConceptId])
GO
ALTER TABLE [dbo].[Picture] CHECK CONSTRAINT [FK_Picture_Concept]
GO
USE [master]
GO
ALTER DATABASE [Capstone] SET  READ_WRITE 
GO
