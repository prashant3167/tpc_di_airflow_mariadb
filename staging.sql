-- MariaDB dump 10.19  Distrib 10.8.3-MariaDB, for osx10.17 (arm64)
--
-- Host: localhost    Database: staging
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
-- Table structure for table `DImessages`
--

DROP TABLE IF EXISTS `DImessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DImessages` (
  `MessageDateAndTime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `BatchID` decimal(5,0) NOT NULL,
  `MessageSource` char(30) DEFAULT NULL,
  `MessageText` char(50) NOT NULL,
  `MessageType` char(12) NOT NULL,
  `MessageData` char(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DimBroker`
--

DROP TABLE IF EXISTS `DimBroker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DimBroker` (
  `SK_BrokerID` int(11) NOT NULL AUTO_INCREMENT,
  `BrokerID` int(11) NOT NULL,
  `ManagerID` int(11) DEFAULT NULL,
  `FirstName` char(50) NOT NULL,
  `LastName` char(50) NOT NULL,
  `MiddleInitial` char(1) DEFAULT NULL,
  `Branch` char(50) DEFAULT NULL,
  `Office` char(50) DEFAULT NULL,
  `Phone` char(14) DEFAULT NULL,
  `IsCurrent` tinyint(1) NOT NULL,
  `BatchID` int(11) NOT NULL,
  `EffectiveDate` date NOT NULL,
  `EndDate` date NOT NULL,
  PRIMARY KEY (`SK_BrokerID`)
) ENGINE=InnoDB AUTO_INCREMENT=4294 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DimCompany`
--

DROP TABLE IF EXISTS `DimCompany`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DimCompany` (
  `SK_CompanyID` int(11) NOT NULL AUTO_INCREMENT,
  `CompanyID` int(11) NOT NULL,
  `Status` char(10) NOT NULL,
  `Name` char(60) NOT NULL,
  `Industry` char(50) NOT NULL,
  `SPrating` char(4) DEFAULT NULL,
  `isLowGrade` tinyint(1) DEFAULT NULL,
  `CEO` char(100) NOT NULL,
  `AddressLine1` char(80) DEFAULT NULL,
  `AddressLine2` char(80) DEFAULT NULL,
  `PostalCode` char(12) NOT NULL,
  `City` char(25) NOT NULL,
  `StateProv` char(20) NOT NULL,
  `Country` char(24) DEFAULT NULL,
  `Description` char(150) NOT NULL,
  `FoundingDate` date DEFAULT NULL,
  `IsCurrent` tinyint(1) NOT NULL,
  `BatchID` decimal(5,0) NOT NULL,
  `EffectiveDate` date NOT NULL,
  `EndDate` date NOT NULL,
  PRIMARY KEY (`SK_CompanyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DimDate`
--

DROP TABLE IF EXISTS `DimDate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DimDate` (
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
  `DayOfWeeknumeric` decimal(1,0) NOT NULL,
  `DayOfWeekDesc` char(10) NOT NULL,
  `FiscalYearID` decimal(4,0) NOT NULL,
  `FiscalYearDesc` char(20) NOT NULL,
  `FiscalQtrID` decimal(5,0) NOT NULL,
  `FiscalQtrDesc` char(20) NOT NULL,
  `HolidayFlag` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`SK_DateID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DimSecurity`
--

DROP TABLE IF EXISTS `DimSecurity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DimSecurity` (
  `SK_SecurityID` int(11) NOT NULL AUTO_INCREMENT,
  `Symbol` char(15) NOT NULL,
  `Issue` char(6) NOT NULL,
  `Status` char(10) NOT NULL,
  `Name` char(70) NOT NULL,
  `ExchangeID` char(6) NOT NULL,
  `SK_CompanyID` int(11) NOT NULL,
  `SharesOutstanding` int(11) NOT NULL,
  `FirstTrade` date NOT NULL,
  `FirstTradeOnExchange` date NOT NULL,
  `Dividend` int(11) NOT NULL,
  `IsCurrent` tinyint(1) NOT NULL,
  `BatchID` decimal(5,0) NOT NULL,
  `EffectiveDate` date NOT NULL,
  `EndDate` date NOT NULL,
  PRIMARY KEY (`SK_SecurityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DimTime`
--

DROP TABLE IF EXISTS `DimTime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DimTime` (
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
  PRIMARY KEY (`SK_TimeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EPS`
--

DROP TABLE IF EXISTS `EPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EPS` (
  `SUM_FI_BASIC_EPS` double DEFAULT NULL,
  `FI_YEAR` int(11) NOT NULL,
  `FI_QTR` int(11) NOT NULL,
  `SK_CompanyID` bigint(20) NOT NULL,
  `FOR_DATE` bigint(15) NOT NULL,
  KEY `test` (`SK_CompanyID`,`FOR_DATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Financial`
--

DROP TABLE IF EXISTS `Financial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Financial` (
  `SK_CompanyID` int(11) NOT NULL,
  `FI_YEAR` decimal(4,0) NOT NULL,
  `FI_QTR` decimal(1,0) NOT NULL,
  `FI_QTR_START_DATE` date NOT NULL,
  `FI_REVENUE` decimal(15,2) NOT NULL,
  `FI_NET_EARN` decimal(15,2) NOT NULL,
  `FI_BASIC_EPS` decimal(10,2) NOT NULL,
  `FI_DILUT_EPS` decimal(10,2) NOT NULL,
  `FI_MARGIN` decimal(10,2) NOT NULL,
  `FI_INVENTORY` decimal(15,2) NOT NULL,
  `FI_ASSETS` decimal(15,2) NOT NULL,
  `FI_LIABILITY` decimal(15,2) NOT NULL,
  `FI_OUT_BASIC` decimal(12,0) NOT NULL,
  `FI_OUT_DILUT` decimal(12,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Industry`
--

DROP TABLE IF EXISTS `Industry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Industry` (
  `IN_ID` char(2) NOT NULL,
  `IN_NAME` char(50) NOT NULL,
  `IN_SC_ID` char(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Prospect`
--

DROP TABLE IF EXISTS `Prospect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Prospect` (
  `AgencyID` char(30) NOT NULL,
  `SK_RecordDateID` int(11) NOT NULL,
  `SK_UpdateDateID` int(11) NOT NULL,
  `BatchID` decimal(5,0) NOT NULL,
  `IsCustomer` tinyint(1) NOT NULL,
  `LastName` char(30) NOT NULL,
  `FirstName` char(30) NOT NULL,
  `MiddleInitial` char(1) DEFAULT NULL,
  `Gender` char(1) DEFAULT NULL,
  `AddressLine1` char(80) DEFAULT NULL,
  `AddressLine2` char(80) DEFAULT NULL,
  `PostalCode` char(12) DEFAULT NULL,
  `City` char(25) NOT NULL,
  `State` char(20) NOT NULL,
  `Country` char(24) DEFAULT NULL,
  `Phone` char(30) DEFAULT NULL,
  `Income` decimal(9,0) DEFAULT NULL,
  `NumberCars` decimal(2,0) DEFAULT NULL,
  `NumberChildren` decimal(2,0) DEFAULT NULL,
  `MaritalStatus` char(1) DEFAULT NULL,
  `Age` decimal(3,0) DEFAULT NULL,
  `CreditRating` decimal(4,0) DEFAULT NULL,
  `OwnOrRentFlag` char(1) DEFAULT NULL,
  `Employer` char(30) DEFAULT NULL,
  `NumberCreditCards` decimal(2,0) DEFAULT NULL,
  `NetWorth` decimal(12,0) DEFAULT NULL,
  `MarketingNameplate` char(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `S_Broker`
--

DROP TABLE IF EXISTS `S_Broker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `S_Broker` (
  `EmployeeID` int(11) NOT NULL,
  `ManagerID` int(11) NOT NULL,
  `EmployeeFirstName` char(30) NOT NULL,
  `EmployeeLastName` char(30) NOT NULL,
  `EmployeeMI` char(1) DEFAULT NULL,
  `EmployeeJobCode` decimal(3,0) DEFAULT NULL,
  `EmployeeBranch` char(30) DEFAULT NULL,
  `EmployeeOffice` char(10) DEFAULT NULL,
  `EmployeePhone` char(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `S_Cash_Balances`
--

DROP TABLE IF EXISTS `S_Cash_Balances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `S_Cash_Balances` (
  `CT_CA_ID` int(11) NOT NULL,
  `CT_DTS` date NOT NULL,
  `CT_AMT` char(20) NOT NULL,
  `CT_NAME` char(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `S_Company`
--

DROP TABLE IF EXISTS `S_Company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `S_Company` (
  `PTS` char(15) NOT NULL,
  `REC_TYPE` char(3) NOT NULL,
  `COMPANY_NAME` char(60) NOT NULL,
  `CIK` char(10) NOT NULL,
  `STATUS` char(4) NOT NULL,
  `INDUSTRY_ID` char(2) NOT NULL,
  `SP_RATING` char(4) NOT NULL,
  `FOUNDING_DATE` char(8) NOT NULL,
  `ADDR_LINE_1` char(80) NOT NULL,
  `ADDR_LINE_2` char(80) NOT NULL,
  `POSTAL_CODE` char(12) NOT NULL,
  `CITY` char(25) NOT NULL,
  `STATE_PROVINCE` char(20) NOT NULL,
  `COUNTRY` char(24) NOT NULL,
  `CEO_NAME` char(46) NOT NULL,
  `DESCRIPTION` char(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `S_Customer`
--

DROP TABLE IF EXISTS `S_Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `S_Customer` (
  `ActionType` char(9) NOT NULL,
  `ActionTS` char(20) NOT NULL,
  `C_ID` int(11) NOT NULL,
  `C_TAX_ID` char(20) DEFAULT NULL,
  `C_GNDR` char(1) NOT NULL,
  `C_TIER` decimal(1,0) DEFAULT NULL,
  `C_DOB` date DEFAULT NULL,
  `C_L_NAME` char(25) DEFAULT NULL,
  `C_F_NAME` char(20) DEFAULT NULL,
  `C_M_NAME` char(1) DEFAULT NULL,
  `C_ADLINE1` char(80) DEFAULT NULL,
  `C_ADLINE2` char(80) DEFAULT NULL,
  `C_ZIPCODE` char(12) DEFAULT NULL,
  `C_CITY` char(25) DEFAULT NULL,
  `C_STATE_PROV` char(20) DEFAULT NULL,
  `C_CTRY` char(24) DEFAULT NULL,
  `C_PRIM_EMAIL` char(50) DEFAULT NULL,
  `C_ALT_EMAIL` char(50) DEFAULT NULL,
  `C_PHONE_1_C_CTRY_CODE` char(30) DEFAULT NULL,
  `C_PHONE_1_C_AREA_CODE` char(30) DEFAULT NULL,
  `C_PHONE_1_C_LOCAL` char(30) DEFAULT NULL,
  `C_PHONE_1_C_EXT` char(30) DEFAULT NULL,
  `C_PHONE_2_C_CTRY_CODE` char(30) DEFAULT NULL,
  `C_PHONE_2_C_AREA_CODE` char(30) DEFAULT NULL,
  `C_PHONE_2_C_LOCAL` char(30) DEFAULT NULL,
  `C_PHONE_2_C_EXT` char(30) DEFAULT NULL,
  `C_PHONE_3_C_CTRY_CODE` char(30) DEFAULT NULL,
  `C_PHONE_3_C_AREA_CODE` char(30) DEFAULT NULL,
  `C_PHONE_3_C_LOCAL` char(30) DEFAULT NULL,
  `C_PHONE_3_C_EXT` char(30) DEFAULT NULL,
  `C_LCL_TX_ID` char(4) DEFAULT NULL,
  `C_NAT_TX_ID` char(4) DEFAULT NULL,
  `CA_ID` int(11) NOT NULL,
  `CA_TAX_ST` decimal(1,0) DEFAULT NULL,
  `CA_B_ID` int(11) DEFAULT NULL,
  `CA_NAME` char(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `S_Financial`
--

DROP TABLE IF EXISTS `S_Financial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `S_Financial` (
  `PTS` char(15) DEFAULT NULL,
  `REC_TYPE` char(3) DEFAULT NULL,
  `YEAR` char(4) DEFAULT NULL,
  `QUARTER` char(1) DEFAULT NULL,
  `QTR_START_DATE` char(8) DEFAULT NULL,
  `POSTING_DATE` char(8) DEFAULT NULL,
  `REVENUE` char(17) DEFAULT NULL,
  `EARNINGS` char(17) DEFAULT NULL,
  `EPS` char(12) DEFAULT NULL,
  `DILUTED_EPS` char(12) DEFAULT NULL,
  `MARGIN` char(12) DEFAULT NULL,
  `INVENTORY` char(17) DEFAULT NULL,
  `ASSETS` char(17) DEFAULT NULL,
  `LIABILITIES` char(17) DEFAULT NULL,
  `SH_OUT` char(13) DEFAULT NULL,
  `DILUTED_SH_OUT` char(13) DEFAULT NULL,
  `CO_NAME_OR_CIK` char(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `S_Prospect`
--

DROP TABLE IF EXISTS `S_Prospect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `S_Prospect` (
  `AGENCY_ID` char(30) NOT NULL,
  `LAST_NAME` char(30) NOT NULL,
  `FIRST_NAME` char(30) NOT NULL,
  `MIDDLE_INITIAL` char(1) DEFAULT NULL,
  `GENDER` char(1) DEFAULT NULL,
  `ADDRESS_LINE_1` char(80) DEFAULT NULL,
  `ADDRESS_LINE_2` char(80) DEFAULT NULL,
  `POSTAL_CODE` char(12) DEFAULT NULL,
  `CITY` char(25) NOT NULL,
  `STATE` char(20) NOT NULL,
  `COUNTRY` char(24) DEFAULT NULL,
  `PHONE` char(30) DEFAULT NULL,
  `INCOME` decimal(9,0) DEFAULT NULL,
  `NUMBER_CARS` decimal(2,0) DEFAULT NULL,
  `NUMBER_CHILDREM` decimal(2,0) DEFAULT NULL,
  `MARITAL_STATUS` char(1) DEFAULT NULL,
  `AGE` decimal(3,0) DEFAULT NULL,
  `CREDIT_RATING` decimal(4,0) DEFAULT NULL,
  `OWN_OR_RENT_FLAG` char(1) DEFAULT NULL,
  `EMPLOYER` char(30) DEFAULT NULL,
  `NUMBER_CREDIT_CARDS` decimal(2,0) DEFAULT NULL,
  `NET_WORTH` decimal(12,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `S_Security`
--

DROP TABLE IF EXISTS `S_Security`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `S_Security` (
  `PTS` char(15) NOT NULL,
  `REC_TYPE` char(3) NOT NULL,
  `SYMBOL` char(15) NOT NULL,
  `ISSUE_TYPE` char(6) NOT NULL,
  `STATUS` char(4) NOT NULL,
  `NAME` char(70) NOT NULL,
  `EX_ID` char(6) NOT NULL,
  `SH_OUT` char(13) NOT NULL,
  `FIRST_TRADE_DATE` char(8) NOT NULL,
  `FIRST_TRADE_EXCHANGE` char(8) NOT NULL,
  `DIVIDEN` char(12) NOT NULL,
  `COMPANY_NAME_OR_CIK` char(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `S_Watches`
--

DROP TABLE IF EXISTS `S_Watches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `S_Watches` (
  `W_C_ID` int(11) NOT NULL,
  `W_S_SYMB` char(15) NOT NULL,
  `W_DTS` date NOT NULL,
  `W_ACTION` char(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `StatusType`
--

DROP TABLE IF EXISTS `StatusType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StatusType` (
  `ST_ID` char(4) NOT NULL,
  `ST_NAME` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TaxRate`
--

DROP TABLE IF EXISTS `TaxRate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TaxRate` (
  `TX_ID` char(4) NOT NULL,
  `TX_NAME` char(50) NOT NULL,
  `TX_RATE` decimal(6,5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TradeType`
--

DROP TABLE IF EXISTS `TradeType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TradeType` (
  `TT_ID` char(3) NOT NULL,
  `TT_NAME` char(12) NOT NULL,
  `TT_IS_SELL` decimal(1,0) NOT NULL,
  `TT_IS_MRKT` decimal(1,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_historical`
--

DROP TABLE IF EXISTS `account_historical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_historical` (
  `CustomerID` int(11) DEFAULT NULL,
  `AccountID` int(11) DEFAULT NULL,
  `BrokerID` int(11) DEFAULT NULL,
  `AccountDesc` text DEFAULT NULL,
  `TaxStatus` int(11) DEFAULT NULL,
  `Action` text DEFAULT NULL,
  `Status` varchar(8) DEFAULT NULL,
  `EffectiveDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  KEY `i` (`CustomerID`),
  KEY `j` (`BrokerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `batch_date`
--

DROP TABLE IF EXISTS `batch_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_date` (
  `batch_number` decimal(3,0) DEFAULT NULL,
  `BatchDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `batch_number`
--

DROP TABLE IF EXISTS `batch_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_number` (
  `batch_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cash_transaction_historical`
--

DROP TABLE IF EXISTS `cash_transaction_historical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cash_transaction_historical` (
  `CT_CA_ID` int(11) NOT NULL,
  `CT_DTS` date NOT NULL,
  `CT_AMT` char(20) NOT NULL,
  `CT_NAME` char(100) NOT NULL,
  KEY `cash_transaction_historical_index` (`CT_CA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmp_records`
--

DROP TABLE IF EXISTS `cmp_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmp_records` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_historical`
--

DROP TABLE IF EXISTS `customer_historical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_historical` (
  `Action` text DEFAULT NULL,
  `EffectiveDate` datetime DEFAULT NULL,
  `Phone1` text DEFAULT NULL,
  `Phone2` text DEFAULT NULL,
  `Phone3` text DEFAULT NULL,
  `Tier` int(11) DEFAULT NULL,
  `CustomerID` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_management`
--

DROP TABLE IF EXISTS `customer_management`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_management` (
  `Action` text DEFAULT NULL,
  `effective_time_stamp` datetime DEFAULT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `TAXID` text DEFAULT NULL,
  `Gender` text DEFAULT NULL,
  `TIER` int(11) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `LastName` text DEFAULT NULL,
  `FirstName` text DEFAULT NULL,
  `MiddleInitial` text DEFAULT NULL,
  `AddressLine1` text DEFAULT NULL,
  `AddressLine2` text DEFAULT NULL,
  `PostalCode` text NOT NULL,
  `City` text NOT NULL,
  `State_Prov` text NOT NULL,
  `Country` text DEFAULT NULL,
  `Email1` text DEFAULT NULL,
  `Email2` text DEFAULT NULL,
  `LocalTaxID` text DEFAULT NULL,
  `NationalTaxID` text DEFAULT NULL,
  `AccountID` int(11) DEFAULT NULL,
  `TaxStatus` int(11) DEFAULT NULL,
  `BrokerID` int(11) DEFAULT NULL,
  `AccountDesc` text DEFAULT NULL,
  `Phone1` text DEFAULT NULL,
  `Phone2` text DEFAULT NULL,
  `Phone3` text DEFAULT NULL,
  `Status` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `daily_market_historical`
--

DROP TABLE IF EXISTS `daily_market_historical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daily_market_historical` (
  `DM_DATE` date NOT NULL,
  `DM_S_SYMB` char(30) NOT NULL,
  `DM_CLOSE` decimal(4,0) NOT NULL,
  `DM_HIGH` decimal(4,0) NOT NULL,
  `DM_LOW` decimal(4,0) NOT NULL,
  `DM_VOL` int(11) NOT NULL,
  KEY `daily_market_historical_ind` (`DM_DATE`),
  KEY `daily_market_historical2_ind` (`DM_S_SYMB`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `daily_market_with_date`
--

DROP TABLE IF EXISTS `daily_market_with_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daily_market_with_date` (
  `DM_DATE` date NOT NULL,
  `DM_S_SYMB` char(30) NOT NULL,
  `DM_CLOSE` decimal(4,0) NOT NULL,
  `DM_HIGH` decimal(4,0) NOT NULL,
  `DM_LOW` decimal(4,0) NOT NULL,
  `DM_VOL` int(11) NOT NULL,
  `SK_DateID` int(11) NOT NULL,
  KEY `dmwr_ind` (`DM_S_SYMB`),
  KEY `dmwr_ind2` (`DM_DATE`),
  KEY `dmwr_ind3` (`DM_S_SYMB`,`DM_DATE`),
  KEY `daily_market_historical3_ind` (`DM_S_SYMB`,`DM_DATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fin_records`
--

DROP TABLE IF EXISTS `fin_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fin_records` (
  `PTS` datetime DEFAULT NULL,
  `Year` int(11) DEFAULT NULL,
  `Quarter` tinyint(4) DEFAULT NULL,
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
  `ShOut` int(11) DEFAULT NULL,
  `DilutedShOut` int(11) DEFAULT NULL,
  `CIK` bigint(20) DEFAULT NULL,
  `CompanyName` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `finwire`
--

DROP TABLE IF EXISTS `finwire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `finwire` (
  `ROW` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `holding_history_historical`
--

DROP TABLE IF EXISTS `holding_history_historical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `holding_history_historical` (
  `HH_H_T_ID` int(11) DEFAULT NULL,
  `HH_T_ID` int(11) DEFAULT NULL,
  `HH_BEFORE_QTY` int(11) DEFAULT NULL,
  `HH_AFTER_QTY` int(11) DEFAULT NULL,
  KEY `HH_IND` (`HH_T_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hr`
--

DROP TABLE IF EXISTS `hr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hr` (
  `EmployeeID` int(11) NOT NULL,
  `ManagerID` int(11) NOT NULL,
  `EmployeeFirstName` char(30) NOT NULL,
  `EmployeeLastName` char(30) NOT NULL,
  `EmployeeMI` char(1) DEFAULT NULL,
  `EmployeeJobCode` decimal(3,0) DEFAULT NULL,
  `EmployeeBranch` char(30) DEFAULT NULL,
  `EmployeeOffice` char(10) DEFAULT NULL,
  `EmployeePhone` char(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prosepect`
--

DROP TABLE IF EXISTS `prosepect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prosepect` (
  `AGENCY_ID` char(30) NOT NULL,
  `LAST_NAME` char(30) NOT NULL,
  `FIRST_NAME` char(30) NOT NULL,
  `MIDDLE_INITIAL` char(1) DEFAULT NULL,
  `GENDER` char(1) DEFAULT NULL,
  `ADDRESS_LINE_1` char(80) DEFAULT NULL,
  `ADDRESS_LINE_2` char(80) DEFAULT NULL,
  `POSTAL_CODE` char(12) DEFAULT NULL,
  `CITY` char(25) NOT NULL,
  `STATE` char(20) NOT NULL,
  `COUNTRY` char(24) DEFAULT NULL,
  `PHONE` char(30) DEFAULT NULL,
  `INCOME` decimal(9,0) DEFAULT NULL,
  `NUMBER_CARS` decimal(2,0) DEFAULT NULL,
  `NUMBER_CHILDREM` decimal(2,0) DEFAULT NULL,
  `MARITAL_STATUS` char(1) DEFAULT NULL,
  `AGE` decimal(3,0) DEFAULT NULL,
  `CREDIT_RATING` decimal(4,0) DEFAULT NULL,
  `OWN_OR_RENT_FLAG` char(1) DEFAULT NULL,
  `EMPLOYER` char(30) DEFAULT NULL,
  `NUMBER_CREDIT_CARDS` decimal(2,0) DEFAULT NULL,
  `NET_WORTH` decimal(12,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sdc_dimcompany`
--

DROP TABLE IF EXISTS `sdc_dimcompany`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sdc_dimcompany` (
  `SK_CompanyID` int(11) NOT NULL AUTO_INCREMENT,
  `CompanyID` int(11) NOT NULL,
  `Status` char(10) NOT NULL,
  `Name` char(60) NOT NULL,
  `Industry` char(50) NOT NULL,
  `SPrating` char(4) DEFAULT NULL,
  `isLowGrade` tinyint(1) DEFAULT NULL,
  `CEO` char(100) NOT NULL,
  `AddressLine1` char(80) DEFAULT NULL,
  `AddressLine2` char(80) DEFAULT NULL,
  `PostalCode` char(12) NOT NULL,
  `City` char(25) NOT NULL,
  `StateProv` char(20) NOT NULL,
  `Country` char(24) DEFAULT NULL,
  `Description` char(150) NOT NULL,
  `FoundingDate` date DEFAULT NULL,
  `IsCurrent` tinyint(1) NOT NULL,
  `BatchID` decimal(5,0) NOT NULL,
  `EffectiveDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `RN` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`SK_CompanyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sdc_dimsecurity`
--

DROP TABLE IF EXISTS `sdc_dimsecurity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sdc_dimsecurity` (
  `SK_SecurityID` int(11) NOT NULL AUTO_INCREMENT,
  `Symbol` char(15) NOT NULL,
  `Issue` char(6) NOT NULL,
  `Status` char(10) NOT NULL,
  `Name` char(70) NOT NULL,
  `ExchangeID` char(6) NOT NULL,
  `SK_CompanyID` int(11) NOT NULL,
  `SharesOutstanding` int(11) NOT NULL,
  `FirstTrade` date NOT NULL,
  `FirstTradeOnExchange` date NOT NULL,
  `Dividend` int(11) NOT NULL,
  `IsCurrent` tinyint(1) NOT NULL,
  `BatchID` decimal(5,0) NOT NULL,
  `EffectiveDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `RN` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`SK_SecurityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sec_records`
--

DROP TABLE IF EXISTS `sec_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sec_records` (
  `PTS` datetime DEFAULT NULL,
  `Symbol` text DEFAULT NULL,
  `IssueType` text DEFAULT NULL,
  `Status` text DEFAULT NULL,
  `Name` text DEFAULT NULL,
  `ExID` text DEFAULT NULL,
  `ShOut` int(11) DEFAULT NULL,
  `FirstTradeDate` date DEFAULT NULL,
  `FirstTradeExchg` date DEFAULT NULL,
  `Dividend` float DEFAULT NULL,
  `CIK` int(11) DEFAULT NULL,
  `CompanyName` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_all`
--

DROP TABLE IF EXISTS `t_all`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_all` (
  `DM_DATE` date NOT NULL,
  `DM_S_SYMB` char(30) NOT NULL,
  `DM_CLOSE` decimal(4,0) NOT NULL,
  `DM_HIGH` decimal(4,0) NOT NULL,
  `DM_LOW` decimal(4,0) NOT NULL,
  `DM_VOL` int(11) NOT NULL,
  `SK_DateID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_all_test`
--

DROP TABLE IF EXISTS `t_all_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_all_test` (
  `SK_SecurityID` text DEFAULT NULL,
  `SK_CompanyID` bigint(20) DEFAULT NULL,
  `DM_DATE` date NOT NULL,
  `DM_S_SYMB` char(30) NOT NULL,
  `DM_CLOSE` decimal(4,0) NOT NULL,
  `DM_HIGH` decimal(4,0) NOT NULL,
  `DM_LOW` decimal(4,0) NOT NULL,
  `DM_VOL` int(11) NOT NULL,
  `SK_DateID` int(11) NOT NULL,
  `FiftyTwoWeekHigh` decimal(4,0) DEFAULT NULL,
  `SK_FiftyTwoWeekHighDate` date DEFAULT NULL,
  `FiftyTwoWeekLow` decimal(4,0) DEFAULT NULL,
  `SK_FiftyTwoWeekLowDate` date DEFAULT NULL,
  `PERatio` float DEFAULT NULL,
  `Yield` float DEFAULT NULL,
  KEY `t_all_ind1` (`DM_S_SYMB`) USING HASH,
  KEY `t_all_ind2` (`DM_DATE`) USING BTREE,
  KEY `t_all_ind3` (`FiftyTwoWeekHigh`) USING BTREE,
  KEY `t_all_ind4` (`FiftyTwoWeekLow`) USING BTREE,
  KEY `a` (`DM_S_SYMB`,`DM_DATE`,`DM_HIGH` DESC),
  KEY `b` (`DM_S_SYMB`,`DM_DATE`,`DM_LOW`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_all_v2`
--

DROP TABLE IF EXISTS `t_all_v2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_all_v2` (
  `DM_S_SYMB` char(30) NOT NULL,
  `DM_DATE` date NOT NULL,
  `SK_DateID` int(11) NOT NULL,
  `DM_CLOSE` decimal(4,0) NOT NULL,
  `DM_HIGH` decimal(4,0) NOT NULL,
  `DM_LOW` decimal(4,0) NOT NULL,
  `DM_VOL` int(11) NOT NULL,
  `high` bigint(20) DEFAULT NULL,
  `low` bigint(20) DEFAULT NULL,
  KEY `st1_ind3` (`DM_DATE`),
  KEY `st1_ind4` (`DM_S_SYMB`,`DM_DATE`),
  KEY `st1_ind` (`DM_S_SYMB`,`DM_DATE`,`DM_HIGH` DESC),
  KEY `st2_ind` (`DM_S_SYMB`,`DM_DATE`,`DM_LOW`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_all_v3`
--

DROP TABLE IF EXISTS `t_all_v3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_all_v3` (
  `DM_S_SYMB` char(30) NOT NULL,
  `DM_DATE` date NOT NULL,
  `SK_DateID` int(11) NOT NULL,
  `DM_CLOSE` decimal(4,0) NOT NULL,
  `DM_HIGH` decimal(4,0) NOT NULL,
  `DM_LOW` decimal(4,0) NOT NULL,
  `DM_VOL` int(11) NOT NULL,
  `o_high` decimal(4,0) DEFAULT NULL,
  `o_low` decimal(4,0) DEFAULT NULL,
  `o_high_sk_id` int(11) DEFAULT NULL,
  `o_low__sk_id` int(11) DEFAULT NULL,
  `SK_SecurityID` text DEFAULT NULL,
  `SK_CompanyID` bigint(20) DEFAULT NULL,
  `Yield` float DEFAULT NULL,
  `PEratio` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trade_historical`
--

DROP TABLE IF EXISTS `trade_historical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trade_historical` (
  `CDC_FLAG` char(1) DEFAULT NULL,
  `CDC_DSN` decimal(12,0) DEFAULT NULL,
  `T_ID` decimal(15,0) DEFAULT NULL,
  `T_DTS` datetime DEFAULT NULL,
  `T_ST_ID` char(4) DEFAULT NULL,
  `T_TT_ID` char(3) DEFAULT NULL,
  `T_IS_CASH` char(3) DEFAULT NULL,
  `T_S_SYMB` char(15) NOT NULL,
  `T_QTY` decimal(6,0) NOT NULL,
  `T_BID_PRICE` decimal(8,0) DEFAULT NULL,
  `T_CA_ID` decimal(11,0) DEFAULT NULL,
  `T_EXEC_NAME` char(49) DEFAULT NULL,
  `T_TRADE_PRICE` decimal(8,0) DEFAULT NULL,
  `T_CHRG` decimal(10,0) DEFAULT NULL,
  `T_COMM` decimal(10,0) DEFAULT NULL,
  `T_TAX` decimal(10,0) DEFAULT NULL,
  KEY `a` (`T_ID`),
  KEY `b` (`T_ST_ID`),
  KEY `c` (`T_TT_ID`),
  KEY `trade_historical_ind` (`T_ID`),
  KEY `trade_historical_ind2` (`T_ST_ID`),
  KEY `trade_historical_ind3` (`T_TT_ID`),
  KEY `trade_historical_ind4` (`T_S_SYMB`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trade_history_historical`
--

DROP TABLE IF EXISTS `trade_history_historical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trade_history_historical` (
  `TH_T_ID` decimal(15,0) DEFAULT NULL,
  `TH_DTS` datetime DEFAULT NULL,
  `TH_ST_ID` char(4) DEFAULT NULL,
  KEY `d` (`TH_T_ID`),
  KEY `TH_IND` (`TH_T_ID`),
  KEY `TH_IND2` (`TH_DTS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `watch_history_historical`
--

DROP TABLE IF EXISTS `watch_history_historical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watch_history_historical` (
  `W_C_ID` int(11) NOT NULL,
  `W_S_SYMB` char(15) NOT NULL,
  `W_DTS` date NOT NULL,
  `W_ACTION` char(4) NOT NULL,
  KEY `wactch_index` (`W_C_ID`,`W_S_SYMB`),
  KEY `dim_cus_index` (`W_ACTION`),
  KEY `watch_index` (`W_C_ID`,`W_S_SYMB`),
  KEY `watch_index2` (`W_ACTION`),
  KEY `watch_history_INDEX` (`W_C_ID`,`W_S_SYMB`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS prospect;
CREATE TABLE `prospect` (
  `AgencyID` char(30) NOT NULL,
  `SK_RecordDateID` int(11) NOT NULL,
  `SK_UpdateDateID` int(11) NOT NULL,
  `BatchID` decimal(5,0) NOT NULL,
  `IsCustomer` tinyint(1) NOT NULL,
  `LastName` char(30) NOT NULL,
  `FirstName` char(30) NOT NULL,
  `MiddleInitial` char(1) DEFAULT NULL,
  `Gender` char(1) DEFAULT NULL,
  `AddressLine1` char(80) DEFAULT NULL,
  `AddressLine2` char(80) DEFAULT NULL,
  `PostalCode` char(12) DEFAULT NULL,
  `City` char(25) NOT NULL,
  `State` char(20) NOT NULL,
  `Country` char(24) DEFAULT NULL,
  `Phone` char(30) DEFAULT NULL,
  `Income` decimal(9,0) DEFAULT NULL,
  `NumberCars` decimal(2,0) DEFAULT NULL,
  `NumberChildren` decimal(2,0) DEFAULT NULL,
  `MaritalStatus` char(1) DEFAULT NULL,
  `Age` decimal(3,0) DEFAULT NULL,
  `CreditRating` decimal(4,0) DEFAULT NULL,
  `OwnOrRentFlag` char(1) DEFAULT NULL,
  `Employer` char(30) DEFAULT NULL,
  `NumberCreditCards` decimal(2,0) DEFAULT NULL,
  `NetWorth` decimal(12,0) DEFAULT NULL,
  `MarketingNameplate` char(100) DEFAULT NULL
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-30 11:23:41
