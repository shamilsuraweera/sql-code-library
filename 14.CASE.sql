/*
============================================================
SQL SCRIPT: ILLUSTRATING THE CASE STATEMENT
A CASE statement adds IF/ELSE logic directly into a SELECT 
statement. It evaluates a set of conditions and returns a 
value for the first condition that is true.
------------------------------------------------------------
Syntax:
CASE 
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE result3 -- Optional: Default if no condition is met
END AS column_name
============================================================
*/

/* ------------------------------------------------------------
   CASE FOR CONDITIONAL LABELING
   Assigns a descriptive label based on the value in the age column.
   ------------------------------------------------------------ */

-- 1. Simple CASE statement (Young/Old/On Death's Door)
-- Note: Jerry Gergich (age 61) falls into the third category.
SELECT 
    first_name, 
    last_name, 
    age,
    CASE
        WHEN age <= 30 THEN 'Young'
        WHEN age BETWEEN 31 AND 50 THEN 'Middle Aged'
        WHEN age > 50 THEN 'On Death''s Door' -- Use double single-quote '' for an apostrophe inside single quotes
        ELSE 'Unknown'
    END AS Age_Group
FROM employee_demographics;


/* ------------------------------------------------------------
   CASE FOR CONDITIONAL CALCULATIONS
   Performs different arithmetic operations based on a condition.
   ------------------------------------------------------------ */

-- 2. Conditional Salary Increase Calculation
-- The raise percentage is determined by the current salary level.
SELECT 
    first_name, 
    last_name, 
    salary,
    CASE
        WHEN salary <= 45000 THEN salary + (salary * 0.07) -- 7% Raise for <= $45,000
        WHEN salary > 45000 THEN salary + (salary * 0.05)  -- 5% Raise for > $45,000
        ELSE salary -- The ELSE clause handles cases like NULL or zero salary
    END AS New_Salary
FROM employee_salary;


-- 3. CASE for Conditional Bonus Assignment
-- The bonus calculation is determined by the department ID.
SELECT 
    sal.first_name, 
    sal.last_name, 
    sal.salary,
    CASE
        WHEN sal.dept_id = 6 THEN sal.salary * 0.10 -- 10% bonus for Finance Dept (ID 6)
        ELSE 0 -- Assigns 0 bonus to all other departments
    END AS Bonus_Amount
FROM employee_salary sal;


-- 4. Combining Salary Increase and Bonus Calculation (Multi-step logic)
-- Calculates the New Salary using the pay raise logic, and the Total Pay 
-- by adding the conditional bonus to the New Salary.
SELECT 
    first_name, 
    last_name, 
    salary,
    -- Step 1: Calculate New Base Salary
    CASE
        WHEN salary <= 45000 THEN salary + (salary * 0.07)
        WHEN salary > 45000 THEN salary + (salary * 0.05)
    END AS New_Base_Salary,
    -- Step 2: Calculate Bonus Amount
    CASE
        WHEN dept_id = 6 THEN salary * 0.10
        ELSE 0
    END AS Bonus_Amount
    -- Note: To calculate 'Total_New_Pay', you would typically use a subquery 
    -- or Common Table Expression (CTE) since you cannot reference a column alias 
    -- (like New_Base_Salary) in the same SELECT statement.
FROM employee_salary;

/* ============================================================
   CASE STATEMENT EXAMPLES COMPLETE
   ============================================================ */