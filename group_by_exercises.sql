-- In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT COUNT(DISTINCT title) 
FROM titles;
#There are 7 unique titles

-- Write a query to find a list of all unique last names that start and end with 'E' using GROUP BY.
SELECT last_name 
FROM employees
WHERE last_name like 'e%e'
GROUP BY last_name;

-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT first_name, last_name
FROM employees
WHERE last_name like 'e%e'
GROUP BY first_name, last_name;


-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT last_name
FROM employees
WHERE last_name LIKE '%q%' 
	AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
#Chleq, Lindqvist, and Qiwen

-- Add a COUNT() to your results for exercise 5 to find the number of employees with the same last name.
SELECT last_name, 
	COUNT(last_name) AS number_of_employees
FROM employees
WHERE last_name LIKE '%q%' 
	AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees with those names for each gender.
SELECT first_name, gender, COUNT(gender) as number_of_employees
FROM employees 
WHERE first_name in ('Irena','Vidya','Maya')
GROUP BY first_name, gender
ORDER BY first_name ASC;

-- Using your query that generates a username for all employees, generate a count of employees with each unique username.
SELECT 
LOWER(CONCAT(
	LEFT(first_name, 1),
	LEFT(last_name, 4),
	"_", 
	SUBSTRING(birth_date, 6,2),
	SUBSTRING(birth_date,3,2))) AS username,
COUNT(LOWER(CONCAT(
	LEFT(first_name, 1),
	LEFT(last_name, 4),
	"_", 
	SUBSTRING(birth_date, 6,2),
	SUBSTRING(birth_date,3,2)))) AS username_count
FROM employees
GROUP BY username
ORDER BY username_count DESC;

-- From your previous query, are there any duplicate usernames? What is the highest number of times a username shows up? Bonus: How many duplicate usernames are there?
#Yes, there are duplicate usernames, the highest number of times is 6, there are 13,251 rows of duplicate usernames
SELECT count(*)
FROM
	(SELECT 
	LOWER(CONCAT(
	LEFT(first_name, 1),
	LEFT(last_name, 4),
	"_", 
	SUBSTRING(birth_date, 6,2),
	SUBSTRING(birth_date,3,2))) AS username,
	COUNT(*) AS username_count
	FROM employees
	GROUP BY username
    HAVING username_count > 1
	ORDER BY username_count DESC) as un_counts;

-- Bonus: More practice with aggregate functions:
-- Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
SELECT emp_no,
	AVG(salary) as avg_salary
FROM salaries
GROUP BY emp_no;

-- Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
SELECT dept_no, COUNT(emp_no) as emp_count
FROM dept_emp
WHERE to_date = '9999-01-01'
GROUP BY dept_no;


-- Determine how many different salaries each employee has had. This includes both historic and current.
SELECT emp_no,
	COUNT(salary) as salary_changes
FROM salaries
GROUP BY emp_no;

-- Find the maximum salary for each employee.
SELECT emp_no,
	MAX(salary) as max_salary
FROM salaries
GROUP BY emp_no;

-- Find the minimum salary for each employee.
SELECT emp_no,
	MIN(salary) as min_salary
FROM salaries
GROUP BY emp_no;

-- Find the standard deviation of salaries for each employee.
SELECT emp_no,
	STD(salary) as std_salary
FROM salaries
GROUP BY emp_no;

-- Find the max salary for each employee where that max salary is greater than $150,000.
SELECT emp_no,
	MAX(salary) as max_salary
FROM salaries
GROUP BY emp_no
HAVING max_salary >= 150000;

-- Find the average salary for each employee where that average salary is between $80k and $90k. 
SELECT emp_no,
	AVG(salary) as avg_salary
FROM salaries
GROUP BY emp_no
HAVING avg_salary BETWEEN 80000 AND 90000;
