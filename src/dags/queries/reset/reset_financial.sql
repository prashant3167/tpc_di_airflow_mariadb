DROP TABLE IF EXISTS
    master.financial;
CREATE TABLE
    master.financial
(
    SK_CompanyID      INT   NOT NULL,
    -- Company SK
    FI_YEAR           INT   NOT NULL,
    -- Year of the quarter end
    FI_QTR            INT   NOT NULL,
    -- Quarter number that the financial information is for: valid values 1, 2, 3, 4
    FI_QTR_START_DATE DATE    NOT NULL,
    -- Start date of quarter
    FI_REVENUE        FLOAT NOT NULL,
    -- Reported revenue for the quarter
    FI_NET_EARN       FLOAT NOT NULL,
    -- Net earnings reported for the quarter
    FI_BASIC_EPS      FLOAT NOT NULL,
    -- Basic earnings per share for the quarter
    FI_DILUT_EPS      FLOAT NOT NULL,
    -- Diluted earnings per share for the quarter
    FI_MARGIN         FLOAT NOT NULL,
    -- Profit divided by revenues for the quarter
    FI_INVENTORY      FLOAT NOT NULL,
    -- Value of inventory on hand at the end of quarter
    FI_ASSETS         FLOAT NOT NULL,
    -- Value of total assets at the end of the quarter.
    FI_LIABILITY      FLOAT NOT NULL,
    -- Value of total liabilities at the end of thequarter.
    FI_OUT_BASIC      INT   NOT NULL,
    -- Average number of shares outstanding (basic).
    FI_OUT_DILUT      INT   NOT NULL -- Average number of shares outstanding(diluted)
);
