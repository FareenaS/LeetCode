/*
Table: RequestAccepted

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 

Write a solution to find the people who have the most friends and the most friends number.

The test cases are generated so that only one person has the most friends.

The result format is in the following example.

 

Example 1:

Input: 
RequestAccepted table:
+--------------+-------------+-------------+
| requester_id | accepter_id | accept_date |
+--------------+-------------+-------------+
| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |
| 2            | 3           | 2016/06/08  |
| 3            | 4           | 2016/06/09  |
+--------------+-------------+-------------+
Output: 
+----+-----+
| id | num |
+----+-----+
| 3  | 3   |
+----+-----+
Explanation: 
The person with id 3 is a friend of people 1, 2, and 4, so he has three friends in total, which is the most number than any others.
*/

/*
Approach:

1.Run two queries of select. In first select requester_id as id from table and in second query select accepter_id as id from table.
2.Combine their result with union all. Since we need to count every friend we can't use union only as union only result unique values.
3.Store this result in cte.
4.From cte select id and count(*) and group by id.
5.Now order by count desc so we can get id with maximum friends op top.
6.Finally use limit 1 to find the topmost id which will have maximum number of friends.
*/

WITH FriendsId AS(
SELECT requester_id AS id
FROM RequestAccepted

UNION ALL

SELECT accepter_id AS id
FROM RequestAccepted
)
SELECT TOP 1 id,COUNT(*) AS num
FROM FriendsId
GROUP BY id
ORDER BY num DESC;
