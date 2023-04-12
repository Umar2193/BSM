/*
---------------------------------------------------------------------------
Name         : bsm.OnEmployeeUpdated
---------------------------------------------------------------------------
Description  : Creates the audit entry when a new employee is updated
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
CREATE TRIGGER bsm.OnEmployeeUpdated
   ON  bsm.Employee
   AFTER UPDATE
AS 
BEGIN	
	SET NOCOUNT ON;

    DECLARE @oldFirstName VARCHAR(100),
			@newFirstName VARCHAR(100),
			@oldLastName VARCHAR(100),
			@newLastName VARCHAR(100),
			@oldIsActive BIT,
			@newIsActive BIT,
			@oldJobTitleId INT,
			@newJobTitleId INT,			
			@oldDepartmentId INT,
			@newDepartmentId INT,
			@oldJobTitle VARCHAR(100),
			@newJobTitle VARCHAR(100),
			@oldDepartmentName VARCHAR(100),
			@newDepartmentName VARCHAR(100),
			@userName VARCHAR(100),
			@oldEmployeeName VARCHAR(100),
			@newEmployeeName VARCHAR(100),
			@actionString VARCHAR(MAX),
			@dateAdded SMALLDATETIME ;

	SELECT
		@userName = LoggedInUser
	FROM bsm.CurrentLoggedinUser;

/*start: employee name chage*/
	SELECT 
		@oldFirstName = FirstName
	FROM deleted;

	SELECT 
		@newFirstName = FirstName
	FROM inserted;

	SELECT 
		@oldLastName = LastName
	FROM deleted;

	SELECT 
		@newLastName = LastName
	FROM inserted;

	SELECT @oldEmployeeName = @oldFirstName + @oldLastName;

	SELECT @newEmployeeName = @newFirstName + @newLastName;

	If @oldEmployeeName <> @newEmployeeName
	BEGIN
	
		SELECT @actionString = 'Changed employee name from''' + @oldEmployeeName + ' to ' + @newEmployeeName;


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
/*end: employee name chage*/

/*start: employee status*/
	SELECT
		@oldIsActive = EmployeeStatus
	FROM deleted;

	SELECT
		@newIsActive = EmployeeStatus
	FROM inserted;

	IF @oldIsActive <> @newIsActive
	BEGIN
			SELECT @actionString = CASE @oldIsActive
										WHEN 
											1
										THEN
											'Changed employee ' + @newEmployeeName + ' status from Active to Inactive'
										ELSE
											'Changed employee ' + @newEmployeeName + ' status from Inactie to Active'
								   END;
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
/*end: employee status*/

/*start: job title */
	SELECT
		@oldJobTitleId = JobTitleId
	FROM deleted;

	SELECT
		@newJobTitleId = JobTitleId
	FROM inserted;

	SELECT
		@oldJobTitle = ISNULL(JobTitleName,'')
	FROM bsm.JobTitle
	WHERE JobTitleId = @oldJobTitleId;

	SELECT
		@newJobTitle = ISNULL(JobTitleName,'')
	FROM bsm.JobTitle
	WHERE JobTitleId = @newJobTitleId;

	IF @oldJobTitleId <> @newJobTitleId
	BEGIN
	
		SELECT @actionString = 'Changed employee ' + @newEmployeeName + ' jobtitle from' + @oldJobTitle + ' to ' + @newJobTitle;


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
/*end: job title*/

/*start: department*/

	SELECT
		@oldDepartmentId = DepartmentId
	FROM deleted;

	SELECT
		@newDepartmentId = DepartmentId
	FROM inserted;
	
	SELECT
		@oldDepartmentName = ISNULL(DepartmentName,'')
	FROM bsm.Department
	WHERE DepartmentId = @oldDepartmentId;

	SELECT
		@newDepartmentName = ISNULL(DepartmentName,'')
	FROM bsm.Department
	WHERE DepartmentId = @newDepartmentId;

	IF @oldDepartmentId <> @newDepartmentId
	BEGIN

	SELECT @actionString = 'Changed employee ' + @newEmployeeName + ' department from' + @oldDepartmentName + ' to ' + @newDepartmentName;


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

END



