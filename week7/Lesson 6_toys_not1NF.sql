/*
Name : Anju Chawla
Date: June/July 2020
Purpose: To create a database and a table therein. 
Populate the table with data.  Check if the table is in 1NF
*/

/*
 A table is said to be in 1NF if it has a Primary Key and there 
 is no 'repeating group' of information/data in any column
 */

-- drop any existing database, create and use a database
DROP DATABASE IF EXISTS db_toys_not_1NF;
CREATE DATABASE db_toys_not_1NF;
USE db_toys_not_1NF;

-- create the table structure
CREATE TABLE  tbl_toys  (
  toy_id 	INT  UNSIGNED  AUTO_INCREMENT PRIMARY KEY,
  toy 		VARCHAR(30) NOT NULL,
  colors    VARCHAR(40) 
  );

-- insert records in the table
INSERT INTO tbl_toys(toy_id,toy,colors) 
VALUES 
(5,'whiffleball','white, yellow, blue'),
(6,'frisbee', 'green, yellow'),
(9,'kite', 'red, blue, green'),
(12,'yoyo', 'white, yellow');

-- The above table has a Primary Key but the 'colors' field has repeating group of  data/information
-- This table is NOT in 1NF


SELECT * FROM tbl_toys;



