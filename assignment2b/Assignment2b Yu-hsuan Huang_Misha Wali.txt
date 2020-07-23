/*
	Authors: 
		200443723 - Yu-Hsuan Huang
		200443124 - Misha Wali
	Date:
		July 23, 2020
	Topic:
		COMP2003 Relational Database - Assignment 2B
    Purpose:
		Answering the assignemt 2b qusetions from the word file.
	Description:
		The tables and data created by the instructor, Anju K. Chawla.
        I will answer the 9 questions which are Multi table operations joins and subqueries question.
*/

-- drop the database, if it exists, create one and use it
DROP DATABASE IF EXISTS db_premiere_products;
CREATE DATABASE db_premiere_products;
USE db_premiere_products;

-- set the environment
SET SQL_MODE = 'STRICT_ALL_TABLES';
SET SQL_MODE = 'ONLY_FULL_GROUP_BY';
SET DEFAULT_STORAGE_ENGINE =  INNODB;

-- create the table structure to store the information of sale representatives
CREATE TABLE tbl_rep
(
	rep_number     		CHAR(2) PRIMARY KEY,	-- the unique identifying number of the sale representative
	last_name   		VARCHAR(15),			-- last name of sale representative
	first_name  		VARCHAR(15),			-- first name of sale representative
	street      		VARCHAR(15),			-- street address of where the sale representative lives
	city        		VARCHAR(15),			-- city where the sale representative lives
	state       		CHAR(2),				-- state where the sale representative lives
	zip         		CHAR(5),				-- zip of where the sale representative lives
	commission_amount  	DECIMAL(7,2) UNSIGNED,	-- commission amount earned by the sale representative
	commission_rate     DECIMAL(3,2) UNSIGNED	-- rate at which the commission is earned
);

-- create the table structure to store the information of customers
CREATE TABLE tbl_customer
(
	customer_number  	CHAR(3) PRIMARY KEY,	-- the unique identifying number of the customer business
	customer_name 		VARCHAR(35) NOT NULL,	-- the name of the customer
	street 		      	VARCHAR(15),			-- street address of customer business
	city 		        VARCHAR(15),			-- city of customer business
	state 		     	CHAR(2),				-- state of customer business
	zip 		        CHAR(5),				-- zip of customer business
	balance 	     	DECIMAL(8,2) UNSIGNED,	-- the amount the customer owes 
	credit_limit 	  	DECIMAL(8,2) UNSIGNED,	-- credit limit allowed to the customer business
	rep_number 	      	CHAR(2),				-- the number of the sale representative associated with the customer
    FOREIGN KEY(rep_number) REFERENCES tbl_rep(rep_number)
 );

-- create the table structure to store the order information 
CREATE TABLE tbl_orders
(
	order_number 	   	CHAR(5) PRIMARY KEY,	-- the unique identifying order number of the order placed by the customer
	order_date 	   	   	DATE,					-- the date on which the order was placed
	customer_number 	CHAR(3),				-- the identifying number of the customer business who placed the order; a customer can place more than one order
	FOREIGN KEY(customer_number) REFERENCES tbl_customer(customer_number) 
);

-- create the table structure to store the part information; 'independent' table ; these parts are ordered by customers
CREATE TABLE tbl_part
(
	part_number 		CHAR(4) PRIMARY KEY,	-- the uniques identifying number of the part
	part_description	VARCHAR(15),			-- the description of the part
	on_hand 	    	TINYINT UNSIGNED,		-- the quntity on hand in the warehouse
	class 		    	CHAR(2),				-- the class to which the part belongs, for example, Appliances(AP), Hardware(HW), Sports Goods(SG)
	warehouse 	  		CHAR(1),				-- the warehouse in which the part is stocked
	price 		    	DECIMAL(6,2) UNSIGNED	-- the price of the part
);

-- create the table structure to store the details of each order, each order can consist of multiple parts 
CREATE TABLE tbl_order_line
(
	order_number 	    CHAR(5),				-- the order number of the order
	part_number 	    CHAR(4),				-- the part number of the part on order
	number_ordered	 	TINYINT UNSIGNED,		-- the quantity/number of the part ordered
	quoted_price  		DECIMAL(6,2) UNSIGNED,	-- the price quoted for the part, may be different from the price of the part
	PRIMARY KEY(order_number, part_number),
	FOREIGN KEY(order_number) REFERENCES tbl_orders(order_number),
	FOREIGN KEY(part_number)  REFERENCES tbl_part(part_number)
);

-- insert relevant data records in the different tables

INSERT INTO tbl_rep
VALUES
('20','Kaiser','Valerie','624 Randall','Grove','FL','33321',20542.50,0.05),
('25','Smith','Greg','124 Jackson','Grove','FL','33321',10042.50,0.05),
('30','Burke','Mark','624 Capilano','Grove','FL','33321',30542.50,0.06),
('35','Hull','Richard','532 Jackson','Sheldon','FL','33553',39216.00,0.07),
('40','Jackson','Joanne','124 Capilano','Sheldon','FL','33553',40000.00,0.08),
('65','Perez','Juan','1626 Taylor','Fillmore','FL','33336',23487.00,0.05),
('99','Chawla','Anju','1 Georgain Dr','Barrie','ON','11111',0,0.05);


INSERT INTO tbl_customer
VALUES
('148','Al''s Appliance and Sport','2837 Greenway','Fillmore','FL','33336',6550.00,7500.00,'20'),
('282','Brookings Direct','3827 Devon','Grove','FL','33321',431.50,10000.00,'35'),
('356','Ferguson''s','382 Wildwood','Northfield','FL','33146',5785.00,7500.00,'65'),
('408','The Everything Shop','1828 Raven','Crystal','FL','33503',5285.25,5000.00,'30'),
('462','Bargains Galore','3829 Central','Grove','FL','33321',3412.00,10000.00,'65'),
('524','Kline''s','838 Ridgeland','Fillmore','FL','33336',12762.00,15000.00,'20'),
('608','Johnson''s Department Store','372 Oxford','Sheldon','FL','33553',2106.00,10000.00,'65'),
('687','Lee''s Sport and Appliance','282 Evergreen','Altonville','FL','32543',2851.00,5000.00,'35'),
('725','Deerfield''s Four Seasons','282 Columbia','Sheldon','FL','33553',248.00,7500.00,'40'),
('842','All Season','28 Lakeview','Grove','FL','33321',8221.00,7500.00,'25');

INSERT INTO tbl_orders
VALUES
('21608','2010-10-20','148'),
('21610','2010-10-20','356'),
('21613','2010-10-21','408'),
('21614','2010-10-21','282'),
('21617','2010-10-23','608'),
('21619','2010-11-23','148'),
('21623','2010-11-23','608'),
('21625','2010-11-24','408');


INSERT INTO tbl_part
VALUES
('AT94','Iron',50,'HW','3',24.95),
('BV06','Home Gym',45,'SG','2',794.95),
('CD52','Microwave Oven',32,'AP','1',165.00),
('DL71','Cordless Drill',21,'HW','3',129.95),
('DR93','Gas Range',8,'AP','2',495.00),
('DW11','Washer',12,'AP','3',399.99),
('FD21','Stand Mixer',22,'HW','3',159.95),
('KL62','Dryer',12,'AP','1',349.95),
('KT03','Dishwasher',8,'AP','3',595.00),
('KV29','Treadmill',9,'SG','2',1390.00);

INSERT INTO tbl_order_line
VALUES
('21608','AT94',11,21.95),
('21610','DR93',1,495.00),
('21610','DW11',1,399.99),
('21613','KL62',4,329.95),
('21614','KT03',2,595.00),
('21617','BV06',2,794.95),
('21617','CD52',4,150.00),
('21619','DR93',1,495.00),
('21623','KV29',2,1290.00),
('21623','CD52',2,165.00),
('21625','DW11',1,399.99);


-- display records of all the tables
SELECT * FROM tbl_rep;
SELECT * FROM tbl_customer;
SELECT * FROM tbl_orders;
SELECT * FROM tbl_part;
SELECT * FROM tbl_order_line;




/*
=============== Start from here ===============
*/
# 1. Use ONLY an OUTER JOIN to display the order number and order date for those orders that have exactly two different parts on the order. Sort the result in descending order number. For example, order number 21617 has two parts BV06 and CD52 on order.
SELECT OD.order_number `order number`, OD.order_date `order date`
FROM tbl_orders OD LEFT OUTER JOIN tbl_order_line OL
ON OD.order_number = OL.order_number
GROUP BY OD.order_number
HAVING count(OD.order_number) = 2
ORDER BY OD.order_number DESC;

# 2. Use ONLY an OUTER JOIN to list the order number, part number, part description, price, quoted price and the price discount(= price – quoted_price) for those parts that are on order and the price discount > 0. Order the result by part number. For example, part number AT94 with order number 21608 was given a discount of 3 dollars.
SELECT OL.order_number `order number`, OL.part_number `part number`, PT.part_description `part description`, PT.price `price`, OL.quoted_price `quoted price`, (PT.price - OL.quoted_price) `price discount` 
FROM tbl_order_line OL LEFT OUTER JOIN tbl_part PT
ON OL.part_number = PT.part_number
WHERE (PT.price - OL.quoted_price) > 0
ORDER BY OL.part_number;

# 3. Use ONLY an INNER JOIN to list the rep number and full address (concatenate the street, city, state and zip each separated by a comma) of the rep, with the name of the customer he/she represents, if the rep number's street contains Jackson. YOU NEED TO USE STRING FUNCTION(S) to check if the street contains Jackson and LIKE is not a function fyi. Sort the output by rep number. For example, rep 25 lives on street 124 Jackson.
SELECT REP.rep_number `rep number`, CONCAT(REP.street, ', ', REP.city ,', ', REP.state, ', ' , REP.zip) `full address`, CUS.customer_name `customer name`
FROM tbl_rep REP INNER JOIN tbl_customer CUS
USING(rep_number)
WHERE INSTR(REP.street, 'Jackson') != 0
ORDER BY REP.rep_number;

# 4. Use ONLY an INNER JOIN to display the customer number and his/her order total, only for all his/her orders, if the order total >= 1000. Sort the output by customer number. The total of any order is (quantity_ordered* quoted_price). For example, the order total for customer 408, who has two orders, is 4*329.95 + 1*399.99 = 1719.79
SELECT OD.customer_number `customer number`, SUM(OL.number_ordered * OL.quoted_price) `order total`
FROM tbl_orders OD INNER JOIN tbl_order_line OL
USING (order_number)
GROUP BY (OD.customer_number)
HAVING SUM(OL.number_ordered * OL.quoted_price) >= 1000
ORDER BY OD.customer_number;

# 5. Use ONLY a JOIN to display the rep number and full name (concatenate the first and last name, separated by a blank) of the rep(s) who does not represent any customer currently. For example, rep number 99 (Anju Chawla) does not represent any customer.
SELECT REP.rep_number `rep number`, CONCAT_WS(' ', REP.first_name, REP.last_name) `full name`
FROM tbl_rep REP LEFT OUTER JOIN tbl_customer CUS
USING (rep_number)
WHERE CUS.customer_number IS NULL;

# 6. Using a CORRELATED SUBQUERY ONLY (with exists/not exists), find the rep number and rep name (first name and last name concatenated) of each rep who represents a customer living in the zip 33321. Order the result by rep number. For example, rep number 25, Greg Smith has a customer living in that zip.
SELECT rep_number `rep number`, CONCAT(first_name, last_name) `full name`
FROM tbl_rep
WHERE rep_number IN (SELECT rep_number FROM tbl_customer WHERE zip = '33321')
ORDER BY rep_number;

# 7. Using a CORRELATED SUBQUERY ONLY (with exists/not exists), find the customer number and name of each customer whose rep does not live in city Grove. Order the result by customer number. For example, the rep of customer number 282 (Brookings Direct) does not live in Grove city.
SELECT customer_number `customer number`, customer_name `customer name`
FROM tbl_customer
WHERE rep_number IN (SELECT rep_number FROM tbl_rep WHERE city NOT IN ('Grove'))
ORDER BY customer_number;

# 8. Use ONLY a subquery to find the number and name of each customer that currently has an order on file for a Washer (description of the part). No other information is available so code the solution only based on information given. For example, customer number 356 (Ferguson's) has an order for Washer.
SELECT CUS.customer_number `customer number`, CUS.customer_name `customer name`
FROM tbl_customer CUS, tbl_orders OD, tbl_order_line OL
WHERE OL.part_number = (SELECT part_number FROM tbl_part WHERE part_description = 'Washer')
	AND OL.order_number = OD.order_number 
    AND OD.customer_number = CUS.customer_number;

# 9. Use ONLY a subquery and the ANY(not ALL) keyword (NO INBUILT FUNCTION ALLOWED) to list the part number, part description, unit price and class for each part that has a unit price greater than the unit price of every part in the Appliances class, AP. Order the results by part number. For example, price of part number BV06 (Home Gym) is greater than the price of all parts in the AP class.
SELECT part_number `part number`, part_description `part description`, price, class
FROM tbl_part
WHERE price > ANY (SELECT price FROM tbl_part WHERE class = 'AP')
	AND class != 'AP';
