/*
	Author: 
		200443723 - Yu-Hsuan Huang
		200443124 - Misha Wali
	Date: 
		June 3rd, 2020
	Topic & Purpose:
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
		June 5th, 2020
	Topic & Purpose:
		Assignment 1b - Class registration
	Description:
		Useing different query statement to get the record(s)
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


/*
	Author: 
		200443723 - Yu-Hsuan Huang
		200443124 - Misha Wali
	Date: 
		June 11th, 2020
	Topic & Purpose:
		Assignment 1c - Class registration
	Description:
		Update record(s) and Delete record(s)
*/
/*
 	UPDATE RECORD(S)
 	(O) 1.	Only one column is updated in a single record using the primary key
	(O) 2.	Only one column is updated in some, but not all, records
	(O) 3.	One update statement only to set more than one column/field in a single record without using the primary key 
	(O) 4.	One update statement only to set more than one column/field in some, but not all, records
	(O) 5.	One or more fields/columns are updated in ALL records
	(O) 6.	SET involves a mathematical operation
	(O) 7.	SET sets a field value to NULL of one or more, but not all records (obviously, this field cannot be defined with NOT NULL in its definition) Note: If you do not have a NOT NULL field, just change the definition of a relevant field by removing NOT NULL and leave a comment for me that you changed it for this update.
	(O) 8.	A statement with SET, WHERE, ORDER BY and LIMIT 
 */

# Use college database/schema
USE college;

# Set the environment variables
SET SQL_SAFE_UPDATES = 0;


# 1. Course_id is '30741' changes classroom to 'E-002' (1 row affected)
UPDATE class_registration
SET classroom = 'E-002'
WHERE course_id = '30741';

# 2. Course code is 'COMM' change credits to 1.75 (2 rows affected)
UPDATE class_registration
SET credits = 1.75
WHERE course_code = 'COMM';

# 3. Course code is 'CPHR' and course number is '0001' update date of start and date of end (1 row affected)
UPDATE class_registration
SET date_of_start = CAST('2020-01-06' AS DATE), date_of_end = CAST('2020-04-14' AS DATE)
WHERE course_code = 'CPHR' AND course_number = '0001';

# 4. Insert a record first. (1 row affected)
# Then, course code is 'COMP', course number is '1006' and instructor name is 'Albert Villaruz' change classromm to 'Online' and campus to null (2 rows affected)
INSERT INTO college.class_registration
VALUE ('12346','COMP','1006','Intro to Web Prog using PHP','Orillia','3.00','50','Thur','2020-05-21','2020-08-06','A-120','Albert Villaruz');

UPDATE class_registration
SET classroom = 'Online', campus = NULL
WHERE instructor_name = 'Albert Villaruz' AND course_code = 'COMP' AND course_number = '1006';

# 5. Change capacity to 250 for all course (14 totoal rows, 12 rows affected)
UPDATE class_registration
SET capacity = 250;

# 6. Course id is '30743' add one credit to course (1 row affected)
UPDATE class_registration
SET credits = credits + 1
WHERE course_id = '30743';

# 7. Course code is 'ENTR' or 'CPHR' change classroom, date_of_start and date_of_end to null (2 rows affected)
UPDATE class_registration
SET classroom = NULL, date_of_start = NULL, date_of_end = NULL
WHERE course_code = 'ENTR' OR course_code = 'CPHR';

# 8. Update first 3 course campus to 'Barrie', which course_code is 'COMP' and course id order by ascending order (3 total rows, 2 rows affecred)
UPDATE class_registration
SET campus = 'Barrie'
WHERE course_code = 'COMP'
ORDER BY course_id
LIMIT 3;

/*
	DELETE RECORD(S)
	(O) 9.	WHERE condition involves a compound condition, each simple condition using a relational operator
	(O) 10.	WHERE condition uses the NOT Boolean operator
	(O) 11.	WHERE condition uses BETWEEN with a DATE or CHAR/VARCHAR field
	(O) 12.	WHERE condition checks for NULL or NOT NULL on a certain field 
	(O) 13.	WHERE works with a DATE field data (do not forget to CAST the literal value) 
	(O) 14.	A statement with WHERE, ORDER BY and LIMIT 
*/

# 9. Delete course which cridits equal to 0 (1 row affected)
DELETE FROM class_registration
WHERE credits = 0;

# 10. Delete course which day of week not in 'tues', 'wed', 'thur', 'fri' (2 rows affected)
DELETE FROM class_registration
WHERE NOT day_of_week IN('Tues', 'Wed', 'Thur', 'Fri');

# 11. Delete course which course id between 12300 and 12399 (2 rows affected)
DELETE FROM class_registration
WHERE course_id BETWEEN '12300' AND '12399';

# 12. Delete course which campus is null (1 row affected)
DELETE FROM class_registration
WHERE campus IS NULL;

# 13. Delete course which date of start between 2020-01-01 and 2020-04-30 (1 row affected)
DELETE FROM class_registration
WHERE date_of_start BETWEEN CAST('2020-01-01' AS DATE) AND CAST('2020-04-30' AS DATE);

# 14. Delete 2 courses which campus equal to 'Barrie' and course id order by ascending order (2 rows affected)
DELETE FROM class_registration
WHERE campus = 'Barrie'
ORDER BY course_id
LIMIT 2;

/*
	Author: 
		200443723 - Yu-Hsuan Huang
		200443124 - Misha Wali
	Date: 
		June 19th, 2020
	Topic & Purpose:
		Assignment 1d - Class registration
	Description:
		Alter table 
*/
/*
	(O) 1.	At least one instance of the ‘Add Column’ to add a new field of type string – adding a new column is just like adding a field definition in the Create Table command. Ensure it has all the properties you need, for example NOT NULL etc. You may add more than one column if required, see following update requirement.
			(Now update the existing records to populate this new column(s) with relevant data using one or more string functions. Hint: You could always split an existing string field data into more than one fields, for example a name or address field.)
	(O) 2.	At least one instance of the ‘Modify Column’. Recall you have to rewrite all properties you want to keep, for example NOT NULL etc. Move the column to a different position too.
	(O) 3.	At least one instance of the ‘Change Column’. Recall you have to rewrite all properties you want to keep, for example NOT NULL etc. Move the column to a different position too.
	(O) 4.	At least one instance of the ‘Drop Column’ to drop an irrelevant field in the table. You could always drop the column that you have ‘split’ in requirement 2, since you are not losing any data. If you do not have any column to drop, add a ‘fake’ column and then drop it.
	(O) 5.	Just change the name of a field using the ‘Rename Column’ command.
	(O) 6.	Adding a UNIQUE constraint to one of the pre-existing fields or to a new field, not to be combined with requirements 1 to 3 above.
*/
USE college;
SET SQL_MODE="STRICT_ALL_TABLES";

# 1. Add column "coutse_name" to the class_registration table
-- Display columns
SHOW COLUMNS FROM class_registration;

-- Add coutse_name column
ALTER TABLE class_registration
ADD COLUMN coutse_name VARCHAR(150);

-- Display columns
SHOW COLUMNS FROM class_registration;

-- Display all data from the class_registration table
SELECT * FROM class_registration;

-- Update data to coutse_name field which combine yearm,course_code, course_number and course_title.
UPDATE class_registration
SET coutse_name = CONCAT(YEAR(CURDATE()), ' ', course_code, course_number, ' - ', course_title);

-- Display all data from the class_registration table
SELECT * FROM class_registration;

# 2. Modify column "day_of_week" to not null and move position to after date_of_end
-- Modify day_of_week column
ALTER TABLE class_registration
MODIFY COLUMN day_of_week ENUM('Mon', 'Tues', 'Wed', 'Thur', 'Fri') NOT NULL AFTER date_of_end;

-- Display columns
SHOW COLUMNS FROM class_registration;

# 3. Change column "coutse_name" to "course_display_name" and move position to after course_title
-- Change coutse_name column
ALTER TABLE class_registration
CHANGE COLUMN coutse_name course_display_name VARCHAR(150) NOT NULL AFTER course_title;

-- Display columns
SHOW COLUMNS FROM class_registration;

# 4. Drop column "course_display_name" which created in required 2.
-- Drop course_display_name column
ALTER TABLE class_registration
DROP COLUMN course_display_name;

-- Display columns
SHOW COLUMNS FROM class_registration;

# 5. Rename column "course_title" to "course_name"
-- Rename course_title colmun
ALTER TABLE class_registration
RENAME COLUMN course_title TO course_name;

-- Display columns
SHOW COLUMNS FROM class_registration;

# 6. Adding a UNIQUE constraint to instructor_name (We assume that each teacher can only instruct one course.)
-- Modify instructor_name column
ALTER TABLE class_registration
MODIFY COLUMN instructor_name VARCHAR(50) NOT NULL UNIQUE;

-- Display columns
SHOW COLUMNS FROM class_registration;
