/*
	Author: 
		200443723 - Yu-Hsuan Huang
		200443124 - Misha Wali
	Date: 
		June 3rd, 2020
	Topic:
		Assignment 1a - Class registration
	Description:
		1. Create and drop database (if exists / if not exists)
		2. Create table
		3. Display structure of the table
		4. Insert records in different ways
		5. Display all records in the table
*/


# a)	Drop a database if it exists
DROP DATABASE IF EXISTS college;

# a)	create a database by the same name and use it.
CREATE DATABASE college;

#Use database
USE college;


/*
	b)	Create a table therein that stores relevant information about an entity of your choice
	Choose relevant fields of BEST FIT to store data pertaining to that entity. Comment the purpose of each field.

	Ensure that the table has at least:
	(O)i.			a primary key field
	(O)ii.		a field of type varchar
	(O)iii.		a field of type char
	(O)iv.		a field of type float or double, unsigned
	(O)v.			a field of type smallint, unsigned
	(O)vi.		a field of enumerated data type
	(O)vii.		a field of date data type
	(O)viii.	at least one field that cannot contain a null value
	(O)ix.		at least one field has a relevant default value
*/
CREATE TABLE class_registration (
	course_id			CHAR(5) PRIMARY KEY, -- Course ID 5 character code
	course_code			CHAR(4) NOT NULL, -- Course code: like COMP, COMM, MATH, BUSI, ECON...
	course_number		CHAR(4) NOT NULL, -- Course number 4 character code
	course_title		VARCHAR(100) NOT NULL, -- Course title 
	campus				VARCHAR(20) DEFAULT 'Barrie',
	credits 			FLOAT(3, 2) NOT NULL,
	capacity			SMALLINT UNSIGNED DEFAULT 500, -- capacity of this course (I know it doesn't make sense but it seems no any fields need integer type in class registration)
	day_of_week			ENUM('Mon', 'Tues', 'Wed', 'Thur', 'Fri'),
	date_of_start		DATE,
	date_of_end			DATE,
	classroom			VARCHAR(10), -- Classroom or Online
	instructor_name		VARCHAR(50) NOT NULL
);


# c)	Display the structure of the table
DESC class_registration;


# d)	Populate the table with relevant data, at least 10 records. Text/string data in quotes and numeric without quotes  please.
# Record 1-5
INSERT INTO class_registration 
VALUE
	('11256', 'COMP', '2003', 'Relational Database', 'Barrie', 3.00, DEFAULT, 'Fri', '2020-05-22', '2020-08-07', 'K-324', 'Anju K. Chawla'),
	('11257', 'COMM', '1017', 'Work Environment Comm', DEFAULT, 1.50, 500, 'Fri', '2020-05-22', '2020-08-07', 'H-211', 'Tracey A. Bedford'),
	('11258', 'COMP', '1098', '.NET Programming using C#', 'Orillia', 3.00, 150, 'Mon', '2020-05-18', '2020-08-03', 'H-227', 'Kevin Li'),
	('11259', 'ENTR', '1002', 'Intro to Entrepreneurship', 'Midland', 1.00, 250, 'Tues', '2020-05-19', '2020-08-04', 'H-227', 'John Pickard'),
	('11260', 'COMP', '1008', 'Intro Obj Oriented Prog-Java', NULL, 3.00, 1500, 'Wed', '2020-05-20', '2020-08-05', 'Online', 'Radhika Sharma');
# Record 6.
INSERT INTO class_registration (course_id, course_code, course_number, course_title, credits, capacity, day_of_week, date_of_start, date_of_end, classroom, instructor_name)
	VALUE ('12345', 'COMP', '1006', 'Intro to Web Prog using PHP', 3.00, 50, 'Thur', '2020-05-21', '2020-08-06', 'Online', 'Albert Villaruz');
# Record 7-11
INSERT INTO class_registration (course_id, course_code, course_number, course_title, campus, credits, capacity, day_of_week, instructor_name)
VALUES
	('30741', 'COMP', '1035', 'Networking Essentials', 'Toronto', 3.00, 250, 'Mon', 'Ali Ershad-Manesh'),
	('30742', 'CPHR', '0001', 'Co-op and Career Preparation', DEFAULT, 0.00, 2500, 'Tues', 'Beth Salt'),
	('30743', 'MATH', '1003', 'Math for the Computer Industry', 'Barrie', 1.50, 35,  'Tues', 'Linda S. Kettle'),
	('30744', 'COMP', '1030', 'Programming Fundamentals', 'Toronto', 3.00, 45, 'Wed', 'Wayne Brown'),
	('30745', 'COMM', '1016', 'Communication Essentials', 'Marham', 1.25, DEFAULT, 'Thur', 'Lori E. Hallahan');
# Record 12.
INSERT INTO class_registration (course_id, course_code, course_number, course_title, campus, credits, capacity, day_of_week, date_of_start, date_of_end, classroom, instructor_name)
	VALUE ('12400', 'COMP', '1045', 'Internet of Things - Arduino', NULL, 3.00, 3000, 'Thur', NULL, NULL, 'Online', 'Matthew Wilson');
# Record 13.
INSERT INTO class_registration 
	VALUE ('12500', 'COMP', '1002', 'HTML, CSS, & JS Fund.', 'Oakville', 3.00,  DEFAULT, 'Fri', '2020-01-10', '2020-04-17', 'A-224','Julie-Ann C. Snache');


# e)	Add a SELECT statement to display the data in the table.
SELECT * FROM class_registration ORDER BY course_id ASC;
