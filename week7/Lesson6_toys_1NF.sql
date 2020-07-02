/*
Name : Anju Chawla
Date: June/July 2020
Purpose: To create a database and a table therein. 
Populate the table with data. Ensure that all tables are in 1NF
*/

-- set the environment
SET SQL_MODE = "STRICT_ALL_TABLES";
SET SQL_SAFE_UPDATES = 0;
SET DEFAULT_STORAGE_ENGINE =  INNODB;

-- DROP ANY EXISTING DATABASE, CREATE AND USE A DATABASE
DROP DATABASE IF EXISTS db_toys_1NF;
CREATE DATABASE db_toys_1NF;
USE db_toys_1NF;

-- drop table if exists and create a new one
-- DROP TABLE IF EXISTS tbl_toys;
-- create the table structure
CREATE TABLE  tbl_toys  (
  toy_id 	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  toy 		VARCHAR(30) NOT NULL 
  ) ;
    
-- drop table if exists and create a new one
-- DROP TABLE IF EXISTS tbl_colors;
-- create the table structure
CREATE TABLE tbl_colors(
	color_id  INT  UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    color     VARCHAR(10) NOT NULL
); 
-- drop table if exists and create a new one 
-- DROP TABLE IF EXISTS tbl_toys_and_colors;
-- create the table structure
CREATE TABLE tbl_toys_and_colors(

	toy_id 		INT UNSIGNED NOT NULL,
    CONSTRAINT C1_FK
    FOREIGN KEY(toy_id)
    REFERENCES tbl_toys(toy_id),
    color_id 	INT UNSIGNED NOT NULL,
    CONSTRAINT C2_FK
    FOREIGN KEY (color_id)
	REFERENCES tbl_colors(color_id),
    
    PRIMARY KEY(toy_id,color_id)
    
);  

 -- SHOW CREATE TABLE tbl_toys_and_colors;
  
 -- populate the toys table 
INSERT INTO tbl_toys(toy_id,toy) 
VALUES 
(5,'whiffleball'),			
(6,'frisbee'), 			
(9,'kite'), 			
(12,'yoyo')	;		

-- populate the colors table
INSERT INTO tbl_colors(color)
VALUES
('white'),
('yellow'),
('blue'),
('green'),
('red'),
('orange');

-- populate the toys and colors table
INSERT INTO tbl_toys_and_colors(toy_id,color_id)
VALUES
(5,1),
(5,2),
(5,3),
(6,4),
(6,2),
(9,5),
(9,3),
(9,4),
(12,1),
(12,2);
/*
-- won't work since 13 is NOT a valid toy_id-remember the constraint?
INSERT INTO tbl_toys_and_colors(toy_id,color_id)
VALUES
(13,1);
-- won't work since 13 is NOT a valid color_id-remember the constraint?
INSERT INTO tbl_toys_and_colors(toy_id,color_id)
VALUES
(12,13);
*/

-- show all records from all  tables
SELECT * FROM tbl_toys;
SELECT * FROM tbl_colors;
SELECT * FROM tbl_toys_and_colors;

-- see which toy is available in which color
SELECT toy, color
FROM tbl_toys  NATURAL JOIN  tbl_colors  NATURAL JOIN tbl_toys_and_colors ;



