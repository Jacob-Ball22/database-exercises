-- Join Example Database
-- Use the join_example_db. Select all the records from both the users and roles tables.
use join_example_db;
SELECT *
FROM users, roles;
-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT users.name as un, roles.name as rn
FROM users
JOIN roles
	ON users.role_id = roles.id;
#4 results
SELECT users.name as un, roles.name as rn
FROM users
LEFT JOIN roles
	ON users.role_id = roles.id;
#6 results
SELECT users.name as un, roles.name as rn
FROM users
RIGHT JOIN roles
	ON users.role_id = roles.id;
#5 results

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that have the role. Hint: You will also need to use group by in the query.
SELECT roles.name as rn, COUNT(users.role_id)
FROM users
RIGHT JOIN roles
	ON users.role_id = roles.id
GROUP BY roles.name;


-- Employees Database
-- Use the employees database.
use employees;
SELECT * FROM departments;

-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
SELECT d.dept_name AS 'Department Name', 
	CONCAT (e.first_name, ' ', e.last_name) AS 'Department Manager'
FROM employees AS e
JOIN dept_manager AS dm
	ON dm.emp_no = e.emp_no
JOIN departments AS d
	ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01'
ORDER BY dept_name ASC;

--   Department Name    | Department Manager
--  --------------------+--------------------
--   Customer Service   | Yuchang Weedman
--   Development        | Leon DasSarma
--   Finance            | Isamu Legleitner
--   Human Resources    | Karsten Sigstam
--   Marketing          | Vishwani Minakawa
--   Production         | Oscar Ghazalie
--   Quality Management | Dung Pesch
--   Research           | Hilary Kambil
--   Sales              | Hauke Zhang

-- Find the name of all departments currently managed by women.
SELECT d.dept_name AS 'Department Name', 
	CONCAT (e.first_name, ' ', e.last_name) AS 'Department Manager'
FROM employees AS e
JOIN dept_manager AS dm
	ON dm.emp_no = e.emp_no
JOIN departments AS d
	ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01' 
	AND e.gender = 'F'
ORDER BY dept_name ASC;

-- Department Name | Manager Name
-- ----------------+-----------------
-- Development     | Leon DasSarma
-- Finance         | Isamu Legleitner
-- Human Resources | Karsetn Sigstam
-- Research        | Hilary Kambil

-- Find the current titles of employees currently working in the Customer Service department.
SELECT t.title AS Title, 
	COUNT(t.emp_no) AS 'Count'
FROM dept_emp as de
JOIN titles as t
	ON t.emp_no = de.emp_no
WHERE de.dept_no = 'd009'
	AND t.to_date = '9999-01-01' 
    AND de.to_date = '9999-01-01'
GROUP BY t.title
ORDER BY t.title ASC;

-- Title              | Count
-- -------------------+------
-- Assistant Engineer |    68
-- Engineer           |   627
-- Manager            |     1
-- Senior Engineer    |  1790
-- Senior Staff       | 11268
-- Staff              |  3574
-- Technique Leader   |   241

-- Find the current salary of all current managers.
SELECT d.dept_name AS 'Department Name', 
	CONCAT (e.first_name, ' ', e.last_name) AS 'Name',
    s.salary as Salary
FROM employees AS e
JOIN dept_manager AS dm
	ON dm.emp_no = e.emp_no
JOIN departments AS d
	ON d.dept_no = dm.dept_no
JOIN salaries as s
	ON s.emp_no = e.emp_no
WHERE dm.to_date = '9999-01-01' 
	AND s.to_date = '9999-01-01'
ORDER BY dept_name ASC;

-- Department Name    | Name              | Salary
-- -------------------+-------------------+-------
-- Customer Service   | Yuchang Weedman   |  58745
-- Development        | Leon DasSarma     |  74510
-- Finance            | Isamu Legleitner  |  83457
-- Human Resources    | Karsten Sigstam   |  65400
-- Marketing          | Vishwani Minakawa | 106491
-- Production         | Oscar Ghazalie    |  56654
-- Quality Management | Dung Pesch        |  72876
-- Research           | Hilary Kambil     |  79393
-- Sales              | Hauke Zhang       | 101987

-- Find the number of current employees in each department.
SELECT d.dept_no AS Dept_No,
	d.dept_name AS Dept_Name, 
	COUNT(de.emp_no) AS Num_Employees
FROM departments AS d
JOIN dept_emp AS de
	ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01'
GROUP BY de.dept_no
ORDER BY de.dept_no ASC;

-- +---------+--------------------+---------------+
-- | dept_no | dept_name          | num_employees |
-- +---------+--------------------+---------------+
-- | d001    | Marketing          | 14842         |
-- | d002    | Finance            | 12437         |
-- | d003    | Human Resources    | 12898         |
-- | d004    | Production         | 53304         |
-- | d005    | Development        | 61386         |
-- | d006    | Quality Management | 14546         |
-- | d007    | Sales              | 37701         |
-- | d008    | Research           | 15441         |
-- | d009    | Customer Service   | 17569         |
-- +---------+--------------------+---------------+

-- Which department has the highest average salary? Hint: Use current not historic information.
SELECT d.dept_name AS Department_Name, 
    AVG(s.salary) AS Avg_Salary
FROM departments AS d
JOIN dept_emp AS de
	ON de.dept_no = d.dept_no
JOIN salaries AS s
	ON s.emp_no = de.emp_no
WHERE s.to_date = '9999-01-01' 
	AND de.to_date = '9999-01-01'
GROUP BY de.dept_no
ORDER BY Avg_Salary DESC
LIMIT 1;

-- +-----------+----------------+
-- | dept_name | average_salary |
-- +-----------+----------------+
-- | Sales     | 88852.9695     |
-- +-----------+----------------+
-- Who is the highest paid employee in the Marketing department?
SELECT e.first_name AS first_name,
	e.last_name AS last_name
FROM employees AS e
JOIN salaries AS s
	ON s.emp_no = e.emp_no
JOIN dept_emp AS de
	ON de.emp_no = e.emp_no
WHERE de.dept_no = 'd001' 
	AND s.to_date = '9999-01-01'
ORDER BY s.salary DESC
LIMIT 1;

-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | Akemi      | Warwick   |
-- +------------+-----------+

-- Which current department manager has the highest salary?
SELECT e.first_name AS First_Name, 
	e.last_name AS Last_Name, 
    s.salary AS Salary, 
    d.dept_name AS Department_Name
FROM employees AS e
JOIN dept_manager AS dm
	ON dm.emp_no = e.emp_no
JOIN departments AS d
	ON d.dept_no = dm.dept_no
JOIN salaries AS s
	ON s.emp_no = e.emp_no
WHERE dm.to_date = '9999-01-01'
ORDER BY s.salary DESC
LIMIT 1;

-- +------------+-----------+--------+-----------+
-- | first_name | last_name | salary | dept_name |
-- +------------+-----------+--------+-----------+
-- | Vishwani   | Minakawa  | 106491 | Marketing |
-- +------------+-----------+--------+-----------+

-- Determine the average salary for each department. Use all salary information and round your results.
SELECT d.dept_name AS Department_Name, 
    ROUND(AVG(s.salary)) AS Avg_Salary
FROM departments AS d
JOIN dept_emp AS de
	ON de.dept_no = d.dept_no
JOIN salaries AS s
	ON s.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY Avg_Salary DESC;

-- +--------------------+----------------+
-- | dept_name          | average_salary | 
-- +--------------------+----------------+
-- | Sales              | 80668          | 
-- +--------------------+----------------+
-- | Marketing          | 71913          |
-- +--------------------+----------------+
-- | Finance            | 70489          |
-- +--------------------+----------------+
-- | Research           | 59665          |
-- +--------------------+----------------+
-- | Production         | 59605          |
-- +--------------------+----------------+
-- | Development        | 59479          |
-- +--------------------+----------------+
-- | Customer Service   | 58770          |
-- +--------------------+----------------+
-- | Quality Management | 57251          |
-- +--------------------+----------------+
-- | Human Resources    | 55575          |
-- +--------------------+----------------+

-- Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT (e.first_name, ' ', e.last_name) AS 'Employee Name', 
	d.dept_name AS 'Department Name',
    CONCAT (m.first_name, ' ', m.last_name) AS 'Manager Name'
FROM employees e
JOIN dept_emp AS de 
	ON de.emp_no = e.emp_no
JOIN departments AS d 
	ON d.dept_no = de.dept_no
JOIN dept_manager AS dm 
	ON dm.dept_no = de.dept_no
JOIN employees AS m 
	ON m.emp_no = dm.emp_no
WHERE dm.to_date > NOW() AND de.to_date > NOW();

-- 240,124 Rows

-- Employee Name | Department Name  |  Manager Name
-- --------------|------------------|-----------------
--  Huan Lortz   | Customer Service | Yuchang Weedman

--  .....