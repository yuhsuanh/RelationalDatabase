/*
Name : Anju Chawla
Date: August 2020
Purpose: To create a database and table therein to save information on books and publishers. The table is not in 3NF
*/

-- set the environment
SET SQL_MODE = "STRICT_ALL_TABLES";
SET SQL_SAFE_UPDATES=0;
SET DEFAULT_STORAGE_ENGINE =  INNODB;

-- drop database if exists, create it and use it
DROP DATABASE IF EXISTS db_books_no_3NF;
CREATE DATABASE db_books_no_3NF;
USE db_books_no_3NF;



-- create the table structure to store information about books
CREATE TABLE tbl_books(
author      	  VARCHAR(40),
title       	  VARCHAR(50),
publisher_id      INT UNSIGNED NOT NULL ,
publisher_city    VARCHAR(25) NOT NULL ,
PRIMARY KEY(author, title)
);
/*
The PK can be atomic or composite for 3NF
A table is in 3NF if it is in 2NF AND every non key field(field not part of the PK)
is non-transitively/directly dependent on the primary key.
Here we see that publisher_city is dependent on publisher_id which is further dependent on the primary key
*/
-- populate the table with data records
INSERT INTO tbl_books
VALUES
('John Deere','Easy Being Green',2,'New York'),-- John Deere Publishing
('Fred Mertz','I hate Lucy',5,'Boston'),
('Lassie','Help Timmy!',3,'San Francisco'),
('Timmy','Lassie, Calm Down',1,'New York'),
('Timmy','Help Timmy!',1,'New York');

-- describe the structure of the table
DESC tbl_books;
-- display all the records from the table
SELECT * FROM tbl_books;
