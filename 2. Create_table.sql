/*
Name: Yu-Hsuan Huang
Date: May 21, 2020
Purpose: create a databse and make it active
*/

#Create database
CREATE DATABASE IF NOT EXISTS georgian_college;
#Use database
USE georgian_college;

#Drop table
DROP TABLE IF EXISTS student_information;

#Create table structure - the fields and their types, to store student information
CREATE TABLE student_information (
	student_id CHAR(10) PRIMARY KEY, -- Primary key must unique and not null
    student_name VARCHAR(50) NOT NULL,
    student_email  VARCHAR(50) UNIQUE,
    date_of_birth	DATE,
    age TINYINT UNSIGNED, -- it means no negative value so value is from 0 to 255
    semester_fee DECIMAL(6, 2) DEFAULT 3000, -- it means value is from 0.00 to 9999.99 (first arg is total digits, secont arg is decimal digits)
    domestic_student ENUM('Yes', 'No', 'Y', 'N') DEFAULT 'N' -- CHAR(3)
);

#Show the table(s) in your database
SHOW TABLES;

#Display the structure of the table
DESC student_information;
