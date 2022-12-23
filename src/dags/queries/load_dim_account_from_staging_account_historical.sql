create index if not exists cut_dim_index on master.dim_broker(BrokerID);


insert into {{ params.table }}
SELECT
    CAST(CONCAT(DATE_FORMAT(acc.EffectiveDate, '%Y%m%d'), CAST(acc.AccountID AS CHAR)) as int) AS SK_AccountID,
    acc.AccountID AS AccountID,
    bro.SK_BrokerID AS SK_BrokerID,
    cus.SK_CustomerID AS SK_CustomerID,
    acc.Status AS Status,
    acc.AccountDesc AS AccountDesc,
    TaxStatus AS TaxStatus,
    CASE
        WHEN acc.EndDate = DATE('9999-12-31') THEN TRUE
        ELSE
            FALSE
        END AS IsCurrent,
    1 AS BatchID,
    acc.EffectiveDate AS EffectiveDate,
    acc.EndDate AS EndDate
FROM (staging.account_historical acc
    JOIN
    master.dim_customer cus
    ON
             acc.CustomerID = cus.CustomerID)
         JOIN
     master.dim_broker bro
     ON
                 bro.BrokerID = acc.BrokerID
    where acc.TaxStatus is not NULL;


-- create index if not exists cut_dim_index on master.dim_customer(CustomerID);

-- create index i on staging.account_historical(CustomerID);
-- create index j on staging.account_historical(BrokerID);
-- create index k on master.dim_customer(CustomerID);
-- create index z on master.dim_broker(BrokerID);
-- drop index i on staging.account_historical;
-- drop index j on staging.account_historical;
-- drop index k on master.dim_customer;
-- drop index z on master.dim_broker;
