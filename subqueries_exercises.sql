use employees;
-- Find all the current employees with the same hire date as employee 101010 using a subquery.
describe employees;
SELECT e.first_name, 
	e.last_name, 
	e.hire_date
FROM employees AS e
JOIN dept_emp AS de
	ON de.emp_no = e.emp_no
WHERE hire_date = 
	(SELECT hire_date 
		FROM employees 
        WHERE emp_no = '101010') 
	AND de.to_date > NOW();

-- Find all the titles ever held by all current employees with the first name Aamod.
SELECT t.title, a.first_name
FROM employees AS e
JOIN titles AS t
	ON t.emp_no = e.emp_no
JOIN dept_emp AS de
	ON de.emp_no = e.emp_no
JOIN (SELECT emp_no, 
		first_name 
		FROM employees 
        WHERE first_name LIKE 'Aamod') AS a 
	ON a.emp_no = e.emp_no
WHERE de.to_date > NOW();

-- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
SELECT COUNT(e.emp_no) AS Old_Employees
FROM employees AS e
WHERE emp_no NOT IN 
	(SELECT emp_no
		FROM dept_emp 
        WHERE to_date > NOW());
#59,900 Employees no longer work there

-- Find all the current department managers that are female. List their names in a comment in your code.
SELECT CONCAT(first_name, ' ', last_name) AS Female_Names
FROM employees
WHERE emp_no IN 
	(SELECT emp_no 
		FROM dept_manager 
        WHERE to_date > NOW()) 
	AND gender = 'F';
#Isamu Legleitner, Karsten Sigstam, Leon DasSarma, and Hilary Kambil

-- Find all the employees who currently have a higher salary than the companie's overall, historical average salary.
SELECT COUNT(e.emp_no)
FROM employees as e
WHERE emp_no IN 
	(SELECT emp_no 
		FROM salaries 
        WHERE salary > 
			(SELECT AVG(salary) AS Avg_Salary 
				FROM salaries) 
		AND to_date > NOW());

-- How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built-in function to calculate the standard deviation.) What percentage of all salaries is this?
SELECT COUNT(salary) as total_salary, (((SELECT COUNT(salary) as total_salary
FROM salaries
WHERE salary
	>= ((SELECT (MAX(salary) - STD(salary)) FROM salaries WHERE to_date > NOW()))
    AND to_date > NOW())*100) / COUNT(salary)) AS percent
FROM salaries
WHERE salary
	>= ((SELECT (MAX(salary) - STD(salary)) FROM salaries WHERE to_date > NOW()))
    AND to_date > NOW() #83 salaries
        ; 
SELECT (((SELECT COUNT(salary) as total_salary
FROM salaries
WHERE salary
	>= ((SELECT (MAX(salary) - STD(salary)) FROM salaries WHERE to_date > NOW()))
    AND to_date > NOW())*100) / COUNT(salary)) AS percentage
FROM salaries
WHERE to_date > NOW(); #0.0346

-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.
-- BONUS

-- Find all the department names that currently have female managers.
SELECT d.dept_name
FROM departments as d
JOIN dept_emp as de
	ON de.dept_no = d.dept_no
JOIN employees as e
	ON e.emp_no = de.emp_no
WHERE e.emp_no IN 
	(SELECT emp_no 
		FROM dept_manager 
        WHERE to_date > NOW()) 
	AND gender = 'F';
    
-- Find the first and last name of the employee with the highest salary.
SELECT CONCAT(first_name, ' ', last_name) AS Full_Name
FROM employees
WHERE emp_no IN 
	(SELECT emp_no 
		FROM salaries 
		WHERE salary = 
			(SELECT MAX(salary) 
				FROM salaries));

-- Find the department name that the employee with the highest salary works in.
SELECT d.dept_name
FROM departments as d
JOIN dept_emp as de
	ON de.dept_no = d.dept_no
WHERE de.emp_no IN 
	(SELECT emp_no 
		FROM salaries 
		WHERE salary = 
			(SELECT MAX(salary) 
				FROM salaries));

-- Who is the highest paid employee within each department. 
SELECT d.dept_name#, CONCAT(e.first_name, ' ', e.last_name) AS Full_Name, s.salary
FROM departments as d
JOIN dept_emp as de
	ON de.dept_no = d.dept_no
#JOIN employees as e
	#ON e.emp_no = de.emp_no
WHERE de.dept_no IN (SELECT emp_no FROM salaries WHERE salary 

