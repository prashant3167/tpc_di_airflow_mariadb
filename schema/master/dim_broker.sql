--depends on hr and date tables
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
  `EndDate` date DEFAULT NULL
)