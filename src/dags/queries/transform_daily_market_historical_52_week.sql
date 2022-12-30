
create index IF NOT EXISTS daily_market_historical_ind on staging.daily_market_historical(DM_DATE);
create index IF NOT EXISTS daily_market_historical2_ind on staging.daily_market_historical(DM_S_SYMB);
create index IF NOT EXISTS daily_market_historical3_ind on staging.daily_market_with_date(DM_S_SYMB,DM_DATE);
create index IF NOT EXISTS dim_date_index on master.dim_date(DateValue);


drop table IF EXISTS staging.t_all_v2; -- Clean up

CREATE TABLE if not exists staging.t_all_v2 (
    `DM_S_SYMB` char(30) NOT NULL,
    `DM_DATE` date NOT NULL,
    `SK_DateID` int(11) NOT NULL,
    `DM_CLOSE` decimal(4, 0) NOT NULL,
    `DM_HIGH` decimal(4, 0) NOT NULL,
    `DM_LOW` decimal(4, 0) NOT NULL,
    `DM_VOL` int(11) NOT NULL,
    `high` bigint DEFAULT NULL,
    `low` bigint DEFAULT NULL
);


insert into staging.t_all_v2
with t_all as (SELECT
    h.*,
    d.SK_DateID
FROM
    staging.daily_market_historical h
    JOIN master.dim_date d ON h.DM_DATE = d.DateValue)
SELECT
    l.DM_S_SYMB,
    l.DM_DATE,
    l.SK_DateID,
    l.DM_CLOSE,
    l.DM_HIGH,
    l.DM_LOW,
    l.DM_VOL,
    max(DM_HIGH*100000000+SK_DateID) over(
        partition by DM_S_SYMB
        order by
            DM_DATE rows between 363 preceding
            and current row
    ) as high,
     min(DM_LOW*100000000+SK_DateID) over(
        partition by DM_S_SYMB
        order by
            DM_DATE rows between 363 preceding
            and current row
    ) as low
FROM
    t_all l;