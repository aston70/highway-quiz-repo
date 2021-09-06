-- ==========================================================================================================
-- This script creates the HighQuiz Database, Tables, and Stored Procedures.
-- Execute with a server based admin login (sa - etc.) that has permission to create databases and users.
-- ==========================================================================================================
USE [HighQuiz]
GO

-- --------------------------------------------------------------------------------------
-- Drop Stored Procedures
-- --------------------------------------------------------------------------------------
DROP PROCEDURE if exists [dbo].[hq_saveQuiz]
GO

DROP PROCEDURE if exists [dbo].[hq_saveQuizDetail]
GO

-- --------------------------------------------------------------------------------------
-- Drop TABLES
-- --------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------
-- Drop User Quiz "link" Table
-- --------------------------------------------------------------------------------------
print 'Dropping User Quiz Table'
ALTER TABLE [dbo].[UserQuiz] DROP CONSTRAINT [FK_UserQuiz_User]
GO

ALTER TABLE [dbo].[UserQuiz] DROP CONSTRAINT [FK_UserQuiz_Quiz]
GO

DROP TABLE if exists [dbo].[UserQuiz]
GO

-- --------------------------------------------------------------------------------------
-- Drop Quiz Detail Table
-- --------------------------------------------------------------------------------------
print 'Dropping Quiz Detail Table'
ALTER TABLE [dbo].[QuizDetail] DROP CONSTRAINT [FK_UserQuizResult_SelectedAnswer]
GO

ALTER TABLE [dbo].[QuizDetail] DROP CONSTRAINT [FK_UserQuizResult_Question]
GO

ALTER TABLE [dbo].[QuizDetail] DROP CONSTRAINT [FK_UserQuizResult_CorrectAnswer]
GO

ALTER TABLE [dbo].[QuizDetail] DROP CONSTRAINT [FK_QuizDetail_Quiz]
GO

DROP TABLE if exists [dbo].[QuizDetail]
GO

-- --------------------------------------------------------------------------------------
-- Drop Quiz Table
-- --------------------------------------------------------------------------------------
print 'Dropping Quiz Table'

DROP TABLE if exists [dbo].[Quiz]
GO

-- --------------------------------------------------------------------------------------
-- Drop Answer Table
-- --------------------------------------------------------------------------------------
print 'Dropping Answer Table'
ALTER TABLE [dbo].[Answer] DROP CONSTRAINT [DF_Answer_Active]
GO

ALTER TABLE [dbo].[Answer] DROP CONSTRAINT [DF_Answer_IsCorrect]
GO

DROP TABLE if exists [dbo].[Answer]
GO

-- --------------------------------------------------------------------------------------
-- Drop Question Table
-- --------------------------------------------------------------------------------------
print 'Dropping Question Table'
ALTER TABLE [dbo].[Question] DROP CONSTRAINT [DF_Question_Active]
GO

DROP TABLE if exists [dbo].[Question]
GO

-- --------------------------------------------------------------------------------------
-- Drop User Table
-- --------------------------------------------------------------------------------------
print 'Dropping User Table'
ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF_User_DateCreated]
GO

DROP TABLE if exists [dbo].[User]
GO


-- --------------------------------------------------------------------------------------
-- Close and Drop Database.
-- --------------------------------------------------------------------------------------
USE [master]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- --------------------------------------------------------------------------------------
-- Close any DB connections if any exist.
-- --------------------------------------------------------------------------------------
print 'Killing any existing connections to database'
DECLARE @DatabaseName nvarchar(50)
SET @DatabaseName = N'HighQuiz'

DECLARE @SQL varchar(max)

SELECT @SQL = COALESCE(@SQL,'') + 'Kill ' + Convert(varchar, SPId) + ';'
FROM MASTER..SysProcesses
WHERE DBId = DB_ID(@DatabaseName) AND SPId <> @@SPId

--SELECT @SQL 
EXEC(@SQL)
GO

-- --------------------------------------------------------------------------------------
-- Drop DB if exist.
-- --------------------------------------------------------------------------------------
print 'Dropping HighQuiz Database'
DROP DATABASE if exists [HighQuiz]
GO



/****** Object:  Database [HighQuiz]    Script Date: 8/30/2021 12:37:16 PM ******/
print 'Creating HighQuiz Database'
CREATE DATABASE [HighQuiz]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HighQuiz', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\HighQuiz.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HighQuiz_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\HighQuiz_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HighQuiz].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [HighQuiz] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [HighQuiz] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [HighQuiz] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [HighQuiz] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [HighQuiz] SET ARITHABORT OFF 
GO

ALTER DATABASE [HighQuiz] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [HighQuiz] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [HighQuiz] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [HighQuiz] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [HighQuiz] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [HighQuiz] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [HighQuiz] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [HighQuiz] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [HighQuiz] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [HighQuiz] SET  DISABLE_BROKER 
GO

ALTER DATABASE [HighQuiz] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [HighQuiz] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [HighQuiz] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [HighQuiz] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [HighQuiz] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [HighQuiz] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [HighQuiz] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [HighQuiz] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [HighQuiz] SET  MULTI_USER 
GO

ALTER DATABASE [HighQuiz] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [HighQuiz] SET DB_CHAINING OFF 
GO

ALTER DATABASE [HighQuiz] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [HighQuiz] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [HighQuiz] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [HighQuiz] SET QUERY_STORE = OFF
GO

ALTER DATABASE [HighQuiz] SET  READ_WRITE 
GO

-- --------------------------------------------------------------------------------------
-- CREATE TABLES....
-- --------------------------------------------------------------------------------------
USE [HighQuiz]
GO

-- --------------------------------------------------------------------------------------
-- Create Question Table.
-- --------------------------------------------------------------------------------------
print 'Creating Question Table'
CREATE TABLE [dbo].[Question](
	[QuestionId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionDescr] [varchar](max) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Question] ADD  CONSTRAINT [DF_Question_Active]  DEFAULT ((0)) FOR [Active]
GO

-- --------------------------------------------------------------------------------------
-- Create Answer Table...
-- --------------------------------------------------------------------------------------
print 'Creating Answer Table'
CREATE TABLE [dbo].[Answer](
	[AnswerId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[AnswerDescr] [varchar](250) NOT NULL,
	[IsCorrect] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Answer] PRIMARY KEY CLUSTERED 
(
	[AnswerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Answer] ADD  CONSTRAINT [DF_Answer_IsCorrect]  DEFAULT ((0)) FOR [IsCorrect]
GO

ALTER TABLE [dbo].[Answer] ADD  CONSTRAINT [DF_Answer_Active]  DEFAULT ((0)) FOR [Active]
GO

-- --------------------------------------------------------------------------------------
-- Create User Table
-- --------------------------------------------------------------------------------------
print 'Creating User Table'
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [varchar](250) NOT NULL,
	[FirstName] [varchar](250) NOT NULL,
	[LastName] [varchar](250) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

-- --------------------------------------------------------------------------------------
-- Create Quiz 'Header' Table
-- --------------------------------------------------------------------------------------
print 'Creating Quiz Table'
CREATE TABLE [dbo].[Quiz](
	[QuizId] [int] IDENTITY(1,1) NOT NULL,
	[Score] [decimal](18, 2) NOT NULL,
	[Grade] [char](1) NOT NULL,
	[DateStarted] [datetime] NOT NULL,
	[DateCompleted] [datetime] NOT NULL,
 CONSTRAINT [PK_UserQuiz] PRIMARY KEY CLUSTERED 
(
	[QuizId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- --------------------------------------------------------------------------------------
-- Create Quiz Detail Table
-- --------------------------------------------------------------------------------------
print 'Creating Quiz Detail Table'
CREATE TABLE [dbo].[QuizDetail](
	[QuizDetailId] [int] IDENTITY(1,1) NOT NULL,
	[QuizId] [int] NOT NULL,
	[QuestionNumber] [int] NOT NULL,
	[OrigQuestionId] [int] NOT NULL,
	[OrigQuestionDescr] [varchar](max) NOT NULL,
	[SelectedAnswerId] [int] NOT NULL,
	[SelectedAnswerDescr] [varchar](250) NOT NULL,
	[CorrectAnswerId] [int] NOT NULL,
	[CorrectAnswerDescr] [varchar](250) NOT NULL,
 CONSTRAINT [PK_UserQuizResult] PRIMARY KEY CLUSTERED 
(
	[QuizDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[QuizDetail]  WITH CHECK ADD  CONSTRAINT [FK_QuizDetail_Quiz] FOREIGN KEY([QuizId])
REFERENCES [dbo].[Quiz] ([QuizId])
GO

ALTER TABLE [dbo].[QuizDetail] CHECK CONSTRAINT [FK_QuizDetail_Quiz]
GO

ALTER TABLE [dbo].[QuizDetail]  WITH CHECK ADD  CONSTRAINT [FK_UserQuizResult_CorrectAnswer] FOREIGN KEY([CorrectAnswerId])
REFERENCES [dbo].[Answer] ([AnswerId])
GO

ALTER TABLE [dbo].[QuizDetail] CHECK CONSTRAINT [FK_UserQuizResult_CorrectAnswer]
GO

ALTER TABLE [dbo].[QuizDetail]  WITH CHECK ADD  CONSTRAINT [FK_UserQuizResult_Question] FOREIGN KEY([OrigQuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
GO

ALTER TABLE [dbo].[QuizDetail] CHECK CONSTRAINT [FK_UserQuizResult_Question]
GO

ALTER TABLE [dbo].[QuizDetail]  WITH CHECK ADD  CONSTRAINT [FK_UserQuizResult_SelectedAnswer] FOREIGN KEY([SelectedAnswerId])
REFERENCES [dbo].[Answer] ([AnswerId])
GO

ALTER TABLE [dbo].[QuizDetail] CHECK CONSTRAINT [FK_UserQuizResult_SelectedAnswer]
GO

-- --------------------------------------------------------------------------------------
-- Create User Quiz "link" Table
-- --------------------------------------------------------------------------------------
print 'Creating User Quiz Table'
CREATE TABLE [dbo].[UserQuiz](
	[UserId] [int] NOT NULL,
	[QuizId] [int] NOT NULL,
 CONSTRAINT [PK_UserQuiz_1] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[QuizId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[UserQuiz]  WITH CHECK ADD  CONSTRAINT [FK_UserQuiz_Quiz] FOREIGN KEY([QuizId])
REFERENCES [dbo].[Quiz] ([QuizId])
GO

ALTER TABLE [dbo].[UserQuiz] CHECK CONSTRAINT [FK_UserQuiz_Quiz]
GO

ALTER TABLE [dbo].[UserQuiz]  WITH CHECK ADD  CONSTRAINT [FK_UserQuiz_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO

ALTER TABLE [dbo].[UserQuiz] CHECK CONSTRAINT [FK_UserQuiz_User]
GO

-- --------------------------------------------------------------------------------------
-- Create Stored Procedures
-- --------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

print 'Creating hq_saveQuiz stored procedure';
GO

-- ======================================================================================
-- Author:		Danny Smith
-- Create date: 09/02/2021
-- Description: Saves a new Quiz record.
-- ======================================================================================
CREATE PROCEDURE [dbo].[hq_saveQuiz]
	(@userId int, @score decimal(18, 2), @grade char(1),
		@dateStarted datetime, @dateCompleted datetime,
		@quizId int output)
AS
begin

	-- Insert Quiz record...
	insert into dbo.Quiz
           (Score, Grade, DateStarted, DateCompleted)
	values
           (@score, @grade, @dateStarted, @dateCompleted)

	set @quizId = scope_identity();
	
	-- Insert USerQuiz record to relate quiz back to User...
	insert into dbo.UserQuiz
           (UserId, QuizId)
	values
           (@userId, @quizId)

end;
GO

print 'Creating hq_saveQuizDetail stored procedure';
GO

-- ======================================================================================
-- Author:		Danny Smith
-- Create date: 09/02/2021
-- Description: Saves a new Quiz Detail record.
-- ======================================================================================
create PROCEDURE [dbo].[hq_saveQuizDetail]
	(@quizId int, @questionNumber int, 
		@origQuestionId int, @origQuestionDescr varchar(max),
		@selectedAnswerId int, @selectedAnswerDescr varchar(max),
		@correctAnswerId int, @correctAnswerDescr varchar(max),
		@quizDetailId int output)
AS
begin

	insert into dbo.QuizDetail
           (QuizId, QuestionNumber, OrigQuestionId, OrigQuestionDescr,
				SelectedAnswerId, SelectedAnswerDescr,
				CorrectAnswerId, CorrectAnswerDescr)
	values
           (@quizId, @questionNumber, @origQuestionId, @origQuestionDescr,
				@selectedAnswerId, @selectedAnswerDescr,
				@correctAnswerId, @correctAnswerDescr)

	set @quizDetailId = scope_identity();
	
end;
GO