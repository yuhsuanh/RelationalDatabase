/*
Name: Anju Chawla
Date: May, 2020
Purpose: Create a database and a table therein to store student information. Populate the table with data.
*/

-- create a database if it does not exist
-- if it exists, the pre-existing database will be used
CREATE DATABASE IF NOT EXISTS georgian_college ;
-- use the database
USE georgian_college;

/*
-- Another option is to drop the database if it exists and always start from scratch with an 'empty' database; this approach works fine 
-- if you want to run your script repeatedly, more in a learning environment than in real life
-- drop the database if it exists
DROP DATABASE IF EXISTS georgian_college;
-- create a database 
CREATE DATABASE georgian_college ;
-- use the database
USE georgian_college;
*/

-- drop the table if it exists
DROP TABLE IF EXISTS student_information;
--  create a table structure- the fields and their type, to store student information
-- CREATE TABLE IF NOT EXISTS student_information
CREATE TABLE student_information  -- table is dropped so do not need 'if not exists'
(
-- the identification number of the student
student_id			CHAR(10) PRIMARY KEY, 					-- unique in every record, cannot have a null value 
-- the name of the student
student_name		VARCHAR(40) NOT NULL,					-- cannot have a null value
-- the email of the student
student_email		VARCHAR(40) UNIQUE,						-- unique in every record, default value is NULL
-- the data of birth of the student
date_of_birth		DATE,									-- default value is NULL
-- the age of the student
age					TINYINT UNSIGNED,						-- default value is NULL
-- the semester fee the student has paid
semester_fee		DECIMAL(6,2) UNSIGNED DEFAULT 3000, 	-- valid values are 0 to 9999.99, default value is 3000
-- is the student a domestic student
domestic_student	ENUM('Yes','No','Y','N') DEFAULT 'Yes' 	-- valid values are listed in the list, default value is Yes
);

-- show the table(s) in the database
SHOW TABLES;

-- display the structure of the table
DESC student_information;

-- insert records/rows in the table
-- no field list - have to insert all values
INSERT INTO student_information
VALUES
('1234567890', 'Anju Chawla', 'anju.chawla@georgiancollege.ca', '1998-10-10', 21, 5400.25,'No');

-- providing a complete field list - have to insert all values
INSERT INTO student_information(student_id, student_name, student_email, date_of_birth, age, semester_fee, domestic_student)
VALUES 
('2345678901', 'Ross Bigelow', 'ross.bigelow@georgiancollege.ca', '1995-12-11', 24, 1200,'Yes' );

-- providing a complete field list in a different order 
INSERT INTO student_information(student_id, student_email, student_name, date_of_birth, age, semester_fee, domestic_student)
VALUES 
('2345678911', 'rich.freeman@georgiancollege.ca','Rich Freeman',  '1990-2-11', 40, 1200, 'Yes' );


-- providing a  field list - data for not null fields MUST be provided; other fields will default to null or default values if provided
INSERT INTO student_information(student_id, student_name)
VALUES 
('3456789012', 'Jaret Wright');

-- providing a field list - have to insert values in the order of the fields in the list and notice the ' in the name
INSERT INTO student_information(student_id, student_name, student_email, date_of_birth, age, semester_fee, domestic_student)
VALUES 
('2345678922', 'Mike O\'Connor', 'mike.connor@georgiancollege.ca', '2000-06-25', 19, 1200,'Yes' );

-- providing a field list - yes, I can put NULL as a value in any field that does not have the NOT NULL qualifier
-- NUll(case does not matter) is a special 'undefined' value
-- DEFAULT can be used as a 'value' - it just plugs in the default value for that field, if defined. If no default is defined
-- and the field does not have NOT NULL, then the default value is null
-- you cannot put a NULL value in a field that has the NOT NULL qualifier 
INSERT INTO student_information(student_id, student_name, student_email, date_of_birth, age, semester_fee, domestic_student)
VALUES 
('2345678923', 'Wayne Brown', NULL, NULL, NULL, NULL, DEFAULT );

/*
-- This will give an error since student id is a unique field; the student_id 2345678901 has been used for a previous insert
INSERT INTO student_information(student_id, student_name, student_email, date_of_birth, age, semester_fee, domestic_student)
VALUES 
('2345678901','Ian McWilliam', 'Ian.McWilliam@georgiancollege.ca', '1995-12-11', 24, 1200,'Yes' );

-- This will give an error since student email is a unique field; this student email has been used
INSERT INTO student_information(student_id, student_name, student_email, date_of_birth, age, semester_fee, domestic_student)
VALUES 
('2345678933','Scott McCrindle', 'Ross.Bigelow@georgiancollege.ca', '1994-10-10', 24, 1200,'Yes' );

-- This will give an error since MUST provide student id, a NOT NULL field
INSERT INTO student_information(student_name, student_email, date_of_birth, age, semester_fee, domestic_student)
VALUES 
('Ross Bigelow', 'ross.bigelow@georgiancollege.ca', '1995-12-11', 24, 1200,'Yes' );

-- This will give an error since MUST provide student name, a NOT NULL field
INSERT INTO student_information(student_id, student_email, date_of_birth, age, semester_fee, domestic_student)
VALUES 
('2345678901', 'ross.bigelow@georgiancollege.ca', '1995-12-11', 24, 1200,'Yes' );

-- This will give an error since student name is a NOT NULL field, contain contain NULL
-- NULL is a special value which means 'does not exist' , do not put it in quotes like 'Null', it is then just a string and becomes the name of the student, though a 'strange' name and you will not get an error
INSERT INTO student_information(student_id, student_name, student_email, date_of_birth, age, semester_fee, domestic_student)
VALUES 
('2345678901',NULL, 'ross.bigelow@georgiancollege.ca', '1995-12-11', 24, 1200,'Yes' );


-- This will give an error since semester fee is > 9999.99, out of range
INSERT INTO student_information(student_id, student_name, student_email, date_of_birth, age, semester_fee, domestic_student)
VALUES 
('2345678901', 'Ross Bigelow', 'ross.bigelow@georgiancollege.ca', '1995-12-11', 24, 12000,'Yes' );

-- This will give an error since incorrect enumerated constant for domestic_student field
INSERT INTO student_information(student_id, student_name, student_email, date_of_birth, age, semester_fee, domestic_student)
VALUES 
('2345678901', 'Ross Bigelow', 'ross.bigelow@georgiancollege.ca', '1995-12-11', 24, 1200,'hello');

-- This will give an error since incorrect value for date_of_birth
INSERT INTO student_information(student_id, student_name, student_email, date_of_birth, age, semester_fee, domestic_student)
VALUES 
('2345678901', 'Ross Bigelow', 'ross.bigelow@georgiancollege.ca', '1995-22-11', 24, 1200,'Yes' );

*/
-- display all records in the table, the * means display all columns
SELECT * FROM student_information;