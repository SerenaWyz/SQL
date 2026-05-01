/*
Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.
Return the result table ordered by id in ascending order.

Input: 
Seat table:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
Output: 
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
*/

select 
    case 
        when id%2=1 and id<(select max(id) from Seat) then id+1
        when id%2=0 then id-1
        else id
    end as id,
    student 
from Seat 
order by id ASC

--TIPs
If the student ID is odd (id % 2 = 1) and it is not the last ID, then swap to id + 1.
If the student ID is even (id % 2 = 0), swap to id - 1.
Otherwise the last student is not swapped(id)
