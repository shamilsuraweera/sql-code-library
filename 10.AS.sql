/*
============================================================
SQL SCRIPT: ILLUSTRATING ALIASING (AS)
Aliasing is used to assign a temporary name (alias) to a 
column or table within a specific SQL query. This improves 
readability and is necessary for derived/calculated columns.
------------------------------------------------------------
- AS keyword is optional in MySQL but recommended for clarity.
- Aliases are temporary and only exist for the duration of the query.
============================================================
*/

/* ------------------------------------------------------------
   1. ALIASING AGGREGATE COLUMNS (Using AS keyword)
   This is the primary reason to use an alias: giving a 
   descriptive name to a calculated field.
   ------------------------------------------------------------ */

-- The AS keyword explicitly assigns 'Avg_age' as the new column header.
SELECT 
    gender, 
    AVG(age) AS Avg_age
FROM employee_demographics
GROUP BY gender
;


/* ------------------------------------------------------------
   2. ALIASING AGGREGATE COLUMNS (Omitting AS keyword)
   The AS keyword can be omitted in most SQL dialects.
   ------------------------------------------------------------ */

-- Omitting AS yields the same result, but is less explicit.
SELECT 
    gender, 
    AVG(age) Avg_age_Implicit
FROM employee_demographics
GROUP BY gender
;


/* ------------------------------------------------------------
   3. ALIASING REGULAR COLUMNS (For clarity or special characters)
   Aliases can be applied to any selected column. If the alias 
   contains spaces or special characters, it MUST be enclosed 
   in quotes (single, double, or backticks depending on the database).
   ------------------------------------------------------------ */

-- Aliasing a standard column for better report labeling
SELECT 
    first_name AS Employee_First_Name,
    birth_date
FROM employee_demographics;

-- Aliasing a column with a space (requires quotes/backticks)
SELECT 
    first_name AS `First Name with Space`
FROM employee_demographics;


/* ------------------------------------------------------------
   4. ALIASING TABLES (Used heavily in JOINS and Subqueries)
   Table aliases are typically short identifiers (e.g., 'dem', 'sal').
   This is required for SELF JOINs and helpful for multi-table queries.
   ------------------------------------------------------------ */

-- We are using 'dem' and 'sal' as aliases for the respective tables.
SELECT 
    dem.first_name, 
    sal.salary
FROM employee_demographics dem -- Table alias 'dem'
JOIN employee_salary sal        -- Table alias 'sal'
    ON dem.employee_id = sal.employee_id;


/* ============================================================
   ALIASING EXAMPLES COMPLETE
   ============================================================ */