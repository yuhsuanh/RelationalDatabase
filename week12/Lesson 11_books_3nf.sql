/*
Name : Anju Chawla
Date: August 2020
Purpose: To create a database and tables therein to save information about books and publishers . All tables are in 3NF

A table is in 3NF if it is in 2NF AND every non key field(field not part of the PK)
is non-transitively/directly dependent on the primary key.

*/
-- set the environment
SET SQL_MODE = "STRICT_ALL_TABLES";
SET SQL_SAFE_UPDATES=0;
SET DEFAULT_STORAGE_ENGINE =  INNODB;

-- drop database if exists, create it and use it
DROP DATABASE IF EXISTS db_book_3NF;
CREATE DATABASE db_book_3NF;
USE db_book_3NF;

-- DROP TABLE IF EXISTS tbl_publisher;
-- create the table structure to store information about publishers
CREATE TABLE tbl_publisher(
	publisher_id   		INT  UNSIGNED PRIMARY KEY,
    publisher_city    	VARCHAR(25) NOT NULL 
);
-- populate the publishers table with data records
INSERT INTO tbl_publisher
VALUES
(1,'New York'),
(2,'New York'),
(3,'San Francisco'),
(5, 'Boston');

-- describe the structure of the publisher table
DESC tbl_publisher;
-- display all the records from the publisher table
SELECT * FROM tbl_publisher;


-- DROP TABLE IF EXISTS tbl_books;
-- create the table structure to store information about books
CREATE TABLE tbl_books(
	author      		VARCHAR(40),
	title       		VARCHAR(50),
	publisher_id      	INT UNSIGNED NOT NULL ,
	CONSTRAINT C1_FK
	FOREIGN KEY(publisher_id)
	REFERENCES tbl_publisher(publisher_id),
    
	PRIMARY KEY(author, title)

);
-- populate the books table with data records
INSERT INTO tbl_books(author, title, publisher_id)
VALUES
('John Deere','Easy Being Green',2),
('Fred Mertz','I hate Lucy',5),
('Lassie','Help Timmy!',3),
('Timmy','Lassie, Calm Down',1),
('Timmy','Help Timmy!',1);

-- describe the structure of the table
DESC tbl_books;
-- display all the records from the table
SELECT * FROM tbl_books;

-- DROP VIEW IF EXISTS view_books_publisher;
-- create a view - inner join of tables publishers and books
CREATE VIEW view_books_publisher AS
(
SELECT author, title, P.publisher_id, publisher_city
FROM tbl_books B, tbl_publisher P
WHERE B.publisher_id = P.publisher_id
ORDER BY P.publisher_id
);

-- show all the tables and view in the databse
SHOW FULL TABLES;

-- select the records in the view
SELECT * FROM view_books_publisher;

-- display the city, book information of all books published by publisher_id 1
SELECT author, title, publisher_city
FROM tbl_publisher, tbl_books
WHERE tbl_books.publisher_id = tbl_publisher.publisher_id
AND tbl_books.publisher_id = 1;

-- could use the view
SELECT author, title, publisher_city
FROM view_books_publisher
WHERE publisher_id = 1;


-- all books published in New York
SELECT title, author, publisher_id
FROM tbl_books
WHERE publisher_id IN
(SELECT publisher_id FROM tbl_publisher WHERE publisher_city = 'New York');

-- could use the view
SELECT author, title
FROM view_books_publisher
WHERE publisher_city = 'New York';

