/*
Name : Anju Chawla
Date: July 2020
Purpose: To create a database and a table therein to store clown information.
To demonstarte a self join
*/

-- if database already exists, delete it
DROP DATABASE IF EXISTS db_clowns;
-- create the database and use it
CREATE DATABASE db_clowns;
USE db_clowns;


-- Create the table structure for tbl_clowns_info
-- A self referencing foreign key is the primary key of the table used
-- in the same table for another purpose(boss _id in this case)
-- MySQL will 'enforce' the self referential constraint in the InnoDB engine 
-- BUT records need to be inserted in a certain order.
-- The value of the boss_id needs to exist before a clown record is inserted

CREATE TABLE tbl_clowns_info(
  clown_id   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  clown_name VARCHAR(20) NOT NULL,
  boss_id    INT UNSIGNED NOT NULL ,

  FOREIGN KEY(boss_id) REFERENCES tbl_clowns_info(clown_id) 
  
  )ENGINE = INNODB;
  
/*
ALTER TABLE tbl_clowns_info
ADD CONSTRAINT FOREIGN KEY(boss_id) REFERENCES clown_id;

*/

-- insert data into the tbl_clowns_info table
INSERT INTO tbl_clowns_info(clown_name, boss_id) VALUES ('Elsie',1);  -- clown_id is 1
-- INSERT INTO tbl_clowns_info(clown_name, boss_id) VALUES('Pickles', 9);
INSERT INTO tbl_clowns_info(clown_name, boss_id) VALUES('Pickles',2);
INSERT INTO tbl_clowns_info(clown_name, boss_id) VALUES('Snuggles',1);
INSERT INTO tbl_clowns_info(clown_name, boss_id) VALUES('Mr. Hobo',1);
INSERT INTO tbl_clowns_info(clown_name, boss_id) VALUES('Clarabelle',3);
INSERT INTO tbl_clowns_info(clown_name, boss_id) VALUES('Scooter',3);
INSERT INTO tbl_clowns_info(clown_name, boss_id) VALUES('Zippo',4);
INSERT INTO tbl_clowns_info(clown_name, boss_id) VALUES('Babe',5); -- clown_id 8
INSERT INTO tbl_clowns_info(clown_name, boss_id) VALUES('Bonzo',5);
INSERT INTO tbl_clowns_info(clown_name, boss_id) VALUES('Sniffles',10); -- clown_id is 10
-- INSERT INTO tbl_clowns_info(clown_name, boss_id) VALUES('BoBo', 12);

-- select all the records of the table
SELECT * FROM tbl_clowns_info; 
SELECT * FROM tbl_clowns_info; 

-- 1) Get the name of each clown and the name of that clown's boss. 
-- You will have to use self-join
SELECT c1.clown_name AS 'Clown Name', c2.clown_name  'Boss Name'
FROM tbl_clowns_info AS c1, tbl_clowns_info  c2
WHERE c1.boss_id = c2.clown_id;













