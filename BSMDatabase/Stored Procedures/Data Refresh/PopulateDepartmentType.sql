/*
---------------------------------------------------------------------------
Name         : bsm.PopulateDepartmentType
---------------------------------------------------------------------------
Description  : populates PopulateDepartmentType table
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
CREATE PROC [bsm].[PopulateDepartmentType]
	
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100);

        DECLARE @departmentType TABLE
            (
                DepartmentTypeName VARCHAR(100)
            )
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;

         INSERT INTO @departmentType
            (
                DepartmentTypeName
            )

        SELECT 'Employee Department' UNION ALL
        SELECT 'Skills Department';

        INSERT INTO bsm.DepartmentType
            (
                DepartmentTypeName
            )
        SELECT
            v_departmentType.DepartmentTypeName
        FROM @departmentType AS v_departmentType
        LEFT JOIN bsm.DepartmentType AS t_departmentType
            ON v_departmentType.DepartmentTypeName = t_departmentType.DepartmentTypeName
        WHERE t_departmentType.DepartmentTypeName IS NULL;
                  
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




