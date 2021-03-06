USE [master]
GO
/****** Object:  Database [Capstone]    Script Date: 03/10/2017 3:48:33 AM ******/
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
/****** Object:  User [IIS APPPOOL\DefaultAppPool]    Script Date: 03/10/2017 3:48:33 AM ******/
CREATE USER [IIS APPPOOL\DefaultAppPool] FOR LOGIN [IIS APPPOOL\DefaultAppPool] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 03/10/2017 3:48:33 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 03/10/2017 3:48:34 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 03/10/2017 3:48:34 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 03/10/2017 3:48:34 AM ******/
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
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 03/10/2017 3:48:34 AM ******/
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
	[PersonGroupId] [int] NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Concept]    Script Date: 03/10/2017 3:48:34 AM ******/
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
/****** Object:  Table [dbo].[Face]    Script Date: 03/10/2017 3:48:34 AM ******/
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
/****** Object:  Table [dbo].[Log]    Script Date: 03/10/2017 3:48:34 AM ******/
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
/****** Object:  Table [dbo].[LogObject]    Script Date: 03/10/2017 3:48:34 AM ******/
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
/****** Object:  Table [dbo].[Person]    Script Date: 03/10/2017 3:48:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[PersonId] [nvarchar](36) NOT NULL,
	[PersonGroupID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[PersonGroup]    Script Date: 03/10/2017 3:48:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonGroup](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PersonGroupName] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_tbl_PersonGroup] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Picture]    Script Date: 03/10/2017 3:48:34 AM ******/
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
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [PersonGroupId]) VALUES (N'09875230-284a-49d6-a072-8e0af4b47987', N'quanha@gmail.com', 0, N'ADmufm4OSfyfxHYVOwTHFi55baDxcqWrIhTK5hsq6MWbBGQM4yrqi92iQayXkrSqsA==', N'f7cc3fc4-af7e-4808-9eb7-874f5f03bb75', NULL, 0, 0, NULL, 1, 0, N'quanha@gmail.com', 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [PersonGroupId]) VALUES (N'9d9d04f2-966b-46dc-acf7-39e2970b172d', N'thanhtrung@gmail.com', 0, N'ABNPC0sG3/CW9ooyoRio7a1Je1X9ffvseNqV/PFqcwlxtAhUfEaZkii9xUaSrDlq9A==', N'f489e0b3-7669-4c57-88aa-b2f2260cbc41', NULL, 0, 0, NULL, 1, 0, N'thanhtrung@gmail.com', 1)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [PersonGroupId]) VALUES (N'ab963246-5fa4-478b-bf19-4e6d8c2193f5', N'son@gmail.com', 0, N'APHyJOw1pM9QQl9BETPtagrhxF1O8ANzD0yu1FT8yUhbEa85YCe8KvgVOYqij28rKg==', N'b8d2a7d8-41cc-40f4-9b7d-60f11a6344f8', NULL, 0, 0, NULL, 1, 0, N'son@gmail.com', 1)
SET IDENTITY_INSERT [dbo].[Concept] ON 

INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (7, N'clock', N'đồng hồ', CAST(N'2017-03-08 13:46:19.197' AS DateTime), 0)
INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (8, N'balo', N'balo puma đen', CAST(N'2017-03-08 22:40:57.880' AS DateTime), 1)
INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (9, N'bút viết bảng', N'bút lông', CAST(N'2017-03-09 09:49:38.757' AS DateTime), 1)
INSERT [dbo].[Concept] ([ConceptId], [ConceptName], [ConceptDescription], [CreateDate], [Active]) VALUES (10, N'đồ bấm casio', N'bấm máy chiếu', CAST(N'2017-03-09 09:59:08.720' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Concept] OFF
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'01f66d20-b274-448d-904b-9276fbb12b4f', N'c10f4660-c26a-49af-b7ff-d249f5f4f8ff', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489026964/gj8j7rpf7mlvuicei4mk.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'2e134cfd-0f68-4113-bf18-bfe512a50e3a', N'd3f960e2-0452-479f-a292-37170d6f4b6f', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1488986211/tnxl8sa4eukjpxr62azv.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'2e3ef19a-34f4-4abc-b7ed-fe590d1d8a89', N'161c1fe0-b551-462f-8213-0a9de51bf75c', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489092301/zrxa7t61vrmheaoqj1iu.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'616bacdf-cda5-4e12-a42c-29448411f9da', N'c10f4660-c26a-49af-b7ff-d249f5f4f8ff', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489026960/dpfr3w1jsdsb0tml8mqp.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'850bd9f2-c0ce-40bf-b84b-d806c9f1babb', N'161c1fe0-b551-462f-8213-0a9de51bf75c', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489092288/nh8vhmtecfjlvkeri8jj.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'87bb1aea-c7fb-496b-8e5b-d1ccad314452', N'd3f960e2-0452-479f-a292-37170d6f4b6f', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489091623/iqg1wj20mnuhbomecsaj.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'9eff407d-a23a-4b99-bab5-310bb5b9e5ef', N'd3f960e2-0452-479f-a292-37170d6f4b6f', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1488986218/ven2jpxblf8so4hcewy7.jpg', 0)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'ab016492-1e3d-401d-b778-1785b895d2e1', N'd3f960e2-0452-479f-a292-37170d6f4b6f', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489091617/kdflkdwnwzhjy7eklec1.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'b51606fb-a4ef-4b0e-b319-a98692fb5eb0', N'161c1fe0-b551-462f-8213-0a9de51bf75c', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489026278/ew3eiqkwtyzqz6cskvi1.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'd1bca258-69e1-4b64-8e21-a747c05b1b96', N'c10f4660-c26a-49af-b7ff-d249f5f4f8ff', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489027301/nlux9qaamyuuii8tdtys.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'df5b59e6-0d2b-45b3-aabb-6c0901a8fafc', N'd3f960e2-0452-479f-a292-37170d6f4b6f', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1488986223/wxenquxyfau8ojccvsg6.jpg', 1)
INSERT [dbo].[Face] ([PersistedFaceId], [PersonID], [ImageURL], [Active]) VALUES (N'e40a69dd-bb36-4dab-af2c-1375f4c03d10', N'161c1fe0-b551-462f-8213-0a9de51bf75c', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489026271/wuooifneftbnu7lg2yzu.jpg', 0)
SET IDENTITY_INSERT [dbo].[Log] ON 

INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (5, CAST(N'2017-03-08 22:08:27.767' AS DateTime), N'ab963246-5fa4-478b-bf19-4e6d8c2193f5', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1488985691/irx4gwofeyxmucshotc3.jpg', N'hoàng sơn', 1)
INSERT [dbo].[Log] ([ID], [CreatedDate], [UserID], [ImageURL], [Name], [Active]) VALUES (6, CAST(N'2017-03-09 09:29:18.180' AS DateTime), N'ab963246-5fa4-478b-bf19-4e6d8c2193f5', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489026467/d5gda98klia43ztmybrn.jpg', N'anh thành', 1)
SET IDENTITY_INSERT [dbo].[Log] OFF
SET IDENTITY_INSERT [dbo].[LogObject] ON 

INSERT [dbo].[LogObject] ([ID], [CreatedDate], [UserID], [ImageURL], [Active]) VALUES (2, CAST(N'2017-03-08 13:30:41.527' AS DateTime), N'ab963246-5fa4-478b-bf19-4e6d8c2193f5', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1488954634/cfkofdeip9vpyrcgs2we.jpg', 1)
INSERT [dbo].[LogObject] ([ID], [CreatedDate], [UserID], [ImageURL], [Active]) VALUES (3, CAST(N'2017-03-09 09:31:17.930' AS DateTime), N'ab963246-5fa4-478b-bf19-4e6d8c2193f5', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489026672/asmqojhvyfzwdapuybzb.jpg', 1)
INSERT [dbo].[LogObject] ([ID], [CreatedDate], [UserID], [ImageURL], [Active]) VALUES (4, CAST(N'2017-03-09 09:55:26.597' AS DateTime), N'ab963246-5fa4-478b-bf19-4e6d8c2193f5', N'http://res.cloudinary.com/debwqzo2g/image/upload/v1489028122/f8vzrbeuicw72goobt4u.jpg', 1)
SET IDENTITY_INSERT [dbo].[LogObject] OFF
INSERT [dbo].[Person] ([PersonId], [PersonGroupID], [Name], [Description], [IsTrained], [Active]) VALUES (N'161c1fe0-b551-462f-8213-0a9de51bf75c', 1, N'Hà Quân', N'team member ', 1, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupID], [Name], [Description], [IsTrained], [Active]) VALUES (N'c10f4660-c26a-49af-b7ff-d249f5f4f8ff', 1, N'Thành', N'nhóm trưởng', 1, 1)
INSERT [dbo].[Person] ([PersonId], [PersonGroupID], [Name], [Description], [IsTrained], [Active]) VALUES (N'd3f960e2-0452-479f-a292-37170d6f4b6f', 1, N'Nguyễn Vũ Hoàng Sơn', N'team member fucking important', 1, 1)
SET IDENTITY_INSERT [dbo].[PersonGroup] ON 

INSERT [dbo].[PersonGroup] ([ID], [PersonGroupName], [Description], [Active]) VALUES (1, N'empty', N'emtpy', 1)
SET IDENTITY_INSERT [dbo].[PersonGroup] OFF
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
ALTER TABLE [dbo].[AspNetUsers]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUsers_PersonGroup] FOREIGN KEY([PersonGroupId])
REFERENCES [dbo].[PersonGroup] ([ID])
GO
ALTER TABLE [dbo].[AspNetUsers] CHECK CONSTRAINT [FK_AspNetUsers_PersonGroup]
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
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_PersonGroup] FOREIGN KEY([PersonGroupID])
REFERENCES [dbo].[PersonGroup] ([ID])
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
