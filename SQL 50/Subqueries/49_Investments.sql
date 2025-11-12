/*
Table: Insurance

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| pid         | int   |
| tiv_2015    | float |
| tiv_2016    | float |
| lat         | float |
| lon         | float |
+-------------+-------+
pid is the primary key (column with unique values) for this table.
Each row of this table contains information about one policy where:
pid is the policyholder's policy ID.
tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
lat is the latitude of the policy holder's city. It's guaranteed that lat is not NULL.
lon is the longitude of the policy holder's city. It's guaranteed that lon is not NULL.
 

Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:

have the same tiv_2015 value as one or more other policyholders, and
are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
Round tiv_2016 to two decimal places.

The result format is in the following example.

 

Example 1:

Input: 
Insurance table:
+-----+----------+----------+-----+-----+
| pid | tiv_2015 | tiv_2016 | lat | lon |
+-----+----------+----------+-----+-----+
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 20       | 20  | 20  |
| 3   | 10       | 30       | 20  | 20  |
| 4   | 10       | 40       | 40  | 40  |
+-----+----------+----------+-----+-----+
Output: 
+----------+
| tiv_2016 |
+----------+
| 45.00    |
+----------+
Explanation: 
The first record in the table, like the last record, meets both of the two criteria.
The tiv_2015 value 10 is the same as the third and fourth records, and its location is unique.

The second record does not meet any of the two criteria. Its tiv_2015 is not like any other policyholders and its location is the same as the third record, which makes the third record fail, too.
So, the result is the sum of tiv_2016 of the first and last record, which is 45.
*/

/*
Notes:
COUNT(*) OVER(PARTITION BY lat,lon) as countLatLon
-This function will give countLatLon>1 for the rows having same lat,lon values
-Ex: If 2 rows have 20,20 as lat,lon values, then countLatLon will have 2 as value as there ar 2 occurences
-As we are looking for a unique occurence, we are adding the condition **countLatLon = 1**

COUNT(*) OVER(PARTITION BY tiv_2015) as countT_2015
-This function will give 1 as result for unique values, but we are checking for records having same values in tiv_2015 column, that is y we are adding the filter **countT_2015>1** to get records having the same values for tiv_2015
*/

WITH CTE AS(
SELECT *,
COUNT(*) OVER(PARTITION BY lat,lon) as countLatLon,
COUNT(*) OVER(PARTITION BY tiv_2015) as countT_2015
FROM Insurance
)
SELECT ROUND(SUM(tiv_2016)*1.00,2) as tiv_2016 
FROM CTE
WHERE countLatLon = 1
AND countT_2015>1
