/*
============================================================
SQL SCRIPT: ILLUSTRATING THE UNION OPERATOR
The UNION operator is used to combine the result sets of two 
or more SELECT statements into a single result set (combining 
rows vertically).
------------------------------------------------------------
Rules for UNION:
1. Each SELECT statement must have the same number of columns.
2. The columns must have similar data types.
3. The columns in each SELECT statement must be in the same order.
============================================================
*/

/* ------------------------------------------------------------
   UNION vs. JOIN
   - JOINs combine columns (horizontally) based on a relationship.
   - UNION combines rows (vertically) from different SELECT statements.
   ------------------------------------------------------------ */

-- 1. Union with Non-Matching Data Types (For demonstration)
-- Note: This works because SQL attempts to cast the data, but mixing 
-- 'first_name' (text) with 'occupation' (text) and 'last_name' (text) 
-- with 'salary' (integer) is generally bad practice.
SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT occupation, salary -- Salary will be displayed as a string in the last_name column
FROM employee_salary;


-- 2. Basic UNION (Implicitly UNION DISTINCT)
-- Combines the first_name and last_name from both tables, removing duplicates.
SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary;


-- 3. Explicitly using UNION DISTINCT
-- Same result as the simple UNION above.
SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary;


-- 4. Using UNION ALL (Keeps Duplicates)
-- This includes duplicate names if the same first_name/last_name pair 
-- exists in both tables (e.g., Leslie Knope appears twice).
SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary;


/* ------------------------------------------------------------
   REAL-WORLD APPLICATION: CATEGORIZING EMPLOYEES
   Use UNION to stack multiple distinct groups into one list 
   with a clear label for each group.
   ------------------------------------------------------------ */

-- 5. Combining and Labeling Multiple Criteria
-- The third column ('Old Lady', 'Old Man', 'Highly Paid Employee') is 
-- a hard-coded string and must be present in all SELECT statements.

SELECT first_name, last_name, 'Old Lady' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'

UNION

SELECT first_name, last_name, 'Old Man' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'

UNION

SELECT first_name, last_name, 'Highly Paid Employee' AS Label
FROM employee_salary
WHERE salary >= 70000

ORDER BY 
    first_name; -- ORDER BY must be placed at the end of the final SELECT statement.

/* ============================================================
   UNION CLAUSE EXAMPLES COMPLETE
   ============================================================ */