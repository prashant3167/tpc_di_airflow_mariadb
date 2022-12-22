staging.customer_historical

CREATE TABLE staging.customer_historical (
  `Action` text DEFAULT NULL,
  `EffectiveDate` datetime DEFAULT NULL,
  `Phone1` text DEFAULT NULL,
  `Phone2` text DEFAULT NULL,
  `Phone3` text DEFAULT NULL,
  `Tier` text DEFAULT NULL,
  `CustomerID` text DEFAULT NULL,
  `Gender` mediumtext DEFAULT NULL,
  `Email1` text DEFAULT NULL,
  `Email2` text DEFAULT NULL,
  `TaxID` text DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `FirstName` text DEFAULT NULL,
  `MiddleInitial` text DEFAULT NULL,
  `LastName` text DEFAULT NULL,
  `Country` text DEFAULT NULL,
  `City` text DEFAULT NULL,
  `PostalCode` text DEFAULT NULL,
  `AddressLine1` text DEFAULT NULL,
  `AddressLine2` text DEFAULT NULL,
  `State_Prov` text DEFAULT NULL,
  `Status` text DEFAULT NULL,
  `NationalTaxID` text DEFAULT NULL,
  `LocalTaxID` text DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL
)