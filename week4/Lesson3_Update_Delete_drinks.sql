-- Name: Anju Chawla
-- Purpose: Create a database and a table therein to store information about drinks. Populate the table with data and display it. Code update and delete statements to change/modify and delete data in the table

-- drop the database if it exists, create a new one and use it
DROP DATABASE IF EXISTS db_drinks;
CREATE DATABASE db_drinks;
USE db_drinks;

-- set the environment variables
SET SQL_SAFE_UPDATES = 0;


-- drop the table if it exists
-- DROP TABLE IF EXISTS tbl_drinks;

-- create the table
CREATE TABLE tbl_drinks(
	drink_name  		VARCHAR(20) PRIMARY KEY,	
	drink_cost			DEC(4,2) UNSIGNED NOT NULL,	
	carbs_grams			FLOAT(4,1) UNSIGNED NOT NULL,
	drink_color			VARCHAR(15) NOT NULL,
	drink_has_ice	    ENUM('Yes', 'No')  DEFAULT 'Yes', 
    calories			TINYINT UNSIGNED 
);

-- insert data in the table
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

-- select all records/columns from the table
SELECT * FROM tbl_drinks;

-- -- -- -- -- -- -- -- -- -- -- UPDATES-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- 1 UPDATE THE cost OF BLUE MOON TO $3.50
UPDATE tbl_drinks
SET drink_cost = 3.50
WHERE drink_name='blue moon';

SELECT *
FROM  tbl_drinks
WHERE drink_name='blue moon';

-- 2 Increase the cost by $1 for the drinks Oh My Gosh and Lime Fizz using a single update statement.
SELECT *
FROM tbl_drinks
WHERE drink_name = 'Oh My Gosh' OR drink_name='Lime Fizz';

UPDATE tbl_drinks
SET drink_cost = drink_cost+ 1
WHERE drink_name = 'Oh My Gosh' OR drink_name='Lime Fizz';

UPDATE tbl_drinks
SET drink_cost = drink_cost+ 1
WHERE drink_name IN ('Oh My Gosh' ,'Lime Fizz');

-- 3 Change the color of orange colored drinks to rust  

SELECT *
FROM tbl_drinks
WHERE drink_color ='orange';

UPDATE tbl_drinks
SET drink_color = 'rust'
WHERE drink_color ='orange';

SELECT *
FROM tbl_drinks
WHERE drink_color ='rust';

-- 4 Set the drink_has_ice field to No where it is NULL

SELECT *
FROM  tbl_drinks
WHERE drink_has_ice IS NULL;

UPDATE tbl_drinks
SET drink_has_ice = 'No'
WHERE drink_has_ice IS NULL;

SELECT *
FROM  tbl_drinks
WHERE drink_has_ice = 'No';

-- 5 Set the drink_has_ice field for all the drinks to Yes
UPDATE tbl_drinks
SET drink_has_ice = 'Yes';
-- WHERE drink_has_ice  = 'No' -- not efficient  and should not be coded

SELECT * FROM tbl_drinks;

-- 5 Update the cost of all drinks that are less than or equal to $5 to $4.50 

UPDATE tbl_drinks
SET drink_cost = 4.50
WHERE drink_cost <= 5;

-- 6 Update the cost to $6 for all the drinks where carbs are greater than 20 and calories at least 80

UPDATE tbl_drinks
SET drink_cost = 6
WHERE carbs_grams > 20 AND calories >= 80;

-- 7 Change the drink_has_ice to No and color to red for Oh My Gosh using a single update statement.

UPDATE tbl_drinks
SET drink_has_ice = 'No',
    drink_color = 'Red'
WHERE drink_name='Oh My Gosh';


-- 8 Change the color of Indian Summer by appending(add at end) 'light' to its color. You have no idea of its original color

UPDATE tbl_drinks 
SET drink_color = CONCAT(drink_color, ' light')
WHERE drink_name='Indian Summer';

-- changing the color of drink M by preceding it by Really
UPDATE tbl_drinks 
SET drink_color = CONCAT('Really ', drink_color)
WHERE drink_name = 'M';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- DELETE-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- 1 Delete all records with no ice
DELETE FROM tbl_drinks
WHERE drink_has_ice = 'No';

DELETE FROM tbl_drinks
WHERE NOT drink_has_ice = 'Yes';


-- 2 Delete the drink with name 'M'
DELETE FROM tbl_drinks
WHERE drink_name = 'M';

-- 3 Delete all rust and brown colored drinks
DELETE FROM tbl_drinks
WHERE drink_color IN ('rust', 'brown');

DELETE FROM tbl_drinks
WHERE drink_color ='rust' OR drink_color = 'brown';

-- 4 Delete all drinks with null calories
DELETE FROM tbl_drinks
WHERE calories IS NULL;


-- 5 Delete all records
DELETE FROM tbl_drinks;

SELECT * FROM tbl_drinks;

-- DROP TABLE tbl_drinks;