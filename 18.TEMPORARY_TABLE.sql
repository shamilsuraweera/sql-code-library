/*
============================================================
SQL SCRIPT: ILLUSTRATING TEMPORARY TABLES
Temporary tables are session-specific tables that are 
automatically dropped when the client session is terminated. 
They are excellent for storing intermediate results.
------------------------------------------------------------
- Visible only to the session that created them.
- Ideal for complex queries requiring multiple calculation steps.
============================================================
*/

/* ------------------------------------------------------------
   1. CREATION METHOD 1: DEFINING SCHEMA AND INSERTING DATA
   Less common, but necessary if the structure is predefined.
   ------------------------------------------------------------ */

-- Create the temporary table with an explicit schema definition
CREATE TEMPORARY TABLE temp_table_manual
(
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    favorite_movie VARCHAR(100)
);

-- Insert data into the newly created temporary table
INSERT INTO temp_table_manual (first_name, last_name, favorite_movie)
VALUES 
    ('Alex', 'Freberg', 'Lord of the Rings: The Twin Towers'),
    ('Leslie', 'Knope', 'Sausage Party');

-- Query the temporary table within the current session
SELECT *
FROM temp_table_manual;


/* ------------------------------------------------------------
   2. CREATION METHOD 2: USING SELECT (Preferred Method)
   Quickly creates the table structure and populates it with 
   the result of a SELECT query.
   ------------------------------------------------------------ */

-- Create a temporary table containing only employees with salary > $50k
CREATE TEMPORARY TABLE salary_over_50k AS
SELECT 
    *
FROM employee_salary
WHERE salary > 50000;

-- Query the second temporary table
SELECT *
FROM salary_over_50k;


/* ------------------------------------------------------------
   3. DEMONSTRATING USE IN COMPLEX QUERIES
   Temporary tables can be joined and filtered just like a 
   permanent table, often simplifying the final logic.
   ------------------------------------------------------------ */

-- Example: Joining the temp table to demographics
SELECT 
    dem.first_name, 
    dem.age, 
    sal.salary, 
    sal.occupation
FROM employee_demographics dem
JOIN salary_over_50k sal -- Joining the temporary table
    ON dem.employee_id = sal.employee_id
ORDER BY age DESC;

/* ============================================================
   TEMPORARY TABLES EXAMPLES COMPLETE
   ============================================================ */