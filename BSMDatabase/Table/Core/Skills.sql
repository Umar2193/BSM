CREATE TABLE [bsm].[Skills]
(
	SkillsId INT IDENTITY(1,1),
	SkillsDescription VARCHAR(200),
	PeriodicityId INT,
	QMNumber VARCHAR(100),
	DepartmentId INT,
	SkillStatus BIT,
	CONSTRAINT PK_Skills_SkillsId PRIMARY KEY (SkillsId),
	CONSTRAINT FK_Periodicity_PeriodicityId_Skills_PeriodicityId FOREIGN KEY (PeriodicityId)
	REFERENCES bsm.Periodicity(PeriodicityId),
	CONSTRAINT FK_Department_DepartmentId_Skills_DepartmentId FOREIGN KEY (DepartmentId)
	REFERENCES bsm.Department(DepartmentId)
)
