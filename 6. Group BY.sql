/* ============================================================
   GROUP BY CLAUSE BASICS
   The GROUP BY clause groups rows that have the same values 
   in one or more columns. It is typically used with aggregate 
   functions (e.g., COUNT, SUM, AVG, MIN, MAX).
   ============================================================ */


/* 1. View the base data (for context) */
SELECT 
    *
FROM 
    employee_demographics;


/* 2. Group rows by gender
   → All rows with the same gender are grouped together */
SELECT 
    gender
FROM 
    employee_demographics
GROUP BY 
    gender;


/* ⚠️ Incorrect Example (for demonstration):
   You cannot SELECT a column that is not part of the GROUP BY 
   or an aggregate function. */
-- This will cause an error in most databases:
SELECT 
    first_name
FROM 
    employee_demographics
GROUP BY 
    gender;


/* 3. Group by a single column (occupation) */
SELECT 
    occupation
FROM 
    employee_salary
GROUP BY 
    occupation;
/* → Each unique occupation appears once in the result set */


/* 4. Group by multiple columns (occupation + salary)
   → Each unique combination of occupation and salary forms its own group */
SELECT 
    occupation, 
    salary
FROM 
    employee_salary
GROUP BY 
    occupation, 
    salary;


/* 5. Use aggregate functions with GROUP BY
   → This is the most common use case */
SELECT 
    gender, 
    AVG(age) AS average_age
FROM 
    employee_demographics
GROUP BY 
    gender;


/* 6. Multiple aggregate functions in the same query */
SELECT 
    gender, 
    MIN(age) AS youngest, 
    MAX(age) AS oldest, 
    COUNT(age) AS total_records, 
    AVG(age) AS average_age
FROM 
    employee_demographics
GROUP BY 
    gender;


/* ------------------------------------------------------------
   Notes:
   - GROUP BY columns must appear in the SELECT clause unless 
     wrapped in an aggregate function.
   - Aggregate functions summarize data for each group.
   - Common aggregate functions:
       COUNT() → Number of rows
       SUM()   → Total value
       AVG()   → Average value
       MIN()   → Minimum value
       MAX()   → Maximum value
   ============================================================ */
