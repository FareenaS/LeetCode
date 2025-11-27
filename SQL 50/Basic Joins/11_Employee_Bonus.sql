/*
Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| empId       | int     |
| name        | varchar |
| supervisor  | int     |
| salary      | int     |
+-------------+---------+
empId is the column with unique values for this table.
Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.
 

Table: Bonus

+-------------+------+
| Column Name | Type |
+-------------+------+
| empId       | int  |
| bonus       | int  |
+-------------+------+
empId is the column of unique values for this table.
empId is a foreign key (reference column) to empId from the Employee table.
Each row of this table contains the id of an employee and their respective bonus.
 

Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Employee table:
+-------+--------+------------+--------+
| empId | name   | supervisor | salary |
+-------+--------+------------+--------+
| 3     | Brad   | null       | 4000   |
| 1     | John   | 3          | 1000   |
| 2     | Dan    | 3          | 2000   |
| 4     | Thomas | 3          | 4000   |
+-------+--------+------------+--------+
Bonus table:
+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
Output: 
+------+-------+
| name | bonus |
+------+-------+
| Brad | null  |
| John | null  |
| Dan  | 500   |
+------+-------+
*/

/*
Note:-
* In the question they have mentioned they want records which satisfies either of two conditions, which means we have to use OR operator.
* When we do a left join, we will have null as the empId and bonus for the employees who did not recieve any bonus in the Bonus table, that is y in the where condition we can use either bonus is null or empId is null condition, both will give the same answer
*/

--Query using only WHERE clause
SELECT E.name, B.bonus
FROM Employee E
LEFT JOIN Bonus B ON B.empId=E.empId
where B.bonus<1000 OR B.bonus IS NULL;

SELECT E.name,B.bonus
FROM Employee E
LEFT JOIN Bonus B ON E.empId = B.empId 
WHERE B.bonus < 1000 OR B.empId IS NULL


--Query using scalar function(Takes more time due to a function call)
SELECT
e.name
,b.bonus
FROM employee e LEFT JOIN bonus b
ON b.empid=e.empid
WHERE IFNULL(b.bonus,0) <1000
