/*
---------------------------------------------------------------------------
Name         : bsm.GetTrainingReport
---------------------------------------------------------------------------
Description  : adds the comment to the review sheet
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 16/06/2020 by  Ali Shah 
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
CREATE PROC [bsm].[GetTrainingReport]
	    @skillsId INT
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
            SELECT DISTINCT
				t_employee.LastName + ' ' + t_employee.FirstName  AS [Requires Training],
				t_employeeTraining.SkillsId,
				t_employee.LastName
			FROM bsm.EmployeeTraining AS t_employeeTraining
			INNER JOIN bsm.Training AS t_training
				ON t_employeeTraining.TrainingId = t_training.TrainingId
			INNER JOIN bsm.Employee AS t_employee
				ON t_employeeTraining.EmployeeId = t_employee.EmployeeId
			WHERE t_training.TrainingDescription = 'REQUIRES TRAINING'
			AND t_employeeTraining.SkillsId = @skillsId
			ORDER BY t_employee.LastName;

            SELECT DISTINCT
				t_employee.LastName + ' ' + t_employee.FirstName AS [Started Training],
				t_employeeTraining.SkillsId,
				t_employee.LastName
			FROM bsm.EmployeeTraining AS t_employeeTraining
			INNER JOIN bsm.Training AS t_training
				ON t_employeeTraining.TrainingId = t_training.TrainingId
			INNER JOIN bsm.Employee AS t_employee
				ON t_employeeTraining.EmployeeId = t_employee.EmployeeId
			WHERE t_training.TrainingDescription = 'STARTED TRAINING'
			AND t_employeeTraining.SkillsId = @skillsId
			ORDER BY t_employee.LastName;

            SELECT DISTINCT
				t_employee.LastName + ' ' + t_employee.FirstName AS [Competent to Complete Task],
				t_employeeTraining.SkillsId,
				t_employee.LastName
			FROM bsm.EmployeeTraining AS t_employeeTraining
			INNER JOIN bsm.Training AS t_training
				ON t_employeeTraining.TrainingId = t_training.TrainingId
			INNER JOIN bsm.Employee AS t_employee
				ON t_employeeTraining.EmployeeId = t_employee.EmployeeId
			WHERE t_training.TrainingDescription = 'COMPETENT / AUTHORISED'
			AND t_employeeTraining.SkillsId = @skillsId
			ORDER BY t_employee.LastName;

            SELECT DISTINCT
				t_employee.LastName + ' ' + t_employee.FirstName AS [Competent to Train Others],
				t_employeeTraining.SkillsId,
				t_employee.LastName
			FROM bsm.EmployeeTraining AS t_employeeTraining
			INNER JOIN bsm.Training AS t_training
				ON t_employeeTraining.TrainingId = t_training.TrainingId
			INNER JOIN bsm.Employee AS t_employee
				ON t_employeeTraining.EmployeeId = t_employee.EmployeeId
			WHERE t_training.TrainingDescription = 'AUTHORISED TO TRAIN'
			AND t_employeeTraining.SkillsId = @skillsId
			ORDER BY t_employee.LastName;
            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc
    ROLLBACK;
    SELECT DISTINCT 
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


