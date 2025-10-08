/*
Table: Users

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
 

Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.

Return the result table ordered by user_id.

The result format is in the following example.

 

Example 1:

Input: 
Users table:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | aLice |
| 2       | bOB   |
+---------+-------+
Output: 
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | Alice |
| 2       | Bob   |
+---------+-------+
*/

/*
SELECT *
,UPPER(LEFT(name,1)) AS First_letter
,LOWER(SUBSTRING(name,2,LEN(name))) AS Remaining_letters
,CONCAT(UPPER(LEFT(name,1)),LOWER(SUBSTRING(name,2,LEN(name)))) AS Final_result
FROM Users

* Here, we are extracting the 1st letter using Left function and converting it to uppercase.
Instead of Left function we can use SUBSTRING function to extract only first letter
SUBSTRING(name,1,1)
* We are extracting the rest of the string using SUBSTRING() function and then converting it to lower case.
* We are using CONCAT function to concatenate the string. We can also use + symbol instead of concat() function
Ex:-upper(SUBSTRING(name, 1, 1))+lower(SUBSTRING(name, 2, len(name))) name
*/

SELECT 
user_id
,CONCAT(UPPER(LEFT(name,1)),LOWER(SUBSTRING(name,2,LEN(name)))) AS name
FROM Users
ORDER BY user_id
