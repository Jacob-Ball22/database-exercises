SHOW databases;
USE albums_db;
SELECT database();
SHOW tables;
USE employees;
SELECT database();
SHOW tables;
DESCRIBE employees;
#Which table(s) do you think contain a numeric type column?
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;
#Which table(s) do you think contain a string type column?
DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE titles;
#Which table(s) do you think contain a date type column?
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;
#What is the relationship between the employees and the departments tables? 
#There is no relationship between employees and departments since there are no similar columns
SHOW create table dept_manager;
