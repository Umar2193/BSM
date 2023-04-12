/*
---------------------------------------------------------------------------
Name         : bsm.PopulateEmployeeTraining
---------------------------------------------------------------------------
Description  : populates employee training table
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
CREATE PROC [bsm].[PopulateEmployeeTraining]
	
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

    UPDATE staging.EmployeeTraining SET
        TrainingId = NULL,
        SkillsId = NULL,
        EmployeeId = NULL;
    
    UPDATE t_employeeTraining SET
        TrainingId = t_training.TrainingId
    FROM staging.EmployeeTraining AS t_employeeTraining
    INNER JOIN bsm.Training AS t_training
        ON t_employeeTraining.Training = t_training.TrainingDescription;

   UPDATE t_employeeTraining SET
        SkillsId = t_skills.SkillsId
    FROM staging.EmployeeTraining AS t_employeeTraining
    INNER JOIN bsm.Skills AS t_skills
        ON t_employeeTraining.Skills = t_skills.SkillsDescription;

    UPDATE t_employeeTraining SET
        EmployeeId = t_employee.EmployeeId
    FROM staging.EmployeeTraining AS t_employeeTraining
    INNER JOIN bsm.Employee AS t_employee
        ON t_employeeTraining.FirstName = t_employee.FirstName
        AND t_employeeTraining.LastName = t_employee.LastName;

    DELETE 
    FROM staging.EmployeeTraining
    WHERE EmployeeId IS NULL OR SkillsId IS NULL OR TrainingId IS NULL;

   INSERT INTO bsm.EmployeeTraining
        (
            EmployeeId,
            SkillsId,
            TrainingId,
            ExpiresOn
        )
    SELECT
        EmployeeId,
        SkillsId,
        TrainingId,
        ExpiresOn
    FROM staging.EmployeeTraining;
                  
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




