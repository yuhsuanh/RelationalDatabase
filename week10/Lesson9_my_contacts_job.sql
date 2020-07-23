/*
Name: Anju Chawla
Date: July 2020
Purpose: To create a database, some tables therein, 
populate them with  data and extract information from the tables using joins and subqueries
*/

-- set the environment
SET SQL_MODE = 'STRICT_ALL_TABLES';
SET SQL_MODE = 'ONLY_FULL_GROUP_BY';
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


-- insert client/contact records into the table
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
	contact_id  INT UNSIGNED  PRIMARY KEY,
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
	FOREIGN KEY (contact_id) REFERENCES tbl_my_contacts(contact_id)
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



-- 1)Name and email of all contacts who currently do not have a job

-- cannot do it using an inner join 
-- outer join , tbl_my_contacts HAS to be the master table
SELECT CONCAT_WS(' ',first_name,last_name) 'Name',email 'Email Address'
FROM tbl_my_contacts MC LEFT OUTER JOIN tbl_job_current JC
ON MC.contact_id = JC.contact_id
WHERE JC.contact_id IS NULL;

/*
-- not the correct solution
SELECT * -- CONCAT_WS(' ',first_name,last_name) 'Name',email
FROM tbl_my_contacts MC RIGHT OUTER JOIN tbl_job_current JC
ON MC.contact_id = JC.contact_id;
*/

-- subquery
SELECT CONCAT_WS(' ',first_name,last_name) 'Name',email 'Email Address'
FROM tbl_my_contacts 
WHERE contact_id NOT IN -- can't use <>
(SELECT contact_id FROM tbl_job_current);

-- correlated subquery
SELECT CONCAT_WS(' ',first_name,last_name) 'Name',email 'Email Address'
FROM tbl_my_contacts MC 
WHERE NOT EXISTS 
(SELECT * FROM tbl_job_current JC WHERE JC.contact_id = MC.contact_id);



-- 2a) Find all those job titles that are desired and are in the job listings

-- join
SELECT  JD.title
FROM tbl_job_desired JD INNER JOIN tbl_job_listings JL
ON JD.title = JL.title; -- USING(title)

SELECT  JD.title
FROM tbl_job_desired JD NATURAL JOIN tbl_job_listings JL;

SELECT  JD.title
FROM tbl_job_desired JD LEFT OUTER JOIN tbl_job_listings JL
USING(title)
WHERE job_id IS NOT NULL;

-- less efficient since more  records are selected
SELECT  JD.title
FROM tbl_job_desired JD RIGHT OUTER JOIN tbl_job_listings JL
USING(title)
WHERE contact_id IS NOT NULL;


-- if unique values are required
SELECT DISTINCT JD.title
FROM tbl_job_desired JD INNER JOIN tbl_job_listings JL
ON JD.title = JL.title;

-- use group by instead of DISTINCT 
SELECT  JD.title -- , count(*) 'Number of Contacts Desiring Job'
FROM tbl_job_desired JD INNER JOIN tbl_job_listings JL
ON JD.title = JL.title
GROUP BY (JD.title);

SELECT DISTINCT JD.title
FROM tbl_job_desired JD LEFT OUTER JOIN tbl_job_listings JL
USING(title)
WHERE job_id IS NOT NULL;

-- less efficient since more records are selected
SELECT DISTINCT JD.title
FROM tbl_job_desired JD RIGHT OUTER JOIN tbl_job_listings JL
USING(title)
WHERE contact_id IS NOT NULL;

-- SUBQUERY
SELECT title
FROM tbl_job_desired
WHERE title IN  -- cannot use = because cannot compare one value with a list of values
(SELECT title FROM tbl_job_listings); -- list - more than one can exists

-- CORRELATED SUBQUERY
SELECT title
FROM tbl_job_desired JD
WHERE EXISTS 
(SELECT * FROM tbl_job_listings JL WHERE JL.title = JD.title);

-- 2b) Find all those job titles that are desired by more than one contacts and are in job listings

-- inner join
SELECT JD.title, COUNT(JD.title) 'Contacts Looking For It'
FROM tbl_job_desired JD INNER JOIN tbl_job_listings JL
ON JD.title = JL.title
GROUP BY (JD.title)
HAVING COUNT(JD.title) > 1;

-- outer join
SELECT JD.title
FROM tbl_job_desired JD LEFT OUTER JOIN tbl_job_listings JL
USING(title)
WHERE job_id IS NOT NULL
GROUP BY (JD.title)
HAVING COUNT(JD.title) > 1;
-- ORDER BY JD.title
/*
When you 'group by', then you can only display the 'group by' field and any aggregated function output on the 'group by' field.If there is any other field in the select field list, then its value is 'incorrect and non-deterministic'. The 'having' can also test a condition on the 'group by' field or an aggregated function value on the 'group by' field.The 'order by' also needs to use the 'group by' field or an aggregated function on the group field.
*/
-- subquery
SELECT title
FROM tbl_job_desired
WHERE title IN  -- cannot use = because cannot compare one value with a list of values
(SELECT title FROM tbl_job_listings)
GROUP BY (title)
HAVING COUNT(title) > 1;

-- coorelated subquery fyi - added this after the video recording 
SELECT title
FROM tbl_job_desired JD
WHERE EXISTS 
(SELECT * FROM tbl_job_listings JL WHERE JL.title = JD.title)
GROUP BY (title)
HAVING COUNT(title) > 1;
