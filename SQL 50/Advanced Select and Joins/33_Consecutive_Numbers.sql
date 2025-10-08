/*
Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.
*/

/*
-In the question they want a number which appears thrice consecutively
So we need check if the number is equal to number in next row (LEAD(num,1) OVER (ORDER BY id) as next_num)
and if the number is equal to number in the 3rd row (LEAD(num,2) OVER (ORDER BY id) as next2_num)
*/

WITH CTE AS
(SELECT *
,LEAD(num,1) OVER (ORDER BY id) as next_num
,LEAD(num,2) OVER (ORDER BY id) as next2_num
FROM Logs)
SELECT DISTINCT num as ConsecutiveNums
FROM CTE
WHERE num=next_num AND num=next2_num;
