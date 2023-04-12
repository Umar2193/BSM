/*
---------------------------------------------------------------------------
Name         : bsm.OnEmployeeAdded
---------------------------------------------------------------------------
Description  : Creates the audit entry when a new employee is added
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
CREATE TRIGGER bsm.OnEmployeeAdded
   ON  bsm.Employee
   AFTER INSERT
AS 
BEGIN	
	SET NOCOUNT ON;

    DECLARE @jobTitleId INT,
			@departmentId INT,
			@jobTitle VARCHAR(100),
			@departmentName VARCHAR(100),
			@userName VARCHAR(100),
			@employeeName VARCHAR(100),
			@actionString VARCHAR(MAX),
			@dateAdded SMALLDATETIME ;

	SELECT
		@userName = LoggedInUser
	FROM bsm.CurrentLoggedinUser;

	SELECT
		@jobTitleId = JobTitleId
	FROM inserted;

	SELECT
		@departmentId = DepartmentId
	FROM inserted;

	SELECT
		@employeeName = FirstName + ' ' + LastName
	FROM inserted;

	SELECT
		@jobTitle = ISNULL(JobTitleName,'')
	FROM bsm.JobTitle
	WHERE JobTitleId = @jobTitleId;

	SELECT
		@departmentName = ISNULL(DepartmentName,'')
	FROM bsm.Department
	WHERE DepartmentId = @departmentId;

	SELECT @actionString = 'Added new employee: ''' + @employeeName + ' Job title: ' + @jobTitle + ', Department: ' + @departmentName;


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


