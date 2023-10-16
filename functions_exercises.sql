-- Write a query to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
select first_name, last_name 
from employees 
where last_name like '%e';

select concat(first_name," ", last_name) as full_name 
from employees 
where last_name like '%e';

-- Convert the names produced in your last query to all uppercase.
select upper(concat(first_name," ", last_name)) 
from employees 
where last_name like '%e';

-- Use a function to determine how many results were returned from your previous query.
select count(concat(first_name," ", last_name)) 
from employees 
where last_name like '%e';

-- Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),
select * 
from employees
where hire_date like '199%' and birth_date like '%12-25';

select datediff(curdate(), hire_date) 
from employees
where hire_date like '199%' and birth_date like '%12-25';

-- Find the smallest and largest current salary from the salaries table.
select min(salary), max(salary) 
from salaries;

-- Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:-- 
-- +------------+------------+-----------+------------+
-- | username   | first_name | last_name | birth_date |
-- +------------+------------+-----------+------------+
-- | gface_0953 | Georgi     | Facello   | 1953-09-02 |
-- | bsimm_0664 | Bezalel    | Simmel    | 1964-06-02 |
-- | pbamf_1259 | Parto      | Bamford   | 1959-12-03 |
-- | ckobl_0554 | Chirstian  | Koblick   | 1954-05-01 |
-- | kmali_0155 | Kyoichi    | Maliniak  | 1955-01-21 |
-- | apreu_0453 | Anneke     | Preusig   | 1953-04-20 |
-- | tziel_0557 | Tzvetan    | Zielinski | 1957-05-23 |
-- | skall_0258 | Saniya     | Kalloufi  | 1958-02-19 |
-- | speac_0452 | Sumant     | Peac      | 1952-04-19 |
-- | dpive_0663 | Duangkaew  | Piveteau  | 1963-06-01 |
-- +------------+------------+-----------+------------+
-- 10 rows in set (0.05 sec)
select 
lower(concat(
left(first_name, 1),
left(last_name, 4),
"_", 
substring(birth_date, 6,2),
substring(birth_date,3,2))) as username, 
first_name, last_name, birth_date 
from employees;