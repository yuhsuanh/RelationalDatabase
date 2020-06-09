/*
Name: Anju Chawla
Date : June, 2020
Purpose: To create a database with a table therein that stores
information about employees
Query the data in the table; update and delete data in the table
*/

-- set the environment
 SET SQL_SAFE_UPDATES = 0;
-- SET DEFAULT_STORAGE_ENGINE = INNODB;

-- drop existing database, if it exists
DROP DATABASE IF EXISTS db_employee;    
-- create the database 
CREATE DATABASE db_employee;
-- use the database
USE db_employee;

-- drop the table, if it exists
-- DROP TABLE IF EXISTS tbl_employee;

-- create the table structure; notice the use of database_name.table_name.
-- You may not 'use' the database but may qualify the table wherever needed

CREATE TABLE db_employee.tbl_employee(
	employee_number	  CHAR(4) PRIMARY KEY,										-- the unique identification number of the employee
	employee_name 	  VARCHAR(40) NOT NULL,										-- the name of the employee
	job_description	  VARCHAR(20)  NOT NULL DEFAULT 'UNASSIGNED',				-- the job description of the employee
	manager_number	  CHAR(4),													-- the employee number of the manager of this employee
	hire_date 	      DATE  NOT NULL,      										-- the date the employee was hired
	monthly_salary 	  DEC(7,2) UNSIGNED  NOT NULL,								-- the monthly salary of the employee
	commission 	      DEC(7,2) UNSIGNED DEFAULT 0 ,								-- the commission earned by the employee; only salesman earn commissions
    
    FOREIGN KEY(manager_number) REFERENCES tbl_employee(employee_number)
    -- manager_number is a 'self-referential' foreign key, that is draws its value from the employee number field of the same table
)ENGINE = INNODB; -- storage engine InnoDB supports/enforces foreign key constraint

--  inserting records into the table
INSERT INTO tbl_employee(employee_number,employee_name,job_description,manager_number, hire_date, monthly_salary, commission)
VALUES
('7839', 'KING', 'PRESIDENT',NULL, '1981-11-17', 5000, default),
('7698', 'BLAKE', 'MANAGER', '7839', '1981-05-01', 2850, default),
('7782', 'CLARK', 'MANAGER','7839', '1981-06-09', 2450, default),
('7566', 'JONES', 'MANAGER','7839', '1981-04-02', 2975, default),
('7654', 'MARTIN', 'SALESMAN','7698', '1981-09-28', 1250, 1400),
('7499', 'ALLEN', 'SALESMAN','7698', '1981-02-20', 1600, 300),
('7844', 'TURNER', 'SALESMAN','7698', '1981-09-08', 1500, null),
('7900', 'JAMES', 'CLERK','7698', '1981-12-03', 950, default),
('7521', 'WARD', 'SALESMAN','7698', '1981-02-22', 1250, 500),
('7902', 'FORD', 'ANALYST','7566', '1981-12-03', 3000, default),
('7369', 'SMITH', 'CLERK','7902', '1980-12-17', 800, default),
('7788', 'SCOTT', 'ANALYST','7566', '1982-12-09', 3000, default),
('7876', 'ADAMS', 'CLERK','7788', '1983-01-12', 1100, default),
('7934', 'MILLER', 'CLERK','7782', '1982-01-23', 1300, default);
-- describe the structure of the table
DESCRIBE tbl_employee;
-- SHOW COLUMNS tbl_employee;
-- show all the records of the table
SELECT * FROM tbl_employee;


-- Now for some updates to the data
/*
UPDATE tbl_name
SET col_name1 = value1 [, col_name2 = value2...]
[WHERE cond]
[ORDER BY field1 [,field2, field3...]
[LIMIT how_many]
*/

-- always try to update using the Primary Key

-- 1) Update Turner's commission to $400.
SELECT *
FROM tbl_employee
WHERE employee_name = 'Turner';

UPDATE tbl_employee
SET commission = 400
WHERE employee_name = 'Turner';

-- 2) Change the job description of all 'ANALYST' to 'MARKET ANALYST'.
SELECT *
FROM tbl_employee
WHERE job_description = 'ANALYST';

UPDATE tbl_employee
SET job_description = 'MARKET ANALYST'
WHERE job_description = 'ANALYST';

-- 3a) Update all NULL commissions to zero.
SELECT *
FROM tbl_employee
WHERE commission IS NULL;

UPDATE tbl_employee
SET commission = 0
WHERE commission IS NULL;

-- 3b) Update all 0 commissions to NULL.
UPDATE tbl_employee
SET commission = NULL
WHERE commission = 0 ;

-- 4) Update Miller's hire date to Jan 25, 1982, using his employee number- do not peek in the data
--  date is not text or number

SELECT *
FROM tbl_employee
WHERE employee_name = 'Miller';
-- cast literal into date before assigning to date field
-- using Primary Key
UPDATE tbl_employee
SET hire_date = CAST('1982-01-25' AS DATE)
WHERE employee_number = '7934';

-- 5) Update Martin's infomation. He is now a manager and will not have any defined commision; new salary $2500
SELECT *
FROM tbl_employee
WHERE employee_name = 'Martin';

UPDATE tbl_employee
SET 
job_description = 'Manager', 
commission = NULL,
monthly_salary = 2500
WHERE employee_number = '7654';
-- WHERE employee_name = 'Martin';

-- 6) Update all records - add 500 to all commissions. 
-- When all records are to be updated, you don't require a where clause
-- null does not participate/ remains unaffected
SELECT commission
FROM tbl_employee;

UPDATE tbl_employee
SET commission = commission + 500;


-- 7) Update the first 2 records after sorting them on employee number descending, to set commission to 0
SELECT *
FROM tbl_employee
ORDER BY employee_number DESC;

UPDATE tbl_employee
SET commission = 0
ORDER BY employee_number DESC
LIMIT 2; -- only how_many in limit
 
-- Let us delete some information we do not need
--  DELETE FROM tbl_name 
-- [WHERE cond]
-- [ORDER BY field1 [,field2, field3...]
-- [LIMIT how_many]


-- always try to delete using the Primary Key

-- 8) Adams has left the company. Delete his record.
-- can we delete Adams- is he somebody's manager? NO
SELECT *
FROM tbl_employee
WHERE employee_name = 'Adams'; -- 7876 employee number

-- which employees work under Adams
SELECT * 
FROM tbl_employee
WHERE manager_number = '7876';

-- safe to delete Adams record
DELETE
FROM tbl_employee
WHERE employee_number = '7876';

-- 9) Delete the records of all employees who joined the company in 1982.
SELECT *
FROM tbl_employee
WHERE YEAR(hire_date) = 1982; -- 7788 and 7934

-- is 7788 a manager
SELECT * 
FROM tbl_employee
WHERE manager_number = '7788';
-- is 7934 a manager
SELECT * 
FROM tbl_employee
WHERE manager_number = '7934';
-- so they are not managers, can delete their records
DELETE
FROM tbl_employee
WHERE YEAR(hire_date) = 1982;
-- optionally delete by employee numbers also
/*
DELETE
FROM tbl_employee
WHERE employee_number = '7788';

DELETE
FROM tbl_employee
WHERE employee_number = '7934';
*/

-- 10)Delete the first 5 records after sorting them on employee number

SELECT *
FROM tbl_employee
ORDER BY employee_number
LIMIT 5;


-- can we delete the first 5 records - NO because one or more of these is the manager of another employee- foreign key constraint is violated. Jones is a manager
DELETE
FROM tbl_employee
ORDER BY employee_number
LIMIT 5; -- only use how_many, no offset


-- 11) Delete all records -BEWARE ALL RECORDS WILL BE DELETED
-- this will again give error because of foreign key constraint
DELETE
FROM tbl_employee;

SELECT * FROM tbl_employee;