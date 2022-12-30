CREATE TABLE if NOT EXISTS master.fact_market_history (
    `DM_S_SYMB` char(30) NOT NULL,
    `DM_DATE` date NOT NULL,
    `SK_DateID` int(11) NOT NULL,
    `DM_CLOSE` decimal(4, 0) NOT NULL,
    `DM_HIGH` decimal(4, 0) NOT NULL,
    `DM_LOW` decimal(4, 0) NOT NULL,
    `DM_VOL` int(11) NOT NULL,
    `FiftyTwoWeekHigh` decimal(4, 0) DEFAULT NULL,
    `SK_FiftyTwoWeekHighDate` int(11) DEFAULT NULL,
    `FiftyTwoWeekLOW` decimal(4, 0) DEFAULT NULL,
    `SK_FiftyTwoWeekLowDate` int(11) DEFAULT NULL,
    `SK_SecurityID` text DEFAULT NULL,
    `SK_CompanyID` bigint(20) DEFAULT NULL,
    `Yield` float DEFAULT NULL,
    `PEratio` float DEFAULT NULL
);

delete from
    master.fact_market_history;

insert into master.fact_market_history
SELECT
    l.DM_S_SYMB,
    l.DM_DATE,
    l.SK_DateID,
    l.DM_CLOSE,
    l.DM_HIGH,
    l.DM_LOW,
    l.DM_VOL,
    l.high/100000000,
    cast(l.high%100000000 as int),
    l.low/100000000,
    cast(l.low%100000000 as int),
    Null,
    Null,
    Null,
    Null
FROM
    staging.t_all_v2 l;

CREATE TABLE if not EXISTS staging.`EPS` (
    `SUM_FI_BASIC_EPS` double DEFAULT NULL,
    `FI_YEAR` int(11) NOT NULL,
    `FI_QTR` int(11) NOT NULL,
    `SK_CompanyID` bigint(20) NOT NULL,
    `FOR_DATE` bigint(15) NOT NULL,
    KEY `eps_in` (`SK_CompanyID`, `FOR_DATE`)
);

delete from
    staging.`EPS`;

insert into staging.EPS
select
    sum(FI_BASIC_EPS) OVER (
        PARTITION BY c.CompanyID
        order by
            f.FI_QTR_START_DATE ROWS BETWEEN 3 PRECEDING
            AND CURRENT ROW
    ) as "SUM_FI_BASIC_EPS",
    f.FI_YEAR,
    f.FI_QTR,
    f.SK_CompanyID,
    case
        when FI_QTR = 4 then (f.FI_YEAR + 1) * 10 + 1
        else f.FI_YEAR * 10 +(FI_QTR + 1)
    end "FOR_DATE"
from
    master.financial f
    join master.dim_company c on f.SK_CompanyID = c.SK_CompanyID;

update
    master.fact_market_history t,
    master.dim_security S
SET
    t.SK_SecurityID = S.SK_SecurityID,
    t.SK_CompanyID = S.SK_CompanyID,
    t.Yield =(S.Dividend * 100) / t.DM_CLOSE
where
    t.DM_S_SYMB = S.Symbol
    and t.DM_DATE >= EffectiveDate
    and t.DM_DATE < EndDate;

update
    master.fact_market_history T,
    staging.EPS E
set
    T.PERatio = T.DM_CLOSE / E.SUM_FI_BASIC_EPS
where
    E.SK_CompanyID = T.SK_CompanyID
    and year(DM_DATE) * 10 + QUARTER(DM_DATE) = E.FOR_DATE;