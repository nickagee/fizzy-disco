select * from employees where department like '%port%' or department = 'Books';

SELECT * FROM employees WHERE salary >= 100000 OR salary <= 65000;

SELECT * FROM employees WHERE department = 'Clothing' AND salary >= 90000 AND region_id = 2;

-- OR example
SELECT *
FROM employees
WHERE department = 'Sports'
OR department = 'Tools';

-- CONDITIONAL AND OR with ()
SELECT *
FROM employees
WHERE department = 'Books'
AND gender = 'M'
AND(region_id = 3 
	 OR region_id =1);
	 
-- NOT != <> examples	 
SELECT * 
FROM employees
WHERE NOT department = 'Sports';

SELECT * 
FROM employees
WHERE department != 'Sports';

SELECT * 
FROM employees
WHERE department <> 'Sports';

-- IS NULL example
SELECT COUNT(employee_id)
FROM employees
WHERE email IS NULL;

-- IN example
SELECT * 
FROM employees
WHERE department 
IN ('Sports', 'First Aid', 'Toys', 'Garden')

-- BETWEEN example
SELECT * 
FROM employees
WHERE salary 
BETWEEN 80000 AND 100000;

-- EXERCISE: WHERE Clause and Operators
-- Question 1
SELECT first_name, email
FROM employees
WHERE gender = 'F'
AND department = 'Tools'
AND salary > 110000;
-- Question 2
SELECT first_name, hire_date
FROM employees
WHERE salary > 165000
OR (department = 'Sports'
	AND gender = 'M');
-- Question 3
SELECT first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '2002-01-01' AND '2004-01-01';
--or this
SELECT first_name, hire_date
FROM employees
WHERE hire_date >= '2002-01-01' 
AND hire_date <= '2004-01-01';
-- Question 4
SELECT *
FROM employees
WHERE gender = 'M'
AND department = 'Automotive'
AND salary BETWEEN 40000 AND 100000
OR (gender = 'F'
   AND department = 'Toys');
   
-- ORDER BY Clause
SELECT *
FROM employees
WHERE salary < 100000
ORDER BY salary DESC;

-- DISTINCT and LIMIT and ORDER BY Clause
SELECT DISTINCT department
FROM employees
ORDER BY 1
LIMIT 10;

-- DISTINCT and FETCH FIRST and ORDER BY Clause
SELECT DISTINCT department
FROM employees
ORDER BY department
FETCH FIRST 5 ROWS ONLY;

-- Rename output columns
SELECT first_name AS "First Name", last_name AS "Last Name", department AS Department, salary AS "Yearly Salary"
FROM employees;

-- Assignment 2
--Question 1 "Write a query to display the names of those students that are between the ages of 18 and 20"
SELECT student_name
FROM students
WHERE age BETWEEN 18 AND 20;
--Question 2 "Write a query to display all of those students that contain the letters "ch" in their name or their name ends with the letters "nd"."
SELECT * 
FROM students
WHERE student_name LIKE '%ch%'
OR student_name LIKE '%nd';
--Question 3 "Write a query to display the name of those students that have the letters "ae" or "ph" in their name and are NOT 19 years old."
SELECT *
FROM students
WHERE age <> 19
AND (student_name LIKE '%ae%'
	 OR student_name LIKE '%ph%'
	);
--Question 4 "Write a query that lists the names of students sorted by their age from largest to smallest."
SELECT student_name
FROM students
ORDER BY age DESC;
--Question 5 "Write a query that displays the names and ages of the top 4 oldest students."
SELECT student_name, age
FROM students
ORDER BY age DESC
LIMIT 4;
--Question 6 "The student must not be older than age 20 if their student_no is either between 3 and 5 or their student_no is 7. Your query should also return students older than age 20 but in that case they must have a student_no that is at least 4."
SELECT *
FROM students
WHERE student_no BETWEEN 3 AND 5
OR student_no = 7 
AND age > 20
OR (age > 20
   AND student_no < 4);
   
-- UPPER LOWER LENGTH case function
SELECT UPPER(first_name), LOWER(last_name), LENGTH(department)
FROM employees;

--TRIM
SELECT TRIM('    TEST TEST TES  ');

--Concatenation columns
SELECT first_name || ' ' || last_name AS "Full Name"
FROM employees;

--Boolean Expressions
SELECT first_name || ' ' || last_name AS "Full Name", (salary > 140000) AS "Salary Test"
FROM employees
ORDER BY salary DESC; 

--Boolean Expressions
SELECT department, ('Clothing' IN (department, first_name) )
FROM employees; 

--Boolean Expressions
SELECT department, (department LIKE '%oth%')
FROM employees; 

--STRING Functions
--SUBSTRING
SELECT 'THIS IS test data' as "test_data";
SELECT SUBSTRING('This is test data' FROM 9);--extract text from the 9th
SELECT SUBSTRING('This is test data' FROM 9 FOR 4); --extract text from the 9th for 4 length

-- REPLACE
SELECT department, REPLACE(department, 'Clothing', 'Attire') as modified_dept
FROM departments;
--Another example
SELECT department, 
REPLACE(department, 'Clothing', 'Attire') as modified_dept, 
REPLACE(department, department, department || ' ' || 'Department') AS new_dept_name
FROM departments;
-- OR COULD DO IT THIS WAY AS WELL
SELECT department, 
REPLACE(department, 'Clothing', 'Attire') as modified_dept, 
department || ' Department' AS new_dept_name
FROM departments;

--SUBSTRING and POSITION get email domain
SELECT SUBSTRING(email, POSITION('@' IN email)) -- Add + 1 to remove the @ sign
FROM employees
WHERE email IS NOT NULL;

--COALESCE replace when NULL
SELECT COALESCE(email, 'NO EMAIL') AS email
FROM employees

--Grouping Functions 
SELECT MAX(salary), MIN(salary), AVG(salary), SUM(salary), COUNT(salary)
FROM employees;
-- Only counts data that is not null
SELECT COUNT(email)
FROM employees;
-- Calculate sum salary for ALL Clothing Departments
SELECT SUM(salary)
FROM employees
WHERE department LIKE '%Clothing';

-- Assignment 3
--Question 1 "Write a query against the professors table that can output the following in the result: "Chong works in the Science department""
SELECT REPLACE(last_name, 'Chong', 'Chong works in the ' || department || ' department')
FROM professors
WHERE last_name = 'Chong';

-- Question 2 "Write a SQL query against the professors table that would return the following result:
-- "It is false that professor Chong is highly paid"
-- "It is true that professor Brown is highly paid"
-- "It is false that professor Jones is highly paid"
-- "It is true that professor Wilson is highly paid"
-- "It is false that professor Miller is highly paid"
-- "It is true that professor Williams is highly paid"
-- NOTE: A professor is highly paid if they make greater than 95000."
SELECT 'It is ' || (salary>95000) || 'that professor ' || last_name || ' is highly paid'
FROM professors;
--Question 3 "Write a query that returns all of the records and columns from the professors table but shortens the department names to only the first three characters in upper case."
SELECT last_name, REPLACE(department, department, UPPER(SUBSTRING(department FROM 1 FOR 3))) AS department, salary, hire_date
FROM professors;
--Question 4 "Write a query that returns the highest and lowest salary from the professors table excluding the professor named 'Wilson'."
SELECT MAX(salary) as highest_salary,
MIN(salary) as lowest_salary
FROM professors
WHERE last_name != 'Wilson';
--Question 5 "Write a query that will display the hire date of the professor that has been teaching the longest."
SELECT MIN(hire_date)
FROM professors;


--GROUPING DATA AND COMPUTING AGGREGATES--
CREATE TABLE IF NOT EXISTS cars (make varchar(10));
INSERT INTO cars VALUES('Honda');
INSERT INTO cars VALUES('Toyota');
INSERT INTO cars VALUES('Ford');
INSERT INTO cars VALUES('Mazda');

SELECT * FROM cars;
--GROUP BY
SELECT COUNT(*), make 
FROM cars
GROUP BY make;

--GROUP BY
SELECT ROUND(AVG(salary), 3), department
FROM employees
WHERE region_id in (4,5,6,7)
GROUP BY department;

--Find count of employees by department
SELECT department, 
COUNT(employee_id) AS tot_n_em,
ROUND(AVG(salary), 2),
MIN(salary),
MAX(salary)
FROM employees
WHERE salary > 70000
GROUP BY department
ORDER BY tot_n_em DESC;

--Find count of employees by department
SELECT department, gender, COUNT(employee_id) 
FROM employees
GROUP BY department, gender
ORDER BY department;

--Having more than 35 employees
SELECT department, COUNT(employee_id)
FROM employees
GROUP BY department
HAVING count(employee_id) > 35
ORDER BY department;


--EXERCISE GROUP BY and HAVING
SELECT COUNT(*), first_name
FROM employees
GROUP BY first_name
HAVING count(*) > 2
ORDER BY count, first_name DESC;


SELECT department 
FROM employees
GROUP BY department
ORDER BY department;

SELECT SUBSTRING(email, POSITION('@' IN email ) + 1) AS email_domain, COUNT(*) AS domain_count
FROM employees
GROUP BY SUBSTRING(email, POSITION('@' IN email ) + 1)
ORDER BY COUNT(email) DESC
ORDER BY COUNT(*);

SELECT gender, region_id, MIN(salary) min_salary, MAX(salary) max_salary, ROUND(AVG(salary)) avg_salary
FROM employees
GROUP BY gender, region_id
ORDER BY gender, region_id



--Assignment 4

CREATE TABLE IF NOT EXISTS fruit_imports
(
	id integer,
	name varchar(20),
	season varchar(10),
	state varchar(20),
	supply integer,
	cost_per_unit decimal
);

insert into fruit_imports values(1, 'Apple', 'All Year', 'Kansas', 32900, 0.22);
insert into fruit_imports values(2, 'Avocado', 'All Year', 'Nebraska', 27000, 0.15);
insert into fruit_imports values(3, 'Coconut', 'All Year', 'California', 15200, 0.75);
insert into fruit_imports values(4, 'Orange', 'Winter', 'California', 17000, 0.22);
insert into fruit_imports values(5, 'Pear', 'Winter', 'Iowa', 37250, 0.17);
insert into fruit_imports values(6, 'Lime', 'Spring', 'Indiana', 40400, 0.15);
insert into fruit_imports values(7, 'Mango', 'Spring', 'Texas', 13650, 0.60);
insert into fruit_imports values(8, 'Orange', 'Spring', 'Iowa', 18000, 0.26);
insert into fruit_imports values(9, 'Apricot', 'Spring', 'Indiana', 55000, 0.20);
insert into fruit_imports values(10, 'Cherry', 'Summer', 'Texas', 62150, 0.02);
insert into fruit_imports values(11, 'Cantaloupe', 'Summer', 'Texas', 8000, 0.49);
insert into fruit_imports values(12, 'Apricot', 'Summer', 'Kansas', 14500, 0.20);
insert into fruit_imports values(13, 'Mango', 'Summer', 'Texas', 17000, 0.68);
insert into fruit_imports values(14, 'Pear', 'Fall', 'Nebraska', 30500, 0.12);
insert into fruit_imports values(15, 'Grape', 'Fall', 'Illinois', 72500, 0.35);

-- Write a query that displays only the state with the largest amount of fruit supply.
SELECT state
FROM fruit_imports 
GROUP BY state
ORDER BY SUM(supply) desc
LIMIT 1


-- Write a query that returns the most expensive cost_per_unit of every season. The query should display 2 columns, the season and the cost_per_unit
SELECT season, MAX(cost_per_unit) highest_cost_per_unit
FROM fruit_imports
GROUP BY season

-- Write a query that returns the state that has more than 1 import of the same fruit.
SELECT state
FROM fruit_imports
GROUP BY state, name
HAVING COUNT(name) > 1

-- Write a query that returns the seasons that produce either 3 fruits or 4 fruits.
SELECT season, COUNT(name)
FROM fruit_imports
GROUP BY season
HAVING count(name) = 3 OR count(name) = 4

-- Write a query that takes into consideration the supply and cost_per_unit columns for determining the total cost and returns the most expensive state with the total cost.
SELECT state, SUM(supply * cost_per_unit) total_cost
FROM fruit_imports
GROUP BY state
ORDER BY total_cost desc
LIMIT 1

-- Execute the below SQL script and answer the question that follows:

CREATE table fruits (fruit_name varchar(10));
INSERT INTO fruits VALUES ('Orange');
INSERT INTO fruits VALUES ('Apple');
INSERT INTO fruits VALUES (NULL);
INSERT INTO fruits VALUES (NULL);



-- Write a query that returns the count of 4. You'll need to count on the column fruit_name and not use COUNT(*)

-- HINT: You'll need to use an additional function inside of count to make this work.




-- SUBQUERIES
select department, count(*) from employees
where department not in (select department from departments)
group by department;


select * 
from (select * from employees where salary > 150000) as foo;

-- JOINS
select * from regions;
select * from employees;
select * from departments;

select first_name, country, 
from employees e, regions r
where e.region_id = r.region_id;

select e.first_name, e.email, e.department, d.division, r.region
from employees e, departments d, regions r
where e.department = d.department 
AND e.region_id = r.region_id
AND e.email IS NOT NULL;

SELECT r.country, count(e.employee_id)
from regions r, employees e
where r.region_id = e. region_id
group by r.country
order by count desc;

SELECT e.first_name || ' ' || e.last_name AS name, e.email, d.division, r.country 
FROM employees e INNER JOIN regions r 
ON e.region_id = r.region_id
INNER JOIN departments d
ON e.department = d.department
WHERE e.email IS NOT NULL;


SELECT first_name, country
FROM employees INNER JOIN regions
ON employees.region_id = regions.region_id;

SELECT first_name, email, division, country
FROM employees INNER JOIN departments
ON employees.department = departments.department
INNER JOIN regions ON employees.region_id = regions.region_id
WHERE email IS NOT NULL;

--UNION and UNION ALL
SELECT department
FROM employees
UNION
SELECT department
FROM departments;


SELECT department
FROM employees
UNION ALL
SELECT department
FROM departments;

--EXCEPT
--Returns the departments that are in the employees.department table that does exists in the departments.department table
SELECT department
FROM employees
EXCEPT --MINUS in Oracle DBs
SELECT department
FROM departments;

--Returns the departments from teh departments table that doesn't exists in the employees table.
SELECT DISTINCT department
FROM departments
EXCEPT --MINUS in Oracle DBs
SELECT DISTINCT department
FROM employees;

SELECT DISTINCT e.department, COUNT(e.employee_id)
FROM employees e
GROUP BY e.department
UNION ALL
SELECT 'TOTAL', COUNT(employee_id)
from employees;


--MORE JOINS
SELECT first_name, country
FROM employees INNER JOIN regions
ON employees.region_id = regions.region_id;

SELECT first_name, email, division, country
FROM employees INNER JOIN departments
ON employees.department = departments.department
INNER JOIN regions ON employees.region_id = regions.region_id
WHERE email IS NOT NULL;

SELECT DISTINCT department
FROM employees

SELECT DISTINCT department
FROM departments

SELECT DISTINCT employees.department, departments.department
FROM employees INNER JOIN departments on employees.department = departments.department