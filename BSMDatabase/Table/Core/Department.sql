CREATE TABLE [bsm].[Department]
(
	DepartmentId INT IDENTITY (1,1),
	DepartmentName VARCHAR(100),
	DepartmentTypeId INT,
	DepartmrntStatus BIT,
    CONSTRAINT PK_Department_DepartmentId PRIMARY KEY (DepartmentId),
	CONSTRAINT FK_DepartmentType_DepartmentTypeId_Department_DepartmentTypeId FOREIGN KEY (DepartmentTypeId)
	REFERENCES bsm.DepartmentType (DepartmentTypeId)
)
