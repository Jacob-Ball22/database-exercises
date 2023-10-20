use ursula_2323;
#Using the example from the lesson, 
#create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. 
#Be absolutely sure to create this table on your own database. 
#If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.


CREATE TEMPORARY TABLE employees_with_departments(
SELECT employees.first_name as first_name, 
	employees.last_name as last_name, 
    departments.dept_name as dept_name
FROM employees.employees
JOIN employees.dept_emp
	USING(emp_no)
JOIN employees.departments
	USING (dept_no)
LIMIT 100
);


-- Add a column named full_name to this table. 
-- It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
ALTER TABLE employees_with_departments add full_name VARCHAR(100);

-- Update the table so that the full_name column contains the correct data.
UPDATE employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name)
WHERE first_name = first_name AND last_name = last_name;
SELECT * FROM employees_with_departments;

-- Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;
SELECT * FROM employees_with_departments;

-- What is another way you could have ended up with this same table?

CREATE TEMPORARY TABLE employees_with_departments(
SELECT departments.dept_name as dept_name, 
	CONCAT(employees.first_name, ' ', employees.last_name)
FROM employees.employees
JOIN employees.dept_emp
	USING(emp_no)
JOIN employees.departments
	USING (dept_no)
LIMIT 100
);

-- Create a temporary table based on the payment table from the sakila database.
CREATE TEMPORARY TABLE payment_cents(
SELECT p.amount as amount
FROM sakila.payment as p
LIMIT 100
);

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
-- For example, 1.99 should become 199.
ALTER TABLE payment_cents MODIFY COLUMN amount VARCHAR(100);
UPDATE payment_cents SET amount = REPLACE(amount, '.', '');
SELECT * FROM payment_cents;
DROP TABLE payment_cents;


-- Go back to the employees database. Find out how the current average pay in each department compares to the overall current pay for everyone at the company.
-- For this comparison, you will calculate the z-score for each salary. 
-- In terms of salary, what is the best department right now to work for? The worst?
use employees;
    -- Returns the current z-scores for each salary
    -- Notice that there are 2 separate scalar subqueries involved
    SELECT salary,
        (salary - (SELECT AVG(salary) FROM salaries where to_date > now()))
        /
        (SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
    FROM salaries
    WHERE to_date > now();
    
SELECT 
	CASE
		WHEN dept_no = 'd001' THEN 'Marketing'
		WHEN dept_no = 'd002' THEN 'Finance'
		WHEN dept_no = 'd003' THEN 'Human Resources'
		WHEN dept_no = 'd004' THEN 'Production'
		WHEN dept_no = 'd005' THEN 'Development'
		WHEN dept_no = 'd006' THEN 'Quality Management'
		WHEN dept_no = 'd007' THEN 'Sales'
		WHEN dept_no = 'd008' THEN 'Research'
		WHEN dept_no = 'd009' THEN 'Customer Service'
	END AS dept_group, 
    AVG(salary) as Avg_Salary,
    CASE
		WHEN dept_no = 'd001' THEN ROUND(
        (
			(
				(SELECT AVG(salary) FROM salaries JOIN dept_emp USING (emp_no) where salaries.to_date > now() AND dept_emp.dept_no = 'd001' AND dept_emp.to_date > NOW())
					- (SELECT AVG(salary) FROM salaries where to_date > now()))
        /
        (SELECT stddev(salary) FROM salaries where to_date > now()))
        ,5)
        WHEN dept_no = 'd002' THEN ROUND(
        (
			(
				(SELECT AVG(salary) FROM salaries JOIN dept_emp USING (emp_no) where salaries.to_date > now() AND dept_emp.dept_no = 'd002' AND dept_emp.to_date > NOW())
					- (SELECT AVG(salary) FROM salaries where to_date > now()))
			/
			(SELECT stddev(salary) FROM salaries where to_date > now()))
        ,5)
        WHEN dept_no = 'd003' THEN ROUND(
		(
			(
				(SELECT AVG(salary) FROM salaries JOIN dept_emp USING (emp_no) where salaries.to_date > now() AND dept_emp.dept_no = 'd003' AND dept_emp.to_date > NOW())
					- (SELECT AVG(salary) FROM salaries where to_date > now()))
			/
			(SELECT stddev(salary) FROM salaries where to_date > now()))
		,5)
        WHEN dept_no = 'd004' THEN ROUND(
        (
			(
				(SELECT AVG(salary) FROM salaries JOIN dept_emp USING (emp_no) where salaries.to_date > now() AND dept_emp.dept_no = 'd004' AND dept_emp.to_date > NOW())
					- (SELECT AVG(salary) FROM salaries where to_date > now()))
			/
			(SELECT stddev(salary) FROM salaries where to_date > now()))
		,5)
        WHEN dept_no = 'd005' THEN ROUND(
        (
			(
				(SELECT AVG(salary) FROM salaries JOIN dept_emp USING (emp_no) where salaries.to_date > now() AND dept_emp.dept_no = 'd005' AND dept_emp.to_date > NOW())
					- (SELECT AVG(salary) FROM salaries where to_date > now()))
			/
			(SELECT stddev(salary) FROM salaries where to_date > now()))
		,5)
        WHEN dept_no = 'd006' THEN ROUND(
		(
			(
				(SELECT AVG(salary) FROM salaries JOIN dept_emp USING (emp_no) where salaries.to_date > now() AND dept_emp.dept_no = 'd006' AND dept_emp.to_date > NOW())
					- (SELECT AVG(salary) FROM salaries where to_date > now()))
			/
			(SELECT stddev(salary) FROM salaries where to_date > now()))
		,5)
        WHEN dept_no = 'd007' THEN ROUND(
        (
			(
				(SELECT AVG(salary) FROM salaries JOIN dept_emp USING (emp_no) where salaries.to_date > now() AND dept_emp.dept_no = 'd007' AND dept_emp.to_date > NOW())
					- (SELECT AVG(salary) FROM salaries where to_date > now()))
			/
			(SELECT stddev(salary) FROM salaries where to_date > now()))
		,5)
        WHEN dept_no = 'd008' THEN ROUND(
		(
			(
				(SELECT AVG(salary) FROM salaries JOIN dept_emp USING (emp_no) where salaries.to_date > now() AND dept_emp.dept_no = 'd008' AND dept_emp.to_date > NOW())
					- (SELECT AVG(salary) FROM salaries where to_date > now()))
			/
			(SELECT stddev(salary) FROM salaries where to_date > now()))
		,5)
        WHEN dept_no = 'd009' THEN ROUND(
		(
			(
				(SELECT AVG(salary) FROM salaries JOIN dept_emp USING (emp_no) where salaries.to_date > now() AND dept_emp.dept_no = 'd008' AND dept_emp.to_date > NOW())
					- (SELECT AVG(salary) FROM salaries where to_date > now()))
			/
			(SELECT stddev(salary) FROM salaries where to_date > now()))
		,5)
        END AS zscore
FROM dept_emp
JOIN salaries
	USING (emp_no)
WHERE salaries.to_date > NOW()
	AND dept_emp.to_date > NOW()
GROUP BY dept_group, zscore
;

#In comparison the best department is Sales and the worst is Human Resources
#'Sales','88852.9695','0.97289'
#'Marketing','80058.8488','0.46485'
#'Finance','78559.9370','0.37826'
#'Research','67913.3750','-0.23679'
#'Customer Service','67285.2302','-0.23679'
#'Production','67843.3020','-0.24084'
#'Development','67657.9196','-0.25155'
#'Quality Management','65441.9934','-0.37956'
#'Human Resources','63921.8998','-0.46738'
