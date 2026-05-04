/*
Write a solution to find the people who have the most friends and the most friends number.
The test cases are generated so that only one person has the most friends.
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
*/

with all_friends as (
    select requester_id as id from RequestAccepted
    union all
    select accepter_id as id from RequestAccepted
) --id: 1,1,2,3,2,3,3,4
select id, count(*) as num
from all_friends
group by id --1:2, 2:2, 3:3, 4:1
order by num desc
limit 1;
