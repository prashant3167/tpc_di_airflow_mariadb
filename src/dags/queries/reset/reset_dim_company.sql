DROP TABLE IF EXISTS master.dim_company;
CREATE TABLE
    master.dim_company
(
    SK_CompanyID  bigint   NOT NULL,
        CompanyID     bigint   NOT NULL,
        Status        text  NOT NULL,
        Name          text  NOT NULL,
        Industry      text  NOT NULL,
        SPrating      text,
        isLowGrade    BOOLEAN,
        CEO           text  NOT NULL,
        AddressLine1  text,
        AddressLine2  text,
        PostalCode    text  NOT NULL,
        City          text  NOT NULL,
        StateProv     text  NOT NULL,
        Country       text,
        Description   text  NOT NULL,
        FoundingDate  DATE,
        IsCurrent     BOOLEAN NOT NULL,
        BatchID       bigint   NOT NULL,
        EffectiveDate DATE    NOT NULL,
        EndDate       DATE    NOT NULL
    );