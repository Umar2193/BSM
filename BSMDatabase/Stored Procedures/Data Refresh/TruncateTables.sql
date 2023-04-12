/*
---------------------------------------------------------------------------
Name         : bsm.TruncateTables
---------------------------------------------------------------------------
Description  : Truncates staging tables
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
CREATE PROC [bsm].[TruncateTables]
	
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

    TRUNCATE TABLE staging.Department;
    TRUNCATE TABLE staging.DepartmentType;
    TRUNCATE TABLE staging.Employee;
    TRUNCATE TABLE staging.EmployeeTraining;
    TRUNCATE TABLE staging.JobTitle;
    TRUNCATE TABLE staging.Periodicity;
    TRUNCATE TABLE staging.Skills;
    TRUNCATE TABLE staging.Training;
                  
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

