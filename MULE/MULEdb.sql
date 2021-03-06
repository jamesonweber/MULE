USE [master]
GO
/****** Object:  Database [mule]    Script Date: 4/27/2017 5:11:07 PM ******/
CREATE DATABASE [mule]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'mule', FILENAME = N'D:\RDSDBDATA\DATA\mule.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'mule_log', FILENAME = N'D:\RDSDBDATA\DATA\mule_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [mule] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [mule].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [mule] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [mule] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [mule] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [mule] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [mule] SET ARITHABORT OFF 
GO
ALTER DATABASE [mule] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [mule] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [mule] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [mule] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [mule] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [mule] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [mule] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [mule] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [mule] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [mule] SET  DISABLE_BROKER 
GO
ALTER DATABASE [mule] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [mule] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [mule] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [mule] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [mule] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [mule] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [mule] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [mule] SET RECOVERY FULL 
GO
ALTER DATABASE [mule] SET  MULTI_USER 
GO
ALTER DATABASE [mule] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [mule] SET DB_CHAINING OFF 
GO
ALTER DATABASE [mule] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [mule] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [mule] SET DELAYED_DURABILITY = DISABLED 
GO
USE [mule]
GO
/****** Object:  User [sqlmaster]    Script Date: 4/27/2017 5:11:07 PM ******/
CREATE USER [sqlmaster] FOR LOGIN [sqlmaster] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [sqlmaster]
GO
/****** Object:  Table [dbo].[comments]    Script Date: 4/27/2017 5:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comments](
	[comment_id] [int] IDENTITY(1,1) NOT NULL,
	[post_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[comment] [nvarchar](500) NOT NULL,
	[comment_date] [datetime] NOT NULL,
 CONSTRAINT [PK_comments] PRIMARY KEY CLUSTERED 
(
	[comment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[groups]    Script Date: 4/27/2017 5:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[groups](
	[group_id] [int] IDENTITY(1,1) NOT NULL,
	[user_owner_id] [int] NOT NULL,
	[group_name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](500) NULL,
	[private_flag] [int] NOT NULL,
 CONSTRAINT [PK_groups] PRIMARY KEY CLUSTERED 
(
	[group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mapping]    Script Date: 4/27/2017 5:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mapping](
	[mapping_id] [int] IDENTITY(1,1) NOT NULL,
	[position_id] [int] NOT NULL,
	[echo_depth] [float] NOT NULL,
 CONSTRAINT [PK_mapping] PRIMARY KEY CLUSTERED 
(
	[mapping_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[positioning]    Script Date: 4/27/2017 5:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[positioning](
	[position_id] [int] IDENTITY(1,1) NOT NULL,
	[post_id] [int] NOT NULL,
	[region] [nvarchar](10) NOT NULL,
	[latitude] [float] NOT NULL,
	[longitude] [float] NOT NULL,
	[northing] [float] NOT NULL,
	[easting] [float] NOT NULL,
	[euv_depth] [float] NOT NULL,
 CONSTRAINT [PK_positioning] PRIMARY KEY CLUSTERED 
(
	[position_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[posts]    Script Date: 4/27/2017 5:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[posts](
	[post_id] [int] NOT NULL,
	[group_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[post_status] [nvarchar](500) NULL,
	[post_date] [datetime] NOT NULL,
 CONSTRAINT [PK_posts] PRIMARY KEY CLUSTERED 
(
	[post_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sensor]    Script Date: 4/27/2017 5:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sensor](
	[sensor_id] [int] IDENTITY(1,1) NOT NULL,
	[post_id] [int] NOT NULL,
	[avg_primary_data] [float] NULL,
	[sd] [float] NULL,
	[sem] [float] NULL,
	[meta_data] [nvarchar](max) NOT NULL,
	[image] [image] NULL,
 CONSTRAINT [PK_sensor] PRIMARY KEY CLUSTERED 
(
	[sensor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sensor_details]    Script Date: 4/27/2017 5:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sensor_details](
	[sensor_details_id] [int] IDENTITY(1,1) NOT NULL,
	[sensor_id] [int] NOT NULL,
	[raw_primary_data] [nvarchar](max) NOT NULL,
	[raw_meta_data] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_sensor_details] PRIMARY KEY CLUSTERED 
(
	[sensor_details_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[user_group]    Script Date: 4/27/2017 5:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_group](
	[user_group_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[group_id] [int] NOT NULL,
	[is_approved] [int] NOT NULL,
 CONSTRAINT [PK_user_group] PRIMARY KEY CLUSTERED 
(
	[user_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users]    Script Date: 4/27/2017 5:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nvarchar](255) NOT NULL,
	[last_name] [nvarchar](255) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[password] [nvarchar](100) NOT NULL,
	[confirm_password] [nvarchar](50) NOT NULL,
	[is_premium] [int] NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[comments]  WITH CHECK ADD  CONSTRAINT [FK_comments_posts] FOREIGN KEY([post_id])
REFERENCES [dbo].[posts] ([post_id])
GO
ALTER TABLE [dbo].[comments] CHECK CONSTRAINT [FK_comments_posts]
GO
ALTER TABLE [dbo].[comments]  WITH CHECK ADD  CONSTRAINT [FK_comments_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[comments] CHECK CONSTRAINT [FK_comments_users]
GO
ALTER TABLE [dbo].[mapping]  WITH CHECK ADD  CONSTRAINT [FK_mapping_positioning] FOREIGN KEY([position_id])
REFERENCES [dbo].[positioning] ([position_id])
GO
ALTER TABLE [dbo].[mapping] CHECK CONSTRAINT [FK_mapping_positioning]
GO
ALTER TABLE [dbo].[positioning]  WITH CHECK ADD  CONSTRAINT [FK_positioning_posts] FOREIGN KEY([post_id])
REFERENCES [dbo].[posts] ([post_id])
GO
ALTER TABLE [dbo].[positioning] CHECK CONSTRAINT [FK_positioning_posts]
GO
ALTER TABLE [dbo].[posts]  WITH CHECK ADD  CONSTRAINT [FK_posts_groups] FOREIGN KEY([group_id])
REFERENCES [dbo].[groups] ([group_id])
GO
ALTER TABLE [dbo].[posts] CHECK CONSTRAINT [FK_posts_groups]
GO
ALTER TABLE [dbo].[posts]  WITH CHECK ADD  CONSTRAINT [FK_posts_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[posts] CHECK CONSTRAINT [FK_posts_users]
GO
ALTER TABLE [dbo].[sensor]  WITH CHECK ADD  CONSTRAINT [FK_sensor_posts] FOREIGN KEY([post_id])
REFERENCES [dbo].[posts] ([post_id])
GO
ALTER TABLE [dbo].[sensor] CHECK CONSTRAINT [FK_sensor_posts]
GO
ALTER TABLE [dbo].[sensor_details]  WITH CHECK ADD  CONSTRAINT [FK_sensor_details_sensor] FOREIGN KEY([sensor_id])
REFERENCES [dbo].[sensor] ([sensor_id])
GO
ALTER TABLE [dbo].[sensor_details] CHECK CONSTRAINT [FK_sensor_details_sensor]
GO
ALTER TABLE [dbo].[user_group]  WITH CHECK ADD  CONSTRAINT [FK_user_group_groups] FOREIGN KEY([group_id])
REFERENCES [dbo].[groups] ([group_id])
GO
ALTER TABLE [dbo].[user_group] CHECK CONSTRAINT [FK_user_group_groups]
GO
ALTER TABLE [dbo].[user_group]  WITH CHECK ADD  CONSTRAINT [FK_user_group_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[user_group] CHECK CONSTRAINT [FK_user_group_users]
GO
/****** Object:  DdlTrigger [rds_deny_backups_trigger]    Script Date: 4/27/2017 5:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [rds_deny_backups_trigger] ON DATABASE WITH EXECUTE AS 'dbo' FOR
 ADD_ROLE_MEMBER, GRANT_DATABASE AS BEGIN
   SET NOCOUNT ON;
   SET ANSI_PADDING ON;
 
   DECLARE @data xml;
   DECLARE @user sysname;
   DECLARE @role sysname;
   DECLARE @type sysname;
   DECLARE @sql NVARCHAR(MAX);
   DECLARE @permissions TABLE(name sysname PRIMARY KEY);
   
   SELECT @data = EVENTDATA();
   SELECT @type = @data.value('(/EVENT_INSTANCE/EventType)[1]', 'sysname');
    
   IF @type = 'ADD_ROLE_MEMBER' BEGIN
      SELECT @user = @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'sysname'),
       @role = @data.value('(/EVENT_INSTANCE/RoleName)[1]', 'sysname');

      IF @role IN ('db_owner', 'db_backupoperator') BEGIN
         SELECT @sql = 'DENY BACKUP DATABASE, BACKUP LOG TO ' + QUOTENAME(@user);
         EXEC(@sql);
      END
   END ELSE IF @type = 'GRANT_DATABASE' BEGIN
      INSERT INTO @permissions(name)
      SELECT Permission.value('(text())[1]', 'sysname') FROM
       @data.nodes('/EVENT_INSTANCE/Permissions/Permission')
      AS DatabasePermissions(Permission);
      
      IF EXISTS (SELECT * FROM @permissions WHERE name IN ('BACKUP DATABASE',
       'BACKUP LOG'))
         RAISERROR('Cannot grant backup database or backup log', 15, 1) WITH LOG;       
   END
END


GO
ENABLE TRIGGER [rds_deny_backups_trigger] ON DATABASE
GO
USE [master]
GO
ALTER DATABASE [mule] SET  READ_WRITE 
GO
