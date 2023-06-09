USE [master]
GO
/****** Object:  Database [BSM]    Script Date: 13/09/2022 12:51:52 ******/
CREATE DATABASE [BSM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BSM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\BSM_Primary.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BSM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\BSM_Primary.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BSM] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BSM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BSM] SET ANSI_NULL_DEFAULT ON 
GO
ALTER DATABASE [BSM] SET ANSI_NULLS ON 
GO
ALTER DATABASE [BSM] SET ANSI_PADDING ON 
GO
ALTER DATABASE [BSM] SET ANSI_WARNINGS ON 
GO
ALTER DATABASE [BSM] SET ARITHABORT ON 
GO
ALTER DATABASE [BSM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BSM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BSM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BSM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BSM] SET CURSOR_DEFAULT  LOCAL 
GO
ALTER DATABASE [BSM] SET CONCAT_NULL_YIELDS_NULL ON 
GO
ALTER DATABASE [BSM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BSM] SET QUOTED_IDENTIFIER ON 
GO
ALTER DATABASE [BSM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BSM] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BSM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BSM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BSM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BSM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BSM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BSM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BSM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BSM] SET RECOVERY FULL 
GO
ALTER DATABASE [BSM] SET  MULTI_USER 
GO
ALTER DATABASE [BSM] SET PAGE_VERIFY NONE  
GO
ALTER DATABASE [BSM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BSM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BSM] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BSM] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BSM] SET QUERY_STORE = OFF
GO
USE [BSM]
GO
/****** Object:  Schema [bsm]    Script Date: 13/09/2022 12:51:52 ******/
CREATE SCHEMA [bsm]
GO
/****** Object:  Schema [staging]    Script Date: 13/09/2022 12:51:52 ******/
CREATE SCHEMA [staging]
GO
/****** Object:  Table [bsm].[AuditLog]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bsm].[AuditLog](
	[AuditLogId] [int] IDENTITY(1,1) NOT NULL,
	[ReviewerName] [varchar](100) NULL,
	[AuditDate] [date] NULL,
	[ActionTaken] [varchar](max) NULL,
	[Comments] [varchar](max) NULL,
 CONSTRAINT [PK_AuditLog_AuditLogId] PRIMARY KEY CLUSTERED 
(
	[AuditLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [bsm].[CurrentLoggedinUser]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bsm].[CurrentLoggedinUser](
	[LoggedInUser] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [bsm].[Department]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bsm].[Department](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [varchar](100) NULL,
	[DepartmentTypeId] [int] NULL,
	[DepartmrntStatus] [bit] NULL,
 CONSTRAINT [PK_Department_DepartmentId] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [bsm].[DepartmentType]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bsm].[DepartmentType](
	[DepartmentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentTypeName] [varchar](100) NULL,
 CONSTRAINT [PK_DepartmentType_DepartmentType] PRIMARY KEY CLUSTERED 
(
	[DepartmentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [bsm].[Employee]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bsm].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](200) NULL,
	[LastName] [varchar](200) NULL,
	[JobTitleId] [int] NULL,
	[DepartmentId] [int] NULL,
	[EmployeeStatus] [bit] NULL,
	[Username] [varchar](100) NULL,
	[Password] [varchar](100) NULL,
	[UserType] [int] NULL,
 CONSTRAINT [PK_Employee_EmployeeId] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [bsm].[EmployeeTraining]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bsm].[EmployeeTraining](
	[EmployeeTrainingId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NULL,
	[SkillsId] [int] NULL,
	[TrainingId] [int] NULL,
	[AcquiredOn] [smalldatetime] NULL,
	[ExpiresOn] [smalldatetime] NULL,
	[Completed] [bit] NULL,
	[CompletedTimestamp] [smalldatetime] NULL,
 CONSTRAINT [PK_EmployeeTraining_EmployeeTrainingId] PRIMARY KEY CLUSTERED 
(
	[EmployeeTrainingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [bsm].[JobTitle]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bsm].[JobTitle](
	[JobTitleId] [int] IDENTITY(1,1) NOT NULL,
	[JobTitleName] [varchar](100) NULL,
 CONSTRAINT [PK_JobTitle_TitleId] PRIMARY KEY CLUSTERED 
(
	[JobTitleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [bsm].[Periodicity]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bsm].[Periodicity](
	[PeriodicityId] [int] IDENTITY(1,1) NOT NULL,
	[PeriodicityName] [varchar](100) NULL,
 CONSTRAINT [PK_Periodicity_PeriodicityId] PRIMARY KEY CLUSTERED 
(
	[PeriodicityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [bsm].[Skills]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bsm].[Skills](
	[SkillsId] [int] IDENTITY(1,1) NOT NULL,
	[SkillsDescription] [varchar](200) NULL,
	[PeriodicityId] [int] NULL,
	[QMNumber] [varchar](100) NULL,
	[DepartmentId] [int] NULL,
	[SkillStatus] [bit] NULL,
 CONSTRAINT [PK_Skills_SkillsId] PRIMARY KEY CLUSTERED 
(
	[SkillsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [bsm].[Training]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bsm].[Training](
	[TrainingId] [int] IDENTITY(1,1) NOT NULL,
	[TrainingDescription] [varchar](100) NULL,
 CONSTRAINT [PK_Training_TrainingId] PRIMARY KEY CLUSTERED 
(
	[TrainingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[Department]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[Department](
	[DepartmentName] [varchar](100) NULL,
	[DepartmentTypeId] [int] NULL,
	[DepartmentStatus] [bit] NULL,
	[DepartmentTypeName] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[DepartmentType]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[DepartmentType](
	[DepartmentTypeName] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[Employee]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[Employee](
	[FirstName] [varchar](200) NULL,
	[LastName] [varchar](200) NULL,
	[JobTitleId] [int] NULL,
	[DepartmentId] [int] NULL,
	[EmployeeStatus] [bit] NULL,
	[JobTitle] [varchar](100) NULL,
	[Department] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[EmployeeTraining]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[EmployeeTraining](
	[EmployeeId] [int] NULL,
	[SkillsId] [int] NULL,
	[TrainingId] [int] NULL,
	[AcquiredOn] [smalldatetime] NULL,
	[ExpiresOn] [smalldatetime] NULL,
	[Skills] [varchar](100) NULL,
	[Training] [varchar](100) NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[JobTitle]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[JobTitle](
	[JobTitleName] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[Periodicity]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[Periodicity](
	[PeriodicityName] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[Skills]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[Skills](
	[SkillsDescription] [varchar](200) NULL,
	[PeriodicityId] [int] NULL,
	[QMNumber] [varchar](100) NULL,
	[DepartmentId] [int] NULL,
	[SkillStatus] [bit] NULL,
	[Periodicity] [varchar](100) NULL,
	[Department] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[Training]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[Training](
	[TrainingDescription] [varchar](100) NULL
) ON [PRIMARY]
GO
ALTER TABLE [bsm].[Department]  WITH NOCHECK ADD  CONSTRAINT [FK_DepartmentType_DepartmentTypeId_Department_DepartmentTypeId] FOREIGN KEY([DepartmentTypeId])
REFERENCES [bsm].[DepartmentType] ([DepartmentTypeId])
GO
ALTER TABLE [bsm].[Department] CHECK CONSTRAINT [FK_DepartmentType_DepartmentTypeId_Department_DepartmentTypeId]
GO
ALTER TABLE [bsm].[EmployeeTraining]  WITH NOCHECK ADD  CONSTRAINT [FK_Employee_EmployeeId_EmployeeTraining_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [bsm].[Employee] ([EmployeeId])
GO
ALTER TABLE [bsm].[EmployeeTraining] CHECK CONSTRAINT [FK_Employee_EmployeeId_EmployeeTraining_EmployeeId]
GO
ALTER TABLE [bsm].[EmployeeTraining]  WITH NOCHECK ADD  CONSTRAINT [FK_Skills_SkillsId_EmpTraining_SkillsId] FOREIGN KEY([SkillsId])
REFERENCES [bsm].[Skills] ([SkillsId])
GO
ALTER TABLE [bsm].[EmployeeTraining] CHECK CONSTRAINT [FK_Skills_SkillsId_EmpTraining_SkillsId]
GO
ALTER TABLE [bsm].[EmployeeTraining]  WITH NOCHECK ADD  CONSTRAINT [FK_Training_TrainingId_EmpTraining_TrainingId] FOREIGN KEY([TrainingId])
REFERENCES [bsm].[Training] ([TrainingId])
GO
ALTER TABLE [bsm].[EmployeeTraining] CHECK CONSTRAINT [FK_Training_TrainingId_EmpTraining_TrainingId]
GO
ALTER TABLE [bsm].[Skills]  WITH NOCHECK ADD  CONSTRAINT [FK_Department_DepartmentId_Skills_DepartmentId] FOREIGN KEY([DepartmentId])
REFERENCES [bsm].[Department] ([DepartmentId])
GO
ALTER TABLE [bsm].[Skills] CHECK CONSTRAINT [FK_Department_DepartmentId_Skills_DepartmentId]
GO
ALTER TABLE [bsm].[Skills]  WITH NOCHECK ADD  CONSTRAINT [FK_Periodicity_PeriodicityId_Skills_PeriodicityId] FOREIGN KEY([PeriodicityId])
REFERENCES [bsm].[Periodicity] ([PeriodicityId])
GO
ALTER TABLE [bsm].[Skills] CHECK CONSTRAINT [FK_Periodicity_PeriodicityId_Skills_PeriodicityId]
GO
/****** Object:  StoredProcedure [bsm].[AddCurrentLoggedInUser]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.AddCurrentLoggedInUser
---------------------------------------------------------------------------
Description  : Adds the current logged in user in the table. this enables tht audit log to be written
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 13/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[AddCurrentLoggedInUser]
	@userName VARCHAR(100)
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100);
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;
            TRUNCATE TABLE bsm.CurrentLoggedinUser;

            select @userName = SUBSTRING (@userName,CharIndex('\',@userName) + 1, LEN(@userName));

            INSERT INTO bsm.CurrentLoggedinUser
            SELECT @userName;
                  
    -- commit transaction opened in this proc
    COMMIT; 
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
/****** Object:  StoredProcedure [bsm].[GetExpirySheet]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.GetExpirySheet
---------------------------------------------------------------------------
Description  : gets expiry sheet
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 17/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[GetExpirySheet]
	    @searchDate VARCHAR(100) = NULL
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100),
        @date DATE;
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
    BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;

    
    SELECT @date = CASE 
                       WHEN @searchDate IS NULL
                       THEN
                            NULL
                        ELSE
                            CONVERT(DATETIME,@searchDate,103)
                        END;

    SELECT
	    t_employee.LastName + ' ' + t_employee.FirstName  +  ' - ' + t_jobTitle.JobTitleName  AS Employee,
	    t_skills.SkillsDescription AS Skill,
	    CONVERT(VARCHAR(12),t_employeeTraining.ExpiresOn,103) AS [Expiry Date]
    FROM bsm.EmployeeTraining AS t_employeeTraining
    INNER JOIN bsm.Employee AS t_employee
	    ON t_employeeTraining.EmployeeId = t_employee.EmployeeId
    INNER JOIN bsm.JobTitle AS t_jobTitle 
	    ON t_employee.JobTitleId = t_jobTitle.JobTitleId
    INNER JOIN bsm.Skills AS t_skills
	    ON t_employeeTraining.SkillsId = t_skills.SkillsId
    WHERE t_employeeTraining.ExpiresOn < = @date
    ORDER BY ExpiresOn DESC,
    t_employee.LastName;

    
                  
    -- commit transaction opened in this proc
    COMMIT; 
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
/****** Object:  StoredProcedure [bsm].[GetReviewSheet]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.GetReviewSheet
---------------------------------------------------------------------------
Description  : Gets the recored of review sheet
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 15/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[GetReviewSheet]
	@reviewerName VARCHAR(100) = NULL,
    @auditDate VARCHAR(100) = NULL
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100),
        @sql VARCHAR(MAX),
        @whereClause VARCHAR(MAX),
        @date DATE;
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;

        
        SELECT @date = CASE 
                       WHEN @auditDate IS NULL
                       THEN
                            NULL
                        ELSE
                            CONVERT(DATETIME,@auditDate,103)
                        END;

        SELECT @sql = 'SELECT
                            AuditLogId,
                            ReviewerName,
                            CONVERT(VARCHAR(12),AuditDate,103) AS AuditDate,
                            ActionTaken,
                            Comments
                        FROM bsm.AuditLog';

        IF @reviewerName IS NOT NULL AND @auditDate IS NOT NULL
        BEGIN
            SELECT @whereClause = ' WHERE ReviewerName LIKE ( ''%' + @reviewerName + '%'') AND AuditDate <= ''' + CAST(@date AS VARCHAR(50)) + '''';
        END;
        ELSE IF @reviewerName IS NOT NULL AND @auditDate IS NULL
        BEGIN
            SELECT @whereClause = ' WHERE ReviewerName LIKE (''%' + @reviewerName + '%'')';
        END;
        ELSE IF @reviewerName IS NULL AND @auditDate IS NOT NULL
        BEGIN
            SELECT @whereClause = ' WHERE AuditDate <= ''' + CAST(@date AS VARCHAR(50)) + '''';
        END;
        ELSE IF @reviewerName IS NULL AND @auditDate IS  NULL
        BEGIN
            SELECT @whereClause = '';
        END;

        SELECT @sql = @sql + @whereClause;

        EXEC(@sql);
    
            
    -- commit transaction opened in this proc
    COMMIT; 
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
/****** Object:  StoredProcedure [bsm].[GetTrainingMatrix]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.TrainingMatrix
---------------------------------------------------------------------------
Description  : Gets the Training Matrix
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 06/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[GetTrainingMatrix]
	@empDepartmentId INT,
    @jobTitleId INT
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100),
        @sqlStatement VARCHAR(MAX),
		@whereClause VARCHAR(MAX),
        @emptyTable BIT = 0;
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;

        IF @empDepartmentId != 0
        BEGIN
            SELECT @whereClause = ' WHERE t_empDepartment.DepartmentId =' +  CAST(@empDepartmentId AS VARCHAR(4))
        END;
        ELSE 
        BEGIN
            SELECT @emptyTable = 1
        END;
       
       IF @empDepartmentId != 0 AND @jobTitleId != 0
        BEGIN
            SELECT @whereClause = @whereClause +  ' AND t_jobTitle.JobTitleId =' +  CAST(@jobTitleId AS VARCHAR(4))
        END;


	   SELECT @sqlStatement = 'SELECT  DISTINCT
	        t_empDepartment.DepartmentName AS [Employee Department],
            t_employee.LastName  + '' '' + t_employee.FirstName   AS EmployeeName,
	        t_jobTitle.JobTitleName,
	        t_periodicity.PeriodicityName AS Periodicity,
	        t_skillsDepartment.DepartmentName AS [Skills Department],
	        t_skills.SkillsDescription AS Skill,
            t_skills.QMNumber,
	        t_training.TrainingDescription AS Training,
	        t_empTraining.ExpiresOn AS [Expiry Date],
            t_employee.LastName
        FROM bsm.EmployeeTraining AS t_empTraining
        INNER JOIN bsm.Employee AS t_employee
	        ON t_empTraining.EmployeeId = t_empTraining.EmployeeId
        INNER JOIN 
		        (
			        bsm.Department AS t_empDepartment
			        INNER JOIN bsm.DepartmentType AS t_empDepartmentType
				        ON t_empDepartment.DepartmentTypeId = t_empDepartmentType.DepartmentTypeId
				        AND t_empDepartmentType.DepartmentTypeName = ''Employee Department''
		        )
	        ON t_employee.DepartmentId = t_empDepartment.DepartmentId
        INNER JOIN bsm.JobTitle AS t_jobTitle 
	        ON t_employee.JobTitleId = t_jobTitle.JobTitleId
        INNER JOIN 
		        (
			        bsm.Skills AS t_skills
			        INNER JOIN bsm.Department AS t_skillsDepartment
				        ON t_skills.DepartmentId = t_skillsDepartment.DepartmentId
			        INNER JOIN bsm.DepartmentType AS t_skillDeptType
				        ON t_skillsDepartment.DepartmentTypeId = t_skillDeptType.DepartmentTypeId
				        AND t_skillDeptType.DepartmentTypeName = ''Skills Department''
			        INNER JOIN bsm.Periodicity AS t_periodicity
				        ON t_skills.PeriodicityId = t_periodicity.PeriodicityId
		        )
	        ON t_empTraining.SkillsId = t_skills.SkillsId
        INNER JOIN bsm.Training AS t_training
	        ON t_empTraining.TrainingId = t_training.TrainingId' + @whereClause + 
        'ORDER BY t_employee.LastName';

            IF @emptyTable = 1
            BEGIN
                SELECT
                    NULL AS [Employee Department],
                    NULL AS EmployeeName,
	                NULL AS JobTitleName,
	                NULL AS Periodicity,
	                NULL AS [Skills Department],
	                NULL AS Skill,
                    NULL AS QMNumber,
	                NULL AS Training,
	                NULL AS [Expiry Date]; 
            END;
            ELSE 
            BEGIN	    
                EXEC(@sqlStatement);
            END;
                  
    -- commit transaction opened in this proc
    COMMIT; 
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
/****** Object:  StoredProcedure [bsm].[GetTrainingReport]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.GetTrainingReport
---------------------------------------------------------------------------
Description  : adds the comment to the review sheet
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 16/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[GetTrainingReport]
	    @skillsId INT
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100);
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
            SELECT DISTINCT
				t_employee.LastName + ' ' + t_employee.FirstName  AS [Requires Training],
				t_employeeTraining.SkillsId,
				t_employee.LastName
			FROM bsm.EmployeeTraining AS t_employeeTraining
			INNER JOIN bsm.Training AS t_training
				ON t_employeeTraining.TrainingId = t_training.TrainingId
			INNER JOIN bsm.Employee AS t_employee
				ON t_employeeTraining.EmployeeId = t_employee.EmployeeId
			WHERE t_training.TrainingDescription = 'REQUIRES TRAINING'
			AND t_employeeTraining.SkillsId = @skillsId
			ORDER BY t_employee.LastName;

            SELECT DISTINCT
				t_employee.LastName + ' ' + t_employee.FirstName AS [Started Training],
				t_employeeTraining.SkillsId,
				t_employee.LastName
			FROM bsm.EmployeeTraining AS t_employeeTraining
			INNER JOIN bsm.Training AS t_training
				ON t_employeeTraining.TrainingId = t_training.TrainingId
			INNER JOIN bsm.Employee AS t_employee
				ON t_employeeTraining.EmployeeId = t_employee.EmployeeId
			WHERE t_training.TrainingDescription = 'STARTED TRAINING'
			AND t_employeeTraining.SkillsId = @skillsId
			ORDER BY t_employee.LastName;

            SELECT DISTINCT
				t_employee.LastName + ' ' + t_employee.FirstName AS [Competent to Complete Task],
				t_employeeTraining.SkillsId,
				t_employee.LastName
			FROM bsm.EmployeeTraining AS t_employeeTraining
			INNER JOIN bsm.Training AS t_training
				ON t_employeeTraining.TrainingId = t_training.TrainingId
			INNER JOIN bsm.Employee AS t_employee
				ON t_employeeTraining.EmployeeId = t_employee.EmployeeId
			WHERE t_training.TrainingDescription = 'COMPETENT / AUTHORISED'
			AND t_employeeTraining.SkillsId = @skillsId
			ORDER BY t_employee.LastName;

            SELECT DISTINCT
				t_employee.LastName + ' ' + t_employee.FirstName AS [Competent to Train Others],
				t_employeeTraining.SkillsId,
				t_employee.LastName
			FROM bsm.EmployeeTraining AS t_employeeTraining
			INNER JOIN bsm.Training AS t_training
				ON t_employeeTraining.TrainingId = t_training.TrainingId
			INNER JOIN bsm.Employee AS t_employee
				ON t_employeeTraining.EmployeeId = t_employee.EmployeeId
			WHERE t_training.TrainingDescription = 'AUTHORISED TO TRAIN'
			AND t_employeeTraining.SkillsId = @skillsId
			ORDER BY t_employee.LastName;
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT DISTINCT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
/****** Object:  StoredProcedure [bsm].[PopulateDepartment]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.PopulateDepartment
---------------------------------------------------------------------------
Description  : populates PopulateDepartment table
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 07/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[PopulateDepartment]
	
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100);
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;

         DELETE 
         FROM staging.Department
         WHERE DepartmentName IS NULL;

         UPDATE t_department SET
            DepartmentTypeId = t_departmentType.DepartmentTypeId
         FROM staging.Department AS t_department
         INNER JOIN bsm.DepartmentType AS t_departmentType
            ON t_department.DepartmentTypeName = t_departmentType.DepartmentTypeName;

        INSERT INTO bsm.Department
            (
                DepartmentName,
                DepartmentTypeId,
                DepartmrntStatus
            )
        SELECT 
            DepartmentName,
            DepartmentTypeId,
            DepartmentStatus
        FROM staging.Department;
                  
    -- commit transaction opened in this proc
    COMMIT; 
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
/****** Object:  StoredProcedure [bsm].[PopulateDepartmentType]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.PopulateDepartmentType
---------------------------------------------------------------------------
Description  : populates PopulateDepartmentType table
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 07/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[PopulateDepartmentType]
	
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100);

        DECLARE @departmentType TABLE
            (
                DepartmentTypeName VARCHAR(100)
            )
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;

         INSERT INTO @departmentType
            (
                DepartmentTypeName
            )

        SELECT 'Employee Department' UNION ALL
        SELECT 'Skills Department';

        INSERT INTO bsm.DepartmentType
            (
                DepartmentTypeName
            )
        SELECT
            v_departmentType.DepartmentTypeName
        FROM @departmentType AS v_departmentType
        LEFT JOIN bsm.DepartmentType AS t_departmentType
            ON v_departmentType.DepartmentTypeName = t_departmentType.DepartmentTypeName
        WHERE t_departmentType.DepartmentTypeName IS NULL;
                  
    -- commit transaction opened in this proc
    COMMIT; 
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
/****** Object:  StoredProcedure [bsm].[PopulateEmployee]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.PopulateEmployee
---------------------------------------------------------------------------
Description  : populates employee table
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 07/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[PopulateEmployee]
	
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100);
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;



    UPDATE t_employee SET
        DepartmentId = t_department.DepartmentId 
    FROM staging.Employee AS t_employee
    INNER JOIN bsm.Department AS t_department
        ON t_employee.Department = t_department.DepartmentName;

    UPDATE t_employee SET
        JobTitleId = t_jobTitle.JobTitleId
    FROM staging.Employee AS t_employee
    INNER JOIN bsm.JobTitle AS t_jobTitle
        ON t_employee.JobTitle = t_jobTitle.JobTitleName;

    DELETE 
    FROM staging.Employee
    WHERE DepartmentId IS NULL OR JobTitleId IS NULL;

    INSERT INTO bsm.Employee
        (
            FirstName,
            LastName,
            JobTitleId,
            DepartmentId,
            EmployeeStatus
        )

    SELECT 
        FirstName,
        LastName,
        JobTitleId,
        DepartmentId,
        EmployeeStatus
    FROM staging.Employee;
                  
    -- commit transaction opened in this proc
    COMMIT; 
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
/****** Object:  StoredProcedure [bsm].[PopulateEmployeeTraining]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.PopulateEmployeeTraining
---------------------------------------------------------------------------
Description  : populates employee training table
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 07/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[PopulateEmployeeTraining]
	
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100);
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;

    UPDATE staging.EmployeeTraining SET
        TrainingId = NULL,
        SkillsId = NULL,
        EmployeeId = NULL;
    
    UPDATE t_employeeTraining SET
        TrainingId = t_training.TrainingId
    FROM staging.EmployeeTraining AS t_employeeTraining
    INNER JOIN bsm.Training AS t_training
        ON t_employeeTraining.Training = t_training.TrainingDescription;

   UPDATE t_employeeTraining SET
        SkillsId = t_skills.SkillsId
    FROM staging.EmployeeTraining AS t_employeeTraining
    INNER JOIN bsm.Skills AS t_skills
        ON t_employeeTraining.Skills = t_skills.SkillsDescription;

    UPDATE t_employeeTraining SET
        EmployeeId = t_employee.EmployeeId
    FROM staging.EmployeeTraining AS t_employeeTraining
    INNER JOIN bsm.Employee AS t_employee
        ON t_employeeTraining.FirstName = t_employee.FirstName
        AND t_employeeTraining.LastName = t_employee.LastName;

    DELETE 
    FROM staging.EmployeeTraining
    WHERE EmployeeId IS NULL OR SkillsId IS NULL OR TrainingId IS NULL;

   INSERT INTO bsm.EmployeeTraining
        (
            EmployeeId,
            SkillsId,
            TrainingId,
            ExpiresOn
        )
    SELECT
        EmployeeId,
        SkillsId,
        TrainingId,
        ExpiresOn
    FROM staging.EmployeeTraining;
                  
    -- commit transaction opened in this proc
    COMMIT; 
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
/****** Object:  StoredProcedure [bsm].[PopulateJobTitle]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.PopulateJobTitle
---------------------------------------------------------------------------
Description  : populates JobTitle table
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 07/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[PopulateJobTitle]
	
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100);
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;

        INSERT INTO bsm.JobTitle
        (
            JobTitleName
        )
    SELECT 
        DISTINCT JobTitle
    FROM staging.Employee AS t_employee
    LEFT JOIN bsm.JobTitle AS t_jobTitle
        ON t_employee.JobTitle = t_jobTitle.JobTitleName
    WHERE t_jobTitle.JobTitleName IS NULL;
         DELETE
         FROM staging.JobTitle
         WHERE JobTitleName IS NULL;

         INSERT INTO bsm.JobTitle
            (
                JobTitleName
            )
         SELECT
            JobTitleName
         FROM staging.JobTitle;
                  
    -- commit transaction opened in this proc
    COMMIT; 
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
/****** Object:  StoredProcedure [bsm].[PopulatePeriodicity]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.PopulatePeriodicity
---------------------------------------------------------------------------
Description  : populates periodicity table
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 07/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[PopulatePeriodicity]
	
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100);
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;

         DELETE 
         FROM staging.Periodicity
         WHERE PeriodicityName IS NULL;

         INSERT INTO bsm.Periodicity
            (
                PeriodicityName
            )
        SELECT
            PeriodicityName
        FROM staging.Periodicity;
                  
    -- commit transaction opened in this proc
    COMMIT; 
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
/****** Object:  StoredProcedure [bsm].[PopulateSkills]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.PopulateSkills
---------------------------------------------------------------------------
Description  : populates skills table
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 07/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[PopulateSkills]
	
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100);
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;

    UPDATE t_stgSkills SET
        DepartmentId = t_department.DepartmentId 
    FROM staging.Skills AS t_stgSkills
    INNER JOIN bsm.Department AS t_department
        ON t_stgSkills.Department = t_department.DepartmentName;

    UPDATE t_stgSkills SET
        PeriodicityId = t_periodicity.PeriodicityId
    FROM staging.Skills AS t_stgSkills
    INNER JOIN bsm.Periodicity AS t_periodicity
        ON t_stgSkills.Periodicity = t_periodicity.PeriodicityName;

    DELETE 
    FROM staging.Skills
    WHERE DepartmentId IS NULL OR PeriodicityId IS NULL;

    INSERT INTO bsm.Skills
        (
            SkillsDescription,
            PeriodicityId,
            QMNumber,
            DepartmentId,
            SkillStatus
        )
    SELECT
        SkillsDescription,
        PeriodicityId,
        QMNumber,
        DepartmentId,
        SkillStatus
    FROM staging.Skills;
                  
    -- commit transaction opened in this proc
    COMMIT; 
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
/****** Object:  StoredProcedure [bsm].[PopulateTraining]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.PopulateTraining
---------------------------------------------------------------------------
Description  : populates Training table
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 07/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[PopulateTraining]
	
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100);
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;

         DELETE
         FROM staging.Training
         WHERE TrainingDescription IS NULL;

         INSERT INTO bsm.Training
            (
                TrainingDescription
            )
         SELECT
            TrainingDescription
         FROM staging.Training;
                  
    -- commit transaction opened in this proc
    COMMIT; 
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
/****** Object:  StoredProcedure [bsm].[RefreshData]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.RefreshData
---------------------------------------------------------------------------
Description  : Refreshes the data in the tables 
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 07/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[RefreshData]
	
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100);
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
 

         PRINT 'Populateing department type .............'
            EXEC bsm.PopulateDepartmentType;

         PRINT 'Populating job titile ...................'
            EXEC bsm.PopulateJobTitle;

        PRINT 'populating periodicity....................'
            EXEC bsm.PopulatePeriodicity;

        PRINT 'Populating training.......................'
            EXEC bsm.PopulateTraining;

        PRINT 'Populating department.....................'
            EXEC bsm.PopulateDepartment;

        PRINT 'Populating skills.........................'
            EXEC bsm.PopulateSkills;

        PRINT 'Populating employee.......................'
            EXEC bsm.PopulateEmployee;

        PRINT 'Populating employee training..............'
            EXEC bsm.PopulateEmployeeTraining;
                  
    -- commit transaction opened in this proc

            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc

    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
/****** Object:  StoredProcedure [bsm].[TruncateTables]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.TruncateTables
---------------------------------------------------------------------------
Description  : Truncates staging tables
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 07/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[TruncateTables]
	
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100);
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;

    TRUNCATE TABLE staging.Department;
    TRUNCATE TABLE staging.DepartmentType;
    TRUNCATE TABLE staging.Employee;
    TRUNCATE TABLE staging.EmployeeTraining;
    TRUNCATE TABLE staging.JobTitle;
    TRUNCATE TABLE staging.Periodicity;
    TRUNCATE TABLE staging.Skills;
    TRUNCATE TABLE staging.Training;
                  
    -- commit transaction opened in this proc
    COMMIT; 
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
/****** Object:  StoredProcedure [bsm].[UpdateReviewSheet]    Script Date: 13/09/2022 12:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
---------------------------------------------------------------------------
Name         : bsm.UpdateReviewSheet
---------------------------------------------------------------------------
Description  : adds the comment to the review sheet
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 16/06/2020 by  Ali Shah 
---------------------------------------------------------------------------
Changes   ** : dd/mm/yyyy by *** (***) TFS ***
               - ***
---------------------------------------------------------------------------
Return Value : Value/Type       Description
             :              
---------------------------------------------------------------------------
Notes        : ***
---------------------------------------------------------------------------
*/
CREATE PROC [bsm].[UpdateReviewSheet]
	@auditLogId VARCHAR(10),
    @comment VARCHAR(MAX)
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100);
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;
            UPDATE bsm.AuditLog SET Comments = @comment
            WHERE AuditLogId = CAST(@auditLogId AS INT);

            
                  
    -- commit transaction opened in this proc
    COMMIT; 
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END
GO
USE [master]
GO
ALTER DATABASE [BSM] SET  READ_WRITE 
GO
