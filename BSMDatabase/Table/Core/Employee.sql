CREATE TABLE [bsm].[Employee]
(
	EmployeeId INT IDENTITY (1,1),
	FirstName VARCHAR(200),
	LastName VARCHAR(200),
	JobTitleId INT, 
	DepartmentId INT,
	EmployeeStatus BIT,
    CONSTRAINT PK_Employee_EmployeeId PRIMARY KEY (EmployeeId),
	CONSTRAINT FK_JobTitle_JobTitleId_Employee_JobTitleId FOREIGN KEY (JobTitleId)
	REFERENCES bsm.JobTitle(JobTitleId),
	CONSTRAINT FK_Department_DepartmentId_Employee_DepartmentId FOREIGN KEY (DepartmentId)
	REFERENCES bsm.Department(DepartmentId)
) 
