CREATE TABLE staging.cmp_records (
  `PTS` datetime DEFAULT NULL,
  `CompanyName` varchar(60) DEFAULT NULL,
  `CIK` bigint(10) DEFAULT NULL,
  `Status` varchar(4) DEFAULT NULL,
  `IndustryID` varchar(2) DEFAULT NULL,
  `SPrating` varchar(4) DEFAULT NULL,
  `FoundingDate` date DEFAULT NULL,
  `AddrLine1` varchar(80) DEFAULT NULL,
  `AddrLine2` varchar(80) DEFAULT NULL,
  `PostalCode` varchar(12) DEFAULT NULL,
  `City` varchar(25) DEFAULT NULL,
  `StateProvince` varchar(20) DEFAULT NULL,
  `Country` varchar(24) DEFAULT NULL,
  `CEOname` varchar(46) DEFAULT NULL,
  `Description` varchar(150) DEFAULT NULL
);