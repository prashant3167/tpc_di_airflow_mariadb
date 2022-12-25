DROP TABLE IF EXISTS master.fact_holdings;
CREATE TABLE master.fact_holdings
(
    TradeID        Integer   NOT NULL,
    CurrentTradeID Integer   NOT NULL,
    SK_CustomerID  Integer   NOT NULL,
    SK_AccountID   Integer   NOT NULL,
    SK_SecurityID  Integer   NOT NULL,
    SK_CompanyID   Integer   NOT NULL,
    SK_DateID      Integer   NOT NULL,
    SK_TimeID      Integer   NOT NULL,
    CurrentPrice   float NOT NULL,
    CurrentHolding Integer   NOT NULL,
    BatchID        Integer   NOT NULL
);