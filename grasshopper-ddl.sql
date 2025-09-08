create table if not exists Passenger (
    PassID integer primary key autoincrement,
    FirstName varchar(30) not null,
    LastName varchar (30) not null,
    BirthDate date,
    CCardID integer, -- means of payment
    Phone char(10),
    Email varchar(30),
constraint FKCCard foreign key(CCardID) references CreditCard
);

create table if not exists CreditCard (
    CCardID integer primary key,
    CCNum char(16),
    Expires date,
    CCV char(3)
);

create table if not exists Airport (
    AptCode char(3) primary key, -- these things just don't change
    AptName varchar(50) not null,
    City varchar(50) not null,
    AptState char(2) not null -- state
);

create table if not exists Aircraft (
    ACID integer primary key autoincrement,
    Registration char(6) not null, -- US "N" number
    Manufacturer varchar(30) not null,
    Model varchar(10) not null,
    NumRows integer,
    SeatsAcross integer,
    -- All aircraft have only a single class of seating (small airline)
    -- Number of seats is the number of rows * the seats across
    -- In reality, we'd also need a list of seats that aren't present
    --    because of irregularities in the seat layout (as for bathrooms)
constraint UniqueReg unique(Registration)
);

create table if not exists Flight (
    FltID integer primary key autoincrement,
    FltNo integer not null, -- rarely changes, but it happens
    Origin char(3) not null,
    Dest char(3) not null,
    DpTime time, -- must be before ArTime
    ArTime time, -- must be after DpTime (accounting for days)
    ACID integer,
constraint UniqueNum unique(FltNo, Origin, Dest),
constraint FKOrigin foreign key(Origin) references Airport(AptCode),
constraint FKDest foreign key(Dest) references Airport(AptCode),
constraint FKAC foreign key(ACID) references Aircraft
);

create table if not exists Booking (
    PassID integer,
    FltID integer,
    FltDate date,
    Seat char(3), 
    -- constraint: the first two characters of Seat must be an
    --   integer less than or equal to the number of rows on the
    --   aircraft assigned to the flight, and the last character
    --   must be a capital letter such that letter-'A'+1 <= seats
    --   across on the aircraft.
constraint PKBooking primary key(PassID, FltID, FltDate),
constraint FKPass foreign key(PassID) references Passenger,
constraint FKFlt foreign key(FltID) references Flight
);