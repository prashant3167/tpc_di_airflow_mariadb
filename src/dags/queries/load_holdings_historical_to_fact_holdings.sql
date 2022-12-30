delete from {{ params.table }};

create index IF NOT EXISTS HH_IND on staging.holding_history_historical(HH_T_ID);
INSERT into {{ params.table }}
SELECT h.HH_H_T_ID      AS TradeID,
       h.HH_T_ID        AS CurrentTradeID,
       t.SK_CustomerID,
       t.SK_AccountID,
       t.SK_SecurityID,
       t.SK_CompanyID,
       COALESCE(t.SK_CloseDateID,0) AS SK_DateID,
       COALESCE(t.SK_CloseTimeID,0) AS SK_TimeID,
       t.BidPrice       AS CurrentPrice,
       h.HH_AFTER_QTY   AS CurrentHolding,
       1                AS BatchID
FROM staging.holding_history_historical h
         JOIN master.dim_trade t ON h.HH_T_ID = t.TradeID;