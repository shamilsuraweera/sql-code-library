/*
============================================================
SQL SCRIPT: ILLUSTRATING COMMON TABLE EXPRESSIONS (CTE)
A CTE (Common Table Expression) is a temporary, named result 
set that is defined within the execution scope of a single 
SELECT, INSERT, UPDATE, or DELETE statement.
------------------------------------------------------------
- Starts with the WITH keyword.
- Improves readability and simplifies complex subqueries.
- Can be referenced multiple times within the final query.
============================================================
*/

/* ------------------------------------------------------------
   1. BASIC CTE STRUCTURE AND USAGE
   A CTE is defined, and immediately referenced by the final 
   SELECT statement.
   ------------------------------------------------------------ */

-- Example: Calculating aggregate salary data
WITH Aggregate_Salary_CTE AS 
(
    SELECT 
        gender, 
        SUM(salary) AS total_salary, 
        MIN(salary) AS min_salary, 
        MAX(salary) AS max_salary, 
        COUNT(salary) AS employee_count, 
        AVG(salary) AS avg_salary
    FROM employee_demographics dem
    JOIN employee_salary sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
-- The main query immediately follows the CTE definition.
SELECT *
FROM Aggregate_Salary_CTE;


/* ------------------------------------------------------------
   2. CTE SCOPE AND REFERENCING COLUMN NAMES
   A CTE only exists for the duration of the query that defines it.
   Note the issue with referencing un-aliased aggregate functions.
   ------------------------------------------------------------ */

-- The final query cannot reference the CTE outside of the WITH block.
/*
SELECT *
FROM Aggregate_Salary_CTE; -- This query would fail if run independently.
*/

-- Example: Using backticks to reference aggregate columns (MySQL specific workaround)
WITH CTE_Raw_Agg AS 
(
    SELECT 
        gender, 
        SUM(salary), 
        COUNT(salary)
    FROM employee_demographics dem
    JOIN employee_salary sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
-- Using backticks (`) to quote the un-aliased aggregate column names.
SELECT 
    gender, 
    ROUND(AVG(`SUM(salary)`/`COUNT(salary)`), 2) AS Calculated_Avg
FROM CTE_Raw_Agg
GROUP BY gender;


/* ------------------------------------------------------------
   3. RENAMING COLUMNS IN THE CTE DEFINITION (Best Practice)
   Allows for clean column references without using backticks.
   ------------------------------------------------------------ */

-- The column names are explicitly listed after the CTE name.
WITH CTE_Clean_Agg (gender, sum_salary, min_salary, max_salary, count_salary) AS 
(
    SELECT 
        gender, 
        SUM(salary), 
        MIN(salary), 
        MAX(salary), 
        COUNT(salary)
    FROM employee_demographics dem
    JOIN employee_salary sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
-- Now the renamed columns can be referenced cleanly.
SELECT 
    gender, 
    ROUND(AVG(sum_salary/count_salary), 2) AS Recalculated_Avg
FROM CTE_Clean_Agg
GROUP BY gender;


/* ------------------------------------------------------------
   4. DEFINING AND JOINING MULTIPLE CTEs
   Multiple CTEs are separated by a comma (,) within the single 
   WITH block.
   ------------------------------------------------------------ */

WITH Recent_Demographics_CTE AS 
(
    -- CTE 1: Filters demographics for employees born after 1985
    SELECT 
        employee_id, 
        gender, 
        birth_date
    FROM employee_demographics
    WHERE birth_date > '1985-01-01'
), 
High_Salary_CTE AS 
(
    -- CTE 2: Filters salary for employees making $50,000 or more
    SELECT 
        employee_id, 
        salary
    FROM employee_salary
    WHERE salary >= 50000
)
-- Main Query: Joins the two CTEs to find recent, highly-paid employees.
SELECT 
    cte1.employee_id, 
    cte1.birth_date, 
    cte2.salary
FROM Recent_Demographics_CTE cte1 -- Aliased as cte1
LEFT JOIN High_Salary_CTE cte2    -- Aliased as cte2
    ON cte1.employee_id = cte2.employee_id;


/* ============================================================
   COMMON TABLE EXPRESSIONS EXAMPLES COMPLETE
   ============================================================ */