use employees;
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. What is the employee number of the top three results?
select * from employees where first_name in ('Irena','Vidya','Maya');
#The top three employee numbers are 10200, 10397, and 10610

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. What is the employee number of the top three results? Does it match the previous question?
select * from employees where first_name = 'Irena' OR 'Vidya' OR 'Maya';
#The top three employee numbers are 10397, 10610, and 10821. The results are not an exact match

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. What is the employee number of the top three results?
select * from employees where gender = 'm' and first_name = 'Irena' OR 'Vidya' OR 'Maya';
#The top three employee numbers are 10397, 10821, and 11327

-- Find all unique last names that start with 'E'.
select distinct last_name from employees where last_name like 'e%';

-- Find all unique last names that start or end with 'E'.
select distinct last_name from employees where last_name like 'e%' or '%e';

-- Find all unique last names that end with E, but does not start with E?
select distinct last_name from employees where last_name like '%e' and last_name not like 'e%';

-- Find all unique last names that start and end with 'E'.
select distinct last_name from employees where last_name like 'e%e';

-- Find all current or previous employees hired in the 90s. Enter a comment with the top three employee numbers.
select * from employees where hire_date like '199%';
#The top three employee numbers are 10008, 10011, and 10012

-- Find all current or previous employees born on Christmas. Enter a comment with the top three employee numbers.
select * from employees where birth_date like '%12-25';
#The top three employee numbers are 10078, 10115, and 10261

-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the top three employee numbers.
select * from employees where hire_date like '199%' and birth_date like '%12-25';
#The top three employee numbers are 10261, 10438, and 10681

-- Find all unique last names that have a 'q' in their last name.
select distinct last_name from employees where last_name like '%q%';

-- Find all unique last names that have a 'q' in their last name but not 'qu'.
select distinct last_name from employees where last_name like '%q%' and last_name not like '%qu%';