DROP TABLE IF EXISTS master.dim_account;
CREATE TABLE
    master.dim_account
(
    SK_AccountID  bigint   NOT NULL,
    AccountID     bigint   NOT NULL,
    SK_BrokerID   bigint   NOT NULL,
    SK_CustomerID bigint   NOT NULL,
    Status        text  NOT NULL,
    AccountDesc   text,
    TaxStatus     bigint   NOT NULL,
    IsCurrent     BOOLEAN NOT NULL,
    BatchID       bigint   NOT NULL,
    EffectiveDate DATE    NOT NULL,
    EndDate       DATE    NOT NULL
);