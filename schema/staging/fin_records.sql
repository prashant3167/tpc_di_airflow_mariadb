CREATE TABLE staging.fin_records(
  `PTS` datetime DEFAULT NULL,
  `Year` integer DEFAULT NULL,
  `Quarter` integer DEFAULT NULL,
  `QtrStartDate` date DEFAULT NULL,
  `PostingDate` date DEFAULT NULL,
  `Revenue` float DEFAULT NULL,
  `Earnings` float DEFAULT NULL,
  `EPS` float DEFAULT NULL,
  `DilutedEPS` float DEFAULT NULL,
  `Margin` float DEFAULT NULL,
  `Inventory` float DEFAULT NULL,
  `Assets` float DEFAULT NULL,
  `Liabilities` float DEFAULT NULL,
  `ShOut` integer DEFAULT NULL,
  `DilutedShOut` integer DEFAULT NULL,
  `CIK` integer DEFAULT NULL,
  `CompanyName` text DEFAULT NULL
    );
