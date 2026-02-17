
   USE Employee;
/* =========================================================
   TABLE 1: teams
   ========================================================= */

CREATE TABLE teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(50),
    location VARCHAR(50)
);

/* Insert data into teams */
INSERT INTO teams VALUES
(1, 'Development', 'Delhi'),
(2, 'HR', 'Mumbai'),
(3, 'Finance', 'London'),
(4, 'Marketing', 'Bangalore'),
(5, 'Support', 'Chennai');

/* =========================================================
   TABLE 2: staff
   ========================================================= */

CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(50),
    team_id INT,
    salary INT,
    joining_year INT
);

/* Insert at least 15 records */
INSERT INTO staff VALUES
(1, 'Amit', 1, 60000, 2021),
(2, 'Rita', 2, 45000, 2020),
(3, 'Suman', 1, 70000, 2019),
(4, 'John', 3, 80000, 2018),
(5, 'Neha', 2, 48000, 2022),
(6, 'Rahul', 1, 75000, 2020),
(7, 'Priya', 3, 65000, 2021),
(8, 'Ankit', 4, 50000, 2022),
(9, 'Kiran', 2, 43000, 2019),
(10, 'Sara', 4, 52000, 2023);


--Display all staff records
SELECT * FROM staff;

-- Display staff name and salary
SELECT staff_name,salary FROM staff; 

-- Display staff along with their team name
SELECT s.staff_name,t.team_id
FROM staff s
JOIN teams t
ON s.staff_id=t.team_id;

--Display all staff even if team does not exist
SELECT s.staff_name,t.team_name
FROM staff s
LEFT JOIN teams t
ON s.staff_id=t.team_id;

--Find staff who work in Development team
SELECT s.*
FROM staff s
JOIN teams t
ON s.staff_id=t.team_id
WHERE t.team_name='Development';


 --Find staff earning more than 60000
 SELECT * FROM staff
 WHERE salary> 60000;

  --Find staff earning more than average salary
  SELECT * FROM staff
  WHERE salary > (SELECT AVG(salary) FROM staff);

  -- Find highest salary
  SELECT  MAX(salary) AS Highest_salary FROM staff;

  --Find second highest salary
  SELECT MAX(salary) AS Second_Highest FROM staff
  WHERE salary < ( SELECT MAX(salary) FROM staff);

/* Find staff earning more than team average */
SELECT *
FROM staff s
WHERE salary > (
    SELECT AVG(salary)
    FROM staff
    WHERE team_id = s.team_id
);

/* Find staff earning less than their team average */
SELECT *
FROM staff s
WHERE salary < (
    SELECT AVG(salary)
    FROM staff
    WHERE team_id = s.team_id
);


/*  Rank staff by salary */

SELECT staff_name, salary,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM staff;


/* Dense rank staff by salary */
SELECT staff_name,salary,
          DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_dense_rank
FROM staff;

/* Assign row numbers to staff by salary */
SELECT staff_name,salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS salary_by_rowNumber
	   FROM staff;

/*  Find top 5 highest paid staff */
SELECT TOP 5 * FROM staff
ORDER BY salary DESC;


/*  Find top 2 salaries in each team */
SELECT *
FROM (
    SELECT staff_name, team_id, salary,
           DENSE_RANK() OVER (PARTITION BY team_id ORDER BY salary DESC) AS rnk
    FROM staff
) t
WHERE rnk <= 2;

/* Find lowest paid staff */
SELECT staff_name,salary FROM staff
WHERE salary= (SELECT MIN(salary) FROM staff);

/*  Find staff who joined before 2020 */
SELECT * FROM staff
WHERE joining_year < 2020;

/* Count number of staff in each team */
SELECT team_id, COUNT(*) AS total FROM staff
GROUP BY team_id;

/* Find teams having more than 2 staff */
SELECT team_id, COUNT(*) AS total 
FROM staff
GROUP BY team_id
HAVING COUNT (*) >2;

/* Find total salary paid by each team */
SELECT team_id, SUM(salary) AS total FROM staff
GROUP BY team_id;


/*  Find average salary of each team */
SELECT team_id, AVG(salary) AS average FROM staff
GROUP BY team_id;

/* Find staff belonging to teams located in Delhi */
SELECT s.* FROM staff s
JOIN teams t 
ON s.team_id=t.team_id
WHERE location='Delhi';

/* Find staff whose team exists (EXISTS) */
SELECT * FROM staff s
WHERE EXISTS (
             SELECT 1
			 FROM teams t
			 WHERE s.team_id=t.team_id
);

/* Find staff whose team does not  exists (EXISTS) */
SELECT * FROM staff s
WHERE NOT EXISTS (
             SELECT 1
			 FROM teams t
			 WHERE s.team_id=t.team_id
);

/* Categorize staff based on salary */
SELECT staff_name, salary,
       CASE
           WHEN salary >= 80000 THEN 'High'
           WHEN salary >= 55000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_category
FROM staff;