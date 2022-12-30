delete from {{ params.table }};

INSERT into {{ params.table }}
SELECT
    STR_TO_DATE(SUBSTR(ROW, 1, 15), '%Y%m%d-%H%i%S') AS PTS,
    CAST(TRIM(SUBSTR(ROW, 19, 4)) AS integer) AS Year,
    CAST(TRIM(SUBSTR(ROW, 23, 1)) AS integer) AS Quarter,
    STR_TO_DATE(TRIM(SUBSTR(ROW, 24, 8)), '%Y%m%d') AS QtrStartDate,
    STR_TO_DATE(TRIM(SUBSTR(ROW, 32, 8)), '%Y%m%d') AS PostingDate,
    CAST(TRIM(SUBSTR(ROW, 40, 17)) AS float) AS Revenue,
    CAST(TRIM(SUBSTR(ROW, 57, 17)) AS float) AS Earnings,
    CAST(TRIM(SUBSTR(ROW, 74, 12)) AS float) AS EPS,
    CAST(TRIM(SUBSTR(ROW, 86, 12)) AS float) AS DilutedEPS,
    CAST(TRIM(SUBSTR(ROW, 98, 12)) AS float) AS Margin,
    CAST(TRIM(SUBSTR(ROW, 110, 17)) AS float) AS Inventory,
    CAST(TRIM(SUBSTR(ROW, 127, 17)) AS float) AS Assets,
    CAST(TRIM(SUBSTR(ROW, 144, 17)) AS float) AS Liabilities,
    CAST(TRIM(SUBSTR(ROW, 161, 13)) AS integer) AS ShOut,
    CAST(TRIM(SUBSTR(ROW, 174, 13)) AS integer) AS DilutedShOut,
    CASE
        WHEN LENGTH(TRIM(BOTH '\r' FROM SUBSTR(ROW, 187, 60))) <= 10 THEN CAST(TRIM(TRIM(BOTH '\r' FROM SUBSTR(ROW, 187, 60))) AS integer)
        ELSE
            NULL
        END
        AS CIK,
    CASE
        WHEN (LENGTH(TRIM(TRIM(BOTH '\r' FROM SUBSTR(ROW, 187, 60)))) > 10 OR CAST(TRIM(TRIM(BOTH '\r' FROM SUBSTR(ROW, 187, 60))) AS integer) IS NULL) THEN TRIM(TRIM(BOTH '\r' FROM SUBSTR(ROW, 187, 60)))
        ELSE
            NULL
        END
        AS CompanyName
FROM
    staging.finwire
WHERE
        TRIM(SUBSTR(ROW, 16, 3)) = 'FIN';