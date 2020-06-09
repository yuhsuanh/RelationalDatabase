-- Name: Anju Chawla
-- Purpose: Create a database and a table therein to store information about drinks. Populate the table with data and display it. Code update and delete statements to change/modify data in row(s) and delete rows in the table.

-- drop the database if it exists, create a new one and use it
DROP DATABASE IF EXISTS db_drinks;
CREATE DATABASE db_drinks;
USE db_drinks;

-- set the environment variables
-- SET SQL_SAFE_UPDATES = 0;


-- drop the table if it exists
DROP TABLE IF EXISTS tbl_drinks;

-- create the table
CREATE TABLE tbl_drinks(
	drink_name  		VARCHAR(20) PRIMARY KEY,	
	drink_cost			DEC(4,2) UNSIGNED NOT NULL,	
	carbs_grams			FLOAT(4,1) UNSIGNED NOT NULL,
	drink_color			VARCHAR(15) NOT NULL,
	drink_has_ice	    ENUM('Yes', 'No')  DEFAULT 'Yes', 
    calories			TINYINT UNSIGNED 
);

-- 
INSERT INTO tbl_drinks
VALUES
('Blackthorn', 3, 8.4, 'Yellow', 'Yes', 33),
('Blue Moon', 2.5, 3.2, 'Blue', 'Yes', NULL),
('Oh My Gosh', 3.5, 8.61, 'Orange', 'Yes', 35),
('Lime Fizz', 2.5, 5.4, 'Green', 'Yes', 24),
('Kiss on the Lips', 5.5, 42.52, 'Purple', 'Yes', 171),
('Hot Gold', 3.2, 32.1, 'Orange', 'No', 135),
('Lone Tree', 3.6, 4.2, 'Red', 'Yes', 17),
('Greyhound', 4, 14, 'Yellow', 'Yes', 50),
('Indian Summer', 2.8, 7.2, 'Brown', 'no', 30),
('Bull Frog', 2.6, 21.5, 'Tan', 'Yes', 80),
('Martini',3,0.8,'Clear','No', 112),
('M',3,0.8,'Clear','No', 112), 
('Soda and It', 3.8, 4.7, 'Red', 'No', 19),
('Penicillin Cocktail', 5 , 11, 'Honey', 'Yes', 189),
('Zaza', 3, 9, 'Red', NULL, 181);

-- select all records from the table
SELECT * FROM tbl_drinks;

-- -- -- -- -- -- -- -- -- -- -- UPDATES-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- 1. Update the calories for Blackthorn and Oh My Gosh to 40 using a single update statement
UPDATE tbl_drinks
SET calories = 40
WHERE drink_name IN ('Blackthorn', 'Oh My Gosh');

-- 2. Increase the cost of all clear drinks by $1
UPDATE tbl_drinks
SET drink_cost = drink_cost + 1
WHERE drink_color = 'Clear';

-- 3. Change the color for tan colored drinks to brown.
# Uncommant Line:10 "SET SQL_SAFE_UPDATES = 0;"
UPDATE tbl_drinks
SET drink_color = 'brown'
WHERE drink_color = 'tan';

-- 4. Set the calories field to 0, wherever it is NULL.
UPDATE tbl_drinks
SET calories = 0
WHERE calories IS NULL;

-- 5. Set the ice field for all the drinks to NULL.
UPDATE tbl_drinks
SET drink_has_ice = NULL;

-- 6. Update the cost to $5 for all those drinks that are currently priced between $4 and $5, not including the two limits.
UPDATE tbl_drinks
SET drink_cost = 5
WHERE drink_cost BETWEEN 4 AND 5;

-- 7. Update the cost to $6 for all the drinks with carbs less than 10 or at most 80 calories.
UPDATE tbl_drinks
SET drink_cost = 6
WHERE carbs_grams < 10 OR calories = 80;

-- 8. Change the ice to Yes and color to Red for Indian Summer using a single update statement.
UPDATE tbl_drinks
SET drink_has_ice = 'Yes', drink_color = 'Red'
WHERE drink_name = 'Indian Summer';

-- 9. Change the color of Blue Moon by appending(add at end) 'sky' to its color. You have no idea of its original color.
UPDATE tbl_drinks
SET drink_color = CONCAT(drink_color, 'sky')
WHERE drink_name = 'Blue Moon';



-- -- -- -- -- -- -- -- -- -- -- -- -- -- DELETE-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- 10. Delete all drinks with null calories.
DELETE FROM tbl_drinks
WHERE calories IS NULL;

-- 11. Delete the drink(s) with name starting with 'Z'.
DELETE FROM tbl_drinks
WHERE LEFT(drink_name, 1) = 'Z';

-- 12. Delete all red and orange colored drinks.
DELETE FROM tbl_drinks
WHERE drink_color IN ('Red', 'Orange');

-- 13 Delete all drinks with 0 calories.
DELETE FROM tbl_drinks
WHERE calories = 0;

-- 14 Delete all records
DELETE FROM tbl_drinks;
