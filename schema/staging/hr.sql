CREATE TABLE staging.hr(
      EmployeeID INTEGER NOT NULL,
      ManagerID INTEGER NOT NULL,
      EmployeeFirstName CHAR(30) NOT NULL,
      EmployeeLastName CHAR(30) NOT NULL,
      EmployeeMI CHAR(1),
      EmployeeJobCode NUMERIC(3),
      EmployeeBranch CHAR(30),
      EmployeeOffice CHAR(10),
      EmployeePhone CHAR(14)
    );