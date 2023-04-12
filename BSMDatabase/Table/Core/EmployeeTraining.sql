CREATE TABLE [bsm].[EmployeeTraining]
(
	EmployeeTrainingId INT IDENTITY(1,1),
	EmployeeId INT,
	SkillsId INT,
	TrainingId INT,
	AcquiredOn SMALLDATETIME,
	ExpiresOn SMALLDATETIME,
	CONSTRAINT PK_EmployeeTraining_EmployeeTrainingId PRIMARY KEY (EmployeeTrainingId),
	CONSTRAINT FK_Employee_EmployeeId_EmployeeTraining_EmployeeId FOREIGN KEY (EmployeeId)
	REFERENCES bsm.Employee(EmployeeId),
	CONSTRAINT FK_Skills_SkillsId_EmpTraining_SkillsId FOREIGN KEY (SkillsId)
	REFERENCES bsm.Skills(SkillsId),
	CONSTRAINT FK_Training_TrainingId_EmpTraining_TrainingId FOREIGN KEY (TrainingId)
	REFERENCES bsm.Training(TrainingId)
)
