DROP TABLE IF EXISTS master.dim_security;
CREATE TABLE
    master.dim_security
(
    SK_SecurityID        INT   NOT NULL,
    -- Surrogate key for Symbol
    Symbol               TEXT  NOT NULL,
    -- Identifies security on “ticker”
    Issue                TEXT  NOT NULL,
    -- Issue type
    Status               TEXT  NOT NULL,
    -- Status type
    Name                 TEXT  NOT NULL,
    -- Security name
    ExchangeID           TEXT  NOT NULL,
    -- Exchange the security is traded on
    SK_CompanyID         INT   NOT NULL,
    -- Company issuing security
    SharesOutstanding    INT   NOT NULL,
    -- Shares outstanding
    FirstTrade           DATE    NOT NULL,
    -- Date of first trade
    FirstTradeOnExchange DATE    NOT NULL,
    -- Date of first trade on this exchange
    Dividend             FLOAT NOT NULL,
    -- Annual dividend per share
    IsCurrent            BOOLEAN NOT NULL,
    -- True if this is the current record
    BatchID              INT   NOT NULL,
    -- Batch ID when this record was inserted
    EffectiveDate        DATE    NOT NULL,
    -- Beginning of date range when this record was the current record
    EndDate              DATE    NOT NULL
    -- Ending of date range when this record was the current record. A record that is not expired will use the date 9999-12-31.
);