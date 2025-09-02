/*
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.

Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to determine the number of players who logged in on the day immediately following their initial login, and divide it by the number of total players.

The result format is in the following example.

 

Example 1:

Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Explanation: 
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33
*/

/*
If the question wants fraction → result should be between 0 and 1.
That’s why we multiply by 1.0 → just to force decimal division instead of integer division.
If the question wanted percentage → then you’d multiply by 100.0.
*/


/* Write your T-SQL query statement below */
WITH CTE AS
(SELECT *
,ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date) as rn
,LAG(event_date,1) OVER(PARTITION BY player_id ORDER BY event_date) as previous_logged_date
FROM Activity)
SELECT 
ROUND(
    SUM(
    CASE WHEN rn=2 AND event_date=DATEADD(DAY,1,previous_logged_date) THEN 1 ELSE 0 END
    )*1.0/COUNT(DISTINCT CASE WHEN rn=1 THEN player_id END)
    ,2
) AS fraction
FROM CTE;
