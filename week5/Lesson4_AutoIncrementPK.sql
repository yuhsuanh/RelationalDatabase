-- Name: Anju Chawla
-- Date: June 2020
-- Purpose: Create a database and a table therein to store information about projects.

-- set the environment
SET SQL_MODE="STRICT_ALL_TABLES";

-- drop existing database if any, create a new one and use the database
DROP DATABASE IF EXISTS db_projects;
CREATE DATABASE db_projects;
USE db_projects;


-- create the table structure 
CREATE TABLE tbl_projects
(
	project_number         			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    description_of_project 			VARCHAR(100) NOT NULL,
	contractor_on_job 				VARCHAR(40)  NOT NULL,    
	contractor_phone_number 		CHAR(15) NOT NULL,
    start_date 						DATE,
	estimated_cost 					DECIMAL(8,2) UNSIGNED NOT NULL DEFAULT 0
);

-- display table structure
DESC tbl_projects;
-- SHOW COLUMNS FROM tbl_projects;
-- display all the table names present in the database
SHOW TABLES;
-- display the 'Create Table' command
SHOW CREATE TABLE tbl_projects;

-- insert records in the table
INSERT INTO tbl_projects(description_of_project, contractor_on_job, contractor_phone_number, start_date, estimated_cost )	
VALUES
('Outside house painting','Murphy','123-456-7890','2020-01-01', 2000.50);
INSERT INTO tbl_projects(description_of_project, contractor_on_job, contractor_phone_number, start_date, estimated_cost )	
VALUES
('Kitchen remodel','Valdez', '234-567-8901', '2020-05-10', 5000);
INSERT INTO tbl_projects(description_of_project, contractor_on_job, contractor_phone_number, start_date, estimated_cost )	
VALUES
('Wood floor Installation','Keller', '345-678-9012', '2020-06-06', 4567.25);

INSERT INTO tbl_projects(description_of_project, contractor_on_job, contractor_phone_number, start_date, estimated_cost)
VALUES
('Yard work', 'Ken','705-123-5678','2020-06-10',500);

-- start_date and estimated_cost may not be provided since have default values
INSERT INTO tbl_projects( description_of_project, contractor_on_job, contractor_phone_number )	
VALUES
('Roofing','Jackson', '4567-890-123');

INSERT INTO tbl_projects(description_of_project, contractor_on_job, contractor_phone_number)
VALUES
('Porch steps reconstruction', 'Rob','705-234-5678');

-- select all records from the table
SELECT *  FROM tbl_projects

