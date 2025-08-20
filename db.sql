-- =============================================
-- DeliveryIssueDashboard Database Setup Script
-- =============================================

-- Create the database if it doesn't exist
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'DeliveryIssueDashboard')
BEGIN
    CREATE DATABASE DeliveryIssueDashboard;
END
GO

USE DeliveryIssueDashboard;
GO

-- Drop tables if they exist (for clean setup)
IF OBJECT_ID('DeliveryIssueDashboards', 'U') IS NOT NULL
    DROP TABLE DeliveryIssueDashboards;

IF OBJECT_ID('AssetClasses', 'U') IS NOT NULL
    DROP TABLE AssetClasses;
GO

-- Create AssetClasses table
CREATE TABLE AssetClasses (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL
);
GO

-- Insert default asset classes
INSERT INTO AssetClasses (Name) VALUES 
('Credit'),
('Equity'),
('Macro'),
('All');
GO

-- Create DeliveryIssueDashboards table
CREATE TABLE DeliveryIssueDashboards (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CheckDate DATE NOT NULL,
    ReportDate DATE NOT NULL,
    AssetClass NVARCHAR(50) NOT NULL,
    DataDeliveredTime DATETIME2 NOT NULL,
    SLATimingMet BIT NULL,
    CompletenessIssue BIT NULL,
    DataQualityIssue BIT NULL,
    DashboardUI BIT NULL,
    IncidentsRaised NVARCHAR(MAX) NULL,
    Comment NVARCHAR(MAX) NULL,
    ReportIsPublished BIT NOT NULL DEFAULT 0,
    CheckedBy NVARCHAR(100) NOT NULL,
    ReviewedBy NVARCHAR(100) NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedDate DATETIME2 NULL
);
GO

-- Create indexes for better performance
CREATE INDEX IX_DeliveryIssueDashboards_ReportDate ON DeliveryIssueDashboards (ReportDate);
CREATE INDEX IX_DeliveryIssueDashboards_AssetClass ON DeliveryIssueDashboards (AssetClass);
CREATE INDEX IX_DeliveryIssueDashboards_CheckedBy ON DeliveryIssueDashboards (CheckedBy);
GO

-- Insert sample data for DeliveryIssueDashboards table
PRINT 'Inserting sample data...';
INSERT INTO DeliveryIssueDashboards (CheckDate, ReportDate, AssetClass, DataDeliveredTime, SLATimingMet, CompletenessIssue, DataQualityIssue, DashboardUI, IncidentsRaised, Comment, ReportIsPublished, CheckedBy, ReviewedBy)
VALUES 
(
    '2024-12-28', 
    '2024-12-27', 
    'Credit', 
    '2025-01-06 08:07:00', 
    1, -- SLA Timing Met: Yes
    0, -- Completeness Issue: No
    1, -- Data Quality Issue: Yes
    1, -- Dashboard UI: Yes
    'INC001234, INC001235', 
    'Data quality issues detected in bond pricing data', 
    1, -- Report Published: Yes
    'Client Nistin', 
    'John Supervisor'
),
(
    '2024-12-28', 
    '2024-12-27', 
    'Equity', 
    '2025-01-06 08:15:00', 
    1, -- SLA Timing Met: Yes
    0, -- Completeness Issue: No
    0, -- Data Quality Issue: No
    1, -- Dashboard UI: Yes
    '', 
    'All equity data delivered on time without issues', 
    1, -- Report Published: Yes
    'Angelika Lisek', 
    'Sarah Manager'
),
(
    '2024-12-28', 
    '2024-12-27', 
    'Macro', 
    '2025-01-06 09:30:00', 
    0, -- SLA Timing Met: No
    1, -- Completeness Issue: Yes
    0, -- Data Quality Issue: No
    1, -- Dashboard UI: Yes
    'INC001236', 
    'FX rates data incomplete for Asian markets', 
    0, -- Report Published: No
    'Rangazimi S', 
    NULL -- Not yet reviewed
),
(
    '2024-12-27', 
    '2024-12-26', 
    'Credit', 
    '2025-01-05 07:45:00', 
    1, -- SLA Timing Met: Yes
    0, -- Completeness Issue: No
    0, -- Data Quality Issue: No
    1, -- Dashboard UI: Yes
    '', 
    'Standard delivery without issues', 
    1, -- Report Published: Yes
    'Drani Nistan', 
    'Asintosh Agarwal'
),
(
    '2024-12-27', 
    '2024-12-26', 
    'Equity', 
    '2025-01-05 08:20:00', 
    1, -- SLA Timing Met: Yes
    1, -- Completeness Issue: Yes
    1, -- Data Quality Issue: Yes
    0, -- Dashboard UI: No
    'INC001237, INC001238', 
    'Multiple issues: missing NASDAQ data and corrupted volume information', 
    0, -- Report Published: No
    'Michael Chen', 
    NULL -- Not yet reviewed
);
GO

-- Verify the data was inserted correctly
PRINT 'Sample data verification:';
SELECT 
    Id,
    CheckDate,
    ReportDate,
    AssetClass,
    DataDeliveredTime,
    CASE WHEN SLATimingMet = 1 THEN 'Yes' WHEN SLATimingMet = 0 THEN 'No' ELSE 'N/A' END AS SLATimingMet,
    CASE WHEN CompletenessIssue = 1 THEN 'Yes' WHEN CompletenessIssue = 0 THEN 'No' ELSE 'N/A' END AS CompletenessIssue,
    CASE WHEN DataQualityIssue = 1 THEN 'Yes' WHEN DataQualityIssue = 0 THEN 'No' ELSE 'N/A' END AS DataQualityIssue,
    CASE WHEN DashboardUI = 1 THEN 'Yes' WHEN DashboardUI = 0 THEN 'No' ELSE 'N/A' END AS DashboardUI,
    IncidentsRaised,
    Comment,
    CASE WHEN ReportIsPublished = 1 THEN 'Yes' ELSE 'No' END AS ReportIsPublished,
    CheckedBy,
    ReviewedBy
FROM DeliveryIssueDashboards;
GO

PRINT 'Database setup completed successfully!';