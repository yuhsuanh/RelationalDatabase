/*
Name: Yu-Hsuan Huang
Date: May 21, 2020
Purpose: create a databse and make it active
*/

#Drop database if exists
DROP DATABASE IF EXISTS georgian_college;

#Create database
CREATE DATABASE georgian_college;
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

#Insert records/rows in the table
#No field list - have to insert all values
INSERT INTO student_information
VALUE ('200443723', 'Yu-Hsuan Huang', '200443723@student.georgianc.on.ca', '2000-01-01', 40, 8888.88, 'N');

#Provide all field lis - have to insert all values by name order
INSERT INTO student_information (
	student_id,
    student_name,
    student_email,
    date_of_birth,
    age,
    semester_fee,
    domestic_student
) VALUE (
	'200443123',
    'Sean Lee',
    '200443123@student.georgianc.on.ca',
    '2000-01-02',
    30,
    6666.66,
    'Yes'
);

#Provide a field list - data for not null must be provided, other fields will default to null or default value
INSERT INTO student_information (
	student_id,
    student_name
) VALUE (
	'200443987',
    'Winnie Lai'
);

#Privide a field list - have to insert values in the order of the fields in the list and notice ' in the name
INSERT INTO student_information (
	student_id,
    student_name,
    student_email,
    date_of_birth
) VALUE (
	'200123456',
    'Joseph Gray',
    '200123456@student.georgianc.on.ca',
    '2000-01-03'
);

#Provide a field list - put null to not null fields or put default to have deafult value fields
INSERT INTO student_information (
	student_id,
    student_name,
    student_email,
    date_of_birth,
    age,
    semester_fee,
    domestic_student
) VALUE (
	'200888666',
    'Isaac Brown',
    NULL,
    NULL,
    NULL,
    NULL,
    DEFAULT
);

#Select all data int the table
SELECT * FROM student_information;