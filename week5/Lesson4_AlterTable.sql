-- Name: Anju Chawla
-- Date: June 2020
-- Purpose: Create a database and a table therein to store information about projects.
-- To work with the ALTER TABLE statement. Use it to change the name of table,
-- and add, change, modify and delete field descriptions

-- set the environment
SET SQL_MODE="STRICT_ALL_TABLES";

-- drop existing database if any, create a new one and use the database
DROP DATABASE IF EXISTS db_projects;
CREATE DATABASE db_projects;
USE db_projects;


-- create the table structure - BAD TABLE STRUCTURE - primary key missing and insufficient size for fields. Futher field names are poor and difficult to interpret 
CREATE TABLE projekts(
  number         			INT               NOT NULL DEFAULT 0,
  descriptionofproject     	VARCHAR(50)       NOT NULL,
  contractoronjob          	VARCHAR(10)       DEFAULT NULL
);

-- display table structure
DESC projekts;
SHOW COLUMNS FROM projekts;
-- display all the table names present in the database
SHOW TABLES;
-- display the 'Create Table' command
SHOW CREATE TABLE projekts;

-- insert records in the table
INSERT INTO projekts
VALUES
(1,'Outside house painting','Murphy');
INSERT INTO projekts
VALUES
(2, 'Kitchen remodel','Valdez');
INSERT INTO projekts
VALUES
(3,'Wood floor Installation','Keller');
INSERT INTO projekts
VALUES
(4,'Roofing','Jackson');

INSERT INTO projekts(descriptionofproject,contractoronjob)
VALUES
('Carpet cleaning','James'),
('Window Cleaning', 'Joe') ;

-- select all records from the table
SELECT * FROM projekts;

-- rename the table to tbl_projects, deleting any previous one by that name
DROP TABLE IF EXISTS tbl_projects;
ALTER TABLE projekts
RENAME TO tbl_projects;

-- from this point onwards the table is called tbl_projects
-- change the name of the number field to project_id and make it the primary key
-- CHANGE COLUMN allows to change the name and the type, remember to give COMPLETE definition, including anything to be retained/kept from previous definition
-- Must delete rows which number is 0 because the new type is unsigned
ALTER TABLE tbl_projects
CHANGE COLUMN `number` `project_id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY;
DESC tbl_projects;

-- if a field was good to be a PK without any changes
-- ALTER TABLE tbl_projects
-- ADD CONSTRAINT PRIMARY KEY(field_name);
-- FYI, can make a field unique by ADD CONSTRAINT UNIQUE KEY(field_name);

-- if a new field is to be added as a PK
-- ALTER TABLE tbl_projects
-- ADD COLUMN project_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY;
-- CHANGE COLUMN allows to change the name and the type, remember to give COMPLETE definition
-- change the names and size for the other two fields, description_of_project(100) and contractor_on_job(40)
ALTER TABLE tbl_projects
CHANGE COLUMN descriptionofproject description_of_project VARCHAR(100) NOT NULL,
CHANGE COLUMN contractoronjob contractor_on_job VARCHAR(40);
DESC tbl_projects;

-- change the field size/type of project description to 120 characters now, name to be retained -redundant, should have done in change BUT show an example of MODIFY
-- MODIFY COLUMN is used to change the type/size, old 'properties' need to be rewritten
ALTER TABLE tbl_projects
MODIFY COLUMN description_of_project VARCHAR(120) NOT NULL;

-- drop the column contractor name
ALTER TABLE tbl_projects
DROP COLUMN contractor_on_job;

-- add new columns -start date, contractor phone(15), not null after the description of project, estimated cost(8,2), unsigned, not null and default of 0
ALTER TABLE tbl_projects
ADD COLUMN start_date DATE,
ADD COLUMN contractor_phone_number CHAR(15) NOT NULL AFTER description_of_project,
ADD COLUMN estimated_cost DECIMAL(8,2) UNSIGNED NOT NULL DEFAULT 0;

-- display the table structure
DESC tbl_projects;

-- select all records from the table
SELECT *  FROM tbl_projects;

-- inserting more records
INSERT INTO tbl_projects(description_of_project,contractor_phone_number,start_date, estimated_cost)
VALUES
('Yard work','705-123-5678','2020-06-10',1000);

-- start_date and estimated_cost may not be provided since have default values
INSERT INTO tbl_projects(description_of_project,contractor_phone_number )
VALUES
('Porch steps reconstruction','705-234-5678');

-- select all records from the table
SELECT *  FROM tbl_projects