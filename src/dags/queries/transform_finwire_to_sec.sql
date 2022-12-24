delete from {{table}};


insert into {{ params.table }}
SELECT
    STR_TO_DATE(SUBSTR(ROW, 1, 15), '%Y%m%d-%H%i%S') AS PTS,
    TRIM(SUBSTR(ROW, 19, 15)) AS Symbol,
    TRIM(SUBSTR(ROW, 34, 6)) AS IssueType,
    TRIM(SUBSTR(ROW, 40, 4)) AS Status,
    TRIM(SUBSTR(ROW, 44, 70)) AS Name,
    TRIM(SUBSTR(ROW, 114, 6)) AS ExID,
    CAST(TRIM(SUBSTR(ROW, 120, 13)) AS integer) AS ShOut,
    STR_TO_DATE(TRIM(SUBSTR(ROW, 133, 8)), '%Y%m%d') AS FirstTradeDate,
    STR_TO_DATE(TRIM(SUBSTR(ROW, 141, 8)), '%Y%m%d') AS FirstTradeExchg,
    CAST(TRIM(SUBSTR(ROW, 149, 12)) AS float) AS Dividend,
    CASE
        WHEN CHAR_LENGTH(TRIM(TRIM(BOTH '\r' from SUBSTR(ROW, 161, 60)))) <= 10 THEN CAST(TRIM(TRIM(BOTH '\r' from SUBSTR(ROW, 161, 60))) AS integer)
        ELSE
            NULL
        END
        AS CIK,
    CASE
        WHEN (CHAR_LENGTH(TRIM(TRIM(BOTH '\r' from SUBSTR(ROW, 161, 60)))) > 10 OR CAST(TRIM(TRIM(BOTH '\r' from SUBSTR(ROW, 161, 60))) AS integer) IS NULL) THEN TRIM(TRIM(BOTH '\r' from SUBSTR(ROW, 161, 60)))
        ELSE
            NULL
        END
        AS CompanyName
FROM
    staging.finwire
WHERE
        TRIM(SUBSTR(ROW, 16, 3)) = 'SEC';