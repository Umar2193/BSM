/*
---------------------------------------------------------------------------
Name         : bsm.PopulateEmployee
---------------------------------------------------------------------------
Description  : populates employee table
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 07/06/2020 by  Ali Shah 
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
CREATE PROC [bsm].[PopulateEmployee]
	
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100);
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;



    UPDATE t_employee SET
        DepartmentId = t_department.DepartmentId 
    FROM staging.Employee AS t_employee
    INNER JOIN bsm.Department AS t_department
        ON t_employee.Department = t_department.DepartmentName;

    UPDATE t_employee SET
        JobTitleId = t_jobTitle.JobTitleId
    FROM staging.Employee AS t_employee
    INNER JOIN bsm.JobTitle AS t_jobTitle
        ON t_employee.JobTitle = t_jobTitle.JobTitleName;

    DELETE 
    FROM staging.Employee
    WHERE DepartmentId IS NULL OR JobTitleId IS NULL;

    INSERT INTO bsm.Employee
        (
            FirstName,
            LastName,
            JobTitleId,
            DepartmentId,
            EmployeeStatus
        )

    SELECT 
        FirstName,
        LastName,
        JobTitleId,
        DepartmentId,
        EmployeeStatus
    FROM staging.Employee;
                  
    -- commit transaction opened in this proc
    COMMIT; 
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT 
            @objectName= OBJECT_NAME(@@PROCID),
            @errorMessage = ERROR_MESSAGE(),
            @errorSeverity = ERROR_SEVERITY(),
            @errorState = ERROR_STATE();
                  
            RAISERROR 
                (
                        @errorMessage, -- Message Text
                        @errorSeverity, -- Error Severity
                        @errorState    -- Error State
                );
END CATCH
 
      
          --------------------------------------------------
      PRINT(CONCAT('End : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @@TRANCOUNT));
      RETURN @returnValue;
END



