/*
---------------------------------------------------------------------------
Name         : bsm.PopulateSkills
---------------------------------------------------------------------------
Description  : populates skills table
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
CREATE PROC [bsm].[PopulateSkills]
	
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

    UPDATE t_stgSkills SET
        DepartmentId = t_department.DepartmentId 
    FROM staging.Skills AS t_stgSkills
    INNER JOIN bsm.Department AS t_department
        ON t_stgSkills.Department = t_department.DepartmentName;

    UPDATE t_stgSkills SET
        PeriodicityId = t_periodicity.PeriodicityId
    FROM staging.Skills AS t_stgSkills
    INNER JOIN bsm.Periodicity AS t_periodicity
        ON t_stgSkills.Periodicity = t_periodicity.PeriodicityName;

    DELETE 
    FROM staging.Skills
    WHERE DepartmentId IS NULL OR PeriodicityId IS NULL;

    INSERT INTO bsm.Skills
        (
            SkillsDescription,
            PeriodicityId,
            QMNumber,
            DepartmentId,
            SkillStatus
        )
    SELECT
        SkillsDescription,
        PeriodicityId,
        QMNumber,
        DepartmentId,
        SkillStatus
    FROM staging.Skills;
                  
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


