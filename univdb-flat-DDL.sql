create table if not exists Student (
    StdSSN char(9) primary key,
    StdFirstName varchar(30) not null,
    StdLastName varchar(50) not null,
    StdCity varchar(50) not null,
    StdState char(2) not null,
    StdMajor char(6),
    StdClass char(2),
    StdGPA float(3,2),
    StdZip char(9) not null
);

create table if not exists Faculty (
    FacSSN char(9) primary key,
    FacFirstName varchar(30) not null,
    FacLastName varchar(50) not null,
    FacCity varchar(50) not null,
    FacState char(2) not null,
    FacDept char(6),
    FacRank char(4),
    FacSalary decimal(10,2),
    FacSupervisor char(9) foreign key references Faculty(FacSSN),
    FacHireDate date,
    FacZipCode char(9) not null
);

-- Repeated columns means repeated data (risk of inconsistency) if there are 
-- students who are also faculty.