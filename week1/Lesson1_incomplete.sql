/*
Name: Anju Chawla
Date: May, 2020
Purpose: Create a database and a table therein to store student information. 
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
