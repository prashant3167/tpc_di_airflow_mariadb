-- master.di_messages definition

CREATE TABLE `di_messages` (
  `MessageDateAndTime` datetime DEFAULT NULL,
  `BatchID` int(11) DEFAULT NULL,
  `MessageSource` varchar(30) DEFAULT NULL,
  `MessageText` varchar(30) DEFAULT NULL,
  `MessageType` varchar(30) DEFAULT NULL,
  `MessageData` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.dim_account definition

CREATE TABLE `dim_account` (
  `SK_AccountID` bigint(20) NOT NULL,
  `AccountID` bigint(20) NOT NULL,
  `SK_BrokerID` bigint(20) NOT NULL,
  `SK_CustomerID` bigint(20) NOT NULL,
  `Status` text NOT NULL,
  `AccountDesc` text DEFAULT NULL,
  `TaxStatus` bigint(20) NOT NULL,
  `IsCurrent` tinyint(1) NOT NULL,
  `BatchID` bigint(20) NOT NULL,
  `EffectiveDate` date NOT NULL,
  `EndDate` date NOT NULL,
  KEY `dim_account_index` (`AccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.dim_broker definition

CREATE TABLE `dim_broker` (
  `SK_BrokerID` bigint(19) DEFAULT NULL,
  `BrokerID` int(11) NOT NULL,
  `ManagerID` int(11) NOT NULL,
  `EmployeeFirstName` char(30) NOT NULL,
  `EmployeeLastName` char(30) NOT NULL,
  `EmployeeMI` char(1) DEFAULT NULL,
  `EmployeeBranch` char(30) DEFAULT NULL,
  `EmployeeOffice` char(10) DEFAULT NULL,
  `EmployeePhone` char(14) DEFAULT NULL,
  `IsCurrent` int(1) NOT NULL,
  `BatchID` int(1) NOT NULL,
  `EffectiveDate` date,
  `EndDate` date DEFAULT NULL,
  KEY `l` (`EffectiveDate`),
  KEY `m` (`EndDate`),
  KEY `z` (`BrokerID`),
  KEY `cut_dim_index` (`BrokerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.dim_company definition

CREATE TABLE `dim_company` (
  `SK_CompanyID` bigint(20) NOT NULL,
  `CompanyID` bigint(20) NOT NULL,
  `Status` text NOT NULL,
  `Name` text NOT NULL,
  `Industry` text NOT NULL,
  `SPrating` text DEFAULT NULL,
  `isLowGrade` tinyint(1) DEFAULT NULL,
  `CEO` text NOT NULL,
  `AddressLine1` text DEFAULT NULL,
  `AddressLine2` text DEFAULT NULL,
  `PostalCode` text NOT NULL,
  `City` text NOT NULL,
  `StateProv` text NOT NULL,
  `Country` text DEFAULT NULL,
  `Description` text NOT NULL,
  `FoundingDate` date DEFAULT NULL,
  `IsCurrent` tinyint(1) NOT NULL,
  `BatchID` bigint(20) NOT NULL,
  `EffectiveDate` date NOT NULL,
  `EndDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.dim_customer definition

CREATE TABLE `dim_customer` (
  `SK_CustomerID` bigint(20) NOT NULL,
  `CustomerID` bigint(20) NOT NULL,
  `TaxID` text NOT NULL,
  `Status` text NOT NULL,
  `LastName` text NOT NULL,
  `FirstName` text NOT NULL,
  `MiddleInitial` text DEFAULT NULL,
  `Gender` text DEFAULT NULL,
  `Tier` bigint(20) DEFAULT NULL,
  `DOB` date NOT NULL,
  `AddressLine1` text NOT NULL,
  `AddressLine2` text DEFAULT NULL,
  `PostalCode` text NOT NULL,
  `City` text NOT NULL,
  `StateProv` text NOT NULL,
  `Country` text DEFAULT NULL,
  `Phone1` text DEFAULT NULL,
  `Phone2` text DEFAULT NULL,
  `Phone3` text DEFAULT NULL,
  `Email1` text DEFAULT NULL,
  `Email2` text DEFAULT NULL,
  `NationalTaxRateDesc` text DEFAULT NULL,
  `NationalTaxRate` decimal(10,0) DEFAULT NULL,
  `LocalTaxRateDesc` text DEFAULT NULL,
  `LocalTaxRate` decimal(10,0) DEFAULT NULL,
  `AgencyID` text DEFAULT NULL,
  `CreditRating` bigint(20) DEFAULT NULL,
  `NetWorth` bigint(20) DEFAULT NULL,
  `MarketingNameplate` text DEFAULT NULL,
  `IsCurrent` tinyint(1) NOT NULL,
  `BatchID` bigint(20) NOT NULL,
  `EffectiveDate` date NOT NULL,
  `EndDate` date NOT NULL,
  KEY `cut_dim_index` (`CustomerID`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.dim_date definition

CREATE TABLE `dim_date` (
  `SK_DateID` int(11) NOT NULL,
  `DateValue` date NOT NULL,
  `DateDesc` char(20) NOT NULL,
  `CalendarYearID` decimal(4,0) NOT NULL,
  `CalendarYearDesc` char(20) NOT NULL,
  `CalendarQtrID` decimal(5,0) NOT NULL,
  `CalendarQtrDesc` char(20) NOT NULL,
  `CalendarMonthID` decimal(6,0) NOT NULL,
  `CalendarMonthDesc` char(20) NOT NULL,
  `CalendarWeekID` decimal(6,0) NOT NULL,
  `CalendarWeekDesc` char(20) NOT NULL,
  `DayOfWeekNum` decimal(1,0) NOT NULL,
  `DayOfWeekDesc` char(10) NOT NULL,
  `FiscalYearID` decimal(4,0) NOT NULL,
  `FiscalYearDesc` char(20) NOT NULL,
  `FiscalQtrID` decimal(5,0) NOT NULL,
  `FiscalQtrDesc` char(20) NOT NULL,
  `HolidayFlag` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`SK_DateID`),
  KEY `DIM_CUS_INDEX` (`DateValue`),
  KEY `DIM_CUS3_INDEX` (`DateValue`),
  KEY `DIM_CUS4_INDEX` (`DateValue`),
  KEY `dim_date_index` (`DateValue`),
  KEY `njc` (`SK_DateID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.dim_security definition

CREATE TABLE `dim_security` (
  `SK_SecurityID` text NOT NULL,
  `Symbol` text NOT NULL,
  `Issue` text NOT NULL,
  `Status` text NOT NULL,
  `Name` text NOT NULL,
  `ExchangeID` text NOT NULL,
  `SK_CompanyID` bigint(20) NOT NULL,
  `SharesOutstanding` int(11) NOT NULL,
  `FirstTrade` date NOT NULL,
  `FirstTradeOnExchange` date NOT NULL,
  `Dividend` float NOT NULL,
  `IsCurrent` tinyint(1) NOT NULL,
  `BatchID` int(11) NOT NULL,
  `EffectiveDate` date NOT NULL,
  `EndDate` date NOT NULL,
  KEY `DIM_CUS2_INDEX` (`Symbol`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.dim_time definition

CREATE TABLE `dim_time` (
  `SK_TimeID` int(11) NOT NULL,
  `TimeValue` time NOT NULL,
  `HourID` decimal(2,0) NOT NULL,
  `HourDesc` char(20) NOT NULL,
  `MinuteID` decimal(2,0) NOT NULL,
  `MinuteDesc` char(20) NOT NULL,
  `SecondID` decimal(2,0) NOT NULL,
  `SecondDesc` char(20) NOT NULL,
  `MarketHoursFlag` tinyint(1) DEFAULT NULL,
  `OfficeHoursFlag` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`SK_TimeID`),
  KEY `njc` (`SecondDesc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.dim_trade definition

CREATE TABLE `dim_trade` (
  `TradeID` int(11) NOT NULL,
  `SK_BrokerID` int(11) DEFAULT NULL,
  `SK_CreateDateID` int(11) NOT NULL,
  `SK_CreateTimeID` int(11) NOT NULL,
  `SK_CloseDateID` int(11) DEFAULT NULL,
  `SK_CloseTimeID` int(11) DEFAULT NULL,
  `Status` text NOT NULL,
  `Type` text NOT NULL,
  `CashFlag` tinyint(1) NOT NULL,
  `SK_SecurityID` text NOT NULL,
  `SK_CompanyID` bigint(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `BidPrice` float NOT NULL,
  `SK_CustomerID` bigint(20) NOT NULL,
  `SK_AccountID` bigint(20) NOT NULL,
  `ExecutedBy` text NOT NULL,
  `TradePrice` float DEFAULT NULL,
  `Fee` float DEFAULT NULL,
  `Commission` float DEFAULT NULL,
  `Tax` float DEFAULT NULL,
  `BatchID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.fact_cash_balances definition

CREATE TABLE `fact_cash_balances` (
  `SK_CustomerID` bigint(20) NOT NULL,
  `SK_AccountID` bigint(20) NOT NULL,
  `SK_DateID` bigint(20) NOT NULL,
  `Cash` decimal(10,0) NOT NULL,
  `BatchID` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.fact_holdings definition

CREATE TABLE `fact_holdings` (
  `TradeID` bigint(20) NOT NULL,
  `CurrentTradeID` bigint(20) NOT NULL,
  `SK_CustomerID` bigint(20) NOT NULL,
  `SK_AccountID` bigint(20) NOT NULL,
  `SK_SecurityID` text NOT NULL,
  `SK_CompanyID` bigint(20) NOT NULL,
  `SK_DateID` bigint(20) NOT NULL,
  `SK_TimeID` bigint(20) NOT NULL,
  `CurrentPrice` decimal(10,0) NOT NULL,
  `CurrentHolding` bigint(20) NOT NULL,
  `BatchID` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.fact_watches definition

CREATE TABLE `fact_watches` (
  `SK_CustomerID` bigint(20) NOT NULL,
  `SK_SecurityID` text NOT NULL,
  `SK_DateID_DatePlaced` bigint(20) NOT NULL,
  `SK_DateID_DateRemoved` bigint(20) DEFAULT NULL,
  `BatchID` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.financial definition

CREATE TABLE `financial` (
  `SK_CompanyID` bigint(20) NOT NULL,
  `FI_YEAR` int(11) NOT NULL,
  `FI_QTR` int(11) NOT NULL,
  `FI_QTR_START_DATE` date NOT NULL,
  `FI_REVENUE` float NOT NULL,
  `FI_NET_EARN` float NOT NULL,
  `FI_BASIC_EPS` float NOT NULL,
  `FI_DILUT_EPS` float NOT NULL,
  `FI_MARGIN` float NOT NULL,
  `FI_INVENTORY` float NOT NULL,
  `FI_ASSETS` float NOT NULL,
  `FI_LIABILITY` float NOT NULL,
  `FI_OUT_BASIC` int(11) NOT NULL,
  `FI_OUT_DILUT` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.industry definition

CREATE TABLE `industry` (
  `IN_ID` char(2) NOT NULL,
  `IN_NAME` char(50) NOT NULL,
  `IN_SC_ID` char(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.prospect definition

CREATE TABLE `prospect` (
  `AgencyID` text NOT NULL,
  `SK_RecordDateID` bigint(20) NOT NULL,
  `SK_UpdateDateID` bigint(20) NOT NULL,
  `BatchID` bigint(20) NOT NULL,
  `IsCustomer` tinyint(1) NOT NULL,
  `LastName` text NOT NULL,
  `FirstName` text NOT NULL,
  `MiddleInitial` text DEFAULT NULL,
  `Gender` text DEFAULT NULL,
  `AddressLine1` text DEFAULT NULL,
  `AddressLine2` text DEFAULT NULL,
  `PostalCode` text DEFAULT NULL,
  `City` text NOT NULL,
  `State` text NOT NULL,
  `Country` text DEFAULT NULL,
  `Phone` text DEFAULT NULL,
  `Income` bigint(20) DEFAULT NULL,
  `NumberCars` bigint(20) DEFAULT NULL,
  `NumberChildren` bigint(20) DEFAULT NULL,
  `MaritalStatus` text DEFAULT NULL,
  `Age` bigint(20) DEFAULT NULL,
  `CreditRating` bigint(20) DEFAULT NULL,
  `OwnOrRentFlag` text DEFAULT NULL,
  `Employer` text DEFAULT NULL,
  `NumberCreditCards` bigint(20) DEFAULT NULL,
  `NetWorth` bigint(20) DEFAULT NULL,
  `MarketingNameplate` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.status_type definition

CREATE TABLE `status_type` (
  `ST_ID` char(4) NOT NULL,
  `ST_NAME` char(10) NOT NULL,
  KEY `e` (`ST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.tax_rate definition

CREATE TABLE `tax_rate` (
  `TX_ID` char(4) NOT NULL,
  `TX_NAME` char(50) NOT NULL,
  `TX_RATE` decimal(6,5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- master.trade_type definition

CREATE TABLE `trade_type` (
  `TT_ID` char(3) NOT NULL,
  `TT_NAME` char(12) NOT NULL,
  `TT_IS_SELL` decimal(1,0) NOT NULL,
  `TT_IS_MRKT` decimal(1,0) NOT NULL,
  KEY `f` (`TT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;