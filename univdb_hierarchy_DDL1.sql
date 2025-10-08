-- Approach #1: one table per type in the hierarchy
-- Advantage: no redundant data
-- Disadvantage: needs a join to get supertype data from a subtype

create table if not exists Person (
    SSN char(9) primary key,
    FirstName varchar(30) not null,
    LastName varchar(50) not null,
    City varchar(50) not null,
    AddrState char(2) not null,
    Zip char(9) not null
);

create table if not exists Student (
    SSN char(9) primary key,
    Major char(6),
    Class char(2),
    GPA float(3,2)
constraint FKSSN foreign key(SSN) references Person
);

create table if not exists Faculty (
    SSN char(9) primary key,
    FacDept char(6),
    FacRank char(4),
    FacSalary decimal(10,2),
    FacSupervisor char(9),
    FacHireDate date,
constraint FKSSN foreign key(SSN) references Person,
constraint FKSupv foreign key(FacSupervisor) references Faculty(SSN)
);
