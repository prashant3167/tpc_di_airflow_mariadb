DROP TABLE IF EXISTS master.fact_cash_balances;
CREATE TABLE
    master.fact_cash_balances
(
    SK_CustomerID INT   NOT NULL,
    -- Surrogate key for CustomerID
    SK_AccountID  INT   NOT NULL,
    -- Surrogate key for AccountID
    SK_DateID     INT   NOT NULL,
    -- Surrogate key for the date
    Cash          FLOAT NOT NULL,
    -- Cash balance for the account after applying changes for this day
    BatchID       INT   NOT NULL
    -- Batch ID when this record was inserted
);