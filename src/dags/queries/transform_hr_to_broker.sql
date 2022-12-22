delete from {{ table }};
INSERT into {{ table }};
WITH
    min_date AS (
        SELECT
            MIN(DateValue) AS EffectiveDate
        FROM
            master.dim_date)
SELECT
    CAST(CONCAT(DATE_FORMAT( min_date.EffectiveDate,'%Y%m%d'), '', CAST(EmployeeID AS CHAR)) AS INT) AS SK_BrokerID,
    EmployeeID AS BrokerID,
    ManagerID,
    EmployeeFirstName,
    EmployeeLastName,
    EmployeeMI,
    EmployeeBranch,
    EmployeeOffice,
    EmployeePhone,
    TRUE AS IsCurrent,
    1 AS BatchID,
    min_date.EffectiveDate,
    DATE('9999-12-31') AS EndDate
FROM
    staging.hr
        CROSS JOIN
    min_date
WHERE
        EmployeeJobCode = 314;