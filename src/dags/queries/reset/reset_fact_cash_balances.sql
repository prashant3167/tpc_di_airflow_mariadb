DROP TABLE IF EXISTS master.fact_cash_balances;
CREATE TABLE
    master.fact_cash_balances
(
    SK_CustomerID Integer   NOT NULL,
    SK_AccountID  Integer   NOT NULL,
    SK_DateID     Integer   NOT NULL,
    Cash          float NOT NULL,
    BatchID       Integer   NOT NULL
);