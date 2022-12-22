DROP TABLE IF EXISTS master.prospect;
CREATE TABLE
    master.prospect
(
    AgencyID           TEXT  NOT NULL,
    -- Unique identifier from agency
    SK_RecordDateID    INT   NOT NULL,
    -- Last date this prospect appeared in input
    SK_UpdateDateID    INT   NOT NULL,
    -- Latest change date for this prospect
    BatchID            INT   NOT NULL,
    -- Batch ID when this record was last modified
    IsCustomer         BOOLEAN NOT NULL,
    -- True if this person is also in DimCustomer, else False
    LastName           TEXT  NOT NULL,
    -- Last name
    FirstName          TEXT  NOT NULL,
    -- First name
    MiddleInitial      TEXT,
    -- Middle initial
    Gender             TEXT,
    -- M / F / U
    AddressLine1       TEXT,
    -- Postal address
    AddressLine2       TEXT,
    -- Postal address
    PostalCode         TEXT,
    -- Postal code
    City               TEXT  NOT NULL,
    -- City
    State              TEXT  NOT NULL,
    -- State or province
    Country            TEXT,
    -- Postal country
    Phone              TEXT,
    -- Telephone number
    Income             INT,
    -- Annual income
    NumberCars         INT,
    -- Cars owned
    NumberChildren     INT,
    -- Dependent children
    MaritalStatus      TEXT,
    -- S / M / D / W / U
    Age                INT,
    -- Current age
    CreditRating       INT,
    -- Numeric rating
    OwnOrRentFlag      TEXT,
    -- O / R / U
    Employer           TEXT,
    -- Name of employer
    NumberCreditCards  INT,
    -- Credit cards
    NetWorth           INT,
    -- Estimated total net worth
    MarketingNameplate TEXT
    -- For marketing purposes
);
