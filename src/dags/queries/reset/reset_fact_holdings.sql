DROP TABLE IF EXISTS master.fact_holdings;
CREATE TABLE master.fact_holdings
(
    TradeID        INT   NOT NULL, -- Key for Orignial Trade Indentifier
    CurrentTradeID INT   NOT NULL, -- Key for the current trade
    SK_CustomerID  INT   NOT NULL, -- Surrogate key for Customer Identifier
    SK_AccountID   INT   NOT NULL, -- key for Account Identifier
    SK_SecurityID  INT   NOT NULL, -- Surrogate key for Security Identifier
    SK_CompanyID   INT   NOT NULL, -- Surrogate key for Company Identifier
    SK_DateID      INT   NOT NULL, -- Surrogate key for the date associated with the current trade
    SK_TimeID      INT   NOT NULL, -- key for the time associated with thecurrent trade
    CurrentPrice   FLOAT NOT NULL, -- > 0Unit price of this security for the current trade
    CurrentHolding INT   NOT NULL, -- Quantity of a security held after the current trade.The value can be a positive or negative integer
    BatchID        INT   NOT NULL
);