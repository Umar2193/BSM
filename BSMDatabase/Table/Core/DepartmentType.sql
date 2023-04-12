CREATE TABLE [bsm].[DepartmentType]
(
	DepartmentTypeId INT IDENTITY (1,1),
	DepartmentTypeName VARCHAR(100),
    CONSTRAINT PK_DepartmentType_DepartmentType PRIMARY KEY (DepartmentTypeId)
)
