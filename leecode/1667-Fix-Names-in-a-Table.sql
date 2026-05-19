/*
Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.

Return the result table ordered by user_id.

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

select 
    user_id, 
    CONCAT(upper(substring(name, 1,1)), lower(substring(name, 2))) as name 
from Users 
order by user_id

--CONCAT(string1, string2, …)
--upper(), lower(), substring(string, index)
