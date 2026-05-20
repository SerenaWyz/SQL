/*
Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
*/
-- method1: dense_rank()
Select (
    select salary
    from (
        select salary, dense_rank() over (order by salary desc) as ranking
        from Employee 
    )t
    where ranking=2
    limit 1   
) as SecondHighestSalary

-- second higheset distinct salary: limit 1
-- outside SELECT ( ... ) : if the subquery can't query any data, return null.

-- method2：
select Max(salary) as SecondHighestSalary 
from Employee
where salary< (select Max(salary) from Employee)

--method3:
SELECT COALESCE(
    (SELECT DISTINCT salary FROM Employee ORDER BY salary DESC LIMIT 1 OFFSET 1),
    NULL
) AS SecondHighestSalary;
