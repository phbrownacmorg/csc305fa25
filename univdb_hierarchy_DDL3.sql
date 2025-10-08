-- Approach #3: one table to rule them all
-- Advantage: no redundant data
-- Advantage: no join to get supertype data from a subtype
-- Disadvantage: may be lots of nulls
-- Disadvantage: foreign-key constraints into the big table may be less
--       specific than they would be with more tables

-- Occasionally see this with a type field added.  That's generally a
-- kludge (pronounced "klooj", meaning an ad-hoc, duct-tapey way of
-- getting things done).

create table if not exists Person (
    SSN char(9) primary key,
    FirstName varchar(30) not null,
    LastName varchar(50) not null,
    City varchar(50) not null,
    AddrState char(2) not null,
    Zip char(9) not null
    Major char(6),
    Class char(2),
    GPA float(3,2),
    FacDept char(6),
    FacRank char(4),
    FacSalary decimal(10,2),
    FacSupervisor char(9),
    FacHireDate date,
constraint FKSupv foreign key(FacSupervisor) references Person(SSN)
);
