DROP TABLE IF EXISTS
    master.financial;
CREATE TABLE
    master.financial
(
    SK_CompanyID      Integer   NOT NULL,
    FI_YEAR           Integer   NOT NULL,
    FI_QTR            Integer   NOT NULL,
    FI_QTR_START_DATE DATE    NOT NULL,
    FI_REVENUE        float NOT NULL,
    FI_NET_EARN       float NOT NULL,
    FI_BASIC_EPS      float NOT NULL,
    FI_DILUT_EPS      float NOT NULL,
    FI_MARGIN         float NOT NULL,
    FI_INVENTORY      float NOT NULL,
    FI_ASSETS         float NOT NULL,
    FI_LIABILITY      float NOT NULL,
    FI_OUT_BASIC      Integer   NOT NULL,
    FI_OUT_DILUT      Integer   NOT NULL
);