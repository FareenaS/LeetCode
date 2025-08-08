/*
Table: Project
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.
 

Table: Employee
+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table. It's guaranteed that experience_years is not NULL.
Each row of this table contains information about one employee.
 
Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.
Return the result table in any order.
The query result format is in the following example.

Example 1:
Input: 
Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+
Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+
Output: 
+-------------+---------------+
| project_id  | average_years |
+-------------+---------------+
| 1           | 2.00          |
| 2           | 2.50          |
+-------------+---------------+
Explanation: The average experience years for the first project is (3 + 2 + 1) / 3 = 2.00 and for the second project is (3 + 2) / 2 = 2.50
*/

/*
Notes:
Formula for calculating average years:- average_years=SUM(Employees experience for that project's employees)/No. of employees in the project(Count of project_id will give us this)
As we are using GROUP BY here, we don't need to worry about getting experience_years for a particular employee 
*/

--Using formula
SELECT P.project_id,
ROUND(CAST(SUM(E.experience_years) AS DECIMAL(18,4))/COUNT(P.project_id),2) as average_years
FROM Project P
JOIN Employee E ON E.employee_id = P.employee_id
GROUP BY P.project_id;

--Using Average function directly
WITH cte AS (
    SELECT A.project_id AS project_id, B.experience_years AS experience_years
    FROM Project A
    LEFT JOIN Employee B ON A.employee_id = B.employee_id
)
SELECT 
    project_id, 
    ROUND(AVG(1.0 * experience_years),2) AS average_years
FROM cte 
GROUP BY project_id;

