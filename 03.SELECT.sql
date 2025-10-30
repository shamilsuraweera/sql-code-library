/* ============================================================
   SELECT STATEMENT BASICS
   The SELECT statement is used to specify which columns
   you want to display in your query output.
   ============================================================ */

/* 1. Select all columns */
SELECT *
FROM Parks_and_Recreation.employee_demographics;


/* 2. Select a specific column */
SELECT first_name
FROM Parks_and_Recreation.employee_demographics;


/* 3. Select multiple specific columns */
SELECT first_name, last_name
FROM Parks_and_Recreation.employee_demographics;


/* 4. Column order can vary (order usually doesn't matter) */
SELECT last_name, first_name, gender, age
FROM Parks_and_Recreation.employee_demographics;


/* 5. Multi-line formatting for readability */
SELECT 
    last_name, 
    first_name, 
    gender, 
    age
FROM employee_demographics;


/* ============================================================
   USING EXPRESSIONS IN SELECT
   You can perform arithmetic operations directly in SELECT.
   SQL follows PEMDAS (Parentheses, Exponents, Multiplication,
   Division, Addition, Subtraction) for order of operations.
   ============================================================ */

-- Example 1: Simple addition
SELECT 
    first_name,
    last_name,
    total_money_spent,
    total_money_spent + 100 AS adjusted_spent
FROM customers;

-- Example 2: Salary arithmetic
SELECT 
    first_name, 
    last_name,
    salary,
    salary + 100 AS salary_plus_100
FROM employee_salary;

-- Example 3: Using parentheses to change order of operations
SELECT 
    first_name, 
    last_name,
    salary,
    (salary + 100) * 10 AS adjusted_salary
FROM employee_salary;


/* ============================================================
   DISTINCT VALUES
   DISTINCT returns only unique values, removing duplicates.
   ============================================================ */

-- Without DISTINCT (duplicates may appear)
SELECT department_id
FROM employee_salary;

-- With DISTINCT (unique values only)
SELECT DISTINCT department_id
FROM employee_salary;


/* ============================================================
   END OF SELECT STATEMENT DEMO
   ============================================================ */