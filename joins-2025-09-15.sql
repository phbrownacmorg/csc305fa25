-- Which students (by first and last name) have taken IS320, and when?
-- Sort by last name, first name, year, and term.
-- (cross-product style)
select StdFirstName, StdLastName, CourseNo, OffTerm, OffYear, OffDays, OffTime
from Student, Enrollment, Offering
where Student.StdSSN = Enrollment.StdSSN
    and Enrollment.OfferNo = Offering.OfferNo
    and CourseNo = 'IS320'
order by StdLastName, StdFirstName, OffYear, OffTerm;

-- Which students (by first and last name) have taken IS320, and when?
-- Sort by last name, first name, year, and term.
-- (join operator style)
select StdFirstName, StdLastName, CourseNo, OffTerm, OffYear, OffDays, OffTime
from Student natural join Enrollment natural join Offering
where CourseNo = 'IS320'
order by StdLastName, StdFirstName, OffYear, OffTerm;
-- Join operator style is particularly helpful when you have natural joins.

-- Which students are also faculty?
-- Join operator style; note that this is *not* a natural join.
select StdFirstName, StdLastName
from Student inner join Faculty on StdSSN = FacSSN;

-- Which professors taught which courses during a Winter 2005?
-- Join operator style, ignoring the fact that this is a natural join
select FacFirstName, FacLastName, CourseNo, OffDays, OffTime
from Faculty inner join Offering on Faculty.FacSSN = Offering.FacSSN
where OffTerm = 'WINTER' and OffYear = '2005'
order by FacLastName, FacFirstName, CourseNo, OffDays, OffTime;

-- Left outer join
-- Which professors taught which courses during a Winter 2005?
-- Include offerings for which no professor was assigned.
-- Join operator style
select FacFirstName, FacLastName, CourseNo, OffDays, OffTime
from Offering left join Faculty on Faculty.FacSSN = Offering.FacSSN
where OffTerm = 'WINTER' and OffYear = '2005'
order by FacLastName, FacFirstName, CourseNo, OffDays, OffTime;

-- 4-way join
-- Which students have taken which courses from Leonard Vince, and when?
select StdFirstName, StdLastName, CourseNo, OffYear, OffTerm
from ((Student natural join Enrollment) natural join Offering)
        natural join Faculty
where FacFirstName = 'LEONARD' and FacLastName = 'VINCE'
order by StdLastName, StdFirstName, OffYear, OffTerm, CourseNo;

-- Aggregation
-- How many courses has each student taken during the period covered by the database?
select StdFirstName, StdLastName, count(OfferNo) as CoursesTaken
from Student natural join Enrollment
group by StdFirstName, StdLastName
order by StdLastName, StdFirstName;

-- How many creadit hours has each student attempted?
-- How many *distinct* courses has each student taken?
select StdFirstName, StdLastName, count(distinct Course.CourseNo) as CoursesTaken, 
        sum(CrsUnits) as HoursAttempted
from Student natural join Enrollment 
    natural join Offering natural join Course
group by StdFirstName, StdLastName
order by StdLastName, StdFirstName;

-- What is each student's GPA?  (Ignore Homer Wells retaking courses.)
-- Since every course has the same number of hours, the GPA is just a
-- straight average of the EnrGrade field in Enrollment.  Restrict the
-- result to those students having a GPA of at least 3.3.
select StdFirstName, StdLastName, avg(EnrGrade) as GPA
from Student natural join Enrollment
group by StdFirstName, StdLastName
having GPA >= 3.3
order by StdLastName, StdFirstName;


-- Unusually many joins

-- Who are the faculty members who make more than their supervisors?
-- List the first and last name, and salary of both faculty 
-- member and supervisor for all faculty who are paid more than
-- their supervisors.
-- Note that renaming the columns is necessary to keep Sqlite from
-- getting confused at output time.
select Sub.FacFirstName as SubFirst, Sub.FacLastName as SubLast, 
    Sub.FacSalary as SubPay,
    Supv.FacFirstName as SupvFirst, Supv.FacLastName as SupvLast, 
    Supv.FacSalary as SupvPay
from Faculty Sub inner join Faculty Supv on Sub.FacSupervisor = Supv.FacSSN
where SubPay > SupvPay;

-- List the names (first and last) and course numbers for which a faculty
-- member teaches the same course as his or her supervisor in calendar year 2005.
select Sub.FacFirstName as SubFirst, Sub.FacLastName as SubLast,
    SubOff.CourseNo as SubCourse,
    Supv.FacFirstName as SupvFirst, Supv.FacLastName as SupvLast,
    SupvOff.CourseNo as SupvCourse
from (Faculty Sub natural join Offering SubOff)
        inner join
    (Faculty Supv natural join Offering SupvOff)
        on Sub.FacSupervisor = Supv.FacSSN
where SubOff.CourseNo = SupvOff.CourseNo
    and SubOff.OffYear = 2005 and SupvOff.OffYear = 2005;
