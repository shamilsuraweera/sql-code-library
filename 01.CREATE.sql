/*
============================================================
SQL SCRIPT: USER, DATABASE, AND TABLE CREATION
This script sets up the necessary user, drops and recreates
the Parks_and_Recreation database, and creates the three
required tables.
============================================================
*/

-- Step 1: Create a MySQL User
-- NOTE: This command's success depends on your MySQL environment and privileges.
CREATE USER 'shamil_suraweera'@'localhost'
BY 'ShamWeer@MySQL0'
;

-- Step 2: Database Management
-- Drops the database if it exists to ensure a clean slate
DROP DATABASE IF EXISTS `Parks_and_Recreation`;

-- Creates the new database
CREATE DATABASE `Parks_and_Recreation`;

-- Selects the database to be used for subsequent table creation
USE `Parks_and_Recreation`;

-- Step 3: Create the employee_demographics table
CREATE TABLE employee_demographics (
  employee_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  birth_date DATE,
  PRIMARY KEY (employee_id)
);

-- Step 4: Create the employee_salary table
CREATE TABLE employee_salary (
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  occupation VARCHAR(50),
  salary INT,
  dept_id INT
);

-- Step 5: Create the parks_departments table
CREATE TABLE parks_departments (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name varchar(50) NOT NULL,
  PRIMARY KEY (department_id)
);

/* ============================================================
   SETUP COMPLETE
   ============================================================ */