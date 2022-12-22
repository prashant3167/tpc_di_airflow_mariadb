DROP TABLE IF EXISTS master.dim_trade;
CREATE TABLE
    master.dim_trade
(
    TradeID         INT   NOT NULL,
    -- Trade identifier
    SK_BrokerID     INT,
    -- Surrogate key for BrokerID
    SK_CreateDateID INT   NOT NULL,
    -- Surrogate key for date created
    SK_CreateTimeID INT   NOT NULL,
    -- Surrogate key for time created
    SK_CloseDateID  INT,
    -- Surrogate key for date closed
    SK_CloseTimeID  INT,
    -- Surrogate key for time closed
    Status          TEXT  NOT NULL,
    -- Trade status
    Type            TEXT  NOT NULL,
    -- Trade type
    CashFlag        BOOLEAN NOT NULL,
    -- Is this trade a cash (1) or margin (0) trade?
    SK_SecurityID   INT   NOT NULL,
    -- Surrogate key for SecurityID
    SK_CompanyID    INT   NOT NULL,
    -- Surrogate key for CompanyID
    Quantity        INT NOT NULL,
    -- Quantity of securities traded.
    BidPrice        FLOAT NOT NULL,
    -- The requested unit price.
    SK_CustomerID   INT   NOT NULL,
    -- Surrogate key for CustomerID
    SK_AccountID    INT   NOT NULL,
    -- Surrogate key for AccountID
    ExecutedBy      TEXT  NOT NULL,
    -- Name of person executing the trade.
    TradePrice      FLOAT,
    -- Unit price at which the security was traded.
    Fee             FLOAT,
    -- Fee charged for placing this trade request
    Commission      FLOAT,
    -- Commission earned on this trade
    Tax             FLOAT,
    -- Amount of tax due on this trade
    BatchID         INT   NOT NULL
    -- Batch ID when this record was inserted
);
