-- CREATE TEMP FUNCTION
--   latest_value( history_of_values ANY TYPE) AS ( (
--     SELECT
--       excluding_nulls[ORDINAL(ARRAY_LENGTH(excluding_nulls))]
--     FROM (
--       SELECT
--         ARRAY_AGG(x IGNORE NULLS) AS excluding_nulls
--       FROM
--         UNNEST(history_of_values) x)) );



delete from {{ params.table }};

INSERT into {{ params.table }}
WITH
    accounts AS (
        SELECT
            Action,
            effective_time_stamp,
            CustomerID,
            AccountID,
            BrokerID,
            AccountDesc,
            TaxStatus,
            CASE
                WHEN Action IN ("INACT", "CLOSEACCT") THEN "INACTIVE"
                ELSE
                    "ACTIVE"
                END
                AS Status
        FROM
            staging.customer_management
        WHERE
                Action IN ("NEW",
                                        "ADDACCT",
                                        "UPDACCT",
                                        "CLOSEACCT",
                                        "INACT")),
    inactive_date AS (
        SELECT
            CustomerID,
            STR_TO_DATE(effective_time_stamp,'%Y-%m-%d %H:%i:%s') AS effective_date
        FROM
            accounts
        WHERE
                Action = "INACT"),
    effective_account_temp AS (
        SELECT
            CustomerID,
            AccountID,
            BrokerID,
            AccountDesc,
            TaxStatus,
            Action,
            Status,
            STR_TO_DATE(effective_time_stamp,'%Y-%m-%d %H:%i:%s') as EffectiveDate,
            LEAD(STR_TO_DATE(effective_time_stamp,'%Y-%m-%d %H:%i:%s'), 1) OVER (
            PARTITION BY
            AccountID
            ORDER BY
            STR_TO_DATE(effective_time_stamp,'%Y-%m-%d %H:%i:%s') ASC) as EndDate
        FROM
            accounts
        WHERE
                Action NOT IN ("INACT")
            ),
    effective_account AS(
        SELECT CustomerID,AccountID,BrokerID,AccountDesc,TaxStatus,Action,Status,EffectiveDate,case when EndDate is NULL then DATE('9999-12-31') else EndDate end as "EndDate" from effective_account_temp
    )
SELECT
    acc.CustomerID,
    acc.AccountID,
    acc.BrokerID,
    acc.AccountDesc,
    acc.TaxStatus,
    Action,
    IF
        (inact.CustomerID IS NULL,
         Status,
         "INACTIVE") AS Status,
    acc.EffectiveDate,
    CASE
        WHEN inact.CustomerID IS NOT NULL THEN IF(acc.EndDate < inact.effective_date, acc.EndDate, inact.effective_date)
        ELSE
            acc.EndDate
        END
                     AS EndDate
FROM
    effective_account acc
        LEFT OUTER JOIN
    inactive_date inact
    ON
                acc.CustomerID = inact.CustomerID
            AND acc.EffectiveDate <= inact.effective_date;