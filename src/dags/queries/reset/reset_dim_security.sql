DROP TABLE IF EXISTS master.dim_security;
CREATE TABLE master.dim_security (
    SK_SecurityID text NOT NULL,
    Symbol text NOT NULL,
    Issue text NOT NULL,
    Status text NOT NULL,
    Name text NOT NULL,
    ExchangeID text NOT NULL,
    SK_CompanyID bigint NOT NULL,
    SharesOutstanding integer NOT NULL,
    FirstTrade DATE NOT NULL,
    FirstTradeOnExchange DATE NOT NULL,
    Dividend float NOT NULL,
    IsCurrent BOOLEAN NOT NULL,
    BatchID integer NOT NULL,
    EffectiveDate DATE NOT NULL,
    EndDate DATE NOT NULL
);