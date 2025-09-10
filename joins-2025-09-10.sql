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