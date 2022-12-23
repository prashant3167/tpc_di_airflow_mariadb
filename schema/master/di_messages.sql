create table master.di_messages(
    MessageDateAndTime DATETIME,
    BatchID numeric(5),
    MessageSource varchar(30),
    MessageText varchar(30),
    MessageType varchar(30),
    MessageData varchar(100)
);