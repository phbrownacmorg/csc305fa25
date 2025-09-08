-- List the SSN, name (first and last), and salary of faculty.
-- select FacSSN, FacFirstName, FacLastName, FacSalary
-- from faculty;

-- List all columns of the Student table for students with a GPA of 3 or better.
-- Order the result by last name, first name.
select *
from Student
where StdGPA >= 3
order by StdLastName, StdFirstName;

-- List the SSN, name (first and last) , the major, and the GPA of IS majors
-- with a GPA of 3 or better and accounting majors with a GPA of 3.4 or better.
select StdSSN, StdFirstName, StdLastName, StdMajor, StdGPA
from Student
where (stdMajor = 'IS' and StdGPA >= 3) or (StdMajor = 'ACCT' and StdGPA >= 3.4);

-- List the cities and states where students reside.  Eliminate duplicates.
select distinct StdCity, StdState
from Student;

-- List all columns of the Offering table for offerings taught by Staff.
select *
from Offering
where FacSSN is null;

-- List all columns of the Offering table for offerings taught in Winter
-- 2005 that meet at 1:30 PM (13:30).
select *
from Offering
where OffTerm = 'WINTER' and OffYear = 2005 and OffTime = time('13:30');

-- List all columns of the Offering table for the IS courses offered in
-- Winter 2004
select *
from Offering
where OffTerm = 'WINTER' and OffYear = 2004 and CourseNo like 'IS%';