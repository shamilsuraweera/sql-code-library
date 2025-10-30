/*
============================================================
SQL SCRIPT: ILLUSTRATING VARIOUS JOIN TYPES
JOINs combine columns from two or more tables based on a 
common column/value relationship.
------------------------------------------------------------
Tables used: employee_demographics, employee_salary, parks_departments
Common Column: employee_id, dept_id
============================================================
*/

/* ------------------------------------------------------------
   INNER JOIN
   Returns only the rows that have matching values in both tables.
   ------------------------------------------------------------ */

-- 1. Inner Join with Full Select
-- Combines demographics and salary info only where employee_id exists in BOTH tables.
-- Note: Ron Swanson (employee_id 2) is missing if his ID is not in employee_demographics.
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;


-- 2. Inner Join with Column Selection and Alias
SELECT 
    dem.first_name, 
    dem.last_name, 
    dem.age, 
    sal.occupation, 
    sal.salary
FROM employee_demographics dem
JOIN employee_salary sal -- INNER is optional here, JOIN defaults to INNER JOIN
    ON dem.employee_id = sal.employee_id;


/* ------------------------------------------------------------
   OUTER JOIN (LEFT & RIGHT)
   Returns matching rows PLUS non-matching rows from one table.
   ------------------------------------------------------------ */

-- 3. LEFT JOIN (Preserves all rows from the LEFT table: employee_salary)
-- Shows all employees in employee_salary, even if they lack demographics data.
SELECT 
    sal.employee_id, 
    sal.first_name, 
    dem.age, 
    sal.salary
FROM employee_salary sal
LEFT JOIN employee_demographics dem -- Left Table (all rows returned)
    ON sal.employee_id = dem.employee_id;
-- Note: Ron Swanson's demographics columns (age, gender) will show NULLs.


-- 4. RIGHT JOIN (Preserves all rows from the RIGHT table: employee_demographics)
-- Shows all employees in employee_demographics, even if they lack salary data.
SELECT 
    dem.employee_id, 
    dem.first_name, 
    sal.salary
FROM employee_salary sal 
RIGHT JOIN employee_demographics dem -- Right Table (all rows returned)
    ON sal.employee_id = dem.employee_id;
-- If all employees have both records (like in your data), this can look like an INNER JOIN.


/* ------------------------------------------------------------
   SELF JOIN
   Joins a table to itself. Requires table aliases.
   Used for comparing values within the same table (e.g., Secret Santa).
   ------------------------------------------------------------ */

-- 5. Self Join for "Secret Santa" Scenario
-- Links employee (emp1) to their Secret Santa recipient (emp2) using ID + 1.
SELECT 
    emp1.employee_id AS santa_id,
    emp1.first_name AS santa_first_name, 
    emp2.first_name AS recipient_first_name
FROM employee_salary emp1
JOIN employee_salary emp2
    ON emp1.employee_id + 1 = emp2.employee_id
;
-- Note: The highest ID employee (Mark Brendanawicz, ID 11) is not included 
-- as a SANTA because ID 12 is the highest RECIPIENT.

/* ------------------------------------------------------------
   JOINING MULTIPLE TABLES
   Multiple JOINs can be chained together.
   ------------------------------------------------------------ */

-- 6. Joining Three Tables (Inner Join)
-- Connects demographics to salary, and salary to department names.
-- Only returns employees who have a match in ALL THREE tables (e.g., excludes Andy).
SELECT 
    dem.first_name, 
    sal.occupation, 
    dept.department_name
FROM employee_demographics dem
INNER JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments dept -- Joining the third table
    ON sal.dept_id = dept.department_id;


-- 7. Joining Three Tables (Left Join for inclusiveness)
-- Ensures all records from the LEFT-most table (employee_demographics/employee_salary combo) 
-- are kept, even if the third table (parks_departments) has no match.
SELECT 
    dem.first_name, 
    sal.occupation, 
    dept.department_name
FROM employee_demographics dem
INNER JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
LEFT JOIN parks_departments dept -- LEFT JOIN ensures Andy's record is kept (department_name = NULL)
    ON sal.dept_id = dept.department_id;

/* ============================================================
   JOIN CLAUSE EXAMPLES COMPLETE
   ============================================================ */