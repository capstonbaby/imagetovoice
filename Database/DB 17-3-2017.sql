USE [master]
GO
/****** Object:  Database [Capstone]    Script Date: 03/17/2017 2:07:39 PM ******/
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
/****** Object:  User [IIS APPPOOL\DefaultAppPool]    Script Date: 03/17/2017 2:07:39 PM ******/
CREATE USER [IIS APPPOOL\DefaultAppPool] FOR LOGIN [IIS APPPOOL\DefaultAppPool] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 03/17/2017 2:07:40 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 03/17/2017 2:07:40 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 03/17/2017 2:07:40 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 03/17/2017 2:07:40 PM ******/
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
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 03/17/2017 2:07:40 PM ******/
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
	[TotalDetect] [int] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Concept]    Script Date: 03/17/2017 2:07:40 PM ******/
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
/****** Object:  Table [dbo].[Face]    Script Date: 03/17/2017 2:07:40 PM ******/
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
/****** Object:  Table [dbo].[Log]    Script Date: 03/17/2017 2:07:40 PM ******/
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
/****** Object:  Table [dbo].[LogObject]    Script Date: 03/17/2017 2:07:40 PM ******/
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
/****** Object:  Table [dbo].[Person]    Script Date: 03/17/2017 2:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[PersonId] [nvarchar](36) NOT NULL,
	[PersonGroupId] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Count] [int] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersonGroup]    Script Date: 03/17/2017 2:07:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonGroup](
	[PersonGroupId] [nvarchar](128) NOT NULL,
	[PersonGroupName] [nvarchar](128) NULL,
	[Description] [nvarchar](250) NULL,
	[UserId] [nvarchar](128) NULL,
	[Type] [int] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_PersonGroup_1] PRIMARY KEY CLUSTERED 
(
	[PersonGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Picture]    Script Date: 03/17/2017 2:07:40 PM ******/
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
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'cab8f67f-3b22-431d-a872-2de96165a36e', N'2')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'2')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [TotalDetect], [Active]) VALUES (N'661d39a3-ad8f-45e3-8c35-057298d16da6', N'quanha@gmail.com', 0, N'APtyxKiousFLxXIxxL0BYD6j7TK0/pSgKwAFseVrHWA5M415qDu8aqwlcT9la0xfdg==', N'4cbf4698-3582-42c9-86d2-f75d8072650d', NULL, 0, 0, NULL, 1, 0, N'quanha@gmail.com', NULL, 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [TotalDetect], [Active]) VALUES (N'7013fc3c-0891-480f-9fc5-7561077e473b', N'admin@gmail.com', 0, N'ADbndu0oVXnB2VHiXMjUEM80esofb0AT0mn+vh6/Rq1DD3UF4ozC+/28YZT1htFfgg==', N'730124ec-8217-4dc2-b1de-86d0d2b4c15b', NULL, 0, 0, NULL, 1, 0, N'admin@gmail.com', NULL, 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [TotalDetect], [Active]) VALUES (N'cab8f67f-3b22-431d-a872-2de96165a36e', N'test@gmail.com', 0, N'AM4732+alixBHhFzVXiXUzROl+eBuBZ4rj+cpA3EZO5WWYqBMaKkwLlhCSGe/JJgKA==', N'd3903e42-1ccf-4934-9233-414d32e092c0', NULL, 0, 0, NULL, 1, 0, N'test@gmail.com', NULL, 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [TotalDetect], [Active]) VALUES (N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'son@gmail.com', 0, N'ANvczCT6MDZM2L8WP1KB8VQCkEaWz2WjywjOQkIdU9a1JnFJYHlPWPfFBDVul1WtsA==', N'1e10e5a0-45ef-4443-94bf-97f529d0819e', NULL, 0, 0, NULL, 1, 0, N'son@gmail.com', NULL, 1)
SET IDENTITY_INSERT [dbo].[Concept] ON 

INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (7, N'clock', N'đồng hồ', CAST(N'2017-03-08 13:46:19.197' AS DateTime), 0)
INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (8, N'balo', N'balo puma đen', CAST(N'2017-03-08 22:40:57.880' AS DateTime), 0)
INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (9, N'bút viết bảng', N'bút lông', CAST(N'2017-03-09 09:49:38.757' AS DateTime), 1)
INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (10, N'đồ bấm casio', N'bấm máy chiếu', CAST(N'2017-03-09 09:59:08.720' AS DateTime), 1)
INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (11, N'Điện thoại', N'Sony Xperia ZL2', CAST(N'2017-03-16 09:22:50.453' AS DateTime), 1)
INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (12, N'giày', N'giày nike trắng', CAST(N'2017-03-16 09:44:02.210' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Concept] OFF
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'00adc6d6-b480-412b-9abd-9a54b4504b4c', N'4e490b73-8526-458e-9c99-47c3d9735a11', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489563454/zczsuoux8scnw03kvgdt.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'023bd7b7-ba83-4762-868b-c15dc6399248', N'2d0fcb18-c980-41ec-8f09-619c82ec7dc5', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489563312/xywdf7rloquacqq6ng12.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'09e48a93-01c8-45f4-8dca-49cfd8b1692e', N'f5a8aeb3-0ad8-4f95-bac1-18c610f969d4', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489563265/wxr3b2lxnuzi5m63vp2d.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'3eee4c9e-a493-4bd6-a923-540f9e5fd522', N'f0445c4f-daca-42a5-b39b-bef86a3e5844', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489563182/p57ynj4nijryiay1p5gt.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'3f9610d1-2794-48ab-a178-7f654b799804', N'bda13a18-b3f1-480d-8a4b-d06a118455be', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489214929/lfc2x8epj2tdh5i4wwol.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'4280f5d1-6f33-420e-82cc-8279b9c306a8', N'bda13a18-b3f1-480d-8a4b-d06a118455be', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489589442/tjod4hqtvv0ai2pcqpiv.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'4fb8c65f-ab80-48c7-ae19-1c8868185d69', N'f0445c4f-daca-42a5-b39b-bef86a3e5844', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489563176/qo6v49alv5eu7brx1y7z.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'5ca83a49-edfa-4fc5-bbba-de3eb463cd00', N'f5a8aeb3-0ad8-4f95-bac1-18c610f969d4', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489563257/p2iig20b21wvqewofwlr.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'61fb11a6-d9c1-44a3-bce4-1f99f68190d2', N'4e490b73-8526-458e-9c99-47c3d9735a11', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489563451/upgqifzpeapjsexoquio.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'6a0ff95f-3ac4-4f61-a13a-88ede40cb5c2', N'f0445c4f-daca-42a5-b39b-bef86a3e5844', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489563179/ytacbvdknbeemhco2y76.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'a29c4ad8-9dfa-4216-92ba-51ebd10f35c6', N'f5a8aeb3-0ad8-4f95-bac1-18c610f969d4', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489563260/pczus7ydqpkc1aprfnmj.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'a36be6cd-00ea-45d6-bea3-fafb3bb4f242', N'bda13a18-b3f1-480d-8a4b-d06a118455be', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489589686/vdtie7zfsv66ds9tnh4w.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'b7557f74-5cb4-4b65-bec9-72fb33869914', N'bda13a18-b3f1-480d-8a4b-d06a118455be', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489589444/xswg2fokwzfdqkhj4txn.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'bd0eee36-93f1-46ee-b012-8f662672b797', N'4e490b73-8526-458e-9c99-47c3d9735a11', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489563450/v0arlfnggbw2ax2igt8x.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'e6d52431-67cc-4992-b0ab-cfc7e841b153', N'bda13a18-b3f1-480d-8a4b-d06a118455be', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489589685/iaqplljrlbltsjmqollm.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'e8404eb2-17ca-49a9-98ee-9dfb04e806c5', N'bda13a18-b3f1-480d-8a4b-d06a118455be', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489589440/dbdgwrczest91fdzawwy.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'e9601a89-ac77-4534-81f6-1d8d78212c83', N'bda13a18-b3f1-480d-8a4b-d06a118455be', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489214929/lfc2x8epj2tdh5i4wwol.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'ea3aa612-b67b-4c3f-8f84-a8072b1dd49d', N'bda13a18-b3f1-480d-8a4b-d06a118455be', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489589917/rg4eylzdkb7ct1az4q1t.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'ec13b9f6-4fd3-4e2a-bf61-0be75f0d44af', N'bda13a18-b3f1-480d-8a4b-d06a118455be', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489589443/kopyap0b6rje7vrxxo5v.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'ef0c1311-4db0-4d42-adb1-80e3d728d3c9', N'2d0fcb18-c980-41ec-8f09-619c82ec7dc5', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489563319/ht4z7mweg83lwtcvln3r.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'f1633694-e431-4bdd-a789-eb338b599714', N'2d0fcb18-c980-41ec-8f09-619c82ec7dc5', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489563324/evz20i03te8uhvly8nvq.jpg', 1)
SET IDENTITY_INSERT [dbo].[Log] ON 

INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (7, CAST(N'2017-03-11 13:49:06.430' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489214929/lfc2x8epj2tdh5i4wwol.jpg', N'hoàng sơn', 0)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (10, CAST(N'2017-03-11 13:49:06.430' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489214929/lfc2x8epj2tdh5i4wwol.jpg', N'hoàng sơn', 0)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (11, CAST(N'2017-03-11 13:49:06.430' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489214929/lfc2x8epj2tdh5i4wwol.jpg', N'hoàng sơn', 0)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (12, CAST(N'2017-03-11 13:49:06.430' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489214929/lfc2x8epj2tdh5i4wwol.jpg', N'hoàng sơn', 0)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (13, CAST(N'2017-03-11 13:49:06.430' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489214929/lfc2x8epj2tdh5i4wwol.jpg', N'hoàng sơn', 0)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (14, CAST(N'2017-03-11 13:49:06.430' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489214929/lfc2x8epj2tdh5i4wwol.jpg', N'hoàng sơn', 0)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (15, CAST(N'2017-03-15 14:44:31.347' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489563857/phimhcgw1og4xg4f1gn8.jpg', N'nguyễn vũ hoàng sơn', 0)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (16, CAST(N'2017-03-15 21:58:55.290' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489589917/rg4eylzdkb7ct1az4q1t.jpg', N'hoàng sơn', 0)
SET IDENTITY_INSERT [dbo].[Log] OFF
SET IDENTITY_INSERT [dbo].[LogObject] ON 

INSERT [dbo].[LogObject] ([ID], [CreatedDate], [UserID], [ImageURL], [Active]) VALUES (5, CAST(N'2017-03-14 00:04:06.827' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489424642/bq9o4ujdfqr1su1dingq.jpg', 0)
INSERT [dbo].[LogObject] ([ID], [CreatedDate], [UserID], [ImageURL], [Active]) VALUES (6, CAST(N'2017-03-14 00:08:14.587' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489424889/fgmkbltnklajcjjfxfd2.jpg', 0)
INSERT [dbo].[LogObject] ([ID], [CreatedDate], [UserID], [ImageURL], [Active]) VALUES (7, CAST(N'2017-03-14 00:08:33.757' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489424908/lttdwxjkezeityz7hvun.jpg', 0)
INSERT [dbo].[LogObject] ([ID], [CreatedDate], [UserID], [ImageURL], [Active]) VALUES (8, CAST(N'2017-03-16 09:24:27.827' AS DateTime), N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489631062/dvbg3pwtcklqrf6muaph.jpg', 0)
SET IDENTITY_INSERT [dbo].[LogObject] OFF
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Count], [Active]) VALUES (N'2d0fcb18-c980-41ec-8f09-619c82ec7dc5', N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'Hà Quân', N'Team Member #3', NULL, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Count], [Active]) VALUES (N'4e490b73-8526-458e-9c99-47c3d9735a11', N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'Cao Duy', N'Team Member #4', NULL, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Count], [Active]) VALUES (N'bda13a18-b3f1-480d-8a4b-d06a118455be', N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'nguyễn vũ hoàng sơn', N'team mate #2', NULL, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Count], [Active]) VALUES (N'f0445c4f-daca-42a5-b39b-bef86a3e5844', N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'Nguyễn Vũ Hoàng Sơn', N'Team Mate #2', NULL, 0)
INSERT [dbo].[Person] ([PersonId], [PersonGroupId], [Name], [Description], [Count], [Active]) VALUES (N'f5a8aeb3-0ad8-4f95-bac1-18c610f969d4', N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'Trung Thành', N'Team Leader', NULL, 1)
INSERT [dbo].[PersonGroup] ([PersonGroupId], [PersonGroupName], [Description], [UserId], [Type], [Active]) VALUES (N'661d39a3-ad8f-45e3-8c35-057298d16da6', N'quanha@gmail.com', N'', NULL, NULL, 1)
INSERT [dbo].[PersonGroup] ([PersonGroupId], [PersonGroupName], [Description], [UserId], [Type], [Active]) VALUES (N'f6575bcc-e47b-4b6c-be91-b76a2af3d687', N'son@gmail.com', NULL, NULL, NULL, 1)
INSERT [dbo].[PersonGroup] ([PersonGroupId], [PersonGroupName], [Description], [UserId], [Type], [Active]) VALUES (N'fresh_cab8f67f-3b22-431d-a872-2de96165a36e', N'Fresh_test@gmail.com', N'test@gmail.com fresh person group', N'cab8f67f-3b22-431d-a872-2de96165a36e', 3, 1)
INSERT [dbo].[PersonGroup] ([PersonGroupId], [PersonGroupName], [Description], [UserId], [Type], [Active]) VALUES (N'normal_cab8f67f-3b22-431d-a872-2de96165a36e', N'Normal_test@gmail.com', N'test@gmail.com normal person group', N'cab8f67f-3b22-431d-a872-2de96165a36e', 2, 1)
INSERT [dbo].[PersonGroup] ([PersonGroupId], [PersonGroupName], [Description], [UserId], [Type], [Active]) VALUES (N'popular_cab8f67f-3b22-431d-a872-2de96165a36e', N'Popular_test@gmail.com', N'test@gmail.com popular person group', N'cab8f67f-3b22-431d-a872-2de96165a36e', 1, 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'a056dd7cf20148199940ad66cefc17ae', 8, N'balo puma đen', N'http://res.cloudinary.com/trains/image/upload/v1488987689/uwkarcc4acacjiref2wf.jpg', 0)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'b07aa8d80ac8433f93f2072ce5313283', 9, N'bút lông', N'http://res.cloudinary.com/trains/image/upload/v1489027794/yt1ykdsobkuysnvlrfk2.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'b07dceb2efe84a429d51e6f07039050c', 9, N'bút lông', N'http://res.cloudinary.com/trains/image/upload/v1489027816/rgolqmfqeztdjibsd79z.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'b30cc12b3f54456393a51d01ef66c78d', 11, N'điện thoại', N'http://res.cloudinary.com/trains/image/upload/v1489630673/eclzk22btd0gqrvsms8i.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'b5a13edf831243c49a1be03b8dc84720', 11, N'điện thoại', N'http://res.cloudinary.com/trains/image/upload/v1489630676/qjpwjjii6yvuvkxjott9.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'bddb43fd9bc2437faff52d21f9224e94', 11, N'điện thoại', N'http://res.cloudinary.com/trains/image/upload/v1489630672/jhriopipvfw8uzyhseeo.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'c730fa63509a488bb4c5fe27d6715a1b', 9, N'bút lông', N'http://res.cloudinary.com/trains/image/upload/v1489027784/phnbshkjomhvkyjyd6tf.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'c9b8d81107bc4ee7afc4b39f63599f9b', 8, N'balo puma đen', N'http://res.cloudinary.com/trains/image/upload/v1488987760/y5dp7rrfjanslsjwadeo.jpg', 0)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'ce95f5be957d4666bcc4a085ff4a602f', 10, N'bấm máy chiếu', N'http://res.cloudinary.com/trains/image/upload/v1489028370/jrex3nazdy1mddbkhap1.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'd2f8cd2f2a01415e8ed52eca6ef08895', 9, N'bút lông', N'http://res.cloudinary.com/trains/image/upload/v1489027842/wjswe98cz3zezfcusinm.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'd318cbdf9fec4b14858c8212dca6b35a', 10, N'bấm máy chiếu', N'http://res.cloudinary.com/trains/image/upload/v1489028358/rkjavamlcrgfzsvoehzm.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'd5a1311c770b434e8c76f013bacb4012', 11, N'điện thoại', N'http://res.cloudinary.com/trains/image/upload/v1489630675/egh7y39vv9qktu05alax.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'da738349e1e6471cb6a8511acfdbb514', 7, N'đồng hồ', N'http://res.cloudinary.com/trains/image/upload/v1488955599/mgxy52gzsg1suvycawfc.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'dba641157ca94618b83b860487bfad50', 12, N'giày nike trắng', N'http://res.cloudinary.com/trains/image/upload/v1489632254/sph6xaunnorqzaxb00iq.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'dbe1f24a520347f5b4b2b99d9e87af43', 11, N'điện thoại', N'http://res.cloudinary.com/trains/image/upload/v1489630677/ojp8kcol3xa9ku2ly7p4.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'e039782059464af1bed7e70bfcd8d2ef', 9, N'bút lông', N'http://res.cloudinary.com/trains/image/upload/v1489027804/fpownckeht0hnw3qgjpm.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'e18253868e1b4e3299e2423dcf259233', 12, N'giày nike trắng', N'http://res.cloudinary.com/trains/image/upload/v1489632247/biduwrjjxkjoiomd9dqn.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'e30c321560a84a83b8f558a0ed44bb81', 11, N'Sony Xperia ZL2', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489631062/dvbg3pwtcklqrf6muaph.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'e6f8860aff414dd7b3534daae0576c7f', 12, N'giày nike trắng', N'http://res.cloudinary.com/trains/image/upload/v1489632253/x15tgrgetb0e4tkqp0g8.png', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'e7285f83d144473f8a795a097a812ef3', 7, N'đồng hồ', N'http://res.cloudinary.com/trains/image/upload/v1488955583/fwoskdazrqufjwlwp5v9.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'e91598fe30a14d37baff0af82419ddc8', 9, N'bút lông', N'http://res.cloudinary.com/trains/image/upload/v1489027831/veqgjorkmnm4ga1ftpms.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'ecc1fb273e9c4557861cde37bd3104b5', 7, N'đồng hồ', N'http://res.cloudinary.com/trains/image/upload/v1488955591/fh09g7ahtbddvtf2nxgb.jpg', 1)
INSERT [dbo].[Picture] ([PictureId], [ConceptId], [Description], [ImageURL], [Active]) VALUES (N'f015fef1ce02402dbd91bfef6dd7d88f', 8, N'balo puma đen', N'http://res.cloudinary.com/trains/image/upload/v1488987664/dyvym1rastmr2sttvpgo.jpg', 0)
ALTER TABLE [dbo].[AspNetUsers] ADD  CONSTRAINT [DF_AspNetUsers_TotalDetect]  DEFAULT ((0)) FOR [TotalDetect]
GO
ALTER TABLE [dbo].[AspNetUsers] ADD  CONSTRAINT [DF_AspNetUsers_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Concept] ADD  CONSTRAINT [DF_Concept_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_Count]  DEFAULT ((0)) FOR [Count]
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
ALTER TABLE [dbo].[PersonGroup]  WITH CHECK ADD  CONSTRAINT [FK_PersonGroup_AspNetUsers] FOREIGN KEY([UserId])
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
