CREATE TABLE staging.account_historical (
  `CustomerID` text DEFAULT NULL,
  `AccountID` text DEFAULT NULL,
  `BrokerID` text DEFAULT NULL,
  `AccountDesc` text DEFAULT NULL,
  `TaxStatus` text DEFAULT NULL,
  `Action` text DEFAULT NULL,
  `Status` varchar(8) DEFAULT NULL,
  `EffectiveDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL
)