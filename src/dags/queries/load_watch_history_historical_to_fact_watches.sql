-- Need index
CREATE INDEX IF NOT EXISTS DIM_CUS1_INDEX ON master.dim_customer(CustomerID);
CREATE INDEX IF NOT EXISTS DIM_CUS2_INDEX ON master.dim_security(Symbol);
CREATE INDEX IF NOT EXISTS DIM_CUS3_INDEX ON master.dim_date(DateValue);
CREATE INDEX IF NOT EXISTS DIM_CUS4_INDEX ON master.dim_date(DateValue);
CREATE INDEX IF NOT EXISTS watch_history_INDEX ON staging.watch_history_historical(W_C_ID,W_S_SYMB) using hash;

insert into {{ params.table }}
WITH watches AS (
    SELECT st.W_C_ID, TRIM(st.W_S_SYMB) AS W_S_SYMB, DATE(st.W_DTS) AS DatePlaced, DATE(en.W_DTS) AS DateRemoved
    FROM staging.watch_history_historical st
             LEFT JOIN staging.watch_history_historical en ON st.W_C_ID = en.W_C_ID AND st.W_S_SYMB = en.W_S_SYMB
    WHERE st.W_ACTION = 'ACTV'
      AND en.W_ACTION = 'CNCL'
)
SELECT SK_CustomerID,
       SK_SecurityID,
       sd.SK_DateID AS SK_DateID_DatePlaced,
       ed.SK_DateID AS SK_DateID_DateRemoved,
       1            AS BatchID
FROM watches w
         JOIN master.dim_customer c ON w.W_C_ID = c.CustomerID
         JOIN master.dim_security s ON w.W_S_SYMB = s.Symbol
         JOIN master.dim_date sd ON w.DatePlaced = sd.DateValue
         LEFT JOIN master.dim_date ed ON w.DateRemoved = ed.DateValue;

-- Need index
-- CREATE INDEX DIM_CUS1_INDEX ON master.dim_customer(CustomerID);
-- CREATE INDEX DIM_CUS2_INDEX ON master.dim_security(Symbol);
-- CREATE INDEX DIM_CUS3_INDEX ON master.dim_date(DateValue);
-- CREATE INDEX DIM_CUS4_INDEX ON master.dim_date(DateValue);