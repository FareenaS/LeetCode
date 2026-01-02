/*
Table: Orders

+-----------------+----------+
| Column Name     | Type     |
+-----------------+----------+
| order_number    | int      |
| customer_number | int      |
+-----------------+----------+
order_number is the primary key (column with unique values) for this table.
This table contains information about the order ID and the customer ID.
 

Write a solution to find the customer_number for the customer who has placed the largest number of orders.

The test cases are generated so that exactly one customer will have placed more orders than any other customer.

The result format is in the following example.

 

Example 1:

Input: 
Orders table:
+--------------+-----------------+
| order_number | customer_number |
+--------------+-----------------+
| 1            | 1               |
| 2            | 2               |
| 3            | 3               |
| 4            | 3               |
+--------------+-----------------+
Output: 
+-----------------+
| customer_number |
+-----------------+
| 3               |
+-----------------+
Explanation: 
The customer with number 3 has two orders, which is greater than either customer 1 or 2 because each of them only has one order. 
So the result is customer_number 3.
*/

--Using CTE
WITH customer_orders AS (
    SELECT customer_number,COUNT(*) AS total_orders
    FROM Orders
    GROUP BY customer_number
)
SELECT TOP 1 customer_number
FROM customer_orders
ORDER BY total_orders DESC

--Using Window function
WITH total_orders AS(
    SELECT *
    ,ROW_NUMBER() OVER (PARTITION BY customer_number ORDER BY customer_number) AS rn
    FROM Orders 
)
SELECT TOP 1 customer_number
FROM total_orders
ORDER BY rn DESC

/*
Follow up question: What if more than one customer has the largest number of orders, can you find all the customer_number in this case?
*/

  --Using aggregate+GroupBy
SELECT customer_number
FROM Orders
GROUP BY customer_number
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM Orders
        GROUP BY customer_number
    ) t
);


--Using Window function
SELECT customer_number
FROM (
    SELECT customer_number,
           COUNT(*) AS cnt,
           RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
    FROM Orders
    GROUP BY customer_number
) t
WHERE rnk = 1;

--Dense_Rank will also work here
