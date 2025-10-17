/* ============================================================
   LIKE STATEMENT BASICS
   The LIKE operator is used for pattern matching in string data.
   It works with two special wildcard characters:
     - % : Represents zero or more characters
     - _ : Represents exactly one character
   ============================================================ */


/* 1. Match values starting with 'a'
   → The % wildcard means “any sequence of characters” */
SELECT 
    *
FROM 
    employee_demographics
WHERE 
    first_name LIKE 'a%';


/* 2. Match values starting with 'a' followed by exactly two characters
   → Each underscore (_) matches exactly one character */
SELECT 
    *
FROM 
    employee_demographics
WHERE 
    first_name LIKE 'a__';


/* 3. Match values starting with 'a', 
      followed by at least three characters,
      and possibly more afterward */
SELECT 
    *
FROM 
    employee_demographics
WHERE 
    first_name LIKE 'a___%';


/* ------------------------------------------------------------
   Notes:
   - The LIKE operator is case-insensitive in MySQL by default,
     but case-sensitive in some databases (e.g., PostgreSQL).
   - To perform case-sensitive matching in MySQL, 
     use the BINARY keyword: 
       WHERE BINARY first_name LIKE 'A%';
   ============================================================ */
