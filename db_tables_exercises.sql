-- Open MySQL Workbench and login to the database server
-- Save your work in a file named db_tables_exercises.sql
-- List all the databases
SHOW databases;
-- Write the SQL code necessary to use the albums_db database
USE albums_db;
-- Show the currently selected database
SELECT database();
-- List all tables in the database
SHOW tables;
-- Write the SQL code to switch to the employees database
USE employees;
-- Show the currently selected database
SELECT database();
-- List all tables in the database
SHOW tables;
-- Explore the employees table. What different data types are present in this table?
DESCRIBE employees;
#Int, Date, Varchar, and Enum
-- Which table(s) do you think contain a numeric type column?
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;
-- Which table(s) do you think contain a string type column?
DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE titles;
-- Which table(s) do you think contain a date type column?
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;
-- What is the relationship between the employees and the departments tables? 
#There is no relationship between employees and departments since there are no similar columns
-- Show the SQL code that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
SHOW create table dept_manager;
