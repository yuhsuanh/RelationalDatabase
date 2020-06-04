/*
Name: Anju Chawla
Date : June, 2020
Purpose: To create a database with a table therein that stores
information about employees
Query the data in the table
*/

#drop existing database, if it exists
DROP DATABASE IF EXISTS db_employee;    
#create the database 
CREATE DATABASE db_employee;
#use the database
USE db_employee;

#drop the table, if it exists; do not need it here since the database is dropped
#DROP TABLE IF EXISTS tbl_employee;

#create the table structure; notice the use of database_name.table_name.
#You may not 'use' the database but may qualify the table wherever needed

CREATE TABLE db_employee.tbl_employee(
	employee_number	  CHAR(4) PRIMARY KEY,
	employee_name 	  VARCHAR(40) NOT NULL,
	job_description	  VARCHAR(20)  NOT NULL DEFAULT 'UNASSIGNED',
	manager_number	  CHAR(4),
	hire_date 	      DATE  NOT NULL,      #stored in 'yyyy-mm-dd' format
	monthly_salary 	  DEC(7,2) UNSIGNED  NOT NULL,
	commission 	      DEC(7,2) UNSIGNED DEFAULT 0,
    
    FOREIGN KEY(manager_number) REFERENCES tbl_employee(employee_number)
) ENGINE = INNODB;

#display the 'create table' command as interpreted by the database engine
SHOW CREATE TABLE db_employee.tbl_employee;

# inserting records into the table
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

/*
SELECT field_list
FROM table_name
[WHERE condition]
[ORDER BY field_name(s)]
[LIMIT offset,how_many]
*/

#select all the records
SELECT * FROM tbl_employee;

#1) A list of the all the employee names and their job description.
SELECT employee_name, job_description
FROM tbl_employee;	

#2) The names of all the managers.
SELECT employee_name  AS 'Manager List'
FROM tbl_employee
WHERE job_description = 'Manager';
    
#3) The name(s) of all employees who do not have a manager(use manager_number field to retrieve information)
SELECT employee_name  AS 'No Manager'
FROM tbl_employee
WHERE manager_number IS NULL;
	

#4) The name and hire date of the employees who were hired after 1981. Don't peek in the table. You have no clue of the other hiring dates.
# Note that dates can be written as text in the format 'yyyy-mm-dd',  as I have done or as number in the format yyyymmdd.
#ALWAYS compare a date type with a literal of type date
SELECT employee_name, hire_date
FROM tbl_employee
WHERE hire_date > CAST('1981-12-31' AS DATE);

SELECT employee_name, hire_date
FROM tbl_employee
WHERE hire_date > CAST(19811231 AS DATE);
     
#5) The name and hire date of all employees that were hired in 1981 only.
#Do not use LIKE with dates since they are not text as per se.
#DO NOT DO THIS THOUGH IT WORKS
SELECT employee_name, hire_date
FROM tbl_employee
WHERE hire_date LIKE '1981%';

#CORRECT WAY
SELECT employee_name, hire_date
FROM tbl_employee
WHERE hire_date >= CAST( '1981-01-01' AS DATE) AND hire_date <= CAST( '1981-12-31' AS DATE);

SELECT employee_name, hire_date
FROM tbl_employee
WHERE hire_date BETWEEN CAST( '1981-01-01' AS DATE) AND CAST( '1981-12-31' AS DATE);


#6a) List the name and commission of all employees that have earned a commission
SELECT employee_name, commission
FROM tbl_employee
WHERE commission > 0; # can use <> or !=
    
#6b) List the name and commission of all employees that have undefined/does not exist commission
SELECT employee_name, commission
FROM tbl_employee
WHERE commission IS NULL;

#7) The name and salary of all employees that earn at least 5000.

	SELECT employee_name, monthly_salary
	FROM tbl_employee
	WHERE monthly_salary >= 5000;

#8) The name, job description and salary of all employess that earn between 1000 and 2000, inclusive.Give two solutions for this query.

	#i) 
    SELECT employee_name, job_description, monthly_salary
	FROM tbl_employee
	WHERE monthly_salary >= 1000 AND monthly_salary <= 2000;
	
	#ii) 
    SELECT employee_name, job_description, monthly_salary
	FROM tbl_employee
	WHERE monthly_salary BETWEEN 1000 AND 2000	;

#9) The name and salary of all the clerks.

	SELECT employee_name, monthly_salary
	FROM tbl_employee
	WHERE job_description='clerk';

#10) The name and job description of the employees that have no commission

	#i)
    SELECT employee_name, job_description
	FROM tbl_employee
	WHERE commission = 0;	

#11) Find the name and job description of employees who is either a manager, analyst or salesman. Give two different solutions for this query.

	#i)
    SELECT employee_name, job_description
	FROM tbl_employee
	WHERE job_description='manager' OR job_description='analyst' OR job_description='salesman';

	#ii) 
    SELECT employee_name, job_description
	FROM tbl_employee
	WHERE job_description IN ('manager' ,'analyst' , 'salesman');
     

	
#12) List the name and job description of employees who is neither a salesman nor a clerk.

	#i)
        SELECT employee_name, job_description
	FROM tbl_employee
	WHERE job_description != 'salesman' AND job_description != 'clerk' ;
	
	#ii)  
    SELECT employee_name, job_description
	FROM tbl_employee
	WHERE job_description <> 'salesman' AND job_description <>'clerk' ;
       

	#iii)  
  SELECT employee_name, job_description
	FROM tbl_employee
	WHERE job_description NOT IN ('salesman' ,'clerk');
        
    #iv) 
      SELECT employee_name, job_description
	FROM tbl_employee
	WHERE NOT job_description = 'salesman' AND NOT job_description = 'clerk' ;
	
	#v)
     SELECT employee_name, job_description
	FROM tbl_employee
	WHERE NOT (job_description = 'salesman' OR job_description = 'clerk') ;   

