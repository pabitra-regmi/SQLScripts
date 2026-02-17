/* =========================================================
   MID-LEVEL SQL
   TABLES USED: staff, teams
   ========================================================= */
USE Employee;
/*  Display all staff records */
SELECT * FROM staff;

/* Display staff name and salary */
SELECT staff_name, salary
FROM staff;

/* Display staff along with their team name */
SELECT s.staff_name, t.team_name
FROM staff s
JOIN teams t ON s.team_id = t.team_id;

/* Display all staff even if team does not exist */
SELECT s.staff_name, t.team_name
FROM staff s
LEFT JOIN teams t ON s.team_id = t.team_id;

/* Find staff who work in Development team */
SELECT s.*
FROM staff s
JOIN teams t ON s.team_id = t.team_id
WHERE t.team_name = 'Development';

/* Find staff earning more than 60000 */
SELECT *
FROM staff
WHERE salary > 60000;

/* Find staff earning more than average salary */
SELECT *
FROM staff
WHERE salary > (SELECT AVG(salary) FROM staff);

/*  Find highest salary */
SELECT MAX(salary) AS highest_salary
FROM staff;

/* Find second highest salary */
SELECT MAX(salary) AS second_highest_salary
FROM staff
WHERE salary < (SELECT MAX(salary) FROM staff);

/*  Find staff earning more than team average */
SELECT *
FROM staff s
WHERE salary > (
    SELECT AVG(salary)
    FROM staff
    WHERE team_id = s.team_id
);

/*  Rank staff by salary */
SELECT staff_name, salary,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM staff;

/* Dense rank staff by salary */
SELECT staff_name, salary,
       DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_salary_rank
FROM staff;

/* Assign row numbers to staff by salary */
SELECT staff_name, salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM staff;

/* Find top 3 highest paid staff */
SELECT TOP 3 *
FROM staff
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
SELECT *
FROM staff
WHERE salary = (SELECT MIN(salary) FROM staff);

/*  Find staff who joined before 2020 */
SELECT *
FROM staff
WHERE joining_year < 2020;

/* Count number of staff in each team */
SELECT team_id, COUNT(*) AS staff_count
FROM staff
GROUP BY team_id;

/*  Find teams having more than 3 staff */
SELECT team_id, COUNT(*) AS staff_count
FROM staff
GROUP BY team_id
HAVING COUNT(*) > 3;

/*  Find total salary paid by each team */
SELECT team_id, SUM(salary) AS total_salary
FROM staff
GROUP BY team_id;

/*  find average salary of each team */
SELECT team_id, AVG(salary) AS avg_salary
FROM staff
GROUP BY team_id;

/* Find staff belonging to teams located in Delhi */
SELECT s.*
FROM staff s
JOIN teams t ON s.team_id = t.team_id
WHERE t.location = 'Delhi';

/*  Find staff whose team exists (EXISTS) */
SELECT *
FROM staff s
WHERE EXISTS (
    SELECT 1
    FROM teams t
    WHERE t.team_id = s.team_id
);

/*  Find staff whose team does not exist */
SELECT *
FROM staff s
WHERE NOT EXISTS (
    SELECT 1
    FROM teams t
    WHERE t.team_id = s.team_id
);

/*   Categorize staff based on salary */
SELECT staff_name, salary,
       CASE
           WHEN salary >= 80000 THEN 'High'
           WHEN salary >= 55000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_category
FROM staff;

/*  Use CTE to find staff earning above 70000 */
WITH HighEarners AS (
    SELECT *
    FROM staff
    WHERE salary > 70000
)
SELECT * FROM HighEarners;

/*  Find staff with same salary (duplicates) */
SELECT salary, COUNT(*) AS count_salary
FROM staff
GROUP BY salary
HAVING COUNT(*) > 1;

/*  Find staff who earn the same salary as someone else */
SELECT *
FROM staff
WHERE salary IN (
    SELECT salary
    FROM staff
    GROUP BY salary
    HAVING COUNT(*) > 1
);

/*   Find staff who joined most recently */
SELECT *
FROM staff
WHERE joining_year = (SELECT MAX(joining_year) FROM staff);

/*   Find staff who joined earliest */
SELECT *
FROM staff
WHERE joining_year = (SELECT MIN(joining_year) FROM staff);

/*   Find highest paid staff in each team */
SELECT *
FROM (
    SELECT staff_name, team_id, salary,
           ROW_NUMBER() OVER (PARTITION BY team_id ORDER BY salary DESC) AS rn
    FROM staff
) x
WHERE rn = 1;

/*  Find lowest paid staff in each team */
SELECT *
FROM (
    SELECT staff_name, team_id, salary,
           ROW_NUMBER() OVER (PARTITION BY team_id ORDER BY salary ASC) AS rn
    FROM staff
) x
WHERE rn = 1;

/*  Find staff earning between 50000 and 70000 */
SELECT *
FROM staff
WHERE salary BETWEEN 50000 AND 70000;

/*  Find staff whose name starts with 'A' */
SELECT *
FROM staff
WHERE staff_name LIKE 'A%';

/*  Find staff whose name contains 'i' */
SELECT *
FROM staff
WHERE staff_name LIKE '%i%';

/* Find teams with no staff */
SELECT t.*
FROM teams t
LEFT JOIN staff s ON t.team_id = s.team_id
WHERE s.staff_id IS NULL;

/* Count staff per location */
SELECT t.location, COUNT(s.staff_id) AS staff_count
FROM teams t
LEFT JOIN staff s ON t.team_id = s.team_id
GROUP BY t.location;

/*  Find team with highest total salary */
SELECT TOP 1 team_id, SUM(salary) AS total_salary
FROM staff
GROUP BY team_id
ORDER BY total_salary DESC;

/*   Find staff earning more than their team’s minimum salary */
SELECT *
FROM staff s
WHERE salary > (
    SELECT MIN(salary)
    FROM staff
    WHERE team_id = s.team_id
);

/*  Find percentage contribution of each staff salary to team total */
SELECT staff_name, team_id, salary,
         salary * 100 / SUM(salary) OVER (PARTITION BY team_id) AS salary_percentage
FROM staff;
