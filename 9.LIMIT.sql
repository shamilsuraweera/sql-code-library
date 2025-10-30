/*
============================================================
SQL SCRIPT: ILLUSTRATING THE LIMIT CLAUSE
The LIMIT clause restricts the number of rows returned by 
a SELECT query. It is essential for pagination and for 
retrieving a specific number of top records.
------------------------------------------------------------
Syntax 1 (Count): LIMIT N
Syntax 2 (Offset & Count): LIMIT offset, N
============================================================
*/

/* ------------------------------------------------------------
   1. BASIC LIMIT (LIMIT N)
   Returns the first N rows encountered in the table.
   ------------------------------------------------------------ */

-- Returns only the first 3 rows from the table in their default order.
SELECT 
    *
FROM employee_demographics
LIMIT 3;


/* ------------------------------------------------------------
   2. LIMIT WITH ORDER BY
   Ensures the result set is sorted *before* the limit is applied, 
   guaranteeing a specific, meaningful set of N rows (e.g., the oldest).
   ------------------------------------------------------------ */

-- Returns the 3 employees whose names come first alphabetically.
SELECT 
    *
FROM employee_demographics
ORDER BY first_name ASC
LIMIT 3;

-- Returns the 3 oldest employees.
SELECT 
    *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3;


/* ------------------------------------------------------------
   3. LIMIT WITH OFFSET (LIMIT offset, N)
   Specifies a starting point (offset) and then how many rows 
   (N) to retrieve from that starting point.
   Note: The offset starts counting from 0 (i.e., offset 3 means 
   start at the 4th row).
   ------------------------------------------------------------ */

-- Start at position 3 (the 4th row) and take 2 rows after that.
SELECT 
    *
FROM employee_demographics
ORDER BY first_name ASC
LIMIT 3, 2;


/* ------------------------------------------------------------
   4. LIMIT FOR SELECTING A SPECIFIC Nth RECORD
   Combined with ORDER BY, this is used to pull the 3rd, 5th, 
   or Nth ranked item.
   ------------------------------------------------------------ */

-- Goal: Find the 3rd oldest person.
-- Order by age descending, skip the first 2 (0 and 1), and return 1 row.
SELECT 
    *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1;

/* ============================================================
   LIMIT CLAUSE EXAMPLES COMPLETE
   ============================================================ */