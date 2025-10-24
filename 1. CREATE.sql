/*
============================================================
SQL SCRIPT: PARKS AND RECREATION DATABASE SETUP AND BASICS
This script performs the initial database and table setup
and then demonstrates fundamental SELECT statement commands.
============================================================
*/


/* ============================================================
   SETUP: USER, DATABASE, AND TABLE CREATION
   ============================================================ */

-- Create a new user (Note: This command's success depends on your MySQL environment and privileges)
CREATE USER 'shamil_suraweera'@'localhost'
IDENTIFIED WITH mysql_native_password
BY 'ShamWeer@MySQL0'
;

-- Drop the database if it exists to ensure a clean start
DROP DATABASE IF EXISTS `Parks_and_Recreation`;

-- Create the new database
CREATE DATABASE `Parks_and_Recreation`;

-- Select the newly created database for subsequent commands
USE `Parks_and_Recreation`;

-- 1. Create the employee_demographics table
CREATE TABLE employee_demographics (
  employee_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  birth_date DATE,
  PRIMARY KEY (employee_id)
);

-- 2. Create the employee_salary table
CREATE TABLE employee_salary (
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  occupation VARCHAR(50),
  salary INT,
  dept_id INT
);

-- 3. Create the parks_departments table
CREATE TABLE parks_departments (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name varchar(50) NOT NULL,
  PRIMARY KEY (department_id)
);


/* ============================================================
   DATA INSERTION: Sample Data for Demonstrations
   ============================================================ */

INSERT INTO parks_departments (department_name) VALUES
('Parks'),
('Accounting'),
('Maintenance'),
('Media');

INSERT INTO employee_demographics (employee_id, first_name, last_name, age, gender, birth_date) VALUES
(101, 'Leslie', 'Knope', 45, 'Female', '1975-01-18'),
(102, 'Ron', 'Swanson', 55, 'Male', '1960-03-06'),
(103, 'Ben', 'Wyatt', 42, 'Male', '1978-07-29'),
(104, 'Ann', 'Perkins', 40, 'Female', '1980-12-01'),
(105, 'Andy', 'Dwyer', 35, 'Male', '1985-06-25'),
(106, 'April', 'Ludgate', 33, 'Female', '1987-10-10'),
(107, 'Donna', 'Meagle', 48, 'Female', '1972-11-20'),
(108, 'Tom', 'Haverford', 41, 'Male', '1979-05-15'),
(109, 'Chris', 'Traeger', 40, 'Male', '1980-08-01');

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id) VALUES
(101, 'Leslie', 'Knope', 'Director', 80000, 1),
(102, 'Ron', 'Swanson', 'Deputy Director', 95000, 1),
(103, 'Ben', 'Wyatt', 'Accountant', 70000, 2),
(104, 'Ann', 'Perkins', 'Nurse', 60000, 3),
(105, 'Andy', 'Dwyer', 'Security Guard', 45000, 1),
(106, 'April', 'Ludgate', 'Assistant', 55000, 1),
(107, 'Donna', 'Meagle', 'Manager', 75000, 1),
(108, 'Tom', 'Haverford', 'Entrepreneur', 65000, 4),
(109, 'Chris', 'Traeger', 'City Manager', 110000, 1);


/* ============================================================
   SELECT STATEMENT BASICS
   The SELECT statement is used to specify which columns
   you want to display in your query output.
   ============================================================ */

/* 1. Select all columns */
SELECT *
FROM employee_demographics;


/* 2. Select a specific column */
SELECT first_name
FROM employee_demographics;


/* 3. Select multiple specific columns */
SELECT first_name, last_name
FROM employee_demographics;


/* 4. Column order can vary (order usually doesn't matter) */
SELECT last_name, first_name, gender, age
FROM employee_demographics;


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

-- Example 1: Simple addition, calculating a bonus
SELECT 
    first_name,
    last_name,
    salary,
    salary + 5000 AS bonus_salary -- Adds a $5000 bonus
FROM employee_salary;

-- Example 2: Salary arithmetic, calculating salary plus 100
SELECT 
    first_name, 
    last_name,
    salary,
    salary + 100 AS salary_plus_100
FROM employee_salary;

-- Example 3: Using parentheses to change order of operations
-- Calculate annual salary plus a 100 bonus, then divide by 12 for the new monthly pay (hypothetical)
SELECT 
    first_name, 
    last_name,
    salary, -- This is their annual salary
    (salary + 100) / 12 AS new_monthly_pay
FROM employee_salary;


/* ============================================================
   DISTINCT VALUES
   DISTINCT returns only unique values, removing duplicates.
   ============================================================ */

-- Without DISTINCT (duplicates may appear, showing many employees are in dept_id 1)
SELECT dept_id
FROM employee_salary;

-- With DISTINCT (unique values only - shows only 4 unique department IDs)
SELECT DISTINCT dept_id
FROM employee_salary;

-- Using DISTINCT on text columns
SELECT occupation
FROM employee_salary;

SELECT DISTINCT occupation
FROM employee_salary;


/* ============================================================
   END OF SQL BASICS DEMO
   ============================================================ */