-- Approach #2: one table per leaf type
-- Almost identical to the DDL *without* a hierarchy
-- Advantage: no joins to get supertype data from a subtype
-- Disadvantage: if the subtypes aren't disjoint, 
--      redundant data => risk of inconsistency

create table if not exists Student (
    SSN char(9) primary key,
    FirstName varchar(30) not null,
    LastName varchar(50) not null,
    City varchar(50) not null,
    AddrState char(2) not null,
    Zip char(9) not null
    Major char(6),
    Class char(2),
    GPA float(3,2)
);

create table if not exists Faculty (
    SSN char(9) primary key,
    FirstName varchar(30) not null,
    LastName varchar(50) not null,
    City varchar(50) not null,
    AddrState char(2) not null,
    Zip char(9) not null
    FacDept char(6),
    FacRank char(4),
    FacSalary decimal(10,2),
    FacSupervisor char(9),
    FacHireDate date,
constraint FKSupv foreign key(FacSupervisor) references Faculty(SSN)
);
