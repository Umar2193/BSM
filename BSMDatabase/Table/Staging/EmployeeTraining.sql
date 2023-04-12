CREATE TABLE [staging].[EmployeeTraining]
(
	EmployeeId INT,
	SkillsId INT,
	TrainingId INT,
	AcquiredOn SMALLDATETIME,
	ExpiresOn SMALLDATETIME,
	Skills VARCHAR(100),
	Training VARCHAR(100),
	FirstName VARCHAR(100),
	LastName VARCHAR(100)
)
