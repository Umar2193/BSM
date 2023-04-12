/*
---------------------------------------------------------------------------
Name         : bsm.GetReviewSheet
---------------------------------------------------------------------------
Description  : Gets the recored of review sheet
---------------------------------------------------------------------------
TFS Object   : **
---------------------------------------------------------------------------
Created      : 15/06/2020 by  Ali Shah 
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
CREATE PROC [bsm].[GetReviewSheet]
	@reviewerName VARCHAR(100) = NULL,
    @auditDate VARCHAR(100) = NULL
AS
BEGIN
DECLARE @returnValue INT = -1,
        @openingTranCount INT = 0,
        @errorMessage NVARCHAR(4000),
        @errorSeverity INT,
        @errorState INT,
        @objectName NVARCHAR(100),
        @sql VARCHAR(MAX),
        @whereClause VARCHAR(MAX),
        @date DATE;
 
       SET @openingTranCount = @@TRANCOUNT;
 
      PRINT(CONCAT('Start : ', OBJECT_NAME(@@PROCID), ' : Tnx Count = ', @openingTranCount));
 
      --------------------------------------------------
BEGIN TRY
            ------------------------------------------------------------     
    BEGIN TRANSACTION;

        
        SELECT @date = CASE 
                       WHEN @auditDate IS NULL
                       THEN
                            NULL
                        ELSE
                            CONVERT(DATETIME,@auditDate,103)
                        END;

        SELECT @sql = 'SELECT
                            AuditLogId,
                            ReviewerName,
                            CONVERT(VARCHAR(12),AuditDate,103) AS AuditDate,
                            ActionTaken,
                            Comments
                        FROM bsm.AuditLog';

        IF @reviewerName IS NOT NULL AND @auditDate IS NOT NULL
        BEGIN
            SELECT @whereClause = ' WHERE ReviewerName LIKE ( ''%' + @reviewerName + '%'') AND AuditDate <= ''' + CAST(@date AS VARCHAR(50)) + '''';
        END;
        ELSE IF @reviewerName IS NOT NULL AND @auditDate IS NULL
        BEGIN
            SELECT @whereClause = ' WHERE ReviewerName LIKE (''%' + @reviewerName + '%'')';
        END;
        ELSE IF @reviewerName IS NULL AND @auditDate IS NOT NULL
        BEGIN
            SELECT @whereClause = ' WHERE AuditDate <= ''' + CAST(@date AS VARCHAR(50)) + '''';
        END;
        ELSE IF @reviewerName IS NULL AND @auditDate IS  NULL
        BEGIN
            SELECT @whereClause = '';
        END;

        SELECT @sql = @sql + @whereClause;

        EXEC(@sql);
    
            
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

