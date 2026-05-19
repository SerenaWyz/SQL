/*
Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.

For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.

For Pandas users, please note that you are supposed to modify Person in place.

After running your script, the answer shown is the Person table. The driver will first compile and run your piece of code and then show the Person table. The final order of the Person table does not matter.


Example 1:

Input: 
Person table:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Output: 
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
*/

--self join
delete p1 
from Person p1, Person p2 
where p1.email=p2.email and p1.id>p2.id

--subquery: In MySQL, the same table cannot be directly referenced in a subquery; it needs to be nested at one level.
delete from Person
where id not in(
  select * from (
    select min(id) 
    from Person 
    group by email) as tmp
) 
