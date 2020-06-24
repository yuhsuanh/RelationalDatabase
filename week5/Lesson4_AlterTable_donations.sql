-- Name: Anju Chawla
-- Date: June 2020
-- Purpose: To create a database and a table therein to store information 
-- about donations made to a party.
-- To alter the table and update data using String functions

-- set the environment
SET SQL_MODE = "STRICT_ALL_TABLES";
SET SQL_SAFE_UPDATES = 0;

-- drop existing database if any, create a new one and use the database
DROP DATABASE IF EXISTS db_donations;
CREATE DATABASE db_donations;
USE db_donations;

-- create the table structure
CREATE TABLE tbl_donations (
	id            INT UNSIGNED AUTO_INCREMENT,
	first_name    VARCHAR(20) NOT NULL,
	last_name     VARCHAR(20) NOT NULL,
	recipient     VARCHAR(255) NOT NULL,
	PRIMARY KEY (id) 
);

-- insert records in the table
INSERT INTO tbl_donations(first_name, last_name, recipient)
values
('Eric','Smith','   Barrie   ,      Liberal Party');
INSERT INTO tbl_donations(first_name, last_name, recipient)
values
('Alicia','Jones','   Simcoe    North   , Conservative Party');
INSERT INTO tbl_donations(first_name, last_name, recipient)
values
('Sue','Wilson','London South, NDP');

-- select all records from the table
SELECT * FROM tbl_donations;

-- alter the table, add new columns, riding and party, text 30 characters
ALTER TABLE tbl_donations
ADD COLUMN riding VARCHAR(30),
ADD COLUMN party VARCHAR(30);

-- describe the table structure
DESC tbl_donations;

-- display output using string functions 
SELECT LEFT('ANJU CHAWLA', 4); -- first 4 chatracters from left
SELECT RIGHT('ANJU CHAWLA', 6);-- 6 characters from the right
SELECT MID('ANJU CHAWLA', 4);-- start at position 4 and extract till the end of the string
SELECT SUBSTR('ANJU CHAWLA', 4);-- same as MID
SELECT SUBSTRING('ANJU CHAWLA', 4);-- same as MID
-- mid, substr and substring can take a third argument also- how many
SELECT MID('ANJU CHAWLA', 4, 5); -- pick up 5 characters starting from position 4
SELECT MID('ANJU CHAWLA', 4, 15); 
-- pick up 15 characters starting from position 4 or till end since there are less than 15 caracters
-- use upper and lower to change case

SELECT UPPER('anju chawla') AS 'Upper Case';
SELECT LOWER('ANJU CHAWLA') AS 'Lower Case';

-- position of , in a string
SELECT recipient, INSTR(recipient,',') 'Position of \'comma\''
FROM tbl_donations;
-- populate the two new fields with data in recipient
UPDATE tbl_donations
SET riding = TRIM(SUBSTRING_INDEX(recipient, ',', 1)) ,
    party = TRIM(SUBSTRING_INDEX(recipient, ',', -1))
    ;
-- another way
UPDATE tbl_donations
SET riding= TRIM(LEFT(recipient, INSTR(recipient,',')-1 )),
    party= TRIM(RIGHT(recipient, LENGTH(recipient)- INSTR(recipient,',')))
    ;
-- another way    
UPDATE tbl_donations
SET riding= TRIM(LEFT(recipient, INSTR(recipient,',')-1 )),
    party= TRIM(MID(recipient, INSTR(recipient,',')+1))
    ;    
-- another way
UPDATE tbl_donations
SET riding= TRIM(LEFT(recipient, INSTR(recipient,',')-1 )),
    party= TRIM(SUBSTRING(recipient, INSTR(recipient,',')+1))
    ; 
-- another way    
UPDATE tbl_donations
SET riding= TRIM(LEFT(recipient, INSTR(recipient,',')-1 )),
    party= TRIM(SUBSTR(recipient, INSTR(recipient,',')+1))
    ; 

-- drop the recipient column
ALTER TABLE tbl_donations
DROP COLUMN recipient;

-- describe the structure of the table
DESC tbl_donations;
-- display the records of the table
SELECT * FROM tbl_donations;

    
  

