/*
You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.

Return the result table ordered by visited_on in ascending order.

The result format is in the following example.

Input: 
Customer table:
+-------------+--------------+--------------+-------------+
| customer_id | name         | visited_on   | amount      |
+-------------+--------------+--------------+-------------+
| 1           | Jhon         | 2019-01-01   | 100         |
| 2           | Daniel       | 2019-01-02   | 110         |
| 3           | Jade         | 2019-01-03   | 120         |
| 4           | Khaled       | 2019-01-04   | 130         |
| 5           | Winston      | 2019-01-05   | 110         | 
| 6           | Elvis        | 2019-01-06   | 140         | 
| 7           | Anna         | 2019-01-07   | 150         |
| 8           | Maria        | 2019-01-08   | 80          |
| 9           | Jaze         | 2019-01-09   | 110         | 
| 1           | Jhon         | 2019-01-10   | 130         | 
| 3           | Jade         | 2019-01-10   | 150         | 
+-------------+--------------+--------------+-------------+
Output: 
+--------------+--------------+----------------+
| visited_on   | amount       | average_amount |
+--------------+--------------+----------------+
| 2019-01-07   | 860          | 122.86         |
| 2019-01-08   | 840          | 120            |
| 2019-01-09   | 840          | 120            |
| 2019-01-10   | 1000         | 142.86         |
+--------------+--------------+----------------+
*/

WITH daily_sum as(
    select visited_on, SUM(amount) as day_amount
    from Customer
    group by visited_on
),
WITH window_week_sum as(
    select 
        visited_on, 
        SUM(day_amount) OVER(order by visited_on) ROWS between 6 preceding and current row) as amount, --sum of current row and previous 6 rows
        AVG(day_amount) OVER(order by visited_on) ROWS between 6 preceding and current row) as avg_amount,
        ROW_NUMBER() OVER(order by visited_on) as rn --row number ordered by visited_on (unique sequential number)
    from daily_sum
)
select visited_on, amount, ROUND(avg_amount,2) as average_amount from window_week_sum where rn>=7  --Filter out the first 6 rows because they do not have a full 7-day window.
