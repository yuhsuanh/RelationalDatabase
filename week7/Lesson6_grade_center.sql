/*
Name : Anju Chawla
Date: June/July 2020
Purpose: To create a database with a table therein to store grades of students in various courses. To comment on the design of the table and redesign the database structure 'splitting' this table into 2NF tables
*/

-- set the environment
-- need to use foreign key so have to set the storage engine to INNODB
SET DEFAULT_STORAGE_ENGINE = INNODB;

-- drop existing database, if any; recreate one by same name and use it.
DROP DATABASE IF EXISTS db_grade_center;
CREATE DATABASE db_grade_center;
USE db_grade_center;

-- create the table structure to store student information and the grade in various courses
CREATE TABLE tbl_grade_center
    (
      first_name  		VARCHAR(30) NOT NULL,
      last_name   		VARCHAR(30) NOT NULL,
      student_number 	CHAR(10) NOT NULL,
      course      		CHAR(8) NOT NULL,
      grade       		TINYINT UNSIGNED NOT NULL DEFAULT 0,
      PRIMARY KEY(student_number, course)
    );
    
-- decribe the table structure
DESC tbl_grade_center;

-- insert records in the table
INSERT INTO tbl_grade_center VALUES ('Phineas', 'Flynn', '1234510001','COMP2003', 88);
INSERT INTO tbl_grade_center VALUES ('Ferb', 'Fletcher', '1234510002','COMP2003', 100);
INSERT INTO tbl_grade_center VALUES ('Candace','Fletcher', '1234510003','COMP2003', 60);
INSERT INTO tbl_grade_center VALUES ('Baljeet', ' ', '1234510004','COMP2003', 100);
INSERT INTO tbl_grade_center VALUES ('Major', 'Monogram ', '1234510005','COMP2003', 50);
INSERT INTO tbl_grade_center VALUES ('Dr.', 'Doofenshmirtz', '1234510006','COMP2003', 55);
INSERT INTO tbl_grade_center VALUES ('Isabella', 'Garcia-Shapiro', '1234510007','COMP2003', 90);
INSERT INTO tbl_grade_center VALUES ('Phineas', 'Flynn', '1234510001','COMP2007', 79);
INSERT INTO tbl_grade_center VALUES ('Ferb', 'Fletcher', '1234510002','COMP2007', 100);
INSERT INTO tbl_grade_center VALUES ('Candace', 'Fletcher', '1234510003','COMP2007', 72);
INSERT INTO tbl_grade_center VALUES ('Baljeet', ' ', '1234510004','COMP2007', 100);
INSERT INTO tbl_grade_center VALUES ('Major', 'Monogram ', '1234510005','COMP2007', 68);
INSERT INTO tbl_grade_center VALUES ('Dr.', 'Doofenshmirtz', '1234510006','COMP2007', 78);
INSERT INTO tbl_grade_center VALUES ('Isabella', 'Garcia-Shapiro', '1234510007','COMP2007', 88);
INSERT INTO tbl_grade_center VALUES ('Anju', 'Chawla', '1234567890','COMP2007', 88);

-- select all records from the table
SELECT * FROM tbl_grade_center;

/*
A table is said to be in 2NF, iff, (a) it is in the 1NF and (b) every non-key attribute is dependant on the complete composite PK, not on part of it. No partial dependance.
-- if the PK is a single field and the table is in 1NF, then it is automatically in 2NF
-- Is this table in the 2NF? Why or why not? Are there any anamolies that arise from a table not being in the 2NF?
The composite PK is student_nuumber and course. The first_name and last_name are only dependant/related on/to the student_number. The grade is fully dependant on the composite PK. Hence we will split the original table into two tables- one just with the student information and the other with the rest of the information.
*/

-- create table that only contains student information, dropping one if exists
DROP TABLE IF EXISTS tbl_student_information;

CREATE TABLE tbl_student_information AS
(SELECT DISTINCT student_number, first_name, last_name FROM tbl_grade_center)	
;
-- make student_number the PK
ALTER TABLE tbl_student_information
ADD PRIMARY KEY(student_number);

-- show the structure of the table 
DESC tbl_student_information;

-- select all the records of the table to ensure that it has all the relevant information
SELECT * FROM tbl_student_information;	

-- create a second table consisting of the rest of the information, dropping one if exists
 
DROP TABLE IF EXISTS tbl_student_grades;
CREATE TABLE tbl_student_grades AS
(SELECT student_number, course, grade FROM tbl_grade_center);

-- make student_number and course the composite PK
ALTER TABLE tbl_student_grades
ADD CONSTRAINT PRIMARY KEY(student_number, course);

-- add a constraint/rule that the student number is valid and is present in the student information table
ALTER TABLE tbl_student_grades
ADD CONSTRAINT fk_student_number
FOREIGN KEY (student_number) REFERENCES tbl_student_information(student_number);


-- show the structure of the table 
DESC tbl_student_grades;
-- select all the records of the table to ensure that it has all the relevant information
SELECT * FROM tbl_student_grades;

-- no information should be lost
-- join the two tables to retrieve the original table information together
-- natural join 'joins' the two tables on the same named field, records with the same value in the fields 'join' to make a single record
-- SELECT * FROM tbl_student_information;
-- SELECT * FROM tbl_student_grades;
SELECT *
FROM
tbl_student_information NATURAL JOIN tbl_student_grades
ORDER BY student_number;

-- show all the tables in the database
SHOW TABLES;
-- the origanl table can be dropped now
DROP TABLE IF EXISTS tbl_grade_center;
-- show all the tables in the database
SHOW TABLES;

