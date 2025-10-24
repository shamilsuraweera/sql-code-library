/*
============================================================
SQL SCRIPT: ILLUSTRATING THE 'HAVING' CLAUSE
The HAVING clause filters groups based on an aggregate
function's result, similar to how WHERE filters rows.
============================================================
*/

-- Example 1: Filtering based on the calculated AVG(age)
-- Filters groups (genders) where the average age is greater than 40.
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

-- Example 2: Filtering using an alias for the aggregate column
-- A more readable way to apply the same filter using the column alias 'AVG_age'.
SELECT gender, AVG(age) AS AVG_age
FROM employee_demographics
GROUP BY gender
HAVING AVG_age > 40
;

/* ============================================================
   HAVING CLAUSE EXAMPLES COMPLETE
   ============================================================ */