/*
    Name: 
    Date: 
    Purpose: This script creates a database and a table therein to save information about cars. 
    It then alters the name and the structure of the table, and updates some records.
*/

-- drop the existing database
DROP DATABASE IF EXISTS db_auto;
-- create the database 
CREATE DATABASE db_auto;
-- use the database 
USE db_auto;


-- create the table structure
CREATE TABLE auto(
    color VARCHAR(10),
    years CHAR(4) NOT NULL,
    make VARCHAR(40) NOT NULL,
    mo VARCHAR(15) NOT NULL,
    howmuch DEC(8,3) NOT NULL  -- yes, 3 incorrect places after decimal for monetary field; should be altered
);

-- populate table with data
INSERT INTO auto 
VALUES
    ('Silver', 1998, 'Porsche', 'Boxter', 17992.541),
    (NULL, 2000, 'Jaguar','XJ', 15995),
    ('Red', 2002,'Cadillac', 'Escalade', 40215.9);

-- get description of the table 'auto'
DESC auto;

-- show all the records of the table 'auto'
SELECT * FROM auto;

-- drop the existing table 'tbl_auto'
DROP TABLE IF EXISTS tbl_auto;

-- rename the table 'auto' as 'tbl_auto'
ALTER TABLE auto RENAME TO tbl_auto;

-- add the column 'car_id' and use it as the primary key. Also, set it as the first column
-- add the column 'VIN' that has 17 characters at the maximum; cannot do UNIQUE and NOT NULL together, can do either ; do NOT NULL here
ALTER TABLE tbl_auto
ADD COLUMN car_id INT PRIMARY KEY AUTO_INCREMENT FIRST,
ADD COLUMN VIN VARCHAR(17) NOT NULL;

-- change names and/or sizes of the other columns
ALTER TABLE tbl_auto
CHANGE COLUMN mo model VARCHAR(15) NOT NULL,
CHANGE COLUMN howmuch price DEC(8,3) NOT NULL,
CHANGE COLUMN years model_year CHAR(4) NOT NULL;

-- populate the table column VIN using update statement; should NOT use insert here
UPDATE tbl_auto
SET VIN = '1HGCP2F30AA071055'
WHERE car_id = 1;

UPDATE tbl_auto
SET VIN = 'JH4TB2H26CC000000'
WHERE car_id = 2;

UPDATE tbl_auto
SET VIN = 'RNKLK66N33G213481'
WHERE car_id = 3;

-- make the column VIN unique; add a constraint
ALTER TABLE tbl_auto
MODIFY COLUMN VIN VARCHAR(17) NOT NULL UNIQUE;


-- to check that VIN is unique
INSERT INTO tbl_auto(VIN, make, model, color, model_year, price)
VALUES
('RNKLK66N33G213481','Porsche', 'Boxter','Silver', 1998,  17992.54);

-- to check that VIN cannot be null
INSERT INTO tbl_auto(VIN, make, model, color, model_year, price)
VALUES
(null,'Porsche', 'Boxter','Silver', 1998,  17992.54);

-- show description of the table tbl_auto
DESC tbl_auto;
SHOW COLUMNS FROM tbl_auto;

-- show all the records in the table
SELECT * FROM tbl_auto;
