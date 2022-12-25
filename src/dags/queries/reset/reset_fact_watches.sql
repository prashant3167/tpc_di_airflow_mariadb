DROP TABLE IF EXISTS master.fact_watches;
CREATE TABLE master.fact_watches
(
    SK_CustomerID         Integer NOT NULL,
    SK_SecurityID         Integer NOT NULL,
    SK_DateID_DatePlaced  Integer NOT NULL,
    SK_DateID_DateRemoved Integer,          
    BatchID               Integer NOT NULL
);