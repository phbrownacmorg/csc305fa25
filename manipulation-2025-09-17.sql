-- Insert yourself as a new row in the Student table
insert into Student(StdSSN, StdFirstName, StdLastName, StdCity, StdState, StdZip)
    values('555555555', 'Peter', 'Brown', 'Spartanburg', 'SC', '29307');

-- enroll all the students whose last names begin with "B" or "D" into offering 8888
insert into Enrollment (StdSSN, OfferNo) -- List of columns because I want nulls for EnrGrade
    select StdSSN, '8888' as OfferNo     -- Columns from SELECT need to match columns in column list
    from Student
    where StdLastName like "B%" or StdLastName like "D%";

-- Give a 10% raise to faculty making less than $60,000, and a 5% raise to the rest
update Faculty set FacSalary = FacSalary * 1.05
WHERE FacSalary >= 60000;
update Faculty set FacSalary = FacSalary * 1.1
WHERE FacSalary < 60000;

-- A hitherto-unknown pressure group threatens the school with legal action
-- over the content of IS320. The university administration, unable to afford
-- a legal fight, decides to remove the course from the catalog.  Delete IS320
-- from the Course table, without violating referential integrity.

delete from Course
where CourseNo = 'IS320';

-- Offerings reference IS320: 1111, 1234, 3333, 4321, 4444, 8888
select OfferNo from Offering
where CourseNo = 'IS320';

delete from Offering
where OfferNo in (1111, 1234, 3333, 4321, 4444, 8888); -- Second DELETE to run


-- Enrollments reference the offerings that reference IS320
select * from Enrollment
where OfferNo in (1111, 1234, 3333, 4321, 4444, 8888);

delete from Enrollment
where OfferNo in (1111, 1234, 3333, 4321, 4444, 8888);  -- First DELETE to run

-- (If you're getting a bad feeling that this would rewrite history, denying
-- students credit retroactively, you're right.  An actual Course table
-- would have dates on which courses were added to and removed from the
-- catalog, so that *future* offerings of IS320 could be prevented without
-- nuking the records of *past* offerings.  This database doesn't have that.)