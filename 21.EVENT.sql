/*
============================================================
SQL SCRIPT: ILLUSTRATING EVENTS (SCHEDULED JOBS)
An Event is a named database object that contains one or 
more SQL statements and is executed according to a schedule.
Events are crucial for automated tasks and maintenance.
------------------------------------------------------------
- Requires the MySQL Event Scheduler to be enabled (often done 
  via SET GLOBAL event_scheduler = ON;).
- Uses DELIMITER, BEGIN, and END, similar to Stored Procedures.
============================================================
*/

/* ------------------------------------------------------------
   1. CHECKING EVENT STATUS
   Verifies the status of the Event Scheduler and lists existing events.
   ------------------------------------------------------------ */

-- Check if the scheduler is running
-- SHOW VARIABLES LIKE 'event_scheduler';

-- List all currently defined events
SHOW EVENTS;


/* ------------------------------------------------------------
   2. CREATING A SCHEDULED EVENT (The 'Mandatory Retirement' Job)
   This event automatically deletes employees who are 60 or older 
   from the demographics table, executing every 30 seconds for testing.
   ------------------------------------------------------------ */

USE Parks_and_Recreation;
-- Drop the event if it already exists to allow re-creation
DROP EVENT IF EXISTS delete_retirees;

-- Temporarily change the delimiter
DELIMITER $$
CREATE EVENT delete_retirees
    -- Specifies the schedule: EVERY 30 SECOND, or use AT TIMESTAMP, EVERY 1 WEEK, etc.
    ON SCHEDULE EVERY 30 SECOND
    -- Defines the SQL code block to execute
    DO BEGIN
        -- Action: Delete records where the age is 60 or older
        DELETE
        FROM parks_and_recreation.employee_demographics
        WHERE age >= 60;
    END $$

-- Reset the delimiter back to the default semicolon
DELIMITER ;


/* ------------------------------------------------------------
   3. VERIFYING THE EVENT (After creation and waiting for execution)
   The DELETE statement inside the event will eventually fire 
   and remove Jerry Gergich (age 61) from the table.
   ------------------------------------------------------------ */

-- Check the contents of the demographics table (Jerry should be gone after the event runs)
SELECT *
FROM Parks_and_Recreation.employee_demographics;


/* ------------------------------------------------------------
   4. ALTERING OR DROPPING THE EVENT
   To stop the scheduled task, the event can be dropped or disabled.
   ------------------------------------------------------------ */

-- Disable the event (it remains defined but won't execute)
-- ALTER EVENT delete_retirees DISABLE;

-- Drop the event completely (recommended after testing)
-- DROP EVENT IF EXISTS delete_retirees;

/* ============================================================
   EVENTS EXAMPLES COMPLETE
   ============================================================ */