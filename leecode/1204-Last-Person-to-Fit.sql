/*1204. Last Person to Fit in the Bus
There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms, so there may be some people who cannot board.
Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit. The test cases are generated such that the first person does not exceed the weight limit.

Input: 
Queue table:
+-----------+-------------+--------+------+
| person_id | person_name | weight | turn |
+-----------+-------------+--------+------+
| 5         | Alice       | 250    | 1    |
| 4         | Bob         | 175    | 5    |
| 3         | Alex        | 350    | 2    |
| 6         | John Cena   | 400    | 3    |
| 1         | Winston     | 500    | 6    |
| 2         | Marie       | 200    | 4    |
+-----------+-------------+--------+------+
Output: 
+-------------+
| person_name |
+-------------+
| John Cena   |
+-------------+
*/
-- Solution 1: self join + subquery to compute cumulative weight
WITH cumulative AS (
    SELECT 
        person_id,
        person_name,
        turn,
        weight,
        (SELECT SUM(weight) FROM Queue q2 WHERE q2.turn <= q1.turn) AS total_weight   -- compute cumulative weight per turn
    FROM Queue q1
)
SELECT c.person_name
FROM cumulative c
INNER JOIN (
    SELECT MAX(turn) AS last_turn          -- find the last turn with total_weight <= 1000
    FROM cumulative
    WHERE total_weight <= 1000
) last ON c.turn = last.last_turn;         -- join to get the person name of that turn

-- Solution 2: window function (preferred, more efficient)
WITH cumulative AS (
    SELECT 
        person_name,
        turn,
        SUM(weight) OVER (ORDER BY turn) AS total_weight   -- cumulative sum using window function
    FROM Queue
)
SELECT person_name
FROM cumulative
WHERE total_weight <= 1000                  -- keep only those who fit
ORDER BY turn DESC
LIMIT 1;                                    -- get the last person who can board
