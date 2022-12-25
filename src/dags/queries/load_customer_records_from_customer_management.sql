-- CREATE TEMP FUNCTION
--   as_string (val ANY TYPE) AS (IFNULL(SAFE_CAST(val AS STRING),
--       ""));
-- CREATE TEMP FUNCTION
--   constructPhoneNumber(phone ANY TYPE) AS (
--     CASE
--       WHEN phone IS NULL THEN NULL
--     ELSE
--     CASE
--       WHEN phone.C_CTRY_CODE IS NOT NULL AND phone.C_AREA_CODE IS NOT NULL AND phone.C_LOCAL IS NOT NULL THEN CONCAT(as_STRING(phone.C_CTRY_CODE), "(", as_STRING(phone.C_AREA_CODE), ")", as_STRING(phone.C_LOCAL), as_STRING(phone.C_EXT))
--       WHEN phone.C_CTRY_CODE IS NULL
--     AND phone.C_AREA_CODE IS NOT NULL
--     AND phone.C_LOCAL IS NOT NULL THEN CONCAT("(", as_STRING(phone.C_AREA_CODE), ")", as_STRING(phone.C_LOCAL), as_STRING(phone.C_EXT))
--       WHEN phone.C_CTRY_CODE IS NULL AND phone.C_AREA_CODE IS NULL AND phone.C_LOCAL IS NOT NULL THEN CONCAT(as_STRING(phone.C_LOCAL), as_STRING(phone.C_EXT))
--     ELSE
--     NULL
--   END
--   END
--     );
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

INSERT into {{ params.table}}
with temp_customer as (
  SELECT
    Action,
    STR_TO_DATE(effective_time_stamp,'%Y-%m-%d %H:%i:%s') as EffectiveDate,
    Phone1,
    Phone2,
    Phone3,
    Tier,
    CustomerID,
    UPPER(Gender) AS Gender,
    Email1,
    Email2,
    TaxID,
    STR_TO_DATE(DOB,'%Y-%m-%d') as DOB,
    FirstName,
    MiddleInitial,
    LastName,
    Country,
    City,
    PostalCode,
    AddressLine1,
    AddressLine2,
    State_Prov,
    Status,
    NationalTaxID,
   LocalTaxID,
   LEAD(STR_TO_DATE(effective_time_stamp,'%Y-%m-%d %H:%i:%s'), 1) OVER (
    PARTITION BY
    CustomerID
    ORDER BY
    STR_TO_DATE(effective_time_stamp,'%Y-%m-%d %H:%i:%s') ASC) AS EndDate
  FROM
    staging.customer_management
  WHERE
    Action IN ("NEW",
      "UPDCUST",
      "INACT")
)
SELECT Action,EffectiveDate,Phone1,Phone2,Phone3,Tier,CustomerID,Gender,Email1,Email2,TaxID,DOB,FirstName,MiddleInitial,LastName,Country,City,PostalCode,AddressLine1,AddressLine2,State_Prov,Status,NationalTaxID,LocalTaxID,case when EndDate is Null then DATE('9999-12-31') else EndDate end  as "EndDate" from temp_customer;