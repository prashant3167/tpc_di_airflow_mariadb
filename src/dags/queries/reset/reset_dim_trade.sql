DROP TABLE IF EXISTS master.dim_trade;
CREATE TABLE
    master.dim_trade
(
    TradeID         integer   NOT NULL,
        SK_BrokerID     integer,
        SK_CreateDateID integer   NOT NULL,
        SK_CreateTimeID integer   NOT NULL,
        SK_CloseDateID  integer,
        SK_CloseTimeID  integer,
        Status          text  NOT NULL,
        Type            text  NOT NULL,
        CashFlag        BOOLEAN NOT NULL,
        SK_SecurityID   integer   NOT NULL,
        SK_CompanyID    integer   NOT NULL,
        Quantity        integer NOT NULL,
        BidPrice        float NOT NULL,
        SK_CustomerID   integer   NOT NULL,
        SK_AccountID    integer   NOT NULL,
        ExecutedBy      text  NOT NULL,
        TradePrice      float,
        Fee             float,
        Commission      float,
        Tax             float,
        BatchID         integer   NOT NULL
    );