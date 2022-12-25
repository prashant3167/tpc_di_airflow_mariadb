DROP TABLE IF EXISTS master.dim_trade;
CREATE TABLE
    master.dim_trade
(
    TradeID         Integer   NOT NULL,
    SK_BrokerID     Integer,
    SK_CreateDateID Integer   NOT NULL,
    SK_CreateTimeID Integer   NOT NULL,
    SK_CloseDateID  Integer,
    SK_CloseTimeID  Integer,
    Status          text  NOT NULL,
    Type            text  NOT NULL,
    CashFlag        BOOLEAN NOT NULL,
    SK_SecurityID   Integer   NOT NULL,
    SK_CompanyID    Integer   NOT NULL,
    Quantity        Integer NOT NULL,
    BidPrice        float NOT NULL,
    SK_CustomerID   Integer   NOT NULL,
    SK_AccountID    Integer   NOT NULL,
    ExecutedBy      text  NOT NULL,
    TradePrice      float,
    Fee             float,
    Commission      float,
    Tax             float,
    BatchID         Integer   NOT NULL
);