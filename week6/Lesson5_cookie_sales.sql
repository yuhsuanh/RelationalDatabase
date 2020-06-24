/*
Name: Anju Chawla
Date: June 2020 
Purpose: To create a database and a table therein to store sale_amount made by girls scouts.
To retrieve information using advanced SELECT statements and inbuilt group functions in MySQL.
*/

-- set the environment
SET SQL_MODE = "STRICT_ALL_TABLES";
SET SQL_SAFE_UPDATES=0;


-- drop existing database, if any, before creating it and then using it
DROP DATABASE IF EXISTS db_girl_scouts;
CREATE DATABASE db_girl_scouts;
USE db_girl_scouts;

-- drop table by same name, if any exists, before creating it
DROP TABLE IF EXISTS tbl_cookie_sales;

-- create table structure; table will store the following deatils for the girl scouts
CREATE TABLE tbl_cookie_sales (
  id          		INT  UNSIGNED AUTO_INCREMENT,
  first_name  		VARCHAR(20) NOT NULL,				-- first name of the girl scout
  sale_amount       DECIMAL(4,2) UNSIGNED NOT NULL,		-- the sale amount she made
  sale_date   		DATE NOT NULL,						-- the date on which she made the sale
  PRIMARY KEY  (id)
  );
  
 -- ALTER TABLE tbl_cookie_sales
 -- AUTO_INCREMENT = 100 ;

-- insert records in the table
-- do not bother to populate  auto_increment fields; don't put numeric fields in quotes

INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Lindsey',32.02,'2007-03-12');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Nicole',26.53,'2007-03-12');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Britney',11.25,'2007-03-12');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Ashley',18.96,'2007-03-12');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Lindsey',9.16,'2007-03-11');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Nicole',1.52,'2007-03-11');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Britney',43.21,'2007-03-11');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Ashley',8.05,'2007-03-11');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Lindsey',17.62,'2007-03-10');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Nicole',24.19,'2007-03-10');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Britney',3.40,'2007-03-10');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Ashley',15.21,'2007-03-10');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Lindsey',0.00,'2007-03-09');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Nicole',31.99,'2007-03-09');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Britney',2.58,'2007-03-09');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Ashley',0.00,'2007-03-09');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Lindsey',2.34,'2007-03-08');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Nicole',13.44,'2007-03-08');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Britney',8.78,'2007-03-08');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Ashley',26.82,'2007-03-08');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Lindsey',3.71,'2007-03-07');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Nicole',0.56,'2007-03-07');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Britney',34.19,'2007-03-07');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Ashley',7.77,'2007-03-07');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Lindsey',16.23,'2007-03-06');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Nicole',2.00,'2007-03-06');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Britney',4.50,'2007-03-06');
INSERT INTO tbl_cookie_sales (first_name,sale_amount,sale_date) VALUES ('Ashley',19.22,'2007-03-06');

-- select all records from the table
SELECT  * FROM tbl_cookie_sales;

-- show all records sorted by first name of the scout
SELECT * FROM tbl_cookie_sales
ORDER BY first_name;  -- ASC is default


-- sort on more than one fields - first name descending and sale date ascending
SELECT * FROM tbl_cookie_sales
ORDER BY first_name DESC, sale_date ASC ;  

-- show total sale_amount for this group of girls
SELECT SUM(sale_amount) 'Total Sale Amount($)'
FROM tbl_cookie_sales;

-- total sale amount by each girl scout, order by total sale amount highest to lowest
SELECT first_name 'Name', SUM(sale_amount) 'Total Sale Amount($)'
FROM tbl_cookie_sales
GROUP BY first_name
ORDER BY 2 DESC;

-- the maximum sale in the group
SELECT MAX(sale_amount) 'Maximum Sale($)'
FROM tbl_cookie_sales;

-- the minimum sale in the group
SELECT MIN(sale_amount) 'Minimum Sale($)'
FROM tbl_cookie_sales;

-- the average sale in the group
SELECT ROUND(AVG(sale_amount),2) 'Average Sale($)'
FROM tbl_cookie_sales;



-- number of  sales  made - COUNT will not count NULL values
SELECT COUNT(sale_amount) 'Number of sale_amount'
FROM tbl_cookie_sales;

-- number of sales > 0
SELECT COUNT(sale_amount) 'Number of sale_amount > 0'
FROM tbl_cookie_sales
WHERE sale_amount  > 0;

-- number of 'no sales' were made
SELECT COUNT(sale_amount) 'Number of sale_amount = 0'
FROM tbl_cookie_sales
WHERE sale_amount  =  0;

-- display number of sales > 0 made on 2007-03-12
SELECT COUNT(sale_amount) 'Number of sale amount > 0  on March 12'
FROM tbl_cookie_sales
WHERE sale_amount  >  0 AND sale_date  = CAST('2007-03-12' AS DATE); -- cast date values

SELECT COUNT(sale_amount) 'Number of sale amount> 0  on March 12'
FROM tbl_cookie_sales
WHERE sale_amount  >  0 AND sale_date  = CAST(20070312 AS DATE); -- cast date values

-- max sale amount by each girl scout ordered by the max sale
SELECT first_name, MAX(sale_amount) 'Maximum Sale($)'
FROM tbl_cookie_sales
GROUP BY first_name
ORDER BY 2; -- MAX(sale_amount);



-- average sale amount by each girl scout with two places after decimal point; order by first name
SELECT first_name 'Name',  ROUND(AVG(sale_amount),2) 'Average Sale($)' -- SUM(sale_amount) 'Total Sales($)'
FROM tbl_cookie_sales
GROUP BY first_name
ORDER BY first_name;

SELECT first_name 'Name', CAST(AVG(sale_amount) AS DECIMAL(4,2)) 'Average Sale($)'
FROM tbl_cookie_sales
GROUP BY first_name
ORDER BY first_name;

-- number of days that a sale was done
SELECT COUNT(sale_amount) -- COUNT(*)
FROM tbl_cookie_sales
WHERE sale_amount > 0; 

-- name of the girl and the number of days she made a sale(>0)
SELECT first_name 'Name', COUNT(sale_amount) AS 'Number of Sale Days' 
FROM tbl_cookie_sales
WHERE sale_amount > 0
GROUP BY first_name
ORDER BY 1
;


-- use of DISTINCT -  count the distinct dates/days where sale_amount were made(>0)
SELECT COUNT(DISTINCT sale_date) 'No. of Sale Days'
FROM  tbl_cookie_sales
WHERE sale_amount > 0;

-- which girl(s) sold cookies(sale amount >0) on maximum number of days

/*
-- not correct- assuming there is only one girl who sold cookies on the 'maximum' days out of all girl scouts
SELECT first_name, COUNT(sale_date) 'Sale Days'
FROM tbl_cookie_sales
WHERE sale_amount > 0
GROUP BY first_name
ORDER BY 2 DESC
LIMIT 1;
*/

-- fool proof AND CORRECT
-- assign the maximum count to a variable ; only one field/calculated field in the SELECT
SET @max_sale = (SELECT COUNT(sale_date) 
FROM tbl_cookie_sales
WHERE sale_amount > 0
GROUP BY first_name
ORDER BY 1 DESC
LIMIT 1);

-- SELECT @max_sale;

SELECT first_name 'Name', COUNT(sale_date) 'Sale Days' 
FROM tbl_cookie_sales
WHERE sale_amount > 0
GROUP BY first_name
HAVING COUNT(sale_date) = @max_sale
ORDER BY  first_name;
-- LIMIT 

-- without the variable - inefficient since the inner select/subquery is executed for every group
SELECT first_name 'Name', COUNT(sale_date) 'Sale Days' 
FROM tbl_cookie_sales
WHERE sale_amount > 0
GROUP BY first_name
HAVING COUNT(sale_date) = (SELECT COUNT(sale_date) 
FROM tbl_cookie_sales
WHERE sale_amount > 0
GROUP BY first_name
ORDER BY 1 DESC
LIMIT 1)
ORDER BY  first_name;









