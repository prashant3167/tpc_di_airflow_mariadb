INSERT INTO
    master.di_messages
SELECT
    now() AS MessageDateAndTime,
    1 AS BatchID,
    "DimCustomer" AS MessageSource,
    error.MessageData AS MessageText,
    "Alert" AS MessageType,
    error.MessageData AS MessageData
FROM (
         SELECT
    "Invalid customer tier" AS MessageText,
    CONCAT("C_ID=", '', CAST(CustomerID AS CHAR),',',"C_TIER=", '', CAST(Tier AS CHAR)) AS MessageData
FROM
    staging.customer_historical
WHERE
    Tier NOT IN (1, 2, 3)
         UNION ALL
         SELECT
             "DOB out of range" AS MessageText,
             CONCAT("C_ID=",CAST(CustomerID AS CHAR), ',', "C_DOB=",CAST(DOB AS CHAR)) AS MessageData
         FROM
             staging.customer_historical
                 CROSS JOIN
             staging.batch_date
         WHERE
                 DOB > BatchDate
            OR 
            timestampdiff(YEAR,DOB,BatchDate) > 100) error;