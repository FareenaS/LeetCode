/*
Table: Seat

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key (unique value) column for this table.
Each row of this table indicates the name and the ID of a student.
The ID sequence always starts from 1 and increments continuously.
 

Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Seat table:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
Output: 
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
Explanation: 
Note that if the number of students is odd, there is no need to change the last one's seat.
*/

/*
We can solve this problem 2 ways:- Either swap the id's or swap names
2 methods of solving the problem:- Subquery and window function(lead and lag)

--Using subquery
SELECT
s.id

		--When id is odd and it is not the last id, take name from next row
		,CASE WHEN s.id % 2 <> 0 AND s.id NOT IN (SELECT max(id) FROM seat)
		THEN (SELECT student FROM seat WHERE id=s.id+1)

		--When id is even, take name from previous row
		WHEN s.id % 2 = 0
		THEN (SELECT student FROM seat WHERE id=s.id-1)

		 --When id is odd and it is the last id, keep name as is (as there is no record to swap)
		ELSE s.student
		
		END AS student

FROM Seat s
ORDER BY id

--Using Winow functions
SELECT id
--When the id is odd, take next value. As lead returns null for the last column, give the default value as student
,CASE WHEN id %2 <> 0 THEN lead(student,1,student) OVER (ORDER BY id)
--When id is even, take previous value
ELSE lag(student) OVER (ORDER BY id)
END AS student
FROM seat
ORDER BY id
*/


/* Write your T-SQL query statement below */
SELECT id
,CASE WHEN id %2 <> 0 THEN lead(student,1,student) OVER (ORDER BY id)
ELSE lag(student) OVER (ORDER BY id)
END AS student
FROM seat
ORDER BY id
