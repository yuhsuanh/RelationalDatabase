/*
Name: Yu-Hsuan Huang
Date: May 21, 2020
Purpose: create a databse and make it active
*/

#Method 1
-- Create a database if it does not exist
CREATE DATABASE IF NOT EXISTS georgian_college;

-- Use database
USE georgian_college;

-- Drop database if it exists
-- DROP DATABASE IF EXISTS georgian_college;





#Method 2
-- Drop database if it exists
DROP DATABASE IF EXISTS georgian_college;

-- Create a database
CREATE DATABASE georgian_college;

-- Use database
USE georgian_college;