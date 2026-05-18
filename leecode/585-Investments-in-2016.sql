/*
Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:

have the same tiv_2015 value as one or more other policyholders, and
are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
Round tiv_2016 to two decimal places.

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
*/
select round(sum(tiv_2016), 2) AS tiv_2016 
from Insurance 
where tiv_2015 in (
    select tiv_2015 from insurance
    group by tiv_2015 
    having count(*)>1
  )
and (lat, lon) in (
    select * from Insurance 
    group by lat, lon 
    having count(*)=1
  )

-- exist
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance i
WHERE EXISTS (
    SELECT 1 FROM Insurance i2
    WHERE i2.tiv_2015 = i.tiv_2015 AND i2.pid != i.pid
)
AND NOT EXISTS (
    SELECT 1 FROM Insurance i2
    WHERE i2.lat = i.lat AND i2.lon = i.lon AND i2.pid != i.pid
);
