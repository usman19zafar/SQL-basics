SELECT @@VERSION;---checking version of SQL

go
CREATE TABLE Applicants (---Creating table command with certain columns
    StudentID INT PRIMARY KEY,-- 
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT
);

go
SELECT * FROM Applicants;--how to see what columnn table has

go
INSERT INTO Applicants (StudentID, FirstName, LastName, Age)--inserting data into table
VALUES (1, 'Ali', 'Khan', 6),
       (2, 'Sara', 'Ahmed', 7);

go
SELECT COUNT(*) FROM Applicants;-- how to check the numbers of rows in table

go
ALTER TABLE Applicants--how to insert column in table
ADD City VARCHAR(50);

go
UPDATE Applicants SET City = 'Milton' WHERE StudentID = 1;-- changing a data in a specific row

go
SELECT FirstName, LastName---Querry by condition (filtering by age)
FROM Applicants
WHERE Age = 7;

go
SELECT FirstName, LastName---Querry by condition (filtering by city-Milton)
FROM Applicants
WHERE city='Milton';

***-------------------------------SELECT------------------------------------***

go
SELECT FirstName, LastName FROM Applicants;-- selecting data from table (Report: List all student names.)

go
SELECT DISTINCT City FROM Applicants;--SELECT DISTINCT City FROM Applicants;

go
SELECT TOP 5 FirstName, Age FROM Applicants ORDER BY Age DESC; --Find the 5 oldest students.

go
SELECT StudentID, FirstName, LastName, Age, City---Report: Sorted list of students aged 6–7 by city.
FROM Applicants
WHERE Age BETWEEN 6 AND 7
ORDER BY City, Age;

go
SELECT StudentID, FirstName + ' ' + LastName AS FullName,--Customized Selection (Full names of students from Milton/Toronto, sorted by age then name.)
       Age, City
FROM applicants
WHERE City IN ('Milton','Toronto')
ORDER BY Age DESC, FullName;

%%%--------------------------WHERE--------------------------------------%%%

go
SELECT * FROM Applicants WHERE Age = 7;--Report: All students aged 7

go
SELECT FirstName, LastName FROM Applicants WHERE City = 'Milton';--Report: Students living in Milton.

go
SELECT * FROM Applicants WHERE Grade IN ('A','A+');--High‑performing students.

go
SELECT * FROM applicants WHERE Age > 6 AND City = 'Toronto';--Toronto students older than 6.

go
SELECT * FROM applicants-----------------------------------Select Multiple Conditions
WHERE (City = 'Mississauga' OR City = 'Oakville')
  AND Grade = 'B+'
  and age> 8;

)))))))))))))))----------------------------NEW CONCEPT = GROUP By-----------------------------(((((((((((((((((((

SELECT City, COUNT(*) AS StudentCount-------Number of students per city.
FROM Applicants
GROUP BY City;

go
SELECT City,------------------------Average hight per city
       AVG(Hight) AS AvgHight
FROM Applicants
GROUP BY City;

go
SELECT Grade, COUNT(*) AS CountPerGrade--------Grade distribution
FROM Applicants
GROUP BY Grade
ORDER BY CountPerGrade DESC;

go
SELECT City, Grade, COUNT(*) AS CountPerGroup-------Students grouped by two different variables like city and grade. 
FROM Applicants
GROUP BY City, Grade
ORDER BY City, Grade;

go
SELECT City, Gender, AVG(Age) AS AvgAge, COUNT(*) AS TotalStudents-------Only show city/section groups where average age > 6.5.(Strict narrow Condition)
FROM Applicants
GROUP BY City, gender
HAVING AVG(Age) > 6.5;

$$$----------------------------Aggregates (COUNT, SUM, AVG)-----------------------$$$

go
SELECT COUNT(*) AS TotalStudents FROM Applicants;------total rows in applicant table, Total student count.

go
SELECT AVG(Age) AS AvgAge FROM applicants;-----Average student age.

go
SELECT SUM(hight) AS Totalhight-----Total hight across all applicants.
FROM Applicants;

go
SELECT hight, AVG(Weight) AS Weight------Average weight per hight of applicants (considering combination of two columns)
FROM Applicants
GROUP BY hight;

go
SELECT City, COUNT(*) AS ApplicantCount, AVG(weight) AS AvgWeight----Cities where applicants are more than 5 years old, with applicant counts.
FROM Applicants
GROUP BY City
HAVING AVG(age) > 7;

###--------------------------------------Join-------------------------------------###

go
SELECT a.FirstName, a.LastName, a.City-----joining table columns
FROM Applicants a;

go 
SELECT a1.FirstName, a1.LastName, a2.City------------------Self join, Demonstrates join mechanics (though redundant).
FROM Applicants a1
INNER JOIN Applicants a2 ON a1.StudentID = a2.StudentID;

go
SELECT a.StudentID, a.FirstName, a.LastName, a.City, a2.Grade, a2.Gender------Joining two tables applicants & applicants2, and columns a & a2
FROM Applicants a
INNER JOIN Applicants2 a2 ON a.StudentID = a2.StudentID;

--Table Applicants (a) is the left table.
--Table Applicants2 (a2) is the right table.
--SQL returns all applicants from Applicants.
--If a matching StudentID exists in Applicants2, you’ll see their Grade and Gender.
--If no match exists, those columns show NULL.

--Visual Analogy
--Imagine two lists:
--Applicants: 100 people.
--Applicants2: 60 people (subset).
--With INNER JOIN → you only see the 60 people who exist in both lists.
--With LEFT JOIN → you see all 100 people, and for the 40 who don’t exist in Applicants2, their extra details are blank (NULL).

go
SELECT a.StudentID, a.FirstName, a.LastName, a.City, a2.Grade, a2.Gender---All applicants, with details from Applicants2 if available.
FROM Applicants a
LEFT JOIN Applicants2 a2 ON a.StudentID = a2.StudentID;

SELECT a.City, COUNT(a2.StudentID) AS MatchedApplicants----Number of applicants per city who also exist in Applicants2.
FROM Applicants a
INNER JOIN Applicants2 a2 ON a.StudentID = a2.StudentID
GROUP BY a.City;

SELECT a.City, a.Grade, COUNT(*) AS ApplicantCount---------City‑wise grade distribution of applicants who appear in both tables.
FROM Applicants a
INNER JOIN Applicants2 a2 ON a.StudentID = a2.StudentID
GROUP BY a.City, a.Grade
ORDER BY a.City, ApplicantCount DESC;

!!!!!!!!!!!!!--------------------------------Concept-Order By--------------------------!!!!!!!!!!!!!

go
SELECT FirstName, LastName, Age---Alphabetical applicant list.
FROM Applicants
ORDER BY LastName;

go
SELECT FirstName, LastName, Age---Applicants ranked by age.
FROM Applicants
ORDER BY Age DESC;

go
SELECT City, COUNT(*) AS ApplicantCount---Cities ranked by applicant volume.
FROM Applicants
GROUP BY City
ORDER BY ApplicantCount DESC;

go
SELECT Grade, AVG(Age) AS AvgAge----Grades ranked by average age.
FROM Applicants
GROUP BY Grade
ORDER BY AvgAge DESC;

go
SELECT City, Gender, COUNT(*) AS ApplicantCount---Gender distribution per city
FROM Applicants
GROUP BY City, Gender
ORDER BY City, ApplicantCount DESC;

///-------------------------------Concept: HAVING--------------------------------\\\

go
SELECT City, COUNT(*) AS ApplicantCount----Cities with more than 5 applicants.
FROM Applicants
GROUP BY City
HAVING COUNT(*) > 5;

go
SELECT Grade, AVG(Age) AS AvgAge---Grades with average age > 6. good analysis
FROM Applicants
GROUP BY Grade
HAVING AVG(Age) > 6;

go
SELECT City, SUM(Weight) AS TotalWeight---Cities where combined applicant weight > 500 kg.
FROM Applicants
GROUP BY City
HAVING SUM(Weight) > 500;

go
SELECT Eye_Colour, COUNT(*) AS CountPerColour---SELECT Eye_Colour, COUNT(*) AS CountPerColour---Eye colours with at least 3 applicants.
FROM Applicants
GROUP BY Eye_Colour
HAVING COUNT(*) >= 3;

go
SELECT City, AVG(Hight) AS AvgHight, COUNT(*) AS ApplicantCount---Cities with both tall average height and large applicant pools.
FROM Applicants
GROUP BY City
HAVING AVG(Hight) > 160 AND COUNT(*) > 10;


FROM Applicants
GROUP BY Eye_Colour
HAVING COUNT(*) >= 3;
@@@----------------------------CHECKING & FIXING ISSUES---------------------------@@@
go
SELECT *---------------------------checking a complete table
FROM applicants;

go
EXEC sp_rename 'Applicants.Colour', 'Eye_Colour', 'COLUMN';----changing column heading

go
SELECT COLUMN_NAME-------------------This will list all columns in the table.
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Applicants';

go
ALTER TABLE Applicants-------adding a column in a table
ADD Grade VARCHAR(10);

go
ALTER TABLE Applicants-------adding more columns in a table
ADD Hight INT,
	Weight INT,
	Colour VARCHAR(10),
	Gender VARCHAR(10);

go
OPTION = 1-- generating radom data

;WITH Numbers AS (---generating random data to fill table
    SELECT 3 AS n---its not emplty table, there are 2 incomplete rows
    UNION ALL
    SELECT n + 1 FROM Numbers WHERE n < 100
)
INSERT INTO Applicants (ApplicantID, FirstName, LastName, Age, City, Grade, Height, Weight, Colour, Gender)
SELECT n,
       CONCAT('First', n),
       CONCAT('Last', n),
       18 + (n % 10),             -- Age cycles between 18–27
       CONCAT('City', n),
       CONCAT('Grade', (n % 5)),  -- Grade0–Grade4
       150 + (n % 50),            -- Height cycles 150–199
       50 + (n % 30),             -- Weight cycles 50–79
       CASE WHEN n % 3 = 0 THEN 'Red'
            WHEN n % 3 = 1 THEN 'Blue'
            ELSE 'Green' END,
       CASE WHEN n % 2 = 0 THEN 'Male' ELSE 'Female' END
FROM Numbers
OPTION (MAXRECURSION 100);

go
--OPTION = 2-- very tirding and long activity!

INSERT INTO Students (StudentID, FirstName, LastName, Age, City, Grade, Height, Weight, Colour, Gender)
VALUES (1, 'Ali', 'Khan', 20, 'Toronto', 'A', 170, 65, 'Blue', 'Male'),
       (2, 'Sara', 'Ahmed', 22, 'Milton', 'B', 165, 55, 'Green', 'Female'),
       ...
       (100, 'Test100', 'User100', 25, 'City100', 'C', 180, 70, 'Red', 'Male');

go
UPDATE applicants----Inserting missing data in multiple boxes (columns) the table
SET Grade = 'A',
    Hight = 170,
    Weight = 65,
    Colour = 'Blue',
    Gender = 'Male'
WHERE StudentID = 2;

go
UPDATE applicants----Inserting missing data in one box only in the table
SET 
	City = 'Toronto'
WHERE StudentID = 2;

go
UPDATE applicants--- updating more missing data
SET Grade = 'A',
    Hight = 170,
    Weight = 65,
    Colour = 'Blue',
    Gender = 'Male'
WHERE StudentID = 1;

go
SELECT *--------------------copy a table 
INTO Applicants2
FROM Applicants;

SELECT LastName, FirstName, City, Age, Grade, Hight, Weight, Eye_Colour, Gender----------rearranging the table columns
FROM applicants2;