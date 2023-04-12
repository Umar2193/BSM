/*
---------------------------------------------------------------------------
Name         : bsm.GetExpirySheet
---------------------------------------------------------------------------
Description  : gets expiry sheet
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 17/06/2020 by  Ali Shah 
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
CREATE PROC [bsm].[GetExpirySheet]
	    @searchDate VARCHAR(100) = NULL
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100),
        @date DATE;
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
    BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;

    
    SELECT @date = CASE 
                       WHEN @searchDate IS NULL
                       THEN
                            NULL
                        ELSE
                            CONVERT(DATETIME,@searchDate,103)
                        END;

    SELECT
	    t_employee.LastName + ' ' + t_employee.FirstName  +  ' - ' + t_jobTitle.JobTitleName  AS Employee,
	    t_skills.SkillsDescription AS Skill,
	    CONVERT(VARCHAR(12),t_employeeTraining.ExpiresOn,103) AS [Expiry Date]
    FROM bsm.EmployeeTraining AS t_employeeTraining
    INNER JOIN bsm.Employee AS t_employee
	    ON t_employeeTraining.EmployeeId = t_employee.EmployeeId
    INNER JOIN bsm.JobTitle AS t_jobTitle 
	    ON t_employee.JobTitleId = t_jobTitle.JobTitleId
    INNER JOIN bsm.Skills AS t_skills
	    ON t_employeeTraining.SkillsId = t_skills.SkillsId
    WHERE t_employeeTraining.ExpiresOn < = @date
    ORDER BY ExpiresOn DESC,
    t_employee.LastName;

    
                  
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





