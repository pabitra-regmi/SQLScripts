CREATE DATABASE Employee;

USE Employee;
/* =========================================================
   TABLE CREATION
   ========================================================= */

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    age INT,
    city VARCHAR(30)
);

/* =========================================================
   INSERT AT LEAST 15 RECORDS
   ========================================================= */

INSERT INTO employees VALUES
(1, 'Amit', 'IT', 50000, 25, 'Delhi'),
(2, 'Rita', 'HR', 40000, 28, 'Mumbai'),
(3, 'Suman', 'IT', 60000, 30, 'Delhi'),
(4, 'John', 'Finance', 55000, 35, 'London'),
(5, 'Neha', 'HR', 45000, 26, 'Mumbai'),
(6, 'Rahul', 'IT', 70000, 32, 'Bangalore'),
(7, 'Priya', 'Finance', 48000, 29, 'Delhi'),
(8, 'Ankit', 'IT', 52000, 27, 'Pune'),
(9, 'Kiran', 'HR', 42000, 31, 'Chennai'),
(10, 'Sara', 'Marketing', 46000, 24, 'Mumbai'),
(11, 'Vikas', 'Marketing', 50000, 33, 'Delhi'),
(12, 'Pooja', 'HR', 39000, 23, 'Pune'),
(13, 'David', 'Finance', 65000, 38, 'London'),
(14, 'Nikhil', 'IT', 58000, 28, 'Bangalore'),
(15, 'Meena', 'Marketing', 47000, 26, 'Chennai');

/*  Display all employees */
SELECT * FROM employees;

/*  Display only employee name and salary */
SELECT name, salary
FROM employees;

/* Find employees working in IT department */
SELECT *
FROM employees
WHERE department = 'IT';


/*  Find employees whose salary is greater than 50000 */
SELECT * FROM employees
WHERE salary > 50000;

/*  Find employees who work in IT and earn more than 50000 */
SELECT * FROM employees
WHERE department ='IT' AND salary > 50000;

/* Find employees who belong to HR or Marketing */
SELECT * FROM employees
WHERE department= 'HR' OR department = 'Marketing';

/*  Display unique list of cities */
SELECT DISTINCT city
FROM employees; 

/* Sort employees by salary in descending order */
SELECT * FROM employees
ORDER BY salary DESC;

/* Display top 5 highest paid employees */
SELECT TOP 5 * FROM employees
ORDER BY salary DESC ;


/* Count total number of employees */
SELECT COUNT(*) AS total
FROM employees;

/* Count total number of employees */
SELECT COUNT(*) AS total_employees
FROM employees;

/* Find average salary of employees */
SELECT AVG(salary) AS average_salary
FROM employees;

/*  Find maximum and minimum salary */
SELECT 
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary
FROM employees;

/*  Find total salary paid by each department */
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department;

/* Count number of employees in each department */
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;

/* Display departments having more than 3 employees */
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 3;

/*  Find employees whose name starts with 'A' */
SELECT *
FROM employees
WHERE name LIKE 'A%';

/*  Find employees whose name contains letter 'i' */
SELECT *
FROM employees
WHERE name LIKE '%i%';

/*  Find employees from Delhi, Mumbai, or Pune */
SELECT *
FROM employees
WHERE city IN ('Delhi', 'Mumbai', 'Pune');

/* Find employees whose salary is between 45000 and 60000 */
SELECT *
FROM employees
WHERE salary BETWEEN 45000 AND 60000;

/*  Increase salary of HR employees by 3000 */
UPDATE employees
SET salary = salary + 3000
WHERE department = 'HR';






