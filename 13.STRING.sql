/*
============================================================
SQL SCRIPT: ILLUSTRATING STRING FUNCTIONS
String functions are used to manipulate and analyze text (string) data
within a column or a fixed literal string.
============================================================
*/

/* ------------------------------------------------------------
   INSPECTION & CASE CONVERSION (LENGTH, UPPER, LOWER)
   ------------------------------------------------------------ */

-- 1. LENGTH: Returns the number of characters in a string.
SELECT 
    first_name, 
    LENGTH(first_name) AS Name_Length
FROM employee_demographics;


-- 2. UPPER: Converts all characters in a string to uppercase.
SELECT 
    first_name, 
    UPPER(first_name) AS Upper_Name
FROM employee_demographics;


-- 3. LOWER: Converts all characters in a string to lowercase.
SELECT 
    first_name, 
    LOWER(first_name) AS Lower_Name
FROM employee_demographics;


/* ------------------------------------------------------------
   TRIMMING (TRIM, LTRIM, RTRIM)
   Removes unnecessary white space from a string.
   ------------------------------------------------------------ */

-- 4. TRIM: Removes leading and trailing spaces.
SELECT TRIM('  White Spaced Name  ') AS Trimmed_Result;

-- 5. LTRIM: Removes leading spaces from the left side only.
SELECT LTRIM('     Left Space Only') AS LTrim_Result;

-- 6. RTRIM: Removes trailing spaces from the right side only.
SELECT RTRIM('Right Space Only     ') AS RTrim_Result;


/* ------------------------------------------------------------
   EXTRACTION (LEFT, RIGHT, SUBSTRING)
   Pulls a portion of the string based on position or length.
   ------------------------------------------------------------ */

-- 7. LEFT: Extracts a specified number of characters from the left.
SELECT 
    first_name, 
    LEFT(first_name, 4) AS First_4_Chars
FROM employee_demographics;


-- 8. RIGHT: Extracts a specified number of characters from the right.
SELECT 
    first_name, 
    RIGHT(first_name, 4) AS Last_4_Chars
FROM employee_demographics;


-- 9. SUBSTRING: Extracts a substring starting from a specified position 
-- and continuing for a specified length. (Syntax: SUBSTRING(string, start_pos, length))
SELECT 
    birth_date, 
    SUBSTRING(birth_date, 1, 4) AS birth_year, -- Extract year (4 chars starting at position 1)
    SUBSTRING(birth_date, 6, 2) AS birth_month -- Extract month (2 chars starting at position 6)
FROM employee_demographics;


/* ------------------------------------------------------------
   REPLACEMENT & LOCATION (REPLACE, LOCATE)
   ------------------------------------------------------------ */

-- 10. REPLACE: Replaces all occurrences of a substring with a new substring.
SELECT 
    first_name,
    REPLACE(first_name, 'a', 'z') AS Replaced_Name
FROM employee_demographics;


-- 11. LOCATE: Returns the starting position of the first occurrence of a substring. 
-- Returns 0 if the substring is not found. (Syntax: LOCATE(substring, string))
SELECT 
    first_name, 
    LOCATE('e', first_name) AS Position_of_e, -- Returns the position of the first 'e'
    LOCATE('Mic', first_name) AS Position_of_Mic -- Used to search for longer strings
FROM employee_demographics;


/* ------------------------------------------------------------
   COMBINATION (CONCAT)
   Joins two or more strings together.
   ------------------------------------------------------------ */

-- 12. CONCAT: Concatenates (joins) two or more strings.
SELECT 
    CONCAT(first_name, ' ', last_name) AS Full_Name,
    CONCAT(first_name, ' is ', age, ' years old.') AS Description
FROM employee_demographics;

/* ============================================================
   STRING FUNCTIONS EXAMPLES COMPLETE
   ============================================================ */