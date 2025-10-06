create table if not exists Passenger (
    PassID      integer primary key,
    FirstName   varchar(30) not null,
    LastName    varchar(50) not null,
    BirthDate   date,
    Phone       char(10),
    Email       varchar(50)
);

create table if not exists CreditCard (
    CCardID     integer primary key,
    PassID      integer not null,
    CCNum       char(16) not null,
    Expires     date not null,
    CCV         char(3) not null,
constraint FKPassID foreign key(PassID) references Passenger
);

create table if not exists Connection (
    Inbound     integer,
    Outbound    integer,
    AptCode     char(3), -- actually not null
constraint PKConnection primary key(Inbound, Outbound),
constraint FKInbound foreign key(Inbound) references Flight(FltID),
constraint FKOutbound foreign key(Outbound) references Flight(FltID),
constraint FKAptCode foreign key(AptCode) references Airport
);

create table if not exists Airport (
    AptCode     char(3) primary key,
    Name        varchar(50) not null,
    City        varchar(50) not null,
    State       char(2) not null
);

create table if not exists Booking (
    PassID      integer,
    FltID       integer,
    FltDate     date,
    PaymentAcct integer not null,
    Seat        char(3),
constraint PKBooking primary key(PassID, FltID, FltDate),
constraint FKPassID foreign key(PassID) references Passenger,
constraint FKFltID foreign key(FltID) references Flight,
constraint FKPayment foreign key(PaymentAcct) references CreditCard(CCardID)
);

create table if not exists Flight (
    FltID       integer primary key,
    FltNo       integer unique,
    Origin      char(3) not null,
    Dest        char(3) not null,
    DpTime      time,
    ArrTime     time,
    InboundFlt  integer,
    ACID        integer
constraint FKOrigin foreign key(Origin) references Airport(AptCode),
constraint FKDest foreign key(Dest) references Airport(AptCode),
constraint FKInbound foreign key(InboundFlt) references Flight(FltID),
constraint FKACID foreign key(ACID) references Aircraft
);

create table if not exists Aircraft (
    ACID            integer primary key,
    Registration    char(6) unique not null,
    Manufacturer    varchar(30) not null,
    Model           varchar(10) not null,
    NumRows         integer,
    SeatsAcross     integer
)