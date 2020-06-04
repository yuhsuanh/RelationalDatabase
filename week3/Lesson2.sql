/*
Name: Anju Chawla
Date: May 2020
Purpose:Create a database and a table therein to store information about doughnuts. Select data from the table using different criterion
*/
-- set the environment variables
SET SQL_MODE = "STRICT_ALL_TABLES";

-- drop the existing database, create it and use it
DROP DATABASE IF EXISTS db_doughnuts;
CREATE DATABASE db_doughnuts;
USE db_doughnuts;

-- drop the existing table, though unnecssary since the database has been dropped, hence in comments but so that you know the command to drop a able
-- DROP TABLE IF EXISTS tbl_doughnuts;
/*
 A table is said to be in 1NF or First Normal Form iff
 i) the table has a primary key
ii) no field has repeating kind of data or every field is 'atomic' in nature
*/
CREATE TABLE tbl_doughnuts
(
	doughnut_name	VARCHAR(20)         PRIMARY KEY, 				-- name of the doughnut
    doughnut_type	VARCHAR(15)			NOT NULL,					-- type of the doughnut
    doughnut_cost	DEC(4,2)			NOT NULL DEFAULT 1,			-- cost of the doughnut
    customer_rating	ENUM('0','1','2','3','4','5') DEFAULT '0'		-- rating given by customer; '5' is the maximum
    -- enum can only contain string objects/enumerated constants and are associated with internal index values 1,2,3...so be VERY CAUTIOUS when using numbers as enumerated constants. The DEFAULT value MUST be a part of the list
   
);

-- populate the table with data
INSERT INTO tbl_doughnuts(doughnut_name,doughnut_type,doughnut_cost,customer_rating)
VALUES
('Apple Fritter','Fritter',2.50,'3'),
('Apple','Cruller',2,'3'),
('Chocolate','Ring',2.00,NULL),
('Caramel','Ring',DEFAULT,'4'),
('Jelly','Filled',1.50,'2'),
('Maple','Ring',2.25,'5');
-- (NULL,'Ring',2.50,4), -- Primary Key value cannot be null
-- ('Maple','Ring',2.50,4); -- cannot add a duplicate name (PK)

INSERT INTO tbl_doughnuts(doughnut_name,doughnut_type)
VALUES
('Nutella','Yeast');

-- 1. select all records(no filter) and all fields(*)
SELECT * FROM tbl_doughnuts;


-- 2a. display record of apple fritter, all fields. Case insensitive filtering.Exact match with =
SELECT * FROM tbl_doughnuts
WHERE doughnut_name = 'Apple FriTTer'; 

-- always mention field list in any order of fields/columns
SELECT doughnut_name, doughnut_type, doughnut_cost, customer_rating
FROM tbl_doughnuts
WHERE doughnut_name = 'Apple FriTTer'; 

-- 2b. case sensitive search. A collation is a set of rules that defines how to compare and sort character strings.
SELECT * FROM tbl_doughnuts
WHERE doughnut_name = 'Apple Fritter'
COLLATE 'utf8mb4_bin';  -- default is utf8_general_ci 
; 

-- 3. inexact match using LIKE - all doughnuts that have apple in its name using wildcard characters - % stands for 0 or more characters
SELECT *
FROM tbl_doughnuts
WHERE doughnut_name LIKE '%apple%';

-- 4b.Select all doughnuts that begin with apple in its name
SELECT  * FROM   tbl_doughnuts
WHERE doughnut_name LIKE 'apple%';

-- 5. Select all doughnuts with a name that has a single character followed by pple; the wildcard character _ stands for one character
SELECT * FROM tbl_doughnuts
WHERE doughnut_name LIKE '_pple';

-- 6. Select all doughnuts with 5 letter names 
SELECT * FROM tbl_doughnuts
WHERE doughnut_name LIKE '_____';

-- use trim to remove leading and trailing blanks and then the length function to count the characters in name
SELECT TRIM('    ANJU    CHAWLA   ');
SELECT LENGTH('ANJU CHAWLA');

SELECT * FROM tbl_doughnuts
WHERE LENGTH(TRIM(doughnut_name)) = 5;


-- 7. Wild characters can be combined
-- all doughnuts with name that have a single character followed by pple..... ;
SELECT * FROM tbl_doughnuts
WHERE TRIM(doughnut_name) LIKE '_pple%';

-- 8. Select all doughnuts with 'ap' in the name
SELECT * FROM tbl_doughnuts
WHERE doughnut_name LIKE '%ap%';

-- 9. try to figure this Select 
SELECT * FROM tbl_doughnuts
WHERE doughnut_name LIKE '\%a_p_e%'; 
--  look for %a$p$e where $ is any character and any characters after e
-- to search for the character % in text, escape it \%

-- 10. Select fields(any number, any order), - doughnut_name, doughnut_cost for all 'apple' doughnuts
SELECT doughnut_name, doughnut_cost
FROM tbl_doughnuts
WHERE doughnut_name LIKE '%apple%';

-- compound conditions using boolean operators - and, or, not
-- relational opeartors >, >=, < ,<= ,=, !=, <> (last two are 'not equal')

-- 11. Select doughnuts of type ring and cost at least 2, display the name and cost
SELECT doughnut_name, doughnut_cost
FROM tbl_doughnuts
WHERE doughnut_type = 'ring' AND doughnut_cost >= 2;

-- 12. Select doughnuts of type ring or cost at least 2, display the name and cost
SELECT doughnut_name, doughnut_cost, doughnut_type 
FROM tbl_doughnuts
WHERE doughnut_type = 'ring' OR doughnut_cost >= 2;

-- 13. Select doughnuts of type ring and cost at least 2, display the name and cost - use NOT operator which SHOULD be used with field name
SELECT doughnut_name, doughnut_cost
FROM tbl_doughnuts
WHERE doughnut_type = 'ring' AND NOT doughnut_cost < 2;

-- 14. Select doughnut  name and cost of those doughnuts where cost is different from $2 - three solutions
SELECT doughnut_name, doughnut_cost
FROM tbl_doughnuts
WHERE doughnut_cost <> 2;

SELECT doughnut_name, doughnut_cost
FROM tbl_doughnuts
WHERE doughnut_cost != 2;

SELECT doughnut_name, doughnut_cost
FROM tbl_doughnuts
WHERE NOT doughnut_cost = 2;

-- 15. Select doughnut name and the customer rating, with rating >=3
-- the rating is an enumerated type- list of string objects with a pre-defined order
SELECT doughnut_name , customer_rating
FROM tbl_doughnuts
WHERE customer_rating >= '3';
-- keep away from internal coding
SELECT doughnut_name , customer_rating
FROM tbl_doughnuts
WHERE customer_rating >= 4;
-- will give wrong answer
SELECT doughnut_name , customer_rating
FROM tbl_doughnuts
WHERE customer_rating >= 3;

-- 16. Select doughnuts with 'NULL' rating; use IS , cannot use = 
SELECT * 
FROM tbl_doughnuts
WHERE customer_rating IS NULL; 

-- 17. Select doughnuts that do not have a NULL rating; use IS NOT , cannot use <> or !=
SELECT * 
FROM tbl_doughnuts
WHERE customer_rating IS NOT NULL; 

-- 18a. Select doughnuts with cost between $2 and $3, inclusive - 3 solutions
SELECT * 
FROM tbl_doughnuts
WHERE doughnut_cost >= 2 AND doughnut_cost <= 3 ;
-- between can be used with numeric and text data ; both limits are included
SELECT * 
FROM tbl_doughnuts
WHERE doughnut_cost BETWEEN 2 AND 3 ;
-- NOT operator
SELECT * 
FROM tbl_doughnuts
WHERE NOT doughnut_cost < 2 AND NOT doughnut_cost > 3 ;

-- 18b. Select doughnuts with name starting with A, B or C
-- using relational operators
SELECT * 
FROM tbl_doughnuts
WHERE doughnut_name >='A' AND doughnut_name < 'D';

-- insert a couple of 'test' records
INSERT INTO tbl_doughnuts
VALUES
('D', 'Ring', 3, '5');
INSERT INTO tbl_doughnuts
VALUES
('Do','Ring', 3, '5');

-- using BETWEEN operator
SELECT * 
FROM tbl_doughnuts
WHERE doughnut_name BETWEEN 'A' AND 'D'
AND doughnut_name != 'D';

-- use a string function
SELECT * 
FROM tbl_doughnuts
WHERE LEFT(doughnut_name,1) BETWEEN 'A' AND 'C';
 
-- 19. Select statement to display names different from field names, use AS or without AS - no quotes requred in display/alias name if it is a single word with no special characters, so Rating in the select list can be used with or without quotes but the other two have to be enclosed in quotes
SELECT doughnut_name AS 'Doughnut Name', doughnut_cost  'Cost($)', customer_rating Rating
FROM tbl_doughnuts;
-- new cost with 20% increase - necessary to use display names in computed fields
SELECT doughnut_name AS 'Doughnut Name', ROUND(doughnut_cost * 1.20,2) 'New Price 20% Increase'
FROM tbl_doughnuts;

-- 20a. Display records - order the display by doughnut type - ascending by default
SELECT *
FROM tbl_doughnuts
ORDER BY doughnut_type
;

SELECT *
FROM tbl_doughnuts
ORDER BY doughnut_type ASC
;

-- 20b. Display records in descending order
SELECT *
FROM tbl_doughnuts
ORDER BY doughnut_type DESC
;

-- 21. Can order by more than one field
-- display all doughnuts by  type in descending order and in there by cost by ascending order
SELECT * 
FROM tbl_doughnuts
ORDER BY doughnut_type DESC, doughnut_cost ASC;

-- 22. Display the first two records - BEWARE could be different for different runs
-- the order of records and the order of columns is not not 'fixed' in a table
SELECT * 
FROM tbl_doughnuts
LIMIT 0,2; -- offset,how_many

SELECT * 
FROM tbl_doughnuts
LIMIT 2; --  0 is the default offset

-- 23. Display records 2,3 and 4
SELECT * 
FROM tbl_doughnuts
LIMIT 1,3 ;

-- 24. Combine the order by and limit to display the 'same' records
SELECT * 
FROM tbl_doughnuts
ORDER BY doughnut_name
LIMIT 0,2; 

-- 25  COMPLETE select STATEMENT - sequence is important
SELECT doughnut_name 'Doughnut Name', doughnut_cost 'Cost($)', customer_rating 'Rating'
FROM tbl_doughnuts
WHERE customer_rating >= '2'
ORDER BY customer_rating DESC
LIMIT 0,5 ; 					--  if number of records < 5, the limit is ignored

SELECT doughnut_name 'Doughnut Name', doughnut_cost 'Cost($)', customer_rating Rating
FROM tbl_doughnuts
WHERE customer_rating >= '2'
ORDER BY 3 DESC 				--  3 represents the third field in the select list
LIMIT 0, 10 ; 					--  if number of records < 10, the limit is ignored

-- you can use diplay/alias name IFF they are single word with no special characters and no quotes, so Rating can be used in the ORDER BY clause
SELECT doughnut_name 'Doughnut Name', doughnut_cost 'Cost($)', customer_rating 'Rating'
FROM tbl_doughnuts
WHERE customer_rating >= '2'
ORDER BY Rating DESC 			-- use the display/alias name without quotes
LIMIT 0,10 ; 					--  if number of records < 10, the limit is ignored