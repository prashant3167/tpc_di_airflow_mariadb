
INSERT into {{ params.table }}
WITH
  cmp_record_effective_date_initial AS (
  SELECT
    *,
    LEAD(PTS, 1) OVER (PARTITION BY CIK ORDER BY PTS ASC) AS end_date_time
  FROM
    staging.cmp_records),
  cmp_record_effective_date AS (SELECT
    PTS,CompanyName,CIK,Status,IndustryID,SPrating,FoundingDate,AddrLine1,AddrLine2,PostalCode,City,StateProvince,Country,CEOname,Description,
    case when end_date_time is NULL then DATE('9999-12-31') else end_date_time end as 'end_date_time'
  FROM cmp_record_effective_date_initial)
SELECT
  CAST(CONCAT(DATE_FORMAT(cmp.PTS, '%Y%m%d'), CAST(cmp.CIK AS char)) as int) AS SK_CompanyID,
  cmp.CIK AS CompanyID,
  st.ST_NAME AS Status,
  cmp.CompanyName AS Name,
  ind.IN_NAME AS Industry,
  CASE
    WHEN SPRating NOT IN ('AAA','AA','AA+','AA-','A','A+','A-','BBB','BBB+','BBB-','BB','BB+','BB-','B','B+','B-','CCC','CCC+','CCC-','CC','C','D') THEN NULL
  ELSE
  cmp.SPRating
END
  AS SPRating,
  CASE
    WHEN SPRating NOT IN ('AAA','AA','AA+','AA-','A','A+','A-','BBB','BBB+','BBB-','BB','BB+','BB-','B','B+','B-','CCC','CCC+','CCC-','CC','C','D') THEN NULL
    WHEN cmp.SPRating like "A%"
  OR cmp.SPRating like "BBB%" THEN FALSE
  ELSE
  TRUE
END
  AS isLowGrade,
  cmp.CEOName AS CEO,
  cmp.AddrLine1 AS AddressLine1,
  cmp.AddrLine2 AS AddressLine2,
  cmp.PostalCode AS PostalCode,
  cmp.City AS City,
  cmp.StateProvince AS StateProv,
  cmp.Country AS Country,
  cmp.Description AS Description,
  cmp.FoundingDate AS FoundingDate,
  CASE
    WHEN DATE(cmp.end_date_time) = DATE('9999-12-31') THEN TRUE
  ELSE
  FALSE
END
  AS IsCurrent,
  1 AS BatchID,
  DATE(cmp.PTS) AS EffectiveDate,
  DATE(cmp.end_date_time) AS EndDate
FROM (cmp_record_effective_date cmp
  JOIN
    master.status_type st
  ON
    cmp.Status = st.ST_ID)
JOIN
  master.industry ind
ON
  cmp.IndustryID = ind.IN_ID;