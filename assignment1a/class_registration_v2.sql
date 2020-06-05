/*
	Author: 
		200443723 - Yu-Hsuan Huang
		200443124 - Misha Wali
	Date: 
		May 29th, 2020
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
DROP DATABASE IF EXISTS georgian_college;

# a)	create a database by the same name and use it.
CREATE DATABASE georgian_college;

#Use database
USE georgian_college;


/*
	b)	Create a table therein that stores relevant information about an entity of your choice
	Choose relevant fields of BEST FIT to store data pertaining to that entity. Comment the purpose of each field.

	Ensure that the table has at least:
	i.	a primary key field
	ii.	a field of type varchar
	iii.	a field of type char
	iv.	a field of type float or double, unsigned
	v.	a field of type smallint, unsigned
	vi.	a field of enumerated data type
	vii.	a field of date data type
	viii.	at least one field that cannot contain a null value
	ix.	at least one field has a relevant default value
*/
CREATE TABLE class_registration (
	course_crn			SMALLINT UNSIGNED PRIMARY KEY, -- from 0 to 65535 (AUTO_INCREMENT)
	course_code		    CHAR(4) NOT NULL,
	course_number		CHAR(4) NOT NULL, -- from 0 to 65535
	course_title		VARCHAR(100) NOT NULL,
	campus				VARCHAR(20) DEFAULT 'Barrie',
	credits 			TINYINT UNSIGNED,
	day_of_week			ENUM('Mon', 'Tues', 'Wed', 'Thur', 'Fri'),
	time_of_day			VARCHAR(50),
	date_of_start		DATE,
	date_of_end			DATE,
	classroom			CHAR(10) NOT NULL,
	instructor_name		VARCHAR(50) NOT NULL
);

# c)	Display the structure of the table
DESC class_registration;

# d)	Populate the table with relevant data, at least 10 records. Text/string data in quotes and numeric without quotes  please.
# Record 1.
INSERT INTO class_registration 
	VALUE (30786, 'COMP', '2003', 'Relational Database', 'Barrie', 3.000, 'Fri', '11:00 am - 1:50 pm', '2020-05-22', '2020-08-07', 'K-324', 'Anju K. Chawla');
# Record 2.
INSERT INTO class_registration (course_crn, course_code, course_number, course_title, instructor_name)
	VALUE (30730, 'COMM', '1017', 'Work Environment Comm', 'Tracey A. Bedford');
# Record 3.
INSERT INTO class_registration (course_crn, course_code, course_number, course_title, campus, credits, instructor_name)
	VALUE (30782, 'COMP', '1098', '.NET Programming using C#',  DEFAULT, 3.000, 'Tracey A. Bedford');
# Record 4.
INSERT INTO class_registration (course_crn, course_code, course_number, course_title, campus, credits, day_of_week, time_of_day, instructor_name)
	VALUE (31006, 'ENTR', '1002', 'Intro to Entrepreneurship',  DEFAULT, 3.000, 'Tues', '8:00 am - 10:50 am', 'John Pickard');
# Record 5.
INSERT INTO class_registration (course_crn, course_code, course_number, course_title, campus, credits, day_of_week, time_of_day, date_of_start, date_of_end,  instructor_name)
	VALUE (30746, 'COMP', '1008', 'Intro Obj Oriented Prog-Java', DEFAULT, 3.000, 'Wed', '10:00 am - 12:50 pm', '2020-05-20', '2020-08-05', 'Radhika Sharma');
# Record 6.
INSERT INTO class_registration (course_crn, course_code, course_number, course_title, campus, credits, day_of_week, time_of_day, date_of_start, date_of_end, classroom, instructor_name)
	VALUE (30743, 'COMP', '1006', 'Intro to Web Prog using PHP', 'Barrie', 3.000, 'Thur', '11:00 am - 1:50 pm', '2020-05-21', '2020-08-06', 'Online', 'Albert Villaruz');
# Record 7.
INSERT INTO class_registration (course_crn, course_code, course_number, course_title, campus, credits, day_of_week, time_of_day, date_of_start, date_of_end, classroom, instructor_name)
	VALUE (23370, 'COMP', '1035', 'Networking Essentials', DEFAULT, NULL, NULL, NULL, NULL, NULL, 'E-002', 'Ali Ershad-Manesh');
# Record 8.
INSERT INTO class_registration (course_crn, course_code, course_number, course_title,  campus, credits, day_of_week, time_of_day, classroom,  instructor_name)
	VALUE (23373, 'CPHR', '0001', 'Co-op and Career Preparation', DEFAULT, 0.000, 'Tues', NULL, 'A-119',  'Beth Salt');
# Record 9.
INSERT INTO class_registration (course_crn, course_code, course_number, course_title, campus, classroom, instructor_name)
	VALUE (23372, 'MATH', '1003', 'Math for the Computer Industry', 'Barrie', 'H-113', 'Linda S. Kettle');
# Record 10.
INSERT INTO class_registration (course_crn, course_code, course_number, course_title, campus, credits, classroom, instructor_name)
	VALUE (23369, 'COMP', '1030', 'Programming Fundamentals', DEFAULT, 3.00, NULL,'Wayne Brown');
# Record 11.
INSERT INTO class_registration (course_crn, course_code, course_number, course_title, day_of_week, time_of_day, date_of_start, date_of_end, classroom, instructor_name)
	VALUE (21148, 'COMM', '1016', 'Communication Essentials', NULL, NULL, NULL, NULL, 'K-219', 'Lori E. Hallahan');
# Record 12.
INSERT INTO class_registration (course_crn, course_code, course_number, course_title, campus, credits, day_of_week, time_of_day, date_of_start, date_of_end, classroom, instructor_name)
	VALUE (23371, 'COMP', '1045', 'Internet of Things - Arduino', DEFAULT, 3.000, 'Thur', '11:00 am - 1:50 pm', NULL, NULL, 'K-324','Matthew Wilson');
# Record 13.
INSERT INTO class_registration 
	VALUE (23368, 'COMP', '1002', 'HTML, CSS, & JS Fund.', DEFAULT, 3.000, 'Fri', '11:00 am - 1:50 pm', '2020-01-10', '2020-04-17', 'A-224', 'Julie-Ann C. Snache');

# e)	Add a SELECT statement to display the data in the table.
SELECT * FROM class_registration ORDER BY course_crn ASC;
