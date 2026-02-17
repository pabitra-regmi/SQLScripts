USE Employee;


INSERT INTO employees (emp_id, name, department, salary, age, city) VALUES
(1, 'Amit', 'IT', 50000, 25, 'Delhi'),
(2, 'Rita', 'HR', 43000, 28, 'Mumbai'),
(3, 'Suman', 'IT', 60000, 30, 'Delhi'),
(4, 'John', 'Finance', 55000, 35, 'London'),
(5, 'Neha', 'HR', 48000, 26, 'Mumbai'),
(6, 'Rahul', 'IT', 70000, 32, 'Bangalore'),
(7, 'Priya', 'Finance', 48000, 29, 'Delhi'),
(8, 'Ankit', 'IT', 52000, 27, 'Pune'),
(9, 'Kiran', 'HR', 45000, 31, 'Chennai'),
(10, 'Sara', 'Marketing', 46000, 24, 'Mumbai'),
(11, 'Vikas', 'Marketing', 50000, 33, 'Delhi'),
(12, 'Pooja', 'HR', 42000, 23, 'Pune'),
(13, 'David', 'Finance', 65000, 38, 'London'),
(14, 'Nikhil', 'IT', 58000, 28, 'Bangalore'),
(15, 'Meena', 'Marketing', 47000, 26, 'Chennai');



SELECT * FROM employees;


-- Q1. Use a CTE to display all employees from the IT department
WITH all_employe AS
(
SELECT * FROM employees
WHERE department='IT'
)
SELECT * FROM all_employe;


-- Q2. Use a CTE to display employees whose salary is greater than 50,000
WITH E_with_higher_salary AS(
SELECT * FROM employees
WHERE salary>50000
)
SELECT * FROM E_with_higher_salary;


-- Q3. Use a CTE to display HR employees who are from Mumbai
WITH HR_emp_mumbai AS(
SELECT * FROM employees
WHERE department='HR' AND city='Mumbai'
)
SELECT * FROM HR_emp_mumbai;


-- Q4. Use a CTE to find the average salary of each department
WITH avg_salary AS(
SELECT department,avg(salary) AS avgSalary
FROM employees
GROUP BY department
)
SELECT * FROM avg_salary;


-- Q5. Use a CTE to display employees who earn MORE than the average salary of their department
WITH earnMoreThanDepart_avg AS (
SELECT department,avg(salary) AS avgSalary
FROM employees
GROUP BY department
)
SELECT e.emp_id,e.department,e.name,e.salary,r.avgSalary FROM employees e
JOIN earnMoreThanDepart_avg r
ON e.department=r.department
WHERE e.salary>r.avgSalary


/* Q6. Use TWO CTEs:
     One CTE for IT employees
     One CTE for HR employees
     Display both using UNION ALL*/

	 WITH cte_it AS(
	 SELECT * FROM employees
	 WHERE department='IT'
	 ),
	 cte_HR AS(
	 SELECT * FROM employees
	 WHERE department='HR'
	 )
	 SELECT * FROM cte_it 
	 UNION ALL
	 SELECT * FROM cte_HR;

	 

-- Q7. Use a CTE to increase salary by 10% for IT employees
WITH toincreaseSalary AS(
SELECT * FROM employees
WHERE department='IT'
)
UPDATE toincreaseSalary
SET salary+=salary*0.5;



-- Q8. Use a CTE to delete employees whose age is less than 25
WITH deleteusingcte AS(
SELECT * FROM employees
WHERE age<25
)
DELETE FROM deleteusingcte;
SELECT * FROM employees;


-- Q9. Use a CTE to update HR employees salary to 50,000
--      if their salary is less than 50,000
 WITH increase AS (
 SELECT * FROM employees
 WHERE department='HR' AND salary<50000
 )
 UPDATE increase
 SET salary=50000;


-- Q10. Use a CTE with ROW_NUMBER to find
--       the highest-paid employee in each department
WITH highestPaid AS (
SELECT name,salary ,ROW_NUMBER() OVER (ORDER BY salary DESC) AS salaryrow
FROM employees
)
SELECT * FROM highestPaid


-- Q11. Use a CTE with DENSE_RANK to find
--       the top 2 highest-paid employees in each department
-- Top 2 highest-paid employees per department using DENSE_RANK
WITH ranked_employees AS (
    SELECT 
        emp_id,
        name,
        department,
        salary,
        DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
    FROM employees
)
SELECT *
FROM ranked_employees
WHERE salary_rank <= 2
ORDER BY department, salary_rank;



-- Q12. Use a CTE to calculate total salary paid in each city
WITH totalsalarypaid AS(
SELECT city,SUM(salary) AS totalsalary
FROM employees
GROUP BY city
)
SELECT city,totalsalary FROM totalsalarypaid ;

-- Q13. Use a CTE to find the department with the highest
--       average salary
WITH dept_highest_salary AS(
SELECT department,avg(salary) AS avgsalary
FROM employees
GROUP BY department
)
SELECT TOP 1 department,avgsalary 
FROM dept_highest_salary
ORDER BY avgsalary DESC;


-- Q14. Use a CTE to find the oldest employee in each department
WITH oldest_emp AS (
SELECT emp_id,name,age,department,
      ROW_NUMBER() OVER (PARTITION BY department ORDER BY age DESC) AS rnk
	  FROM employees

)
SELECT emp_id,name,department,age,rnk FROM oldest_emp
WHERE rnk=1;


-- Q15. Use a CTE to increase salary by 5%
--       for employees who belong to Delhi
WITH increase_salary AS (
SELECT * FROM employees
WHERE city ='Delhi'
)
UPDATE increase_salary
SET salary+=salary*0.05


-- Q16. Use a CTE to delete employees from the Marketing department
--       whose salary is less than 48,000

WITH delete_from_emp AS (
SELECT * FROM employees
WHERE department='Marketing' AND salary<48000
)
DELETE  FROM delete_from_emp;

-- Q17. Use a CTE to display the top 3 highest-paid employees overall
WITH highest_paid_emp AS (
SELECT TOP 3 emp_id,name,salary
FROM employees
ORDER BY salary
)
SELECT * FROM highest_paid_emp;


-- Q18. Use a CTE to display employees whose age is
--       above the company average age
WITH emp_avg AS (
    SELECT 
        emp_id,
        name,
        age,
        AVG(age) OVER () AS company_avg_age
    FROM employees
)
SELECT emp_id, name, age
FROM emp_avg
WHERE age > company_avg_age;

--Or

WITH company_avg AS (
    SELECT AVG(age) AS avg_age
    FROM employees
)
SELECT e.emp_id, e.name, e.age
FROM employees e
CROSS JOIN company_avg c
WHERE e.age > c.avg_age;



-- Q19. Use a CTE to count number of employees in each department
WITH countof_emp AS (
SELECT COUNT(*) AS total_count,department 
FROM employees
GROUP BY department
)
SELECT * FROM countof_emp;

-- Q20. Use a CTE to display employees whose salary
--       is between 45,000 and 60,000
WITH emp_salary AS (
SELECT * FROM employees
WHERE salary BETWEEN 45000 AND 60000
)
SELECT * FROM emp_salary;