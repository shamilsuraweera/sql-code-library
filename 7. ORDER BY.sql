/* ============================================================
   ORDER BY CLAUSE BASICS
   The ORDER BY clause is used to sort query results 
   in ascending (ASC) or descending (DESC) order.
   ------------------------------------------------------------
   - ASC (default): Sorts from smallest to largest / A → Z
   - DESC: Sorts from largest to smallest / Z → A
   ============================================================ */


/* 1. View base data (for context) */
SELECT 
    *
FROM 
    customers;


/* 2. Order by a single column (ascending by default) */
SELECT 
    *
FROM 
    customers
ORDER BY 
    first_name;
/* → Sorted A to Z (ascending order) */


/* 3. Order by a single column in descending order */
SELECT 
    *
FROM 
    employee_demographics
ORDER BY 
    first_name DESC;
/* → Sorted Z to A (descending order) */


/* 4. Order by multiple columns
   → First by gender, then by age within each gender group */
SELECT 
    *
FROM 
    employee_demographics
ORDER BY 
    gender, 
    age;
/* → Default is ascending for both columns */


/* 5. Order by multiple columns (descending) */
SELECT 
    *
FROM 
    employee_demographics
ORDER BY 
    gender DESC, 
    age DESC;
/* → Both gender and age sorted in descending order */


/* 6. Ordering by column position (not recommended)
   → Uses the numerical position of columns in the SELECT list */
SELECT 
    *
FROM 
    employee_demographics
ORDER BY 
    5 DESC, 
    4 DESC;
/* ⚠️ Best practice: use column names instead of numbers for clarity */


/* ------------------------------------------------------------
   Notes:
   - ORDER BY applies after WHERE, GROUP BY, and HAVING clauses.
   - ASC is the default order; DESC must be specified explicitly.
   - Column position ordering works, but it’s fragile — use column 
     names for maintainability.
   - ORDER BY is one of the most frequently used clauses in SQL.
   ============================================================ */
