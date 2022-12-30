DROP TABLE IF EXISTS master.fact_holdings;
CREATE TABLE master.fact_holdings
(
    TradeID        bigint   NOT NULL, 
    CurrentTradeID bigint   NOT NULL, 
    SK_CustomerID  bigint   NOT NULL, 
    SK_AccountID   bigint   NOT NULL, 
    SK_SecurityID  text   NOT NULL, 
    SK_CompanyID   bigint   NOT NULL, 
    SK_DateID      bigint   NOT NULL, 
    SK_TimeID      bigint   NOT NULL, 
    CurrentPrice   NUMERIC NOT NULL, 
    CurrentHolding bigint   NOT NULL, 
    BatchID        bigint   NOT NULL
);