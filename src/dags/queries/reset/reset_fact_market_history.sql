DROP TABLE IF EXISTS master.fact_market_history;
CREATE TABLE
    master.fact_market_history
(
    SK_SecurityID           Integer   NOT NULL,
    SK_CompanyID            Integer   NOT NULL,
    SK_DateID               Integer   NOT NULL,
    PERatio                 float,
    Yield                   float NOT NULL,
    FiftyTwoWeekHigh        float NOT NULL,
    SK_FiftyTwoWeekHighDate Integer   NOT NULL,
    FiftyTwoWeekLow         float NOT NULL,
    SK_FiftyTwoWeekLowDate  Integer   NOT NULL,
    ClosePrice              float NOT NULL,
    DayHigh                 float NOT NULL,
    DayLow                  float NOT NULL,
    Volume                  Integer   NOT NULL,
    BatchID                 Integer   NOT NULL 
);