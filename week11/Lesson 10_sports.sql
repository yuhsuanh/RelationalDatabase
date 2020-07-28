/*
Name: Anju Chawla
Date: July 2020
Purpose: To create a sports database and related tables therein populating them with data about players. 
Thereafter query the tables using subqueries and joins
*/
-- set the environment
SET SQL_MODE = "STRICT_ALL_TABLES";
SET SQL_SAFE_UPDATES=0;
SET SQL_MODE = 'ONLY_FULL_GROUP_BY';
SET DEFAULT_STORAGE_ENGINE =  INNODB;

-- drop the database if exists, create it and use it
DROP DATABASE IF EXISTS db_sports;
CREATE DATABASE db_sports;
USE db_sports;


-- create table tbl_players to save information about players

CREATE TABLE tbl_players
    (
      playerNumber      INT        		UNSIGNED	,
      playerName    	CHAR(15)    	Not NULL	,
      initials      	CHAR(3)     	Not NULL	,
      birthDate     	DATE                		,
      sex           	ENUM('M','F') 	Not NULL	,
      joined        	YEAR       		Not NULL	,
      street        	VARCHAR(30) 	Not NULL	,
      houseNumber       CHAR(4)             		,
      postalCode      	CHAR(6)             		,
      town          	VARCHAR(30) 	Not NULL	,
      phoneNumber       CHAR(13)            		,
      leagueNumber      CHAR(4)             		,
      PRIMARY KEY  (playerNumber)
    );

-- create table tbl_teams to save information about teams 

CREATE TABLE tbl_teams
    (
      teamNumber    	INT         UNSIGNED			,
      captain       	INT         UNSIGNED Not NULL	,
      division      	CHAR(6)     Not NULL			,
      PRIMARY KEY   (teamNumber),
      FOREIGN KEY (captain) REFERENCES tbl_players (playerNumber)
    );

-- create table tbl_penalties to save information on penalties incurred by players
    
CREATE TABLE tbl_penalties
    (
      paymentNumber     INT         UNSIGNED 			,
      playerNumber      INT         UNSIGNED Not NULL	,
      paymentDate   	DATE        Not NULL			,
      amount        	DEC(7,2)    UNSIGNED Not NULL	,
      PRIMARY KEY   (paymentNumber),
      FOREIGN KEY (playerNumber) REFERENCES tbl_players (playerNumber)
    );


-- populate the tbl_players table
INSERT INTO tbl_players VALUES (2, 'Everett',   'R',   '1948-09-01', 'M', 1975, 'Stoney Road',    '43', '3575NH', 'Stratford', '070-237893', '2411');
INSERT INTO tbl_players VALUES (6, 'Parmenter', 'R',   '1964-06-25', 'M', 1977, 'Haseltine Lane', '80', '1234KK', 'Stratford', '070-476537', '8467');
INSERT INTO tbl_players VALUES (7, 'Wise',      'GWS', '1963-05-11', 'M', 1981, 'Edgecombe Way',  '39', '9758VB', 'Stratford', '070-347689',  NULL);
INSERT INTO tbl_players VALUES (8, 'Newcastle', 'B',   '1962-07-08', 'F', 1980, 'Station Road',   '4',  '6584RO', 'Inglewood', '070-458458', '2983');
INSERT INTO tbl_players VALUES (27, 'Collins',  'DD',  '1964-12-28', 'F', 1983, 'Long Drive',     '804', '8457DK', 'Eltham',   '079-234857', '2513');
INSERT INTO tbl_players VALUES (28, 'Collins',  'C',   '1963-06-22', 'F', 1983, 'Old Main Road',  '10', '1294QK', 'Midhurst',  '071-659599',  NULL);
INSERT INTO tbl_players VALUES (39, 'Bishop',   'D',   '1956-10-29', 'M', 1980, 'Eaton Square',   '78', '9629CD', 'Stratford', '070-393435',  NULL);
INSERT INTO tbl_players VALUES (44, 'Baker',    'E',   '1963-01-09', 'M', 1980, 'Lewis Street',   '23', '4444LJ', 'Inglewood', '070-368753', '1124');
INSERT INTO tbl_players VALUES (57, 'Brown',    'M',   '1971-08-17', 'M', 1985, 'Edgecombe Way',  '16', '4377CB', 'Stratford', '070-473458', '6409');
INSERT INTO tbl_players VALUES (83, 'Hope',     'PK',  '1956-11-11', 'M', 1982, 'Magdalene Road', '16A', '1812UP','Stratford', '070-353548', '1608');
INSERT INTO tbl_players VALUES (95, 'Miller',   'P',   '1963-05-14', 'M', 1972, 'High Street',    '33A', '57460P', 'Douglas',  '070-867564',  NULL);
INSERT INTO tbl_players VALUES (100,'Parmenter','P',   '1963-02-28', 'M', 1979, 'Haseltine Lane', '80',  '1234KK', 'Stratford','070-494593', '6524');
INSERT INTO tbl_players VALUES (104,'Moorman',  'D',   '1970-05-10', 'F', 1984, 'Stout Street',   '65',  '9437A0', 'Eltham',   '079-987571', '7060');
INSERT INTO tbl_players VALUES (112, 'Bailey',  'IP',  '1963-10-01', 'F', 1984, 'Vixen Road',     '8',   '6392LK', 'Plymouth', '010-548745', '1319');

-- populate the tbl_teams table
INSERT INTO tbl_teams VALUES (1, 6, 'first');
INSERT INTO tbl_teams VALUES (2, 27, 'second');
INSERT INTO tbl_teams VALUES (3, 112, 'second');


-- populate the penalities tables
INSERT INTO tbl_penalties VALUES (1,  6, '1980-12-08', 100);
INSERT INTO tbl_penalties VALUES (2, 44, '1981-05-05', 75);
INSERT INTO tbl_penalties VALUES (3, 27, '1983-09-10', 100);
INSERT INTO tbl_penalties VALUES (4, 104,'1984-12-08', 50);
INSERT INTO tbl_penalties VALUES (5, 44, '1980-12-08', 25);
INSERT INTO tbl_penalties VALUES (6,  8, '1980-12-08', 25);
INSERT INTO tbl_penalties VALUES (7, 44, '1982-12-30', 30);
INSERT INTO tbl_penalties VALUES (8, 27, '1984-11-12', 75);

-- display records of all the tables
SELECT * FROM tbl_players;
SELECT * FROM tbl_teams;
SELECT * FROM tbl_penalties;


/******************************************************************************************************/
/*Question 1a - Find the name and initials of the players for whom at least one penalty has been paid */
/* SHOW THE NAME, INITIALS ONLY ONCE                                                                  */
/******************************************************************************************************/
-- inner join
SELECT DISTINCT playerName 'Player Name', initials 'Initials'
FROM tbl_players PL INNER JOIN tbl_penalties P
ON PL.playerNumber = P.playerNumber;

SELECT  PL.playerNumber, playerName 'Player Name', initials 'Initials'
FROM tbl_players PL INNER JOIN tbl_penalties P
ON PL.playerNumber = P.playerNumber
GROUP BY PL.playerNumber;

SELECT DISTINCT playerName 'Player Name', initials 'Initials'
FROM tbl_players PL INNER JOIN tbl_penalties P
USING(playerNumber);

SELECT DISTINCT playerName 'Player Name', initials 'Initials'
FROM tbl_players PL NATURAL JOIN tbl_penalties P
;

SELECT DISTINCT playerName 'Player Name', initials 'Initials'
FROM tbl_players PL , tbl_penalties P
WHERE PL.playerNumber = P.playerNumber;


-- outer join
-- more efficient because you are only checking the players who have made a penalty
SELECT DISTINCT playerName 'Player Name', initials 'Initials'
FROM tbl_players PL RIGHT OUTER JOIN tbl_penalties P
ON PL.playerNumber = P.playerNumber;

-- less efficient - more records because every player is being checked and 
-- will have to filter the records
SELECT DISTINCT playerName 'Player Name', initials 'Initials'
FROM tbl_players PL LEFT OUTER JOIN tbl_penalties P
ON PL.playerNumber = P.playerNumber
WHERE paymentNumber IS Not NULL;


-- subquery
SELECT playerName 'Player Name', initials 'Initials'
FROM tbl_players 
WHERE playerNumber IN
(SELECT DISTINCT playerNumber FROM tbl_penalties); -- distinct will create a smaller list
-- if engine stops searching at first find, then distinct Not required

-- correlated subquery
SELECT playerName 'Player Name', initials 'Initials'
FROM tbl_players P
WHERE EXISTS
(SELECT * FROM tbl_penalties PP WHERE P.playerNumber = PP.playerNumber ); 

/******************************************************************************************************/
/*Question 1b - Find the name and initials of the players who have paid no penalties              */	
/******************************************************************************************************/
-- outer join 
SELECT  PL.playerNumber, playerName 'Player Name', initials 'Initials'
FROM tbl_players PL LEFT OUTER JOIN tbl_penalties P
ON PL.playerNumber = P.playerNumber
WHERE paymentNumber IS NULL;
-- subquery
SELECT playerName 'Player Name', initials 'Initials'
FROM tbl_players 
WHERE playerNumber NOT IN
(SELECT DISTINCT playerNumber FROM tbl_penalties); -- distinct will create a smaller list
-- engine has to search the complete list

-- correlated subquery
SELECT playerName 'Player Name', initials 'Initials'
FROM tbl_players P
WHERE NOT EXISTS
(SELECT * FROM tbl_penalties PP WHERE P.playerNumber = PP.playerNumber );

/******************************************************************************************************/
/*Question 1c - Find the name and initials of the players for whom at least two penalties have been paid 					                                                                              */
/******************************************************************************************************/
-- inner join
SELECT playerName 'Player Name', initials 'Initials'
FROM tbl_players PL INNER JOIN tbl_penalties P
ON PL.playerNumber = P.playerNumber
GROUP BY PL.playerNumber  -- group by unique number, Not by name which may be duplicate
HAVING COUNT(*) >= 2;

-- outer join
-- most efficient because you are only checking the players who have made a penalty
SELECT playerName 'Player Name', initials 'Initials'
FROM tbl_players PL RIGHT OUTER JOIN tbl_penalties P
ON PL.playerNumber = P.playerNumber
GROUP BY PL.playerNumber  -- group by unique number, Not by name which may be duplicate
HAVING COUNT(PL.playerNumber) >= 2;

-- subquery 
SELECT playerName 'Player Name', initials 'Initials'
FROM tbl_players PL
WHERE playerNumber IN(
SELECT playerNumber FROM tbl_penalties
GROUP BY tbl_penalties.playerNumber  -- group by unique number, Not by name which may be duplicate
HAVING COUNT(*) >= 2);



/************************************************************************************************/
/*Question 2 - Get the player number of the captains ONCE who have incurred at least one penalty*/
/************************************************************************************************/
-- inner join
SELECT DISTINCT T.captain
FROM tbl_penalties P INNER JOIN tbl_teams T
ON  T.captain = P.playerNumber;

-- outer join 
SELECT DISTINCT T.captain
FROM tbl_penalties P LEFT JOIN tbl_teams T
ON  T.captain = P.playerNumber
WHERE T.teamNumber IS NOT NULL;

-- more efficient just because the teams table has less records
SELECT DISTINCT T.captain
FROM tbl_penalties P RIGHT JOIN tbl_teams T
ON  T.captain = P.playerNumber
WHERE P.paymentNumber IS NOT NULL;

-- subquery
SELECT DISTINCT playerNumber
FROM tbl_penalties
WHERE playerNumber IN
(SELECT captain FROM tbl_teams);

-- another subquery
SELECT  captain -- do Not need DISTINCT here since captain can only be a captain of a team
FROM tbl_teams
WHERE captain IN
(SELECT DISTINCT playerNumber FROM tbl_penalties); -- DISTINCT will give shorter list

-- correlated subquery
/*
SELECT * 
FROM tbl_penalties P INNER JOIN tbl_teams T
ON  T.captain = P.playerNumber;
*/

SELECT DISTINCT playerNumber
FROM tbl_penalties
WHERE EXISTS
(SELECT captain FROM tbl_teams WHERE captain = playerNumber); -- can replace the captain by *

SELECT DISTINCT playerNumber
FROM tbl_penalties
WHERE playerNumber IN
(SELECT captain FROM tbl_teams WHERE captain = playerNumber);-- cannot replace captain by *

-- if name and initials are required

-- inner join
SELECT DISTINCT T.captain, playerName 'Player Name', initials 'Initials'
FROM tbl_players PL INNER JOIN tbl_penalties P INNER JOIN tbl_teams T
ON PL.playerNumber = P.playerNumber
AND T.captain = P.playerNumber;

-- outer join
SELECT DISTINCT T.captain , playerName 'Player Name', initials 'Initials'
FROM tbl_penalties P RIGHT JOIN tbl_teams T
ON  T.captain = P.playerNumber
LEFT JOIN tbl_players PL
ON PL.playerNumber = T.captain
WHERE P.paymentNumber IS NOT NULL;

-- subquery
SELECT  playerNumber , playerName, initials
FROM tbl_players
WHERE playerNumber IN
(SELECT DISTINCT playerNumber FROM tbl_penalties
WHERE playerNumber IN 
(SELECT captain FROM tbl_teams));

/****************************************************************************************/
/*                                            							                 */
/*Question 3 - Get the number, name and initials of the players who are older than      */
/*              R. Parmenter; you can assume that the combination of name and initials  */
/*              is unique.  The solution should not display R. Parmenter                */
/****************************************************************************************/
SELECT * FROM tbl_players; 
-- subquery
SELECT * -- playerNumber, playerName, initials
FROM tbl_players
WHERE birthDate < 
(SELECT birthDate FROM tbl_players WHERE playerName = 'Parmenter' AND initials = 'R');
 
-- self join
SELECT  P1.playerNumber, P1.playerName, P1.initials
FROM tbl_players P1, tbl_players P2 
WHERE P1.birthDate < P2.birthDate
AND P2.playerName = 'Parmenter' AND P2.initials = 'R';

-- create temporary table - basically  if application needs to work with the query often
-- it physically exists and takes storage in the database
DROP TABLE IF EXISTS tbl_captain_penalties;
CREATE TABLE tbl_captain_penalties AS
(
SELECT  T.captain, playerName 'Player Name', initials 'Initials'
FROM tbl_players PL INNER JOIN tbl_penalties P INNER JOIN tbl_teams T
ON PL.playerNumber = P.playerNumber
AND T.captain = P.playerNumber
);

-- describe the table structure
DESC tbl_captain_penalties;
-- select all records from the table
SELECT * FROM tbl_captain_penalties;
-- select the record for player number 27
SELECT * FROM tbl_captain_penalties WHERE captain = 27;
-- show the tables that exist in the database
SHOW TABLES;


-- create a view - JUST A DEFINITION
-- it's DEFINITION exists and does have any contents
DROP VIEW IF EXISTS view_captain_penalties;
CREATE VIEW view_captain_penalties AS
(
SELECT T.captain, playerName 'Player Name', initials 'Initials'
FROM tbl_players PL INNER JOIN tbl_penalties P INNER JOIN tbl_teams T
ON PL.playerNumber = P.playerNumber
AND T.captain = P.playerNumber
);

-- describe the structure of the viw
DESC view_captain_penalties;
-- view becomes active- definition is executed when it is required
-- display all records from the view
SELECT * FROM view_captain_penalties;
-- display the information for player number 27
SELECT * FROM view_captain_penalties WHERE captain = 27;
-- view is NOT a table
-- this command shows you a second column where in it tells you if it is 'phsical' base table or just a view
SHOW FULL TABLES;
-- you can update and delete data from the underlying tables in a view BUT it is Not
-- recommended because there are constraints on the view being created in that case






