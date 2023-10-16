-- MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:
-- SELECT DISTINCT title FROM titles;
-- List the first 10 distinct last names sorted in descending order.
select distinct last_name 
from employees 
order by last_name desc limit 10;

-- Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.
select * 
from employees 
where hire_date like '199%' and birth_date like '%12-25' 
order by hire_date limit 5;
#The first five names are Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, and Petter Stroustrup

-- Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.
select * 
from employees 
where hire_date like '199%' and birth_date like '%12-25' 
order by hire_date limit 5 offset 45;

-- LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
#Offset is the number of skips so 5 would skip 1 page and so on.
#Limit gives the results per each page.
#The page number gives you a smaller set of data to work with and can help you keep track better.