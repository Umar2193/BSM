/*
---------------------------------------------------------------------------
Name         : bsm.RefreshData
---------------------------------------------------------------------------
Description  : Refreshes the data in the tables 
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
CREATE PROC [bsm].[RefreshData]
	
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
 

         PRINT 'Populateing department type .............'
            EXEC bsm.PopulateDepartmentType;

         PRINT 'Populating job titile ...................'
            EXEC bsm.PopulateJobTitle;

        PRINT 'populating periodicity....................'
            EXEC bsm.PopulatePeriodicity;

        PRINT 'Populating training.......................'
            EXEC bsm.PopulateTraining;

        PRINT 'Populating department.....................'
            EXEC bsm.PopulateDepartment;

        PRINT 'Populating skills.........................'
            EXEC bsm.PopulateSkills;

        PRINT 'Populating employee.......................'
            EXEC bsm.PopulateEmployee;

        PRINT 'Populating employee training..............'
            EXEC bsm.PopulateEmployeeTraining;
                  
    -- commit transaction opened in this proc

            
    SET @returnValue = 1;
 END TRY
 BEGIN CATCH
-- roll back transaction opened in this proc

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






