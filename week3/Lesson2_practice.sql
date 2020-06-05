/*
*Name:
*Date:
*Purpose:To create a database to store a table with drink information. To write SELECT statements to query the data.
*/

#drop any existing database; create a new one and use it
DROP DATABASE IF EXISTS db_drinks;
CREATE DATABASE db_drinks;
USE db_drinks;

#drop if the table already exists
#DROP TABLE IF EXISTS tbl_drinks;
#create a table to store information about drinks
CREATE TABLE tbl_drinks(
	drink_name  		VARCHAR(20) PRIMARY KEY,	
	drink_cost			DEC(4,2) UNSIGNED NOT NULL,	
	carbs_grams			FLOAT(4,1) UNSIGNED NOT NULL,
	drink_color			VARCHAR(10) NOT NULL,
	drink_has_ice	    ENUM('Yes', 'No') NOT NULL DEFAULT 'Yes', 
    calories			TINYINT UNSIGNED 
);

#insert data into the drinks table
INSERT INTO tbl_drinks
VALUES
('Blackthorn', 3, 8.4, 'Yellow', 'Yes', 33),
('Blue Moon', 2.5, 3.2, 'Blue', 'Yes', NULL),
('Oh My Gosh', 3.5, 8.61, 'Orange', 'Yes', 35),
('Lime Fizz', 2.5, 5.4, 'Green', 'Yes', 24),
('Kiss on the Lips', 5.5, 42.52, 'Purple', 'Yes', 171),
('Hot Gold', 3.2, 32.1, 'Orange', 'No', 135),
('Lone Tree', 3.6, 4.2, 'Red', 'Yes', 17),
('Greyhound', 4, 14, 'Yellow', 'Yes', 50),
('Indian Summer', 2.8, 7.2, 'Brown', 'no', 30),
('Bull Frog', 2.6, 21.5, 'Tan', 'Yes', 80),
('Martini',3,0.8,'Clear','No', 112),
('M',3,0.8,'Clear','No', 112), #to double check that solution 6 works correctly
('Soda and It', 3.8, 4.7, 'Red', 'No', 19),
('Penicillin Cocktail', 5 , 11, 'Honey', 'Yes', 189),
('Zaza', 3, 9, 'Red', 'No', 181);

#display all the records from the table
SELECT * FROM tbl_drinks;

/*
Answer the following queries using Select statements. DO NOT PEEK IN THE DATA BEFORE YOU ANSWER THESE QUERIES. Check that the results are correct by comparing the resultant table with the drinks data table manually. The output is correct and the instructions in the query should be completely followed. Add these solutions (SELECT statements) to the end of the script, numbering them correctly.
Note: If column names are not mentioned, then all information needs to be displayed.

1)	Select the drinks whose name starts with an ‘O’ and those that start with a ‘P’.
2)	Select the drink name of all the drinks that have more than 20 carbs and contain ice.
3)	Select all drinks that have no defined calorie information. 
4)	Select the name, cost, carbs and calories of all drinks that do not contain ice, using the ‘NOT’ boolean operator.
5)	Select the name and cost of all the drinks that have carbs in the range 5 to 10 grams, inclusive, WITHOUT the use of BETWEEN verb. Display Drink Name and Price($) as the column headings respectively.
6)	Select all drinks whose name begin with the letters I, J, K or L using the BETWEEN verb. Sort the records in descending order by drink name. 
7)	Use the IN verb to select all drinks that are either blue or purple in color. Sort the records in ascending order by drink name. 
8)	Use an inbuilt string function to display the records for drinks whose drink name starts with the letter Z.
9)	Write a select statement to display the two records, record numbers 5 and 6, after you sort the records in the table in ascending order by calories.
10)	Select the drink name, cost, carbs and calories of all drinks that are neither red nor orange in color, displaying the result by descending order of drink name. I want to see the use of the Boolean operator NOT in the solution. You do not know the colors of any other drinks.

*/

# 1)	Select the drinks whose name starts with an ‘O’ and those that start with a ‘P’.
SELECT * 
FROM tbl_drinks
WHERE drink_name LIKE 'O%' OR drink_name LIKE 'P%';

# 2)	Select the drink name of all the drinks that have more than 20 carbs and contain ice.
SELECT * 
FROM tbl_drinks
WHERE carbs_grams > 20 AND drink_has_ice = 'Yes';

# 3)	Select all drinks that have no defined calorie information. 
SELECT * 
FROM tbl_drinks
WHERE calories IS NULL;

# 4)	Select the name, cost, carbs and calories of all drinks that do not contain ice, using the ‘NOT’ boolean operator.
SELECT drink_name AS 'name', drink_cost 'cost', carbs_grams carbs, calories
FROM tbl_drinks
WHERE NOT drink_has_ice = 'Yes';

# 5)	Select the name and cost of all the drinks that have carbs in the range 5 to 10 grams, inclusive, WITHOUT the use of BETWEEN verb. Display Drink Name and Price($) as the column headings respectively.
SELECT drink_name 'Drink Name', drink_cost 'Price($)'
FROM tbl_drinks
WHERE carbs_grams > 5 AND carbs_grams < 10;

# 6)	Select all drinks whose name begin with the letters I, J, K or L using the BETWEEN verb. Sort the records in descending order by drink name. 
SELECT *
FROM tbl_drinks
WHERE LEFT(drink_name, 1) BETWEEN 'I' AND 'L'
ORDER BY drink_name DESC;

# 7)	Use the IN verb to select all drinks that are either blue or purple in color. Sort the records in ascending order by drink name. 
SELECT *
FROM tbl_drinks
WHERE drink_color IN ('Blue', 'Purple')
ORDER BY drink_name;

# 8)	Use an inbuilt string function to display the records for drinks whose drink name starts with the letter Z.
SELECT * 
FROM tbl_drinks
WHERE LEFT(drink_name, 1) = 'Z';

# 9)	Write a select statement to display the two records, record numbers 5 and 6, after you sort the records in the table in ascending order by calories.
SELECT * 
FROM tbl_drinks
ORDER BY calories
LIMIT 4, 2;

# 10)	Select the drink name, cost, carbs and calories of all drinks that are neither red nor orange in color, displaying the result by descending order of drink name. I want to see the use of the Boolean operator NOT in the solution. You do not know the colors of any other drinks.
SELECT * 
FROM tbl_drinks
WHERE drink_color NOT IN ('Red', 'Orange')
ORDER BY drink_name DESC;