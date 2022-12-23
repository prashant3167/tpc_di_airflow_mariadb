DROP TABLE IF EXISTS master.dim_customer;


CREATE TABLE
    master.dim_customer
(
    SK_CustomerID       bigint   NOT NULL,
    CustomerID          bigint   NOT NULL,
    TaxID               text  NOT NULL,
    Status              text  NOT NULL,
    LastName            text  NOT NULL,
    FirstName           text  NOT NULL,
    MiddleInitial       text,
    Gender              text,
    Tier                bigint,
    DOB                 DATE    NOT NULL,
    AddressLine1        text  NOT NULL,
    AddressLine2        text,
    PostalCode          text  NOT NULL,
    City                text  NOT NULL,
    StateProv           text  NOT NULL,
    Country             text,
    Phone1              text,
    Phone2              text,
    Phone3              text,
    Email1              text,
    Email2              text,
    NationalTaxRateDesc text,
    NationalTaxRate     NUMERIC,
    LocalTaxRateDesc    text,
    LocalTaxRate        NUMERIC,
    AgencyID            text,
    CreditRating        bigint,
    NetWorth            bigint,
    MarketingNameplate  text,
    IsCurrent           BOOLEAN NOT NULL,
    BatchID             bigint   NOT NULL,
    EffectiveDate       DATE    NOT NULL,
    EndDate             DATE    NOT NULL
);

create index if not exists cut_dim_index on master.dim_customer(CustomerID);

-- CREATE TABLE
--     master.dim_customer
-- (
--     SK_CustomerID       bigint   NOT NULL,
--     --Surrogate key for CustomerID
--     CustomerID          bigint   NOT NULL,
--     --Customer identifier
--     TaxID               text  NOT NULL,
--     --Customer’s tax identifier
--     Status              text  NOT NULL,
--     --Customer status type
--     LastName            text  NOT NULL,
--     --Customer's last name.
--     FirstName           text  NOT NULL,
--     --Customer's first name.
--     MiddleInitial       text,
--     --Customer's middle name initial
--     Gender              text,
--     --Gender of the customer
--     Tier                bigint,
--     --Customer tier
--     DOB                 DATE    NOT NULL,
--     --Customer’s date of birth.
--     AddressLine1        text  NOT NULL,
--     --Address Line 1
--     AddressLine2        text,
--     --Address Line 2
--     PostalCode          text  NOT NULL,
--     --Zip or Postal Code
--     City                text  NOT NULL,
--     --City
--     StateProv           text  NOT NULL,
--     --State or Province
--     Country             text,
--     --Country
--     Phone1              text,
--     --Phone number 1
--     Phone2              text,
--     --Phone number 2
--     Phone3              text,
--     --Phone number 3
--     Email1              text,
--     --Email address 1
--     Email2              text,
--     --Email address 2
--     NationalTaxRateDesc text,
--     --National Tax rate description
--     NationalTaxRate     NUMERIC,
--     --National Tax rate
--     LocalTaxRateDesc    text,
--     --Local Tax rate description
--     LocalTaxRate        NUMERIC,
--     --Local Tax rate
--     AgencyID            text,
--     --Agency identifier
--     CreditRating        bigint,
--     --Credit rating
--     NetWorth            bigint,
--     --Net worth
--     MarketingNameplate  text,
--     --Marketing nameplate
--     IsCurrent           BOOLEAN NOT NULL,
--     --True if this is the current record
--     BatchID             bigint   NOT NULL,
--     --Batch ID when this record was inserted
--     EffectiveDate       DATE    NOT NULL,
--     --Beginning of date range when this record was the current record
--     EndDate             DATE    NOT NULL
--     --Ending of date range when this record was the current record. A record that is not expired will use the date 9999-12-31.
-- );