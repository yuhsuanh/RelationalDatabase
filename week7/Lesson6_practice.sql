/*
Name : Anju Chawla
Date: June/July 2020
Purpose: To create a database and tables therein. 
All tables are in 1NF but not in 2NF
Recreate the table structures so that all tables are in 2NF, ensuring no loss of information

*/

SET SQL_MODE = "STRICT_ALL_TABLES";
SET SQL_SAFE_UPDATES=0;
SET DEFAULT_STORAGE_ENGINE =  INNODB;


DROP DATABASE IF EXISTS db_toys_no_2NF;
CREATE DATABASE db_toys_no_2NF;
USE db_toys_no_2NF; 


DROP TABLE IF EXISTS tbl_toys;
CREATE TABLE tbl_toys (
  toy_id 	INT UNSIGNED AUTO_INCREMENT,
  toy 		VARCHAR(30) NOT NULL,
  PRIMARY KEY  (toy_id)
) ;

INSERT INTO tbl_toys (toy_id,toy) VALUES (5,'whiffleball');
INSERT INTO tbl_toys (toy_id,toy) VALUES (6,'frisbee');
INSERT INTO tbl_toys (toy_id,toy) VALUES (9,'kite');
INSERT INTO tbl_toys (toy_id,toy) VALUES (12,'yoyo');


DROP TABLE IF EXISTS tbl_toys_other;
CREATE TABLE tbl_toys_other (
  toy_id 	     INT UNSIGNED NOT NULL ,
  CONSTRAINT C1_FK
  FOREIGN KEY (toy_id)
  REFERENCES tbl_toys(toy_id),
  store_id 	      INT UNSIGNED NOT NULL,
  inventory 	  INT UNSIGNED NOT NULL,
  store_address   VARCHAR(30) NOT NULL,
  PRIMARY KEY(toy_id, store_id) #composite PK
);
/*
2NF is relevant IFF the PK is composite. 
A table is in 2NF if it is in 1NF AND every non key field(a field not part of the PK) 
is completely dependant on the whole primary key, not on any part of it.
Here we see that store_address is dependant on part of the primary key 
since it only depends on store_id
*/

DESC tbl_toys_other;

INSERT INTO tbl_toys_other (toy_id,store_id,inventory,store_address) VALUES (5,1,34,'23 Maple');
INSERT INTO tbl_toys_other (toy_id,store_id,inventory,store_address) VALUES (5,3,12,'100 E. North St.');
INSERT INTO tbl_toys_other (toy_id,store_id,inventory,store_address) VALUES (6,2,10,'1902 Amber Ln.');
INSERT INTO tbl_toys_other (toy_id,store_id,inventory,store_address) VALUES (6,4,24,'17 Engleside');
INSERT INTO tbl_toys_other (toy_id,store_id,inventory,store_address) VALUES (9,1,50,'23 Maple');
INSERT INTO tbl_toys_other (toy_id,store_id,inventory,store_address) VALUES (9,2,2,'1902 Amber Ln.');
INSERT INTO tbl_toys_other (toy_id,store_id,inventory,store_address) VALUES (12,4,28,'17 Engleside');
#try to add a record for a non-existing toy_id - cannot do this
#INSERT INTO toy_other (toy_id,store_id,inventory,store_address) VALUES (10,4,28,'17 Engleside');

SELECT * FROM tbl_toys;
SELECT * FROM tbl_toys_other;

SHOW TABLES;



