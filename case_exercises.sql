use employees;
-- Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.
SELECT CONCAT(e.first_name, ' ', e.last_name) as 'Full Name', 
	de.dept_no, 
	de.from_date, 
	de.to_date, 
	IF(de.to_date > now(), 1, 0) AS is_current_employee
FROM employees as e
JOIN dept_emp as de
	ON de.emp_no = e.emp_no;

-- Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT CONCAT(e.first_name, ' ', e.last_name) as 'Full Name', 
	de.dept_no, 
	de.from_date, 
	de.to_date,
    CASE
		WHEN e.last_name BETWEEN 'a' AND 'i' THEN 'A-H'
        WHEN e.last_name BETWEEN 'i' AND 'r' THEN 'I-Q'
        WHEN e.last_name >= 'r' THEN 'R-Z'
	END AS alpha_group
FROM employees as e
JOIN dept_emp as de
	ON de.emp_no = e.emp_no;

-- How many employees (current or previous) were born in each decade?
SELECT
		COUNT(CASE WHEN birth_date LIKE '195%' THEN '50s' END) AS fiftys,
        COUNT(CASE WHEN birth_date LIKE '196%' THEN '60s' END) AS sixtys
FROM employees;
#182,886 From 50s, 117,138 From 60s

-- What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT
	DISTINCT CASE
       WHEN dept_name IN ('research', 'development') THEN 'R&D'
       WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
       WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
       WHEN dept_name IN ('Customer Service') THEN 'Customer Service'
	END AS dept_group,
    CASE
		WHEN dept_name IN ('research', 'development') THEN 
			(
            SELECT AVG(salary) 
            FROM salaries 
            WHERE emp_no IN 
				(
                SELECT emp_no 
                FROM dept_emp 
                WHERE dept_no IN ('d005','d008') 
					AND to_date > now()
				) AND to_date > now()
            )
		WHEN dept_name IN ('sales', 'marketing') THEN 
			(
            SELECT AVG(salary) 
            FROM salaries 
            WHERE emp_no IN 
				(
                SELECT emp_no 
                FROM dept_emp 
                WHERE dept_no IN ('d007','d001') 
					AND to_date > now()
				) AND to_date > now()
            )
		WHEN dept_name IN ('Production' , 'Quality Management') THEN 
        (
        SELECT AVG(salary) 
        FROM salaries 
        WHERE emp_no IN 
			(
            SELECT emp_no 
            FROM dept_emp 
            WHERE dept_no IN ('d004','d006') 
				AND to_date > now()
            ) AND to_date > now()
		)
		WHEN dept_name IN ('Finance' , 'Human Resources') THEN 
        (
        SELECT AVG(salary) 
        FROM salaries 
        WHERE emp_no IN 
			(
            SELECT emp_no 
            FROM dept_emp 
            WHERE dept_no IN ('d002','d003') 
				AND to_date > now()
			) AND to_date > now()
		)
		WHEN dept_name IN ('Customer Service') THEN 
        (
        SELECT AVG(salary) 
        FROM salaries 
        WHERE emp_no IN 
			(
            SELECT emp_no 
            FROM dept_emp 
            WHERE dept_no IN ('d009') 
				AND to_date > now()
			) AND to_date > now()
		) 
	END AS Average_Salary
FROM departments as d
;

-- BONUS
-- Remove duplicate employees from exercise 1.
select emp_no, max(to_date) as to_date
from demp_empy
group by em_no;

SELECT
	CONCAT(e.first_name, ' ', e.last_name) as 'Full Name',
    de.dept_no, 
	de.from_date, 
	de.to_date,
    IF(de.to_date > now(), 1, 0) AS is_current_employee
FROM employees as e
JOIN dept_emp as de
	ON de.emp_no = e.emp_no
JOIN (select emp_no, max(to_date) as to_date
from dept_emp
group by emp_no) as md
	on e.emp_no = md.emp_no
		and de.to_date = md.to_date
;


SELECT COUNT(emp_no) FROM dept_emp GROUP BY emp_no;

