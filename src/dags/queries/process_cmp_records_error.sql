INSERT INTO master.di_messages
SELECT
    now() AS MessageDateAndTime,
    1 AS BatchID,
    "DimCompany" AS MessageSource,
    "Invalid SPRating" AS MessageText,
    "Alert" AS MessageType,
    CONCAT("CO_ID=", CAST(CIK AS char), "CO_SP_RATE=", SPrating) AS MessageData
FROM
    staging.cmp_records
WHERE
        SPrating NOT IN ("AAA",
                         "AA",
                         "AA+",
                         "AA-",
                         "A",
                         "A+",
                         "A-",
                         "BBB",
                         "BBB+",
                         "BBB-",
                         "BB",
                         "BB+",
                         "BB-",
                         "B",
                         "B+",
                         "B-",
                         "CCC",
                         "CCC+",
                         "CCC-",
                         "CC",
                         "C",
                         "D");