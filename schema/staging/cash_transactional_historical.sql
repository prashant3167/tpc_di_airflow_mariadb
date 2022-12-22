CREATE TABLE staging.cash_transaction_historical(
      CT_CA_ID INTEGER NOT NULL,
      CT_DTS DATE NOT NULL,
      CT_AMT CHAR(20) NOT NULL,
      CT_NAME CHAR(100) NOT NULL
    );