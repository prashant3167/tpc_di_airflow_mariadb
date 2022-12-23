CREATE TABLE staging.account_historical (
  `CustomerID` integer DEFAULT NULL,
  `AccountID` integer DEFAULT NULL,
  `BrokerID` integer DEFAULT NULL,
  `AccountDesc` text DEFAULT NULL,
  `TaxStatus` int DEFAULT NULL,
  `Action` text DEFAULT NULL,
  `Status` varchar(8) DEFAULT NULL,
  `EffectiveDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL
);



create index cus_index if not EXISTS on staging.account_historical(CustomerID);
create index bro_index if not EXISTS on staging.account_historical(BrokerID);
