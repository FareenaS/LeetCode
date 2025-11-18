/*
Table: Weather
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
 
Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).
Return the result table in any order.
The result format is in the following example.

Example 1:

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).
*/

--Using Self-Join
--As we have to compare based on date also, we will be joining the tables based on date here
SELECT W1.id
FROM Weather W1
JOIN Weather W2 ON W1.recordDate = DATEADD(day,1,W2.recordDate)
WHERE W1.temperature > W2.temperature;


--Using LAG function
--Read the question properly, they want to compare the temperature between the recordDate and recordDate-1(Yesterday's date of recordDate).
WITH PreviousDayTemperatureCalculation AS(
SELECT *,
LAG(temperature) OVER(ORDER BY recordDate) AS previoudDayTemp,
LAG(recordDate) OVER(ORDER BY recordDate) AS previousDay
FROM Weather)
SELECT id
FROM PreviousDayTemperatureCalculation
WHERE temperature > previoudDayTemp
AND DATEDIFF(day,previousDay,recordDate)=1
