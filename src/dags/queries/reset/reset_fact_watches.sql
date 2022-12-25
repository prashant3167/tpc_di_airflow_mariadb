DROP TABLE IF EXISTS master.fact_watches;
CREATE TABLE master.fact_watches
(
    SK_CustomerID         bigint NOT NULL, 
    SK_SecurityID         text NOT NULL, 
    SK_DateID_DatePlaced  bigint NOT NULL, 
    SK_DateID_DateRemoved bigint,          
    BatchID               bigint NOT NULL  
);