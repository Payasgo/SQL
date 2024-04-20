SELECT * FROM dbo.Employee

--- TO DELETE The Duplicate value in sql.
;with cte as
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY FirstName ORDER BY Phone) as dup
FROM dbo.Employee
)
Delete FROM cte where dup >1

