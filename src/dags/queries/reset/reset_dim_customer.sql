DROP TABLE IF EXISTS master.dim_customer;
CREATE TABLE
    master.dim_customer
(
    SK_CustomerID       INT   NOT NULL,
    -- Surrogate key for CustomerID
    CustomerID          INT   NOT NULL,
    -- Customer identifier
    TaxID               TEXT  NOT NULL,
    -- Customerâ€™s tax identifier
    Status              TEXT  NOT NULL,
    -- Customer status type
    LastName            TEXT  NOT NULL,
    -- Customer's last name.
    FirstName           TEXT  NOT NULL,
    -- Customer's first name.
    MiddleInitial       TEXT,
    -- Customer's middle name initial
    Gender              TEXT,
    -- Gender of the customer
    Tier                INT,
    -- Customer tier
    DOB                 DATE    NOT NULL,
    -- Customer's date of birth.
    AddressLine1        TEXT  NOT NULL,
    -- Address Line 1
    AddressLine2        TEXT,
    -- Address Line 2
    PostalCode          TEXT  NOT NULL,
    -- Zip or Postal Code
    City                TEXT  NOT NULL,
    -- City
    StateProv           TEXT  NOT NULL,
    -- State or Province
    Country             TEXT,
    -- Country
    Phone1              TEXT,
    -- Phone number 1
    Phone2              TEXT,
    -- Phone number 2
    Phone3              TEXT,
    -- Phone number 3
    Email1              TEXT,
    -- Email address 1
    Email2              TEXT,
    -- Email address 2
    NationalTaxRateDesc TEXT,
    -- National Tax rate description
    NationalTaxRate     NUMERIC,
    -- National Tax rate
    LocalTaxRateDesc    TEXT,
    -- Local Tax rate description
    LocalTaxRate        NUMERIC,
    -- Local Tax rate
    AgencyID            TEXT,
    -- Agency identifier
    CreditRating        INT,
    -- Credit rating
    NetWorth            INT,
    -- Net worth
    MarketingNameplate  TEXT,
    -- Marketing nameplate
    IsCurrent           BOOLEAN NOT NULL,
    -- True if this is the current record
    BatchID             INT   NOT NULL,
    -- Batch ID when this record was inserted
    EffectiveDate       DATE    NOT NULL,
    -- Beginning of date range when this record was the current record
    EndDate             DATE    NOT NULL
    -- Ending of date range when this record was the current record. A record that is not expired will use the date 9999-12-31.
);
