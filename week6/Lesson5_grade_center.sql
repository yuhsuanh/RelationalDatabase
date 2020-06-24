/*
Name : Anju Chawla
Date: June 2020
Purpose: To create a database with a table therein  to store grades of students in various courses. Alter the table  to add a primary key 
to the table. Display a list of students who have scored 80% or higher in atleast two subjects. Further display the average mark of each student. 
*/

-- drop existing database, if any. Recreate one by same name and use it.
DROP DATABASE IF EXISTS db_grade_center;
CREATE DATABASE db_grade_center;
USE db_grade_center;

-- create the table structure to store information
CREATE TABLE tbl_grade_center
    (
      first_name  		VARCHAR(30) NOT NULL,
      last_name   		VARCHAR(30) NOT NULL,
      student_number 	CHAR(10) NOT NULL,
      course      		CHAR(8) NOT NULL,
      grade       		TINYINT UNSIGNED NOT NULL DEFAULT 0
      
      -- , PRIMARY KEY(student_number, course)
    );
    
-- decribe the table structure
DESC tbl_grade_center;

-- insert records in the table
INSERT INTO tbl_grade_center VALUES ('Phineas', 'Flynn', '1234510001','COMP2003', 88);
INSERT INTO tbl_grade_center VALUES ('Ferb', 'Fletcher', '1234510002','COMP2003', 100);
INSERT INTO tbl_grade_center VALUES ('Candace','Fletcher', '1234510003','COMP2003', 60);
INSERT INTO tbl_grade_center VALUES ('Baljeet', ' ', '1234510004','COMP2003', 100);
INSERT INTO tbl_grade_center VALUES ('Major', 'Monogram ', '1234510005','COMP2003', 50);
INSERT INTO tbl_grade_center VALUES ('Dr.', 'Doofenshmirtz', '1234510006','COMP2003', 55);
INSERT INTO tbl_grade_center VALUES ('Isabella', 'Garcia-Shapiro', '1234510007','COMP2003', 90);
INSERT INTO tbl_grade_center VALUES ('Phineas', 'Flynn', '1234510001','COMP2007', 79);
INSERT INTO tbl_grade_center VALUES ('Ferb', 'Fletcher', '1234510002','COMP2007', 100);
INSERT INTO tbl_grade_center VALUES ('Candace', 'Fletcher', '1234510003','COMP2007', 72);
INSERT INTO tbl_grade_center VALUES ('Baljeet', ' ', '1234510004','COMP2007', 100);
INSERT INTO tbl_grade_center VALUES ('Major', 'Monogram ', '1234510005','COMP2007', 68);
INSERT INTO tbl_grade_center VALUES ('Dr.', 'Doofenshmirtz', '1234510006','COMP2007', 78);
INSERT INTO tbl_grade_center VALUES ('Isabella', 'Garcia-Shapiro', '1234510007','COMP2007', 88);
-- INSERT INTO tbl_grade_center VALUES ('Isabella', 'Garcia-Shapiro', '1234510007','COMP2008', 79);
INSERT INTO tbl_grade_center VALUES ('Anju', 'Chawla', '1234567890','COMP2003', 88);

SELECT * FROM tbl_grade_center;

-- Is this table in the 1NF? Why or why not?
-- No, since there is no primary key in the table though all the fields are 'atomic' in nature, that is, there is no repeating data in any column/field

-- Let us add a primary key to the table so that it is in the 1NF by altering its structure
ALTER TABLE tbl_grade_center
ADD COLUMN id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY FIRST;
-- cannot make the the student_number the primary key since it is not unique, one student has more than one records

-- show the description of the table
DESC tbl_grade_center;
-- show all records of the table
SELECT * FROM tbl_grade_center;



/*find the average mark for each student rounded to 1 decimal place, display the full name of the 
student as 'Student Name' and the average grade column as 'Average Mark'. Order by name*/

SELECT CONCAT(first_name,' ', last_name) 'Student Name', ROUND(AVG(grade),1) AS 'Average Mark'
FROM tbl_grade_center
GROUP BY student_number
ORDER BY 1; 

SELECT CONCAT(first_name,' ', last_name) 'Student Name', CAST(AVG(grade) AS DECIMAL(4,1)) AS 'Average Mark'
FROM tbl_grade_center
GROUP BY student_number
ORDER BY CONCAT(first_name,' ', last_name);

-- if alias name is a single word, then you can use it in ORDER BY 
SELECT CONCAT(first_name,' ', last_name) Name, CAST(AVG(grade) AS DECIMAL(4,1)) AS 'Average Mark'
FROM tbl_grade_center
GROUP BY student_number
ORDER BY Name;

/*
Create the list of potential tutors by providing the first and last name of all the students 
that have received 80% or higher in at least 2 courses, listed alphabetically by last name.
*/
SELECT first_name, last_name
FROM tbl_grade_center
WHERE grade >= 80
GROUP BY student_number
HAVING COUNT(course) >= 2
ORDER BY last_name; -- ORDER BY 2