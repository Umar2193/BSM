/*
---------------------------------------------------------------------------
Name         : bsm.OnTrainingEdited
---------------------------------------------------------------------------
Description  : Creates the audit entry when a training is Edited
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
CREATE TRIGGER bsm.OnTrainingEdited
   ON  bsm.EmployeeTraining
   AFTER UPDATE
AS 
BEGIN	
	SET NOCOUNT ON;

    DECLARE @oldTrainingId INT,
			@newTrainingId INT,
			@jobTitleId INT,
			@employeeId INT,
			@oldSkillsId INT,
			@newSkillsId INT,
			@oldSkillsDeptId INT,
			@newSkillsDeptId INT,
			@oldTrainingName VARCHAR(100),
			@newTrainingName VARCHAR(100),
			@jobTitle VARCHAR(100),
			@userName VARCHAR(100),
			@employeeName VARCHAR(100),
			@oldSkillsName VARCHAR(200),
			@newSkillsName VARCHAR(200),
			@oldSkillsDeptName VARCHAR(50),
			@newSkillsDeptName VARCHAR(50),
			@actionString VARCHAR(MAX),
			@dateAdded SMALLDATETIME ;

	SELECT
		@userName = LoggedInUser
	FROM bsm.CurrentLoggedinUser;
	
	SELECT
		@employeeId = EmployeeId
	FROM deleted;

	SELECT
		@oldTrainingId = TrainingId
	FROM deleted;

	SELECT
		@newTrainingId = TrainingId
	FROM inserted;

	SELECT
		@jobTitleId = JobTitleId
	FROM bsm.Employee AS t_employee
	WHERE EmployeeId = @employeeId;

	SELECT
		@oldSkillsId = SkillsId
	FROM deleted;

	SELECT
		@newSkillsId = SkillsId
	FROM inserted;

	SELECT
		@oldSkillsDeptId = DepartmentId
	FROM bsm.Skills
	WHERE SkillsId = @oldSkillsId;

	SELECT
		@newSkillsDeptId = DepartmentId
	FROM bsm.Skills
	WHERE SkillsId = @newSkillsId;

	SELECT
		@oldskillsName = ISNULL(SkillsDescription,'')
	FROM bsm.Skills
	WHERE SkillsId = @oldskillsId;

	SELECT
		@newskillsName = ISNULL(SkillsDescription,'')
	FROM bsm.Skills
	WHERE SkillsId = @newskillsId;

	SELECT
		@employeeName = FirstName + ' ' + LastName
	FROM bsm.Employee
	WHERE EmployeeId = @employeeId;

	SELECT 
		@oldTrainingName = ISNULL(TrainingDescription,'')
	FROM bsm.Training
	WHERE TrainingId = @oldTrainingId;

	SELECT 
		@newTrainingName = ISNULL(TrainingDescription,'')
	FROM bsm.Training
	WHERE TrainingId = @newTrainingId;

	SELECT
		@jobTitle = ISNULL(JobTitleName,'')
	FROM bsm.JobTitle
	WHERE JobTitleId = @jobTitleId;

	SELECT
		@oldSkillsDeptName = ISNULL(DepartmentName,'')
	FROM bsm.Department
	WHERE DepartmentId = @oldSkillsDeptId;

	IF @oldSkillsId <> @newSkillsId
	BEGIN

	SELECT @actionString = 'Changed Skill from ''' + @oldSkillsName + ' for Dept ' + @oldSkillsDeptName  + 
						  + ' to  Dept ' + @newSkillsDeptName  + ' - ' + @newSkillsName + ' for Employee: ' + @jobTitle + ' (' + @employeeName + ')';

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
	END;

	IF @oldTrainingId <> @newTrainingId
	BEGIN

	SELECT @actionString = 'Changed training from ''' + @oldTrainingName + ' for Dept ' + @oldSkillsDeptName  + 
						  + ' to  training ' + @newTrainingName  + ' - ' + @newSkillsName + ' for Employee: ' + @jobTitle + ' (' + @employeeName + ')';

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


END

