create index IF NOT EXISTS dim_date_ind1 on master.dim_date(SK_DateID) using HASH;

create index IF NOT EXISTS dim_time_ind1 on master.dim_time(SecondDesc) using HASH;

create index if not EXISTS dim_account_index on master.dim_account(AccountID);

create index if not EXISTS dim_account_index2 on master.dim_account(EffectiveDate);

create index if not EXISTS dim_account_index3 on master.dim_account(EndDate);

create index if not EXISTS l on master.dim_security(Symbol);

create index if not EXISTS m on master.dim_security(EndDate);

create index if not EXISTS z on master.dim_security(EffectiveDate);

create index if not EXISTS l on master.dim_broker(EffectiveDate);

create index if not EXISTS m on master.dim_broker(EndDate);

create index if not EXISTS z on master.dim_broker(BrokerID);

create index if not EXISTS cut_dim_index on master.dim_broker(BrokerID);

create index if not EXISTS DIM_CUS1_INDEX on master.dim_customer(CustomerID);

create index if not EXISTS trade_type_ind on master.trade_type(TT_ID);

create index if not EXISTS TH_IND on staging.trade_history_historical(TH_T_ID);

create index if not EXISTS TH_IND2 on staging.trade_history_historical(TH_DTS);

create index if not EXISTS watch_index on staging.watch_history_historical(W_C_ID, W_S_SYMB);

create index if not EXISTS watch_index2 on staging.watch_history_historical(W_ACTION);

create index if not EXISTS trade_historical_ind on staging.trade_historical(T_ID);

create index if not EXISTS trade_historical_ind2 on staging.trade_historical(T_ST_ID);

create index if not EXISTS trade_historical_ind3 on staging.trade_historical(T_TT_ID);

create index if not EXISTS trade_historical_ind4 on staging.trade_historical(T_S_SYMB);

INSERT into
    {{ params.table }} with abc as (
        SELECT
            T.T_ID AS TradeID,
            1 AS SK_BrokerID,
            CASE
                WHEN TH.TH_ST_ID = 'SBMT'
                AND T.T_TT_ID IN ('TMB', 'TMS')
                OR TH.TH_ST_ID = 'PNDG' THEN DATE_FORMAT(TH.TH_DTS, '%Y%m%d')
                WHEN TH.TH_ST_ID IN ('CMPT', 'CNCL') THEN NULL
            END AS SK_CreateDateID,
            CASE
                WHEN TH.TH_ST_ID = 'SBMT'
                AND T.T_TT_ID IN ('TMB', 'TMS')
                OR TH.TH_ST_ID = 'PNDG' THEN DATE_FORMAT(TH.TH_DTS, '%T')
                WHEN TH.TH_ST_ID IN ('CMPT', 'CNCL') THEN NULL
            END AS SK_CreateTimeID,
            CASE
                WHEN TH.TH_ST_ID = 'SBMT'
                AND T.T_TT_ID IN ('TMB', 'TMS')
                OR TH.TH_ST_ID = 'PNDG' THEN NULL
                WHEN TH.TH_ST_ID IN ('CMPT', 'CNCL') THEN cast(DATE_FORMAT(TH.TH_DTS, '%Y%m%d') as int)
            END AS SK_CloseDateID,
            CASE
                WHEN TH.TH_ST_ID = 'SBMT'
                AND T.T_TT_ID IN ('TMB', 'TMS')
                OR TH.TH_ST_ID = 'PNDG' THEN NULL
                WHEN TH.TH_ST_ID IN ('CMPT', 'CNCL') THEN DATE_FORMAT(TH.TH_DTS, '%T')
            END AS SK_CloseTimeID,
            T.T_IS_CASH AS CashFlag,
            Null AS SK_SecurityID,
            NUll AS SK_CompanyID,
            T.T_QTY AS Quantity,
            T.T_BID_PRICE AS BidPrice,
            NULL AS SK_CustomerID,
            NULL AS SK_AccountID,
            T.T_EXEC_NAME AS ExecutedBy,
            T.T_TRADE_PRICE AS TradePrice,
            T.T_CHRG AS Fee,
            T.T_COMM AS Commission,
            T.T_TAX AS Tax,
            1 AS BatchID,
            row_number() over(
                partition by T.T_ID
                order by
                    TH.TH_DTS desc
            ) as rn,
            date(TH.TH_DTS) as TH_DTS,
            T.T_ST_ID,
            T.T_TT_ID,
            T_S_SYMB,
            T.T_CA_ID
        FROM
            staging.trade_historical T
            INNER JOIN staging.trade_history_historical TH ON T.T_ID = TH.TH_T_ID
    ),
    trade_all as(
        SELECT
            TradeID,
            SK_BrokerID,
            SK_CreateDateID,
            SK_CreateTimeID,
            SK_CloseDateID,
            SK_CloseTimeID,
            CashFlag,
            (
                select
                    SK_SecurityID
                from
                    master.dim_security
                where
                    T.T_S_SYMB = Symbol
                    and T.TH_DTS >= EffectiveDate
                    and T.TH_DTS < EndDate
            ) as "SK_SecurityID",
            (
                select
                    SK_CompanyID
                from
                    master.dim_security
                where
                    T.T_S_SYMB = Symbol
                    and T.TH_DTS >= EffectiveDate
                    and T.TH_DTS < EndDate
            ) as "SK_CompanyID",
            Quantity,
            BidPrice,
            T_CA_ID,
            ExecutedBy,
            TradePrice,
            Fee,
            Commission,
            Tax,
            BatchID,
            TH_DTS,
            T_ST_ID,
            T_TT_ID,
            T_S_SYMB
        from
            abc T
        where
            rn = 1
    ),
    trade_creation as (
        select
            TradeID,
            min(concat(SK_CreateDateID, SK_CreateTimeID)) as trade_creation
        from
            trade_all
        group by
            TradeID
    ),
    final_merge as (
        SELECT
            t.TRADEID,
            SK_BrokerID,
            COALESCE(
                (
                    select
                        COALESCE(SK_DateID, 0)
                    from
                        master.dim_date
                    where
                        SK_DateID = cast(SUBSTR(tc.trade_creation, 1, 8) as int)
                ),
                0
            ) as "SK_CreateDateID",
            COALESCE(
                (
                    select
                        SK_TimeID
                    from
                        master.dim_time
                    where
                        SecondDesc = SUBSTR(tc.trade_creation, 9, 8)
                ),
                0
            ) as "SK_CreateTimeID",
            (
                select
                    SK_DateID
                from
                    master.dim_date
                where
                    SK_DateID = SK_CloseDateID
            ) as "SK_CloseDateID",
            (
                select
                    SK_TimeID
                from
                    master.dim_time
                where
                    SecondDesc = SK_CloseTimeID
            ) as "SK_CloseTimeID",
            ST.ST_NAME AS Status,
            TT.TT_NAME AS "Type",
            CashFlag,
            SK_SecurityID,
            SK_CompanyID,
            Quantity,
            BidPrice,
            -- 0 as  SK_CustomerID,
            -- 0 as SK_AccountID,
            ExecutedBy,
            TradePrice,
            Fee,
            Commission,
            Tax,
            BatchID,
            TH_DTS,
            T_CA_ID
        from
            trade_all t
            left join trade_creation tc on t.TRADEID = tc.TRADEID
            INNER JOIN master.status_type ST ON t.T_ST_ID = ST.ST_ID
            INNER JOIN master.trade_type TT ON t.T_TT_ID = TT.TT_ID
    )
select
    TRADEID,
    A.SK_BrokerID,
    SK_CreateDateID,
    SK_CreateTimeID,
    SK_CloseDateID,
    SK_CloseTimeID,
    T.Status,
    Type,
    CashFlag,
    SK_SecurityID,
    SK_CompanyID,
    Quantity,
    BidPrice,
    SK_CustomerID,
    SK_AccountID,
    ExecutedBy,
    TradePrice,
    Fee,
    Commission,
    Tax,
    T.BatchID
from
    final_merge T
    inner join master.dim_account A on T.T_CA_ID = a.AccountID
    and TH_DTS >= A.EffectiveDate
    and TH_DTS < A.EndDate;

-- with trade_init as(SELECT
--         T.T_ID AS TradeID,
--         1 AS SK_BrokerID,
--         CASE
--             WHEN TH.TH_ST_ID = 'SBMT'
--             AND T.T_TT_ID IN ('TMB', 'TMS')
--             OR TH.TH_ST_ID = 'PNDG' THEN DATE_FORMAT(TH.TH_DTS, '%Y%m%d')
--             WHEN TH.TH_ST_ID IN ('CMPT', 'CNCL') THEN NULL
--         END AS SK_CreateDateID,
--         CASE
--             WHEN TH.TH_ST_ID = 'SBMT'
--             AND T.T_TT_ID IN ('TMB', 'TMS')
--             OR TH.TH_ST_ID = 'PNDG' THEN DATE_FORMAT(TH.TH_DTS, '%T')
--             WHEN TH.TH_ST_ID IN ('CMPT', 'CNCL') THEN NULL
--         END AS SK_CreateTimeID,
--         CASE
--             WHEN TH.TH_ST_ID = 'SBMT'
--             AND T.T_TT_ID IN ('TMB', 'TMS')
--             OR TH.TH_ST_ID = 'PNDG' THEN NULL
--             WHEN TH.TH_ST_ID IN ('CMPT', 'CNCL') THEN cast(DATE_FORMAT(TH.TH_DTS, '%Y%m%d') as int)
--         END AS SK_CloseDateID,
--         CASE
--             WHEN TH.TH_ST_ID = 'SBMT'
--             AND T.T_TT_ID IN ('TMB', 'TMS')
--             OR TH.TH_ST_ID = 'PNDG' THEN NULL
--             WHEN TH.TH_ST_ID IN ('CMPT', 'CNCL') THEN DATE_FORMAT(TH.TH_DTS, '%T')
--         END AS SK_CloseTimeID,
--         ST.ST_NAME AS Status,
--         TT.TT_NAME AS "Type",
--         T.T_IS_CASH AS CashFlag,
--         S.SK_SecurityID AS SK_SecurityID,
--         S.SK_CompanyID AS SK_CompanyID,
--         T.T_QTY AS Quantity,
--         T.T_BID_PRICE AS BidPrice,
--         A.SK_CustomerID AS SK_CustomerID,
--         A.SK_AccountID AS SK_AccountID,
--         T.T_EXEC_NAME AS ExecutedBy,
--         T.T_TRADE_PRICE AS TradePrice,
--         T.T_CHRG AS Fee,
--         T.T_COMM AS Commission,
--         T.T_TAX AS Tax,
--         1 AS BatchID,
--         row_number() over(
--             partition by T.T_ID
--             order by
--                 TH.TH_DTS desc
--         ) as rn
--     FROM
--         staging.trade_historical T
--         INNER JOIN staging.trade_history_historical TH ON T.T_ID = TH.TH_T_ID
--         INNER JOIN master.status_type ST ON T.T_ST_ID = ST.ST_ID
--         INNER JOIN master.trade_type TT ON T.T_TT_ID = TT.TT_ID
--         inner join master.dim_security S on T.T_S_SYMB = S.Symbol
--         and date(TH.TH_DTS) >= S.EffectiveDate
--         and date(th.th_dts) < s.EndDate
--         inner join master.dim_account A on T.T_CA_ID = a.AccountID
--         and date(TH.TH_DTS) >= A.EffectiveDate
--         and date(TH.TH_DTS) < A.EndDate
-- ), trade_creation as (
--     select
--         TradeID,
--         min(concat(SK_CreateDateID, SK_CreateTimeID)) as trade_creation
--     from
--         trade_init
--     group by
--         TradeID
-- ),
-- trade_all as(
--     select
--         *
--     from
--         trade_init
--     where
--         rn = 1
-- )
-- SELECT
--     t.TRADEID,
--     SK_BrokerID,
--         COALESCE((select
--             COALESCE(SK_DateID,0)
--         from
--             master.dim_date
--         where
--             SK_DateID = cast(SUBSTR(tc.trade_creation, 1, 8) as int)
--     ),0) as "SK_CreateDateID",
--     COALESCE((
--         select
--             SK_TimeID
--         from
--             master.dim_time
--         where
--             SecondDesc = SUBSTR(tc.trade_creation, 9, 8)
--     ),0) as "SK_CreateTimeID",
--     (
--         select
--             SK_DateID
--         from
--             master.dim_date
--         where
--             SK_DateID = SK_CloseDateID
--     ) as "SK_CloseDateID",
--     (
--         select
--             SK_TimeID
--         from
--             master.dim_time
--         where
--             SecondDesc = SK_CloseTimeID
--     ) as "SK_CloseTimeID",
--     Status,
--     Type,
--     CashFlag,
--     SK_SecurityID,
--     SK_CompanyID,
--     Quantity,
--     BidPrice,
--     SK_CustomerID,
--     SK_AccountID,
--     ExecutedBy,
--     TradePrice,
--     Fee,
--     Commission,
--     Tax,
--     BatchID
-- from
--     trade_all t
--     left join trade_creation tc on t.TRADEID = tc.TRADEID;