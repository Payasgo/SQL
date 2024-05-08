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
