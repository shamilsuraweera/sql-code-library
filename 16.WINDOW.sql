/*
============================================================
SQL SCRIPT: ILLUSTRATING WINDOW FUNCTIONS
Window functions perform calculations across a set of table 
rows that are somehow related to the current row. Unlike 
GROUP BY, window functions do not collapse rows into a single 
output row; each row retains its unique identity.
------------------------------------------------------------
Syntax:
AGGREGATE_FUNCTION() OVER ([PARTITION BY col] [ORDER BY col])
============================================================
*/

/* ------------------------------------------------------------
   OVER() CLAUSE: CALCULATING GLOBAL AGGREGATES
   The basic OVER() clause calculates the aggregate across 
   the entire result set (the "window").
   ------------------------------------------------------------ */

-- 1. Global Average Salary
-- Calculates the AVG(salary) across all employees and displays it 
-- on every row. This is similar to a scalar subquery but faster.
SELECT 
    dem.employee_id, 
    dem.first_name, 
    dem.gender, 
    sal.salary,
    AVG(sal.salary) OVER() AS Global_Avg_Salary
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;


/* ------------------------------------------------------------
   PARTITION BY CLAUSE: CALCULATING GROUP AGGREGATES
   Divides the result set into partitions (groups) based on 
   the specified column(s). The aggregate is calculated per partition.
   ------------------------------------------------------------ */

-- 2. Average Salary Partitioned by Gender
-- Calculates the average salary for 'Male' and 'Female' groups separately, 
-- but still shows the individual employee row.
SELECT 
    dem.employee_id, 
    dem.first_name, 
    dem.gender, 
    sal.salary,
    AVG(sal.salary) OVER(PARTITION BY dem.gender) AS Gender_Avg_Salary
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;


/* ------------------------------------------------------------
   ORDER BY CLAUSE: CREATING RUNNING/ROLLING AGGREGATES
   When ORDER BY is used *within* the OVER() clause, it specifies 
   the order of rows within the partition, enabling rolling totals.
   ------------------------------------------------------------ */

-- 3. Rolling Sum of Salary Partitioned by Gender
-- Calculates a running total of salary within each gender group, 
-- ordered by employee_id.
SELECT 
    dem.employee_id, 
    dem.first_name, 
    dem.gender, 
    sal.salary,
    SUM(sal.salary) OVER(PARTITION BY dem.gender ORDER BY dem.employee_id) AS Rolling_Gender_Salary
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;


/* ------------------------------------------------------------
   RANKING FUNCTIONS (ROW_NUMBER, RANK, DENSE_RANK)
   These functions assign a sequential rank/number to rows 
   within each partition, based on the ORDER BY clause.
   ------------------------------------------------------------ */

-- 4. Comparing Ranking Functions
SELECT 
    dem.employee_id, 
    dem.first_name, 
    dem.gender, 
    sal.salary,
    ROW_NUMBER() OVER(PARTITION BY dem.gender ORDER BY sal.salary DESC) AS Row_Num,
    RANK() OVER(PARTITION BY dem.gender ORDER BY sal.salary DESC) AS Rank_1,
    DENSE_RANK() OVER(PARTITION BY dem.gender ORDER BY sal.salary DESC) AS Dense_Rank_2
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

/* ============================================================
   WINDOW FUNCTIONS EXAMPLES COMPLETE
   ============================================================ */