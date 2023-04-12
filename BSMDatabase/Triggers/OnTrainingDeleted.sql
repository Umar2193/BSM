/*
---------------------------------------------------------------------------
Name         : bsm.OnTrainingDeleted
---------------------------------------------------------------------------
Description  : Creates the audit entry when a training is deleted
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
CREATE TRIGGER bsm.OnTrainingDeleted
   ON  bsm.EmployeeTraining
   AFTER DELETE
AS 
BEGIN	
	SET NOCOUNT ON;

    DECLARE @trainingId INT,
			@jobTitleId INT,
			@employeeId INT,
			@skillsId INT,
			@skillsDeptId INT,
			@trainingName VARCHAR(100),
			@jobTitle VARCHAR(100),
			@userName VARCHAR(100),
			@employeeName VARCHAR(100),
			@skillsName VARCHAR(200),
			@skillsDeptName VARCHAR(50),
			@actionString VARCHAR(MAX),
			@dateAdded SMALLDATETIME ;

	SELECT
		@userName = LoggedInUser
	FROM bsm.CurrentLoggedinUser;
	
	SELECT
		@employeeId = EmployeeId
	FROM deleted;

	SELECT
		@trainingId = TrainingId
	FROM deleted;

	SELECT
		@jobTitleId = JobTitleId
	FROM bsm.Employee AS t_employee
	WHERE EmployeeId = @employeeId;

	SELECT
		@skillsId = SkillsId
	FROM deleted;

	SELECT
		@skillsDeptId = DepartmentId
	FROM bsm.Skills
	WHERE SkillsId = @skillsId;

	SELECT
		@skillsName = ISNULL(SkillsDescription,'')
	FROM bsm.Skills
	WHERE SkillsId = @skillsId;

	SELECT
		@employeeName = FirstName + ' ' + LastName
	FROM bsm.Employee
	WHERE EmployeeId = @employeeId;

	SELECT 
		@trainingName = ISNULL(TrainingDescription,'')
	FROM bsm.Training
	WHERE TrainingId = @trainingId;

	SELECT
		@jobTitle = ISNULL(JobTitleName,'')
	FROM bsm.JobTitle
	WHERE JobTitleId = @jobTitleId;

	SELECT
		@skillsDeptName = ISNULL(DepartmentName,'')
	FROM bsm.Department
	WHERE DepartmentId = @skillsDeptId;

	SELECT @actionString = 'Deleted ''' + @trainingName + ' for Dept ' + @skillsDeptName + ' - ' + @skillsName + ' for Employee: ' + @jobTitle + ' (' + @employeeName + ')';

	SELECT @dateAdded = GETUTCDATE();
	
	INSERT INTO bsm.AuditLog
			(
				ReviewerName,
				AuditDate,
				ActionTaken
			)

	SELECT
		@userName,
		@dateAdded,
		@actionString;


END

