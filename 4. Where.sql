/* ============================================================
   WHERE CLAUSE BASICS
   The WHERE clause filters records (rows) based on conditions.
   It determines which rows are returned in the result set.
   ------------------------------------------------------------
   Example: WHERE name = 'Alex' 
   → Returns only rows where the "name" column equals 'Alex'
   ============================================================ */


/* 1. Filter rows based on numeric condition */
SELECT 
    *
FROM 
    employee_salary
WHERE 
    salary > 50000;


/* 2. Using greater than or equal to (>=) */
SELECT 
    *
FROM 
    employee_salary
WHERE 
    salary >= 50000;


/* 3. Filter rows by string condition */
SELECT 
    *
FROM 
    employee_demographics
WHERE 
    gender = 'Female';


/* 4. Exclude specific values (NOT EQUALS) */
SELECT 
    *
FROM 
    employee_demographics
WHERE 
    gender != 'Female';


/* 5. Filter rows using date conditions */
SELECT 
    *
FROM 
    employee_demographics
WHERE 
    birth_date > '1985-01-01';


/* ------------------------------------------------------------
   Note:
   - 'YYYY-MM-DD' is the default date format in MySQL.
   - Other date formats are supported and will be covered later.
   ============================================================ */
