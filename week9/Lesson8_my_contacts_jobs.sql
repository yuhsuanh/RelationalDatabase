/*
Name: Anju Chawla
Date: July 2020
Purpose: To create a database, some tables therein, 
populate them with  data and extract information from the tables using joins and subqueries
*/

-- set the environment
SET SQL_MODE = "STRICT_ALL_TABLES";
SET DEFAULT_STORAGE_ENGINE =  INNODB;

-- drop the database is one exists by the same name
DROP DATABASE IF EXISTS db_jobs;
-- create the database
CREATE DATABASE db_jobs;
-- use the database
USE db_jobs;


-- create the table structure to store information about clients/contacts
CREATE TABLE tbl_my_contacts
(
	contact_id	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	last_name  	VARCHAR(30) NOT NULL ,
	first_name	VARCHAR(20) NOT NULL,
	phone 		CHAR(13),
	email		VARCHAR(50) NOT NULL,
	gender		ENUM('M','F') NOT NULL ,
	birthday	DATE NOT NULL,
	zip 		CHAR(5) NOT NULL
);


-- insert client/contact data into the table
INSERT INTO tbl_my_contacts(last_name, first_name, phone,email, gender,birthday,zip)
VALUES
('Anderson','Jillian','(555)555-3214','jill_anderson@breakneckpizza.com','F','1980-09-05','12345'),
('Kenton','Leo','(567)565-5514','lkenton@starbuzzcoffee.com','M','1974-01-10','55467'),
('McGavin','Darrin','(678)559-7890',' captainlove@headfirsttheater.com','M','1966-01-23','64578'),
('Franklin','Joe','(578)543-4235','joe_franklin@leapinlimos.com','M','1977-04-28','32456'),
('Hamilton','Jamie','(789)542-3768','dontbother@starbuzzcoffee.com','F','1964-09-10','55467'),
('Chevrolet','Maurice','(235)521-3344','bookman4u@objectville.net','M','1962-07-01','25790'),
('Kroger','Renee','(556)546-1234','poorrenee@mightygumball.net','F','1976-12-03','55467'),
('Mendoza','Angelina','(545)523-3456','angelina@starbuzzcoffee.com','F','1979-08-19','77567'),
('Murphy','Donald','(225)325-3544','padraic@tikibeanlounge.com','M','1967-01-23','12345'),
('Spatner','John','(550)125-1114','jpoet@objectville.net','M','1963-04-18','34125');

-- create the table structure to store information on contact/client current job
CREATE TABLE tbl_job_current
(
	contact_id      INT UNSIGNED  PRIMARY KEY,
	title 		VARCHAR(30) NOT NULL ,
	salary 		DEC(8,2) UNSIGNED NOT NULL,
	start_date 	DATE NOT NULL,

	CONSTRAINT tbl_my_contacts_contact_id_fk1
	FOREIGN KEY (contact_id)
	REFERENCES tbl_my_contacts(contact_id)
);
-- insert data in the job current table
INSERT INTO tbl_job_current
VALUES
(1,'Technical Writer',80000.00,'2010-01-01'),
(2,'Manager',110000.00,'2000-05-31'),
(3,'Web Designer',75000.00,'1986-05-05'),
(4,'Software Sales',60000.00,'2003-06-19'),
(5,'System Administrator',120000.00, '1990-01-01'),
(6,'Bookshop Owner',90000.00,'1992-07-18'),
(8,'UNIX Sysadmin',110000.00,'2005-10-10'),
(9,'Baker',80000.00,'1987-10-26');

-- create the table structure to store job desired by a client/contact
CREATE TABLE tbl_job_desired
(
	contact_id 	INT UNSIGNED  PRIMARY KEY,
	title 		VARCHAR(30),
	salary_low 	DEC(8,2) UNSIGNED NOT NULL,	-- ready to take salary this low
	salary_high DEC(8,2) UNSIGNED NOT NULL,  -- the expected salary
	years_exp 	TINYINT UNSIGNED DEFAULT 0,

	CONSTRAINT tbl_my_contacts_contact_id_fk2
	FOREIGN KEY (contact_id)
	REFERENCES tbl_my_contacts(contact_id)
);

-- insert data in the job desired table
INSERT INTO tbl_job_desired
VALUES
(7,'Computer Programmer',80000.00, 100000.00,10),
(8,'Computer Programmer',90000.00, 150000.00,10),
(4,'Sales Manager',75000.00, 85000.00, 11),
(10,'Baker',60000.00, 70000.00, 2),
(9,'Chef', 90000.00, 100000, 20);


-- create the table structure to store information about job listings in the market
CREATE TABLE tbl_job_listings
(
	job_id 		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
	title 		VARCHAR(30) NOT NULL,
	salary 		DEC(8,2) UNSIGNED NOT NULL,
	zip 		CHAR(5) NOT NULL
);

-- insert data in the table job listings table
INSERT INTO tbl_job_listings(title, salary, zip)
VALUES
('Baker', 60000.00,'12345'),
('Clown',50000.00,'34625'),
('Dog Trainer',55000.00,'14624'),
('Hairdresser',70000.00,'67435'),
('Jeweler',66000.00,'45231'),
('Lawyer', 100000.00, '24675'),
('Mechanic',55000.00,'67890'),
('Neurosurgeon',150000.00,'34125'),
('Web Designer',95000.00,'64578'),
('Teacher',60000.00,'25790'),
('Salesman',60000.00,'55467'),
('Artist',67000.00,'46890'),
('Computer Programmer',75000.00,'12345'),
('Manager', 80000.00,'32587');

-- select data from all tables
SELECT * FROM tbl_my_contacts;
SELECT * FROM tbl_job_current;
SELECT * FROM tbl_job_desired;
SELECT * FROM tbl_job_listings;




-- ANSWER THESE QUERIES NOW:

-- 1a) Select the full name and phone of all those contacts who are 'looking' for a job as listed in job_desired table

-- joins
SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC INNER JOIN tbl_job_desired JD
ON MC.contact_id = JD.contact_id -- joining condition
;

SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC INNER JOIN tbl_job_desired JD
USING(contact_id) -- joining condition - field names should be same and joined on equality
;

SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC NATURAL JOIN tbl_job_desired JD -- field names should be same and joined on equality
;

SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC ,tbl_job_desired JD -- comma instead of INNER JOIN
WHERE MC.contact_id = JD.contact_id -- joining condition, cannot use ON with comma
;

-- using an outer join - JD is the 'master' table
SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC RIGHT OUTER JOIN tbl_job_desired JD
ON MC.contact_id = JD. contact_id
;

-- less efficient because 'master' table is MC
SELECT * -- CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC LEFT OUTER JOIN tbl_job_desired JD
ON MC.contact_id = JD. contact_id
WHERE JD.contact_id IS NOT NULL
;
 -- SUBQUERY
SELECT CONCAT_WS(' ',first_name,last_name) 'Name', phone AS 'Phone Number'
FROM tbl_my_contacts  
WHERE contact_id IN(
SELECT contact_id
FROM tbl_job_desired
);

-- 1b)Select the full name and phone of all those who are people not looking for job
/* INCORRECT SOLUTION
SELECT * -- CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC INNER JOIN tbl_job_desired JD
ON MC.contact_id <> JD.contact_id -- joining condition
;
*/
SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC LEFT OUTER JOIN tbl_job_desired JD
ON MC.contact_id = JD. contact_id
WHERE JD.contact_id IS  NULL
;

-- SUBQUERY
SELECT CONCAT_WS(' ',first_name,last_name) 'Name', phone AS 'Phone Number'
FROM tbl_my_contacts  
WHERE contact_id NOT IN(
SELECT contact_id
FROM tbl_job_desired
);


-- 1c) Now see if there are any job oppurtunities for contacts looking for a job as listed in the job listings table.

-- JOINS
SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC INNER JOIN tbl_job_desired JD INNER JOIN tbl_job_listings JL
ON MC.contact_id = JD.contact_id -- joining condition
AND TRIM(JD.title)= TRIM(JL.title); -- joining condition

SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC ,tbl_job_desired JD , tbl_job_listings JL-- comma instead of INNER JOIN
WHERE MC.contact_id = JD.contact_id -- joining condition, cannot use ON with comma
AND TRIM(JD.title)= TRIM(JL.title);

-- using an outer join 
-- efficient
SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM 
tbl_job_listings JL 
RIGHT OUTER JOIN 
tbl_job_desired JD  -- master table 
ON TRIM(JD.title)= TRIM(JL.title)
LEFT OUTER JOIN 
tbl_my_contacts MC
ON MC.contact_id = JD. contact_id
WHERE JL.job_id IS NOT NULL;

-- efficient
SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM 
tbl_job_desired JD -- master
LEFT OUTER JOIN 
tbl_job_listings JL
ON TRIM(JD.title)= TRIM(JL.title)
LEFT OUTER JOIN 
tbl_my_contacts MC
ON MC.contact_id = JD. contact_id
WHERE JL.job_id IS NOT NULL;

-- less efficient
SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM 
tbl_job_listings JL -- master table
RIGHT OUTER JOIN 
tbl_job_desired JD
ON TRIM(JD.title)= TRIM(JL.title)
INNER JOIN
tbl_my_contacts MC
ON MC.contact_id = JD.contact_id
WHERE JL.job_id IS NOT NULL;

-- less efficiient
SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC
INNER JOIN
tbl_job_listings JL RIGHT OUTER JOIN tbl_job_desired JD
ON TRIM(JD.title)= TRIM(JL.title) AND MC.contact_id = JD.contact_id
WHERE JL.job_id IS NOT NULL;

-- SUBQUERY
SELECT CONCAT_WS(' ',first_name,last_name) 'Name', phone AS 'Phone Number'
FROM tbl_my_contacts  
WHERE contact_id IN(
SELECT contact_id
FROM tbl_job_desired
WHERE TRIM(title) IN
(SELECT TRIM(title) FROM tbl_job_listings
));

-- JOIN AND SUBQUERY
SELECT CONCAT_WS(' ',first_name,last_name) 'Name', phone AS 'Phone Number'
FROM tbl_my_contacts INNER JOIN tbl_job_desired
USING(contact_id)
WHERE title IN(SELECT title FROM tbl_job_listings);
-- more efficient
SELECT CONCAT_WS(' ',first_name,last_name) 'Name', phone AS 'Phone Number'
FROM tbl_my_contacts RIGHT OUTER JOIN tbl_job_desired
USING(contact_id)
WHERE title in(SELECT title FROM tbl_job_listings);


-- 2) Select the name(concatenate first and last name) and phone number of all 
-- those contacts who are interested in a Computer Programmer job and are ready 
-- to accept a salary of $95000 or less

-- JOINS
SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC INNER JOIN tbl_job_desired JD
ON MC.contact_id = JD.contact_id -- joining condition
WHERE TRIM(JD.title) = 'Computer Programmer'
AND JD.salary_low <= 95000;

SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC INNER JOIN tbl_job_desired JD
USING(contact_id) -- joining condition - field names should be same and joined on equality
WHERE TRIM(JD.title) = 'Computer Programmer'
AND JD.salary_low <= 95000;

SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC NATURAL JOIN tbl_job_desired JD -- field names should be same and joined on equality
WHERE TRIM(JD.title) = 'Computer Programmer'
AND JD.salary_low <= 95000;

SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC ,tbl_job_desired JD -- comma instead of INNER JOIN
WHERE MC.contact_id = JD.contact_id -- joining condition, cannot use ON with comma
AND TRIM(JD.title) = 'Computer Programmer'
AND JD.salary_low <= 95000;

-- using an outer join - JD is the 'master' table
SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC RIGHT OUTER JOIN tbl_job_desired JD
ON MC.contact_id = JD. contact_id
WHERE TRIM(JD.title) = 'Computer Programmer'
AND JD.salary_low <= 95000;

-- less efficient because 'master' table is MC
SELECT CONCAT_WS(' ',MC.first_name,MC.last_name) 'Name', MC.phone AS 'Phone Number'
FROM tbl_my_contacts MC LEFT OUTER JOIN tbl_job_desired JD
ON MC.contact_id = JD. contact_id
WHERE TRIM(JD.title) = 'Computer Programmer'
AND JD.salary_low <= 95000;


-- SUBQUERY
SELECT CONCAT_WS(' ',first_name,last_name) 'Name', phone AS 'Phone Number'
FROM tbl_my_contacts  
WHERE contact_id IN(			-- cannot use = 
SELECT  contact_id  -- cannot use a *
FROM tbl_job_desired
WHERE TRIM(title) = 'Computer Programmer'
and salary_low <= 95000);

-- insert a record so that two people earn the highest salary
-- new contact
INSERT INTO tbl_my_contacts(last_name, first_name, phone,email, gender,birthday,zip)
VALUES
('Chawla','Anju','(705)728-1968','anju.chawla@georgiancollege.ca','F','1980-09-05','12345');
-- insert data in the job current table
INSERT INTO tbl_job_current
VALUES
(11,'Computer Analyst',120000.00,'2010-01-01');


-- 3)List title(s) for jobs that earn salary equal to the highest salary in the job_current table

-- subquery
SELECT TRIM(title) 'Highest Earning Title(s)'-- , salary 'Salary($)'
FROM tbl_job_current
WHERE salary =
(SELECT MAX(salary) FROM tbl_job_current); -- need this subquery; cannot do it any other way

-- 4a) Who makes the most money out of all contacts. Display their first and last name and their salary

-- join and subquery
SELECT first_name, last_name, salary
FROM tbl_my_contacts INNER JOIN tbl_job_current
USING(contact_id)
WHERE salary = (SELECT MAX(salary) FROM tbl_job_current);
-- efficient tbl_job_current SHOULD be the master
SELECT   first_name, last_name, salary
FROM tbl_my_contacts RIGHT OUTER JOIN tbl_job_current
USING(contact_id)
WHERE salary = (SELECT MAX(salary) FROM tbl_job_current);

-- less efficient tbl_my_contacts is the master table
SELECT    first_name, last_name, salary
FROM tbl_my_contacts MC LEFT OUTER JOIN tbl_job_current JC
USING(contact_id)
WHERE JC.contact_id IS NOT NULL 
and salary = (SELECT MAX(salary) FROM tbl_job_current);

-- subquery - can't show the salary
SELECT first_name, last_name
FROM tbl_my_contacts
WHERE contact_id IN
(SELECT contact_id  FROM tbl_job_current
WHERE salary =
(SELECT MAX(salary) FROM tbl_job_current));

-- work around
SET @maximum_salary = (SELECT MAX(salary) FROM tbl_job_current);
SELECT first_name 'First Name', last_name 'Last Name', @maximum_salary 'Salary($)'
FROM tbl_my_contacts
WHERE contact_id IN
(SELECT contact_id  FROM tbl_job_current
WHERE salary = @maximum_salary);

-- less efficient since repeated SELECT statements are executed
-- notice the  subquery in the select list 
SELECT first_name 'First Name', last_name 'Last Name', (SELECT MAX(salary) FROM tbl_job_current) 'Salary($)'
FROM tbl_my_contacts
WHERE contact_id IN
(SELECT contact_id  FROM tbl_job_current
WHERE salary =
(SELECT MAX(salary) FROM tbl_job_current));


-- 4b)List the names of all employees with a salary greater than the average salary 
-- will need a join and subquery
SELECT CONCAT_WS(' ',first_name,last_name) 'Name' -- , salary
FROM tbl_my_contacts INNER JOIN tbl_job_current
USING(contact_id)
WHERE salary >
(SELECT ROUND(AVG(salary),0) FROM tbl_job_current);

-- master table is tbl_job_current - efficient
SELECT CONCAT_WS(' ',first_name,last_name) 'Name'
FROM tbl_my_contacts RIGHT OUTER JOIN tbl_job_current
USING(contact_id)
WHERE salary >
(SELECT ROUND(AVG(salary),0) FROM tbl_job_current);

-- master table is tbl_my_contacts, less efficient
SELECT  CONCAT_WS(' ',first_name,last_name) 'Name'
FROM tbl_my_contacts LEFT OUTER JOIN tbl_job_current
USING(contact_id)
WHERE tbl_job_current.title IS NOT NULL AND salary >
(SELECT ROUND(AVG(salary),0) FROM tbl_job_current);

-- subquery
SELECT CONCAT_WS(' ',first_name,last_name) 'Name'
FROM tbl_my_contacts
WHERE contact_id IN
(SELECT contact_id
FROM
tbl_job_current
WHERE salary >
(SELECT ROUND(AVG(salary),0) FROM tbl_job_current));

-- show the  salary and AVERAGE SALARY
SET @average_salary = ROUND((SELECT AVG(salary) FROM tbl_job_current),0);
-- efficient
SELECT CONCAT_WS(' ',first_name,last_name) 'Name', salary 'Salary($)', @average_salary 'Average Salary($)'
FROM tbl_my_contacts RIGHT OUTER JOIN tbl_job_current
USING(contact_id)
WHERE salary >
(SELECT ROUND(AVG(salary),0) FROM tbl_job_current);

-- less efficient
SELECT CONCAT_WS(' ',first_name,last_name) 'Name', salary 'Salary($)', @average_salary 'Average Salary'
FROM tbl_my_contacts INNER JOIN tbl_job_current
USING(contact_id)
WHERE salary >
(SELECT AVG(salary) FROM tbl_job_current);

-- cannot answer using ONLY subquery

-- 5) List everyone who lives in the same zip code as the person with the highest current salary

SELECT CONCAT_WS(' ',first_name,last_name) 'Name'
FROM tbl_my_contacts
WHERE zip IN (
SELECT zip
FROM tbl_my_contacts
WHERE contact_id IN(
SELECT contact_id
FROM tbl_job_current 
WHERE salary =
(SELECT MAX(salary) FROM tbl_job_current)));

