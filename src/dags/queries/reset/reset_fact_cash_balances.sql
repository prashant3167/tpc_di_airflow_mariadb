DROP TABLE IF EXISTS master.fact_cash_balances;
CREATE TABLE
    master.fact_cash_balances
(
    SK_CustomerID bigint   NOT NULL,
        SK_AccountID  bigint   NOT NULL,
        SK_DateID     bigint   NOT NULL,
        Cash          NUMERIC NOT NULL,
        BatchID       bigint   NOT NULL
    );