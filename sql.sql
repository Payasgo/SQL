SELECT * FROM dbo.Employee

--- TO DELETE The Duplicate value in sql.
;with cte as
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY FirstName ORDER BY Phone) as dup
FROM dbo.Employee
)
Delete FROM cte where dup >1

----

SELECT * FROM  dbo.orders

update dbo.Employee
SET phone = 45687912
where phone IS NULL    

