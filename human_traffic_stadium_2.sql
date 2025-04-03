/**
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| visit_date    | date    |
| people        | int     |
+---------------+---------+
visit_date is the column with unique values for this table.
Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
As the id increases, the date increases as well.
 

Write a solution to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.

Return the result table ordered by visit_date in ascending order.

The result format is in the following example.
**/

WITH Consecutive AS (
    SELECT 
        id, 
        visit_date, 
        people,
        ROW_NUMBER() OVER (ORDER BY id) AS rn
    FROM Stadium
    WHERE people >= 100
),
Groups AS (
    SELECT 
        id,
        visit_date,
        people,
        rn - id AS group_id
    FROM Consecutive
)
SELECT 
    id,
    visit_date,
    people
FROM Groups
WHERE group_id IN (
    SELECT group_id
    FROM Groups
    GROUP BY group_id
    HAVING COUNT(*) >= 3
)
ORDER BY visit_date;
