Create Table icc_world_cup(
Team_1 varchar(20),
Team_2 varchar(20),
Winner varchar(20)
)

INSERT INTO icc_world_cup values('India', 'SL', 'India');
INSERT INTO icc_world_cup values('SL', 'Aus', 'Aus');
INSERT INTO icc_world_cup values('SA', 'Eng', 'Eng');
INSERT INTO icc_world_cup values('Eng', 'NZ', 'NZ');
INSERT INTO icc_world_cup values('Aus', 'India', 'India');


SELECT * FROM icc_world_cup

---write a qurey for number matched_palyed matched_wins matched_los
SELECT Team_1 ,case when Team_1=Winner then 1 else 0 end Winner from icc_world_cup
union all
SELECT Team_2, case When Team_2= Winner then 1 else 0 end Winner From icc_world_cup

--- Using subqurey Matched_played
SELECT A.Team_1 as Team_name, count(1) matched_played FROM(
SELECT Team_1, CASE WHEN Team_1=Winner Then 1 else 0 end Winner FROM icc_world_cup
union all
SELECT Team_2, CASE WHEN Team_2=Winner Then 1 else 0 end Winner FROM icc_world_cup
) A
GROUP BY A.Team_1
ORDER BY A.Team_1

--- Macthed Win
SELECT A.Team_1 as Team_name, COUNT(1) matched_played, SUM(Winner) as matched_win FROM(
SELECT Team_1, CASE WHEN Team_1=Winner Then 1 else 0 end Winner FROM icc_world_cup
union all 
SELECT Team_2, CASE WHEN Team_2=Winner THEN 1 ELSE 0 END Winner FROM icc_world_cup
) A
GROUP BY A.Team_1
ORDER BY SUM(A.Winner) desc

---Matched lose
SELECT A.Team_1 as Team_name, COUNT(1) matched_played, SUM(Winner) as Macthed_win, COUNT(1)-sum(a.winner) as Matched_lose FROM(
SELECT Team_1, CASE WHEN Team_1=Winner THEN 1 ELSE 0 END Winner FROM icc_world_cup
union all
SELECT Team_2, CASE WHEN Team_2=Winner THEN 1 ELSE 0 END Winner FROM icc_world_cup
) A
GROUP BY A.team_1
ORDER BY SUM(A.Winner) DESC

CREATE TABLE inter(
ID_name Varchar(50),
ID INT
)

Insert INTO inter values('a-b-c', 1);
INSERT INTO inter values('d-e-f', 2);
INSERT INTO inter values('g-h-i', 3)

SELECT * FROM inter

SELECT * FROM inter
CROSS APPLY string_split(ID_name, '-')

SELECT value,ID FROM inter
CROSS APPLY string_split(ID_name, '-')

CREATE TABLE sample(
ID INT
)

INSERT INTO sample VALUES(1);
INSERT INTO sample VALUES(2);
INSERT INTO sample VALUES(3);
INSERT INTO sample VALUES(4);
INSERT INTO sample VALUES(5);
INSERT INTO sample VALUES(6);
INSERT INTO sample VALUES(7);
INSERT INTO sample VALUES(8);
INSERT INTO sample VALUES(9);
INSERT INTO sample VALUES(10);

SELECT * FROM sample

SELECT ID AS Input,
(ID + 2) AS stage,
(ID + 2) % 10 AS Output
FROM sample

-----using mod logic
SELECT ID AS Input,
(ID + 2) % 10 AS Output
FROM sample


---HOW TO FIND 1,2,3 NTH HIGHEST SALARY IN SQL(USING MAX FUNCTION, SUBQUERY, CTE)
CREATE TABLE EMPLOYEESALARY(
ID INT PRIMARY KEY IDENTITY,
FirstName nvarchar(50),
LastName nvarchar(50),
Gender nvarchar(50),
Salary INT
)

INSERT INTO EMPLOYEESALARY VALUES('AJAY', 'Master', 'Male', 70000);
INSERT INTO EMPLOYEESALARY VALUES('RAM', 'BUTTA', 'Male', 60000);
INSERT INTO EMPLOYEESALARY VALUES('RAJESH', 'JAGA', 'Male', 45000);
INSERT INTO EMPLOYEESALARY VALUES('Tarun', 'Chabelou', 'Male', 70000);
INSERT INTO EMPLOYEESALARY VALUES('VIVEK', 'BI', 'Male', 45000);
INSERT INTO EMPLOYEESALARY VALUES('Asha', 'Med', 'Female', 30000);
INSERT INTO EMPLOYEESALARY VALUES('Aditi', 'A', 'Female',35000);
INSERT INTO EMPLOYEESALARY VALUES('SaiCharan', 'Palla', 'Male', 80000);
INSERT INTO EMPLOYEESALARY VALUES('Tejaswini', 'GOllamudi', 'Female',35000);
INSERT INTO EMPLOYEESALARY VALUES('Ranjith', 'Kumar','Male', 80000);

SELECT * FROM EMPLOYEESALARY

SELECT * FROM EMPLOYEESALARY ORDER BY Salary DESC

--To find the highesr Salary it is stright forward. we can simply use the MAX() function as shown below
SELECT MAX(Salary) AS highest  FROM EMPLOYEESALARY

--TO get the second highest Salary use a sub qurey along with MAX() function as show below.
SELECT MAX(SALARY) AS SecondHighest FROM EMPLOYEESALARY WHERE Salary <(
SELECT MAX(SALARY) FROM EMPLOYEESALARY)

SELECT MAX(Salary) FROM EMPLOYEESALARY WHERE Salary < 80000

---TO FIND nth highest Salary using subqurey
SELECT TOP 1 Salary
FROM(
SELECT DISTINCT TOP 9 Salary
FROM EMPLOYEESALARY
ORDER BY Salary DESC) RESULT
ORDER BY Salary

--To Find nth highest Salary Using CTE
WITH RESULT AS
(
SELECT Salary, 
		DENSE_RANK() OVER (ORDER BY Salary DESC) AS DENSERANK
		FROM EMPLOYEESALARY
)
SELECT TOP 1 Salary
FROM RESULT
WHERE DENSERANK = 5

