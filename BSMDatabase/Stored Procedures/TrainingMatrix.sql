/*
---------------------------------------------------------------------------
Name         : bsm.TrainingMatrix
---------------------------------------------------------------------------
Description  : Gets the Training Matrix
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 06/06/2020 by  Ali Shah 
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
CREATE PROC [bsm].[GetTrainingMatrix]
	@empDepartmentId INT,
    @jobTitleId INT
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100),
        @sqlStatement VARCHAR(MAX),
		@whereClause VARCHAR(MAX),
        @emptyTable BIT = 0;
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;

        IF @empDepartmentId != 0
        BEGIN
            SELECT @whereClause = ' WHERE t_empDepartment.DepartmentId =' +  CAST(@empDepartmentId AS VARCHAR(4))
        END;
        ELSE 
        BEGIN
            SELECT @emptyTable = 1
        END;
       
       IF @empDepartmentId != 0 AND @jobTitleId != 0
        BEGIN
            SELECT @whereClause = @whereClause +  ' AND t_jobTitle.JobTitleId =' +  CAST(@jobTitleId AS VARCHAR(4))
        END;


	   SELECT @sqlStatement = 'SELECT  DISTINCT
	        t_empDepartment.DepartmentName AS [Employee Department],
            t_employee.LastName  + '' '' + t_employee.FirstName   AS EmployeeName,
	        t_jobTitle.JobTitleName,
	        t_periodicity.PeriodicityName AS Periodicity,
	        t_skillsDepartment.DepartmentName AS [Skills Department],
	        t_skills.SkillsDescription AS Skill,
            t_skills.QMNumber,
	        t_training.TrainingDescription AS Training,
	        t_empTraining.ExpiresOn AS [Expiry Date],
            t_employee.LastName
        FROM bsm.EmployeeTraining AS t_empTraining
        INNER JOIN bsm.Employee AS t_employee
	        ON t_empTraining.EmployeeId = t_empTraining.EmployeeId
        INNER JOIN 
		        (
			        bsm.Department AS t_empDepartment
			        INNER JOIN bsm.DepartmentType AS t_empDepartmentType
				        ON t_empDepartment.DepartmentTypeId = t_empDepartmentType.DepartmentTypeId
				        AND t_empDepartmentType.DepartmentTypeName = ''Employee Department''
		        )
	        ON t_employee.DepartmentId = t_empDepartment.DepartmentId
        INNER JOIN bsm.JobTitle AS t_jobTitle 
	        ON t_employee.JobTitleId = t_jobTitle.JobTitleId
        INNER JOIN 
		        (
			        bsm.Skills AS t_skills
			        INNER JOIN bsm.Department AS t_skillsDepartment
				        ON t_skills.DepartmentId = t_skillsDepartment.DepartmentId
			        INNER JOIN bsm.DepartmentType AS t_skillDeptType
				        ON t_skillsDepartment.DepartmentTypeId = t_skillDeptType.DepartmentTypeId
				        AND t_skillDeptType.DepartmentTypeName = ''Skills Department''
			        INNER JOIN bsm.Periodicity AS t_periodicity
				        ON t_skills.PeriodicityId = t_periodicity.PeriodicityId
		        )
	        ON t_empTraining.SkillsId = t_skills.SkillsId
        INNER JOIN bsm.Training AS t_training
	        ON t_empTraining.TrainingId = t_training.TrainingId' + @whereClause + 
        'ORDER BY t_employee.LastName';

            IF @emptyTable = 1
            BEGIN
                SELECT
                    NULL AS [Employee Department],
                    NULL AS EmployeeName,
	                NULL AS JobTitleName,
	                NULL AS Periodicity,
	                NULL AS [Skills Department],
	                NULL AS Skill,
                    NULL AS QMNumber,
	                NULL AS Training,
	                NULL AS [Expiry Date]; 
            END;
            ELSE 
            BEGIN	    
                EXEC(@sqlStatement);
            END;
                  
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
