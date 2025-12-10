/*
============================================================
SQL SCRIPT: ILLUSTRATING TRIGGERS
A Trigger is a special type of stored procedure that executes 
automatically when a specific database event (INSERT, UPDATE, 
DELETE) occurs on a specific table.
------------------------------------------------------------
- Uses NEW (for INSERT/UPDATE) or OLD (for DELETE/UPDATE) to 
  reference the row data involved in the operation.
- Requires DELIMITER for multi-statement logic (BEGIN/END).
============================================================
*/

/* ------------------------------------------------------------
   1. CREATE THE TRIGGER (Best Practice with Delimiter)
   This trigger automatically adds an employee's basic details 
   to the 'employee_demographics' table AFTER they are inserted 
   into the 'employee_salary' table.
   ------------------------------------------------------------ */

USE Parks_and_Recreation;
DROP TRIGGER IF EXISTS `employee_insert_log`; -- Clean up if the trigger exists

DELIMITER $$
CREATE TRIGGER employee_insert_log
    -- The trigger executes AFTER an INSERT operation on the employee_salary table.
    AFTER INSERT ON employee_salary
    -- MySQL executes this block FOR EACH ROW inserted (row-level trigger).
    FOR EACH ROW
BEGIN
    -- Action: Insert data into employee_demographics using values from the NEWly inserted row.
    -- NEW.column_name accesses the data just inserted into employee_salary.
    INSERT INTO employee_demographics (employee_id, first_name, last_name) 
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$

-- Reset the delimiter back to the default semicolon
DELIMITER ;


/* ------------------------------------------------------------
   2. TESTING THE TRIGGER (INSERT)
   Inserting a new row into employee_salary should automatically 
   create a corresponding row in employee_demographics.
   ------------------------------------------------------------ */

-- Check current state of demographics (before insert)
SELECT '--- employee_demographics BEFORE INSERT ---';
SELECT * FROM employee_demographics ORDER BY employee_id DESC LIMIT 1;


-- Insert the new employee into employee_salary
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, NULL);


-- Check state of both tables (after insert)
SELECT '--- employee_salary AFTER INSERT ---';
SELECT * FROM employee_salary WHERE employee_id = 13;

SELECT '--- employee_demographics AFTER TRIGGER EXECUTION ---';
SELECT * FROM employee_demographics WHERE employee_id = 13; -- Should now contain Jean-Ralphio


/* ------------------------------------------------------------
   3. CLEANUP (DELETE)
   Removing the test row. The trigger does not handle DELETE.
   ------------------------------------------------------------ */

-- Delete the inserted record from both tables for a clean state
DELETE FROM employee_salary
WHERE employee_id = 13;

DELETE FROM employee_demographics
WHERE employee_id = 13;

/* ============================================================
   TRIGGER EXAMPLES COMPLETE
   ============================================================ */