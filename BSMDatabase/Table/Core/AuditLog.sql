CREATE TABLE [bsm].[AuditLog]
(
	AuditLogId INT IDENTITY (1,1),
	ReviewerName VARCHAR(100),
	AuditDate DATE,
	ActionTaken VARCHAR(MAX),
	Comments VARCHAR(MAX),
	CONSTRAINT PK_AuditLog_AuditLogId PRIMARY KEY (AuditLogId)
)
