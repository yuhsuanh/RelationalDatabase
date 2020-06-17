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

/*
I want to see at least 15 SELECT statements, satisfying the criterion given below. A statement can include one or more than one criteria.

	(O) i.		An exact match involving character data – recollect does not involve wildcard characters, like % and _
	(O) ii.		Use of NOT LIKE comparison operator, for an inexact match, using wildcard character %
	(O) iii.		Use of NOT LIKE comparison operator, for an inexact match, using wildcard character _
	(O) iv.		Use of at least two relational operator (>, < >=, <=, <>, !=) in the same or different statements
	(O) v.		Use of all Boolean operators (AND, OR, NOT) in the same or different statements
	(O) vi.		Use of the BETWEEN comparison operator
	(O) vii.		Use of a string function
	(O) viii.	Use of a numeric function
	(O) ix.		Use of IN() or NOT IN() comparison function
	(O) x.		Use of display/alias names
	(O) xi.		Displaying only some fields 
	(O) xii.		Displaying all fields of the table
	(O) xiii.	Use of order by using ASC
	(O) xiv.		Use of order by using DESC
	(O) xv.		Order by more than one fields
	(O) xvi.		Use of limit clause displaying some records including record 1
	(O) xvii.	 Use of limit clause displaying some records in the table, not including record 1
*/


# Use college database/schema
USE college;

# Display all records
SELECT * FROM class_registration;

# i. Display course which instructor name match 'Anju K. Chawla'
SELECT *
FROM class_registration
WHERE instructor_name = 'Anju K. Chawla';

# ii. Display the course which course title not start with 'Intro' string.
SELECT * 
FROM class_registration
WHERE NOT course_title LIKE 'Intro%';

# iii. Display the course which course code not start with 'COM' string and any character in the last character.
SELECT * 
FROM class_registration
WHERE NOT course_code LIKE 'COM_';


# iv. Display the course which capacity greater than 30 and capacity less than 100;
SELECT * 
FROM class_registration
WHERE capacity > 30 AND capacity < 100;

# v. Display the course which course code equals 'COMP' or 'COMM' and campus not at 'Barrie';
SELECT * 
FROM class_registration
WHERE (course_code = 'COMP' OR course_code = 'COMM') AND (NOT campus = 'Barrie');


# vi. Display the course which course title between start with 'A' character and end with 'I' character (incude course title equal 'I')
SELECT *
FROM class_registration
WHERE course_title BETWEEN 'A' AND 'I';

# vii. Display the course which starting three of course title characters match 'Int'.
SELECT *
FROM class_registration
WHERE LEFT(course_title, 3) = TRIM('      Int     ');

# viii. Display the course which credits round to 0 decimal place is greater than or equal to 2
SELECT *
FROM class_registration
WHERE ROUND(credits, 0) >= 2;

# ix. Display the course which campus not at 'Toronto' or 'Orillia'
SELECT *
FROM class_registration
WHERE campus IN ('Toronto', 'Orillia');

# x.  Display thw course which field name use display/alias name: (1) Using 'AS' & single quote, (2) Not using 'AS' & single quote, (3) Using 'AS' & not using single quote, (4) Not using 'AS' & not usgin single quote
# xi. Display only 6 fields in this query: course_id, course_code, course_number, course_title, campus, instructor_name
SELECT course_id AS 'ID', course_code AS 'Course Code', course_number 'Course Number', course_title AS Title, campus Campus, instructor_name 'Instructor Name'
FROM class_registration
WHERE campus IN ('Toronto', 'Orillia');

# xii. Display the course which only all fields in this query
SELECT course_id, course_code, course_number, course_title, campus, credits, capacity, day_of_week, date_of_start, date_of_end, classroom, instructor_name
FROM class_registration
WHERE campus IN ('Toronto', 'Orillia');

# xiii. using course code in descending order.
# xiv. using course number in ascending order.
# xv. Display all courses by course code in descending order and in there by course number by ascending order
SELECT *
FROM class_registration
ORDER BY course_code DESC, course_number ASC;

# Display all courses by course code in descending order and in there by course number by ascending order
# xvi. Display the first five records
SELECT *
FROM class_registration
ORDER BY course_code DESC, course_number ASC
LIMIT 0,5;

# Display all courses by course code in descending order and in there by course number by ascending order
# xvi. Display the fourth eight records
SELECT *
FROM class_registration
ORDER BY course_code DESC, course_number ASC
LIMIT 3,8;