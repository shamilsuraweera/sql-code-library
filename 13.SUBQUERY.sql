/*
============================================================
SQL SCRIPT: ILLUSTRATING SUBQUERIES
A Subquery (or Inner Query) is a query nested inside another 
SQL query (Outer Query). They can be used in the WHERE, 
SELECT, and FROM clauses.
------------------------------------------------------------
Types:
1. Scalar Subquery (SELECT): Returns a single value.
2. Multiple Row Subquery (WHERE): Returns a list of values 
   (used with IN, ANY, ALL, EXISTS).
3. Derived Table (FROM): Returns a table that the Outer Query 
   treats as a regular table.
============================================================
*/

/* ------------------------------------------------------------
   SUBQUERIES IN THE WHERE CLAUSE (Multiple Row Subquery)
   Used for filtering data based on a list of values returned 
   by the inner query.
   ------------------------------------------------------------ */

-- 1. Finding employees in the 'Parks and Rec' department (dept_id = 1)
-- The subquery returns a list of employee_ids, and the outer query 
-- selects demographics rows where the employee_id is IN that list.
SELECT 
    *
FROM 
    employee_demographics
WHERE 
    employee_id IN (
        SELECT 
            employee_id
        FROM 
            employee_salary
        WHERE 
            dept_id = 1
    );

-- 2. ⚠️ ERROR Demonstration: Selecting more than one column in the subquery
-- This causes an error if the outer query is only expecting one column list (like with IN).
/*
SELECT *
FROM employee_demographics
WHERE employee_id IN (
    SELECT employee_id, salary -- Error: Subquery returns multiple columns
    FROM employee_salary
    WHERE dept_id = 1
);
*/


/* ------------------------------------------------------------
   SUBQUERIES IN THE SELECT CLAUSE (Scalar Subquery)
   Used to return a single, calculated value (scalar) to be 
   displayed alongside each row of the outer query.
   ------------------------------------------------------------ */

-- 3. Comparing individual salaries to the overall average salary
-- The subquery calculates the single average salary across the entire table.
SELECT 
    first_name, 
    salary, 
    (SELECT AVG(salary) FROM employee_salary) AS Overall_Average_Salary
FROM 
    employee_salary;

-- Note: Without the subquery, using AVG(salary) in the SELECT list would 
-- typically require a GROUP BY and would calculate the average *per group*.


/* ------------------------------------------------------------
   SUBQUERIES IN THE FROM CLAUSE (Derived Table)
   Used to create a temporary, named table (must use an alias) 
   that the outer query can then treat as a regular table.
   ------------------------------------------------------------ */

-- 4. Creating an aggregated table and querying its results
-- Inner Query: Calculates aggregate stats (MIN, MAX, AVG) per gender.
-- Outer Query: Queries the results of that aggregated table.
SELECT 
    Agg_Table.gender, 
    Agg_Table.Min_age, 
    Agg_Table.Avg_age
FROM 
    (
        SELECT 
            gender, 
            MIN(age) AS Min_age, 
            MAX(age) AS Max_age, 
            COUNT(age) AS Count_age,
            AVG(age) AS Avg_age
        FROM 
            employee_demographics
        GROUP BY 
            gender
    ) AS Agg_Table -- REQUIRED: The derived table MUST be aliased (e.g., Agg_Table)
WHERE
    Agg_Table.Avg_age > 40 -- Example of filtering on the calculated average
;

/* ============================================================
   SUBQUERIES EXAMPLES COMPLETE
   ============================================================ */