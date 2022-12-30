create index IF NOT EXISTS cash_transaction_historical_index on staging.cash_transaction_historical(CT_CA_ID);
create index IF NOT EXISTS dim_account_index on master.dim_account(AccountID);

INSERT into  {{ params.table }}
WITH cash_balance_day AS (
    SELECT CT_CA_ID, DATE(CT_DTS) AS TradeDate, SUM(CT_AMT) AS DayCash
    FROM staging.cash_transaction_historical
    GROUP BY 1, 2
)
SELECT SK_CustomerID,
       SK_AccountID,
       SK_DateID,
       CAST(SUM(c.DayCash) OVER (PARTITION BY CT_CA_ID ORDER BY TradeDate ASC ) AS float) AS Cash,
       1                                                                                    AS BatchID
FROM cash_balance_day c
         JOIN master.dim_account acc
              ON acc.AccountID = c.CT_CA_ID AND c.TradeDate >= acc.EffectiveDate AND c.TradeDate < acc.EndDate
         JOIN master.dim_date d ON d.DateValue = c.TradeDate;



