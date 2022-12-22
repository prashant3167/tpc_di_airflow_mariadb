DROP TABLE IF EXISTS master.fact_market_history;
CREATE TABLE
    master.fact_market_history
(
    SK_SecurityID           INT   NOT NULL,
    -- Surrogate key for SecurityID
    SK_CompanyID            INT   NOT NULL,
    -- Surrogate key for CompanyID
    SK_DateID               INT   NOT NULL,
    -- Surrogate key for the date
    PERatio                 FLOAT,
    -- Price to earnings per share ratio
    Yield                   FLOAT NOT NULL,
    -- Dividend to price ratio, as a percentage
    FiftyTwoWeekHigh        FLOAT NOT NULL,
    -- Security highest price in last 52 weeks from this day
    SK_FiftyTwoWeekHighDate INT   NOT NULL,
    -- Earliest date on which the 52 week high price was set
    FiftyTwoWeekLow         FLOAT NOT NULL,
    -- Security lowest price in last 52 weeks from this day
    SK_FiftyTwoWeekLowDate  INT   NOT NULL,
    -- Earliest date on which the 52 week low price was set
    ClosePrice              FLOAT NOT NULL,
    -- Security closing price on this day
    DayHigh                 FLOAT NOT NULL,
    -- Highest price for the security on this day
    DayLow                  FLOAT NOT NULL,
    -- Lowest price for the security on this day
    Volume                  INT   NOT NULL,
    -- Trading volume of the security on this day
    BatchID                 INT   NOT NULL -- Batch ID when this record was inserted
);
