/*
	Author: 
		200443723 - Yu-Hsuan Huang
		200443124 - Misha Wali
	Date: 
		July 7, 2020
	Topic:
		Class registration
	Description:
		Assignment 2a - Multi-table 
			Create a new relevant table to the old table.
*/

/*
	1)	The new table should at least have 5 relevant fields. Choose the CORRECT BEST FIT data types and other properties (not null, default etc) depending on the data to be stored in the fields. Comment the PURPOSE of each field.
	2)	Both tables must be in Second Normal Form/2NF. Put the definitions of  First Normal Form/1NF and Second Normal Form/2NF in comments and justify that the two tables are in 2NF.
	3)	The new table must have a foreign key that references a field (preferably primary key) of the old table. You can have more than one foreign keys in the new table, if required. You may ‘reverse’ this requirement. The old table can have a foreign key instead referring to a field (preferably primary key) of the new table. The aim is that the two tables are ‘related’ via foreign key(s). You will not be able to do the following sub assignments if the tables are not ‘related’.
	4)	Clearly ‘comment’ the type of relationship (1-1, 1-m, m-m) between the two tables.
	5)	Display the structure of the new table.
	6)	Populate the table with relevant data, at least 10 records. Ensure that you have the set the sql_mode to “STRICT_ALL_TABLES” to catch data input errors. Important Note: Use literal text data in quotes, numeric data without quotes and date in a consistent format of your choice. You will lose marks if you do not follow this instruction.
	7)	Add a SELECT statement to display the records of the new table.
*/

-- Set environment
SET SQL_MODE = "STRICT_ALL_TABLES";
SET DEFAULT_STORAGE_ENGINE =  INNODB;

# Drop a database if it exists
DROP DATABASE IF EXISTS college;

# create a database by the same name and use it.
CREATE DATABASE college;

# Use database
USE college;


/*
	What is 1NF (First Normal Form) ?
		For the first normal form, it should follow the following 4 rules:
		1. It should only have single(atomic) valued attributes/columns.
		2. Values stored in a column should be of the same domain
		3. All the columns in a table should have unique names.
		4. And the order in which data is stored, does not matter.

	What is 2NF (Second Normal Form) ?
		For the second normal form, it should follow the following 2 rules:
		1. It should be in the First Normal form.
		2. And, it should not have Partial Dependency.
*/


# Drop a table if it exists
DROP TABLE IF EXISTS instructor;

# Create a new table which store instructor information
CREATE TABLE instructor (
	instructor_id			INT AUTO_INCREMENT PRIMARY KEY, -- Instructor id
    instructor_first_name	VARCHAR(50) NOT NULL, -- Instructor first name
    instructor_last_name	VARCHAR(50) NOT NULL, -- Instructor last name
	contact_phone			CHAR(10) UNIQUE NOT NULL, -- Instructor's phone number
    contact_email			VARCHAR(100) NOT NULL -- Instructor's email
);

# Insert new data to instructor table
INSERT INTO instructor (instructor_first_name, instructor_last_name, contact_phone, contact_email)
VALUES
 	('Albert', 'Villaruz', '6478888888', 'Albert.Villaruz@college.com'),
 	('John', 'Pickard', '6477405614', 'John.Pickard@college.com'),
	('Ali', 'Ershad-Manesh', '6475992610', 'Ali.Ershad.Manesh@college.com'),
	('Beth', 'Salt', '6471248643', 'Beth.Salt@college.com'),
	('Linda', 'Kettle', '6471394662', 'Linda.Kettle@college.com'),
	('Matthew', 'Wilson', '6473961995', 'Matthew.Wilson@college.com'),
	('Wayne', 'Brown', '6479361040', 'Wayne.Brown@college.com');

# Show table description
DESC instructor;

# Show table data
SELECT * FROM instructor;





# Drop a table if it exists
DROP TABLE IF EXISTS semester;

# Creste a new table which store semester information
CREATE TABLE semester (
	semester_id		INT AUTO_INCREMENT PRIMARY KEY, -- Semester id
	year 			CHAR(4) NOT NULL, -- Semester year
    term 			ENUM('Winter', 'Summer', 'Fall') NOT NULL, -- Semester term
    date_of_start 	DATE NOT NULL, -- Semester start date
    date_of_end		DATE NOT NULL, -- Semester end date
    
    UNIQUE KEY (year, term)
);

#INSERT new data to semester table
INSERT INTO semester (year, term, date_of_start, date_of_end)
VALUES
	('2019', 'Winter', '2019-01-03', '2019-04-20'),
	('2019', 'Summer', '2019-05-02', '2019-08-23'),
	('2019', 'Fall', '2019-09-04', '2019-12-21'),
	('2020', 'Winter', '2020-01-06', '2020-04-17'),
	('2020', 'Summer', '2020-05-15', '2020-08-16'),
	('2020', 'Fall', '2020-08-29', '2020-12-17');

# Show table description
DESC semester;


# Show table data
SELECT * FROM semester;





# Drop a table if it exists
DROP TABLE IF EXISTS student;

# Creste a new table which store student information
CREATE TABLE student (
	student_id CHAR(9) PRIMARY KEY, -- Student id number
	student_first_name VARCHAR(50) NOT NULL, -- Student first name
	student_last_name VARCHAR(50) NOT NULL, -- Student last name
	program VARCHAR(100) NOT NULL, -- Program which student taken
	contact_phone CHAR(10) UNIQUE NOT NULL, -- Student's phone number
	contact_email VARCHAR(100) NOT NULL -- Student's email
);

#INSERT new data to semester table
INSERT INTO student(student_id, student_first_name, student_last_name, program, contact_phone, contact_email)
VALUES
	('200123456', 'Bedford', 'Tracey', 'Computer Programming', '6472845516', 'Bedford.Tracey@student.college.com'),
	('200417415', 'Joseph', 'Reshma', 'Mobile Application Development', '6478870537', 'Joseph.Reshma@student.college.com'),
	('200471657', 'Jessica', 'Gosse', 'Business Administration', '6471631053', 'Jessica.Gosse@student.college.com'),
	('200471508', 'Mercedes', 'Brown', 'Computer Programming', '6479748941', 'Mercedes.Brown@student.college.com'),
	('200570749', 'Burak', 'Akcal', 'Big Data Analytics', '6471249640', 'Burak.Akcal@student.college.com');

# Show table description
DESC student;

# Show table data
SELECT * FROM student;





# Drop a table if it exists
DROP TABLE IF EXISTS course;

# Create a table which store course information
CREATE TABLE course (
	course_id			CHAR(5) PRIMARY KEY, -- Course ID 5 character code
	course_code			CHAR(4) NOT NULL, -- Course code: like COMP, COMM, MATH, BUSI, ECON...
	course_number		CHAR(4) NOT NULL, -- Course number 4 character code
	course_title		VARCHAR(100) NOT NULL, -- Course title 
	campus				ENUM('Barrie', 'Midland', 'Muskoka', 'Orillia', 'Orangeville', 'Owen Sound') DEFAULT 'Barrie', -- College campus
	credits 			FLOAT(3, 2) NOT NULL, -- Course credits
	capacity			SMALLINT UNSIGNED DEFAULT 500, -- Capacity of this course
	day_of_week			ENUM('Mon', 'Tues', 'Wed', 'Thur', 'Fri'), -- Course on which day of week
	classroom			VARCHAR(10), -- Classroom or Online
	semester_id		INT NOT NULL, -- Semester id
	instructor_id		INT NOT NULL, -- instructor id

	-- This table semester_id foreign key refers to the semester table primary key
	-- one to many (1-m)
	CONSTRAINT semester_id_fk1
  FOREIGN KEY (semester_id)
  REFERENCES semester(semester_id),

  -- This table instructor_id foreign key refers to the instructor table primary key
  -- one to many (1-m)
  CONSTRAINT instructor_id_fk1
  FOREIGN KEY (instructor_id)
  REFERENCES instructor(instructor_id)
  
);

#INSERT new data to course table
INSERT INTO course
VALUES
	('14387', 'MDEV', '1000', 'Application Design and Interfaces', 'Orillia', 3.00, 500, 'Mon', 'L-102', 3, 1),
	('12358', 'MDEV', '1014', 'Cross-platform Development', 'Orillia', 3.00, 125, 'Tues', 'Online', 3, 2),
	('38460', 'BUSI', '2005', 'Customer Service', 'Barrie', 1.25, 50, 'Wed', 'F-220', 3, 1),
	('37071', 'HURM', '1000', 'Human Resources Management Foundations', 'Barrie', 2.50, 75, 'Thur', 'C-118', 3, 4),
	('51749', 'ENTR', '1002', 'Introduction to Entrepreneurship', 'Barrie', 1.00, 1200, 'Fri', 'A-108', 3, 5),
	('57153', 'ENTR', '1002', 'Introduction to Entrepreneurship', 'Orillia', 1.00, 1200, 'Mon', 'B-123', 3, 6),
	('43912', 'COMP', '1030', 'Programming Fundamentals', 'Barrie', 3.00, 190, 'Tues', 'B-230', 3, 6),
	('40371', 'COMP', '3002', 'Advanced Databases', 'Barrie', 3.00, 100, 'Wed', 'C-218', 3, 7),
	('48104', 'COMP', '1045', 'Internet of Things using Arduino', 'Barrie', 3.00, 60, 'Thur', 'C-112', 3, 1),
	('41840', 'COMP', '1002', 'HTML, CSS, and JS Fundamentals', 'Barrie', 3.00, 670, 'Fri', 'D-101', 3, 3),
	('41740', 'COMP', '1006', 'Introduction to Web Programming using PHP', 'Barrie', 3.00, 250, 'Mon', 'Online', 3, 2),
	('29361', 'BDAT', '1001', 'Information Encoding Standards', 'Midland', 1.25, 265, 'Tues', 'G-111', 3, 7),
	('24710', 'BDAT', '1004', 'Data Programming', 'Midland', 3.00, 145, 'Wed', 'D-212', 3, 6),
	('22841', 'BDAT', '1006', 'Data Visualization', 'Midland', 3.00, 80, 'Thur', 'C-301', 3, 4),
	('91375', 'COMM', '1016', 'Communication Essentials', 'Barrie', 1.00, 2500, 'Fri', 'H-210', 3, 1),
	('94714', 'COMM', '1016', 'Communication Essentials', 'Midland', 1.00, 2500, 'Thur', 'H-104', 4, 2),
	('94715', 'COMM', '1016', 'Communication Essentials', 'Orillia', 1.00, 2500, 'Thur', 'A-106', 4, 3),
	('94716', 'COMM', '1016', 'Communication Essentials', 'Muskoka', 1.00, 2500, 'Thur', 'A-123', 5, 2),
	('94717', 'COMM', '1016', 'Communication Essentials', 'Orangeville', 1.00, 2500, 'Thur', 'B-131', 5, 2),
	('94718', 'COMM', '1016', 'Communication Essentials', 'Owen Sound', 1.00, 2500, 'Thur', 'A-112', 6, 2);

# Show table description
DESC course;

# Show table data
SELECT * FROM course;





# Drop a table if it exists
DROP TABLE IF EXISTS register;

# Creste a new table which store courses the student taken
CREATE TABLE register (
	register_id INT AUTO_INCREMENT PRIMARY KEY, -- Register id
	course_id CHAR(5), -- Course id
	student_id CHAR(9), -- Student id number

	-- This table course_id foreign key refers to the course table primary key
	-- one to many (1-m)
	CONSTRAINT course_id_fk_1
	FOREIGN KEY (course_id)
	REFERENCES course(course_id),

	-- This table student_id foreign key refers to the student table primary key
	-- one to many (1-m)
	CONSTRAINT student_id_fk_1
	FOREIGN KEY (student_id)
	REFERENCES student(student_id)

);

#INSERT new data to course table
INSERT INTO register (course_id, student_id)
VALUES
	('43912', '200123456'),
	('40371', '200123456'),
	('48104', '200123456'),
	('41840', '200123456'),
	('41740', '200123456'),
	('91375', '200123456'),
	('94714', '200123456'),
	('14387', '200417415'),
	('12358', '200417415'),
	('94715', '200417415'),
	('94716', '200417415'),
	('38460', '200471657'),
	('37071', '200471657'),
	('51749', '200471657'),
	('57153', '200471508'),
	('43912', '200471508'),
	('40371', '200471508'),
	('48104', '200471508'),
	('41840', '200471508'),
	('41740', '200471508'),
	('29361', '200570749'),
	('24710', '200570749'),
	('22841', '200570749'),
	('91375', '200570749'),
	('94714', '200570749');

# Show table description
DESC register;

# Show table data
SELECT * FROM register;




# Query - 1
# Student table natural join(if have same column name and same condition) register table
SELECT *
FROM student NATURAL JOIN register;

# Only get student id, student name and course id fields
SELECT student.student_id `student id`, CONCAT(student.student_first_name, student.student_last_name) name , register.course_id `course id`
FROM student NATURAL JOIN register;

# Register table continue natural join course table (show course name)
SELECT student.student_id, CONCAT(student.student_first_name, student.student_last_name) name , course.course_title course
FROM student NATURAL JOIN register NATURAL JOIN course;


# Query - 2
# Course table natural join instructor table
SELECT *
FROM course NATURAL JOIN instructor;

# Only show course code, title and instructor name
SELECT CONCAT(c.course_code, c.course_number) `course code`, c.course_title `title`, CONCAT(i.instructor_first_name, i.instructor_last_name) `instructor name`
FROM course c NATURAL JOIN instructor i;

# Also join semester table to show each course's semester
SELECT CONCAT(s.year, ' ',s.term) `semester`, CONCAT(c.course_code, c.course_number) `course code`, c.course_title `title`, CONCAT(i.instructor_first_name, i.instructor_last_name) `instructor name`
FROM course c NATURAL JOIN instructor i NATURAL JOIN semester s
ORDER BY semester;


# Query - 3
# Show instructor's course
SELECT *
FROM instructor i LEFT JOIN course c
ON i.instructor_id = c.instructor_id;

# Show instructor's course. only show instructor name and course title
SELECT CONCAT(i.instructor_first_name, i.instructor_last_name) `instructor name`, c.course_title `course`
FROM instructor i LEFT JOIN course c
ON i.instructor_id = c.instructor_id;
