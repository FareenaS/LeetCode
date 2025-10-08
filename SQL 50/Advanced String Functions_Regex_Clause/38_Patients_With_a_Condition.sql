/*
Table: Patients

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| patient_id   | int     |
| patient_name | varchar |
| conditions   | varchar |
+--------------+---------+
patient_id is the primary key (column with unique values) for this table.
'conditions' contains 0 or more code separated by spaces. 
This table contains information of the patients in the hospital.
 

Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes. Type I Diabetes always starts with DIAB1 prefix.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Patients table:
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
| 1          | Daniel       | YFEV COUGH   |
| 2          | Alice        |              |
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 |
| 5          | Alain        | DIAB201      |
+------------+--------------+--------------+
Output: 
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 | 
+------------+--------------+--------------+
Explanation: Bob and George both have a condition that starts with DIAB1.
*/

/*
WHERE conditions LIKE '% DIAB1%'
OR conditions LIKE 'DIAB1%'
* We are using 2 conditions in WHERE instead of one LIKE '%DIAB1%' here, bcz 
1. LIKE '%DIAB1% include all records starting with DIAB1 
2. Also records which has any prefix before DIAB1, which is wrong, as in the question it i mentioned that "Type I Diabetes always starts with DIAB1 prefix",so it can have no prefix or prefix then space followed by DIAB1
Ex: SADIAB100 is not a Type1 diabetes, so it should be omitted that is y we dont use LIKE '% DIAB1%'
*/

SELECT *
FROM Patients
WHERE conditions LIKE '% DIAB1%'
OR conditions LIKE 'DIAB1%'
