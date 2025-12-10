/*
============================================================
SQL SCRIPT: ILLUSTRATING STORED PROCEDURES
A Stored Procedure is a prepared SQL code that you can save, 
so the code can be reused over and over again.
------------------------------------------------------------
- Improves performance by pre-compiling the SQL.
- Enhances security by abstracting table access.
- Allows for complex, multi-statement logic.
============================================================
*/

/* ------------------------------------------------------------
   1. SIMPLE STORED PROCEDURE (Single Query)
   This structure only works for a single SELECT statement.
   ------------------------------------------------------------ */

-- Creation:
CREATE PROCEDURE large_salaries_simple()
SELECT *
FROM employee_salary
WHERE salary >= 60000;

-- Execution:
CALL large_salaries_simple();


/* ------------------------------------------------------------
   2. STORED PROCEDURE WITH MULTIPLE STATEMENTS (Best Practice)
   Uses DELIMITER to temporarily change the statement terminator 
   from ';' to '$$', allowing multiple statements inside BEGIN/END.
   ------------------------------------------------------------ */

-- First, ensure we are in the correct database and drop if exists for clean re-creation
USE `Parks_and_Recreation`;
DROP PROCEDURE IF EXISTS `large_salaries_complex`;

-- Change the delimiter to allow BEGIN/END block to be treated as one statement
DELIMITER $$
CREATE PROCEDURE large_salaries_complex()
BEGIN
    -- Query 1: Salaries >= $60,000
    SELECT '--- Salaries >= $60,000 ---' AS Report_Title;
    SELECT 
        *
    FROM employee_salary
    WHERE salary >= 60000;
    
    -- Query 2: Salaries >= $50,000
    SELECT '--- Salaries >= $50,000 ---' AS Report_Title;
    SELECT 
        *
    FROM employee_salary
    WHERE salary >= 50000;
END $$

-- Change the delimiter back to the default semicolon
DELIMITER ;

-- Execution:
CALL large_salaries_complex();


/* ------------------------------------------------------------
   3. STORED PROCEDURE WITH PARAMETERS
   Allows dynamic input from the user when calling the procedure.
   ------------------------------------------------------------ */

USE `Parks_and_Recreation`;
DROP PROCEDURE IF EXISTS `salaries_by_employee`;

DELIMITER $$
CREATE PROCEDURE salaries_by_employee(employee_id_param INT)
BEGIN
    -- Only returns the employee matching the provided parameter ID
    SELECT 
        first_name, 
        last_name, 
        salary, 
        occupation
    FROM employee_salary
    WHERE employee_id = employee_id_param;
END $$
DELIMITER ;

-- Execution Example: Finding employee ID 1 (Leslie Knope)
CALL salaries_by_employee(1);

/* ============================================================
   STORED PROCEDURE EXAMPLES COMPLETE
   ============================================================ */