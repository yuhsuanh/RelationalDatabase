#Provide your name and today's date
/*
Name : Yu-Hsuan Huang
Date: 2020-06-23
Purpose: To create a database with a table therein  to store grades of students in various course_codes. Perform sone queries/analysis on the table data. 

*/

#drop existing database, if any. Recreate one by same name and use it.
DROP DATABASE IF EXISTS db_grade_center;
CREATE DATABASE db_grade_center;
USE db_grade_center;

#drop existing table, if any, by the same name
DROP TABLE IF EXISTS tbl_grade_center;

#create the table
CREATE TABLE tbl_grade_center
    (
      id 				INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
      first_name  		VARCHAR(30) NOT NULL,
      last_name   		VARCHAR(30) NOT NULL,
      student_number 	CHAR(10) NOT NULL,
      course_code      	CHAR(8) NOT NULL,
      grade       		TINYINT UNSIGNED NOT NULL DEFAULT 0
    );
    
#decribe the table structure
DESC tbl_grade_center;

#insert records in the table
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course_code, grade) VALUES ('Phineas', 'Flynn', '1234510001','COMP2003', 88);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course_code, grade) VALUES ('Ferb', 'Fletcher', '1234510002','COMP2003', 100);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course_code, grade) VALUES ('Candace','Fletcher', '1234510003','COMP2003', 60);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course_code, grade) VALUES ('Baljeet', ' ', '1234510004','COMP2003', 100);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course_code, grade) VALUES ('Major', 'Monogram ', '1234510005','COMP2003', 50);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course_code, grade) VALUES ('Dr.', 'Doofenshmirtz', '1234510006','COMP2003', 55);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course_code, grade) VALUES ('Isabella', 'Garcia-Shapiro', '1234510007','COMP2003', 90);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course_code, grade) VALUES ('Phineas', 'Flynn', '1234510001','COMP2008', 79);
INSERT INTO tbl_grade_center (first_name, last_name, student_number, course_code, grade)VALUES ('Ferb', 'Fletcher', '1234510002','COMP2008', 100);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course_code, grade) VALUES ('Candace', 'Fletcher', '1234510003','COMP2008', 72);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course_code, grade) VALUES ('Baljeet', ' ', '1234510004','COMP2008', 100);
INSERT INTO tbl_grade_center (first_name, last_name, student_number, course_code, grade)VALUES ('Major', 'Monogram ', '1234510005','COMP2008', 52);
INSERT INTO tbl_grade_center (first_name, last_name, student_number, course_code, grade)VALUES ('Dr.', 'Doofenshmirtz', '1234510006','COMP2008', 78);
INSERT INTO tbl_grade_center (first_name, last_name, student_number, course_code, grade)VALUES ('Isabella', 'Garcia-Shapiro', '1234510007','COMP2008', 88);
INSERT INTO tbl_grade_center (first_name, last_name, student_number, course_code, grade)VALUES ('Anju', 'Chawla', '1234567890','COMP2008', 88);

#show all records of the table
SELECT * FROM tbl_grade_center;

#Complete the following queries now. NO REDUNDANT CODE please. 

#1. Display information of all students who have achieved the lowest grade scored in COMP2008 - display the full name (first name and  last name together) and grade. 
#   Display the records in descending order of full name. No peeking in the data. Hint: First find the lowest grade and then use it to find the students who scored the lowest grade.
-- Method 1
SET @min_grade = (SELECT MIN(grade) FROM tbl_grade_center WHERE course_code = 'COMP2008');
SELECT CONCAT(first_name,' ', last_name) as full_name, grade
FROM tbl_grade_center
WHERE course_code = 'COMP2008' AND grade = @min_grade
ORDER BY 1 DESC;
-- Method 2
SELECT CONCAT(first_name,' ', last_name) as full_name, grade
FROM tbl_grade_center
WHERE course_code = 'COMP2008' AND grade = (SELECT MIN(grade) FROM tbl_grade_center WHERE course_code = 'COMP2008')
ORDER BY full_name DESC;


#2. List the students(no repetitions please) by student number, first and last name , that have any grade in the range 50 to 59, limits inclusive. Display the result in ascending order of student number.
SELECT student_number, first_name, last_name
FROM tbl_grade_center
WHERE grade BETWEEN 50 AND 59
GROUP BY student_number
ORDER BY student_number;


#3. Display the highest grade and the number of students that have achieved the highest grade in COMP 2003. The column headings should be clear and complete, showing the course code too. No peeking in the data. Hint: First find the highest grade in the course and then use it to find the number of students who scored the highest grade.
SELECT course_code, COUNT(*) max_grade_amount
FROM tbl_grade_center
WHERE course_code = 'COMP2003' AND grade = (SELECT MAX(grade) FROM tbl_grade_center WHERE course_code = 'COMP2003');


#4 Display the course code and the number of students enrolled in it, only for those courses that have at least 5 students enrolled in it, in ascending order of the number of students enrolled. Give appropriate display headings. 
SELECT course_code, COUNT(student_number)
FROM tbl_grade_center
GROUP BY course_code
HAVING COUNT(course_code) >= 5;


#5 Find the average mark for each distinct course -  display the course_code and the average mark, rounded to an integer, with proper display headings. For example, 92.6 will round to 97 and 92.4 will round to 92 
SELECT course_code, ROUND(AVG(grade), 0)
FROM tbl_grade_center
GROUP BY course_code;