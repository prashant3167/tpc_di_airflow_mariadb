DROP TABLE IF EXISTS master.dim_company;
CREATE TABLE
    master.dim_company
(
    SK_CompanyID  INT   NOT NULL,
    -- Surrogate key for CompanyID
    CompanyID     INT   NOT NULL,
    -- Company identifier (CIK number)
    Status        TEXT  NOT NULL,
    -- Company status
    Name          TEXT  NOT NULL,
    --  Company name
    Industry      TEXT  NOT NULL,
    -- Company’s industry
    SPrating      TEXT,
    -- Standard & Poor company’s rating
    isLowGrade    BOOLEAN,
    -- True if this company is low grade
    CEO           TEXT  NOT NULL,
    -- CEO name
    AddressLine1  TEXT,
    -- Address Line 1
    AddressLine2  TEXT,
    -- Address Line 2
    PostalCode    TEXT  NOT NULL,
    -- Zip or postal code
    City          TEXT  NOT NULL,
    -- City
    StateProv     TEXT  NOT NULL,
    -- State or Province
    Country       TEXT,
    Description   TEXT  NOT NULL,
    -- Company description
    FoundingDate  DATE,
    -- the company was founded
    IsCurrent     BOOLEAN NOT NULL,
    -- True if this is the current record
    BatchID       INT   NOT NULL,
    -- Batch ID when this record was inserted
    EffectiveDate DATE    NOT NULL,
    -- Beginning of date range when this record was the current record
    EndDate       DATE    NOT NULL
    -- Ending of date range when this record was the current record. A record that is not expired will use the date 9999-12-31.
);
