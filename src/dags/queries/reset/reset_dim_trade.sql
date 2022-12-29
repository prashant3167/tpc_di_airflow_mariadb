DROP TABLE IF EXISTS master.dim_trade;
CREATE TABLE master.`dim_trade` (
  `TradeID` int(11) NOT NULL,
  `SK_BrokerID` bigint DEFAULT NULL,
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
  );