-- Please provide your name(s) and  date

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