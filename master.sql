-- MariaDB dump 10.19  Distrib 10.8.3-MariaDB, for osx10.17 (arm64)
--
-- Host: localhost    Database: master
-- ------------------------------------------------------
-- Server version	10.8.3-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `di_messages`
--

DROP TABLE IF EXISTS `di_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `di_messages` (
  `MessageDateAndTime` datetime DEFAULT NULL,
  `BatchID` int(11) DEFAULT NULL,
  `MessageSource` varchar(30) DEFAULT NULL,
  `MessageText` varchar(30) DEFAULT NULL,
  `MessageType` varchar(30) DEFAULT NULL,
  `MessageData` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_account`
--

DROP TABLE IF EXISTS `dim_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  KEY `dim_account_index` (`AccountID`),
  KEY `dim_account_index2` (`EffectiveDate`),
  KEY `dim_account_index3` (`EndDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_broker`
--

DROP TABLE IF EXISTS `dim_broker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_company`
--

DROP TABLE IF EXISTS `dim_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_customer`
--

DROP TABLE IF EXISTS `dim_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  KEY `DIM_CUS1_INDEX` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_date`
--

DROP TABLE IF EXISTS `dim_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  KEY `njc` (`SK_DateID`),
  KEY `dim_date_ind1` (`SK_DateID`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_security`
--

DROP TABLE IF EXISTS `dim_security`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  PRIMARY KEY (`SK_SecurityID`),
  KEY `DIM_CUS2_INDEX` (`Symbol`(768)),
  KEY `l` (`Symbol`(768)),
  KEY `m` (`EndDate`),
  KEY `z` (`EffectiveDate`),
  KEY `pr` (`SK_SecurityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_time`
--

DROP TABLE IF EXISTS `dim_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  KEY `njc` (`SecondDesc`),
  KEY `dim_time_ind1` (`SecondDesc`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_trade`
--

DROP TABLE IF EXISTS `dim_trade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_trade` (
  `TradeID` int(11) NOT NULL,
  `SK_BrokerID` bigint(20) DEFAULT NULL,
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_cash_balances`
--

DROP TABLE IF EXISTS `fact_cash_balances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fact_cash_balances` (
  `SK_CustomerID` bigint(20) NOT NULL,
  `SK_AccountID` bigint(20) NOT NULL,
  `SK_DateID` bigint(20) NOT NULL,
  `Cash` decimal(10,0) NOT NULL,
  `BatchID` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_holdings`
--

DROP TABLE IF EXISTS `fact_holdings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_market_history`
--

DROP TABLE IF EXISTS `fact_market_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fact_market_history` (
  `DM_S_SYMB` char(30) NOT NULL,
  `DM_DATE` date NOT NULL,
  `SK_DateID` int(11) NOT NULL,
  `DM_CLOSE` decimal(4,0) NOT NULL,
  `DM_HIGH` decimal(4,0) NOT NULL,
  `DM_LOW` decimal(4,0) NOT NULL,
  `DM_VOL` int(11) NOT NULL,
  `FiftyTwoWeekHigh` decimal(4,0) DEFAULT NULL,
  `SK_FiftyTwoWeekHighDate` int(11) DEFAULT NULL,
  `FiftyTwoWeekLOW` decimal(4,0) DEFAULT NULL,
  `SK_FiftyTwoWeekLowDate` int(11) DEFAULT NULL,
  `SK_SecurityID` text DEFAULT NULL,
  `SK_CompanyID` bigint(20) DEFAULT NULL,
  `Yield` float DEFAULT NULL,
  `PEratio` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_watches`
--

DROP TABLE IF EXISTS `fact_watches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fact_watches` (
  `SK_CustomerID` bigint(20) NOT NULL,
  `SK_SecurityID` text NOT NULL,
  `SK_DateID_DatePlaced` bigint(20) NOT NULL,
  `SK_DateID_DateRemoved` bigint(20) DEFAULT NULL,
  `BatchID` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `financial`
--

DROP TABLE IF EXISTS `financial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `industry`
--

DROP TABLE IF EXISTS `industry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `industry` (
  `IN_ID` char(2) NOT NULL,
  `IN_NAME` char(50) NOT NULL,
  `IN_SC_ID` char(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prospect`
--

DROP TABLE IF EXISTS `prospect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `status_type`
--

DROP TABLE IF EXISTS `status_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status_type` (
  `ST_ID` char(4) NOT NULL,
  `ST_NAME` char(10) NOT NULL,
  KEY `e` (`ST_ID`),
  KEY `status_type_ind` (`ST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tax_rate`
--

DROP TABLE IF EXISTS `tax_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_rate` (
  `TX_ID` char(4) NOT NULL,
  `TX_NAME` char(50) NOT NULL,
  `TX_RATE` decimal(6,5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trade_type`
--

DROP TABLE IF EXISTS `trade_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trade_type` (
  `TT_ID` char(3) NOT NULL,
  `TT_NAME` char(12) NOT NULL,
  `TT_IS_SELL` decimal(1,0) NOT NULL,
  `TT_IS_MRKT` decimal(1,0) NOT NULL,
  KEY `f` (`TT_ID`),
  KEY `trade_type_ind` (`TT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-30 11:25:25
