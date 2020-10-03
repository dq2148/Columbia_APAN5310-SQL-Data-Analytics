{\rtf1\ansi\ansicpg936\cocoartf2509
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;\f1\fnil\fcharset134 PingFangSC-Regular;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww23000\viewh11960\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 \
-- APAN 5310: SQL & RELATIONAL DATABASES SUMMER 2020 (F2F)\
\
   -------------------------------------------------------------------------\
   --                                                                     --\
   --                            HONOR CODE                               --\
   --                                                                     --\
   --  I affirm that I will not plagiarize, use unauthorized materials,   --\
   --  or give or receive illegitimate help on assignments, papers, or    --\
   --  examinations. I will also uphold equity and honesty in the         --\
   --  evaluation of my work and the work of others. I do so to sustain   --\
   --  a community built around this Code of Honor.                       --\
   --                                                                     --\
   -------------------------------------------------------------------------\
\
/*\
 *    You are responsible for submitting your own, original work. We are\
 *    obligated to report incidents of academic dishonesty as per the\
 *    Student Conduct and Community Standards.\
 */\
\
\
-------------------------------------------------------------------------------\
-------------------------------------------------------------------------------\
\
\
-- HOMEWORK ASSIGNMENT 3 (DUE 6/16/2019, 11:59 pm EST)\
\
/*\
 *  NOTES:\
 *\
 *    - Type your SQL statements between the START and END tags for each\
 *      question. Do not alter this template .sql file in any way other than\
 *      adding your answers. Do not delete the START/END tags. The .sql file\
 *      you submit will be validated before grading and will not be graded if\
 *      it fails validation due to any alteration of the commented sections.\
 *\
 *    - Our course is using PostgreSQL. We grade your assignments in PostgreSQL.\
 *      You risk losing points if you prepare your SQL queries for a different\
 *      database system (MySQL, MS SQL Server, Oracle, etc).\
 *\
 *    - It is highly recommended that you insert additional, appropriate data\
 *      to test the results of your queries. You do not need to include your\
 *      sample data in your answers.\
 *\
 *    - Make sure you test each one of your answers. If a query returns an\
 *      error it will earn no points.\
 *\
 *    - In your CREATE TABLE statements you must provide data types,\
 *      primary/foreign keys and integrity constraints (if applicable).\
 *\
 *    - You may expand your answers in as many lines as you need between the\
 *      START/END tags.\
 *\
 */\
\
\
\
-------------------------------------------------------------------------------\
\
\
\
/*\
 * QUESTION 1 (11 points: 2 points for each table plus 1 point for correct order\
 *             of execution)\
 * ----------------------------------------------------------------------------\
 *\
 * You are tasked to create a simplified database of a chess tournament. Provide\
 * the SQL statements that create the five tables with data types of your design.\
 * Implement integrity constraints (primary/foreign keys, NOT NULL) as needed.\
 * Note: since underlining is not supported in this file format, primary keys\
 * for each relation below are shown within '*'.\
 *\
 *   matches (*tournament_id*, *player_id_1*, *player_id_2*, *match_start*, result)\
 *   organizers (*organizer_id*, club_id, person_in_charge, details)\
 *   players (*player_id*, club_id, first_name, last_name, email, ranking, phone_number, join_date)\
 *   chess_clubs (*club_id*, name, street, city, established)\
 *   tournaments (*tournament_id*, organizer_id, name, start_date, end_date, details)\
 *\
 * A few words about the database: A player must be a member of a chess club.\
 * Chess clubs can have one or more members. Tournaments are organized by one\
 * chess club at a time and the club must assign a lead organizer who does not\
 * need to be a player. Tournaments will host multiple matches between two players.\
 * The database must save the result of every match (Win, Loss, Draw) for the\
 * player defined as player 1.\
 *\
 * Type the CREATE TABLE statements in the order they have to be executed so\
 * that there is no error in PostgreSQL. Expand the space between the START/END\
 * tags to fit all of your CREATE TABLE statements.\
 *\
 * IMPORTANT: Make sure to implement the schema with **exactly** the provided\
 *            relation and attribute names. Do not rename relations or\
 *            attributes, either by accident (typos) or on purpose. Doing so\
 *            will greatly impact the grading process. Do not provide any code\
 *            beyond what we ask for.\
 *\
 *\
 * Attribute Descriptions:\
 * -----------------------\
 *\
 * matches\
 * -------\
 *  tournament_id: unique identifier for tournaments (PK)\
 *  player_id_1: unique identifier for player 1 (PK)\
 *  player_id_2: unique identifier for player 2 (PK)\
 *  match_start: date and time of the start of the match between the two players (PK)\
 *  result: the result of the match (Win, Loss, Draw) for player 1\
 *\
 * organizers\
 * ----------\
 *  organizer_id: unique identifier for organizers (PK)\
 *  club_id: unique identifier for chess clubs\
 *  person_in_charge: the full name of the lead organizer\
 *  details: some additional details for the organizer\
 *\
 * players\
 * -------\
 *  player_id: unique identifier for players (PK)\
 *  club_id: unique identifier for chess clubs\
 *  first_name: the first name of the chess player\
 *  last_name: the last name of the player\
 *  email: the email address of the player\
 *  ranking: the ranking of the player (i.e. Master, Grandmaster, etc.)\
 *  phone_number: the phone number of the player (US format only)\
 *  join_date: date when the player joined the club\
 *\
 * chess_clubs\
 * -----------\
 *  club_id: unique identifier for chess clubs (PK)\
 *  name: the name of the club\
 *  street: the street address of the club\
 *  city: the city where the club is located in (assume USA clubs only)\
 *  established: date when the club was established\
 *\
 * tournaments\
 * -----------\
 *  tournament_id: unique identifier for tournaments (PK)\
 *  organizer_id: unique identifier for organizers\
 *  name: name for the tournament\
 *  start_date: the start date for the tournament\
 *  end_date: the end date for the tournament\
 *  details: some additional details for the tournament\
 *\
 */\
\
-- START ANSWER 1 --\
\
drop table matches;\
drop table organizers;\
drop table players;\
drop table chess_clubs;\
drop table tournaments;\
\
CREATE TABLE matches(\
	tournament_id int not null,\
	player_id_1 int not null,\
	player_id_2 int not null,\
	match_start timestamp,\
	result varchar(5),\
	PRIMARY KEY (tournament_id, player_id_1, player_id_2, match_start),\
	FOREIGN KEY (tournament_id) REFERENCES tournaments(tournament_id));\
\
CREATE TABLE organizers(\
	organizer_id int not null PRIMARY KEY,\
	club_id int,\
	person_in_charge varchar(50),\
	details text,\
	FOREIGN KEY (club_id) REFERENCES chess_clubs(club_id));\
\
CREATE TABLE players(\
	player_id int not null PRIMARY KEY,\
	club_id int not null,\
	first_name varchar(50),\
	last_name varchar(50),\
	email text,\
	ranking int,\
	phone_numer varchar(15),\
	join_date date,\
	FOREIGN KEY (club_id) REFERENCES chess_clubs(club_id));\
\
CREATE TABLE chess_clubs(\
	club_id int not null PRIMARY KEY,\
	name varchar(50),\
	street varchar(50),\
	city varchar(50),\
	established date);\
	\
CREATE TABLE tournaments(\
	tournament_id int not null PRIMARY KEY,\
	organizer_id int,\
	name varchar(50),\
	start_date date,\
	end_date date,\
	details text,\
	FOREIGN KEY (organizer_id) REFERENCES organizers(organizer_id));\
\
-- END ANSWER 1 --\
\
-------------------------------------------------------------------------------\
\
/*\
 * QUESTION 2 (4 points)\
 * ---------------------\
 *\
 * Provide detailed reasoning on your selection of each one of the data types\
 * above as well as your implementation of any/all integrity constraints. Include\
 * any additional assumptions you made beyond the provided schema description.\
 * Explain relationships and cardinalities. Type your answers as plain text\
 * within the START/END tags. Expand your answer in as many lines as you need.\
 *\
 * We will check for reasonable data types based on the answers shown above. We\
 * will also check that primary and foreign keys have been properly defined as\
 * well as some basic implementation of NOT NULL, as needed. More important,\
 * we want to see well-defined reasoning on the data types, integrity constraints\
 * and established relationships and cardinalities. Insufficient/short answers\
 * will not receive full credit.\
 *\
 */\
\
-- START ANSWER 2 --\
\
/*TABLE TYPES:\
 * int (tournament_id, player_id_1, player_id_2, organizer_id, club_id, player_id, ranking)\
 *  - They are unique identifiers as numbers, so integer is good fit to them.\
 * varchar (result,person_in_charge, first_name, last_name, phone_number, name, street, city)\
 *  - I use varchar(5) for result because it only contains "WIN, LOSS, DRAW" as 4 maximum characters,\
 *  - I also use varchar(15) and varchar(50) for the phone number and certain names\
 * text (details, email)\
 *  - I use text because there might be many characters in these two data.\
 * timestamp (match_start)\
 *  - I use timestamp because it both includes date and time for the match.\
 * date (join_date, established, start_date, end_date)\
 *  - I use date because they only require the date (MM/DD/YYYY) here.\
 * PRIMARY KEY and FOREIGN KEY:\
 * PK and FK all defined in each schema. They are set to not null so it would be easy to extract the data.\
 * PK are listed following:\
 *  matches - tournament_id, player_id_1, player_id_2
\f1 \'a3\'ac
\f0 match_start.\
 *  organziers - organizer_id.\
 *  players - player_id.\
 *  chess_clubs - club_id.\
 *  tournaments - tournament_id.\
 * FK are listed following, they are all certain PK from original tables:\
 * tournament_id from table tournaments is FK under matches.\
 * club_id from table chess_clubs is FK under matches.\
 * club_id from tale chess_clubs is FK under players.\
 * organizer_id from organizers is FK under tournaments.\
 */\
\
-- END ANSWER 2 --\
\
-------------------------------------------------------------------------------\
\
/*\
 * QUESTION 3 (6 points)\
 * ---------------------\
 *\
 * Draw the ER diagram for the schema detailed in Question 1 using the same\
 * notation as in Chapter 6 of your textbook, also the notation we presented\
 * in the slides and lecture for this module. Pay close attention in properly\
 * defining relationships and cardinalities. You may draw the ER diagram in\
 * any software you prefer, Lucidchart is recommended. Hand drawn diagrams will\
 * not be accepted. Upload the ER diagram as a separate file.\
 *\
 */\
\
-- No START/END tags here. Your answer is a PDF diagram submitted along with\
-- this SQL file.\
\
\
-------------------------------------------------------------------------------\
\
/*\
 * QUESTION 4 (2 points)\
 * ---------------------\
 *\
 * Draw the ER diagram for the schema detailed in Question 1 using Engineering\
 * notation. Pay close attention in properly defining relationships and\
 * cardinalities. You may draw the ER diagram in any software you prefer,\
 * Lucidchart is recommended. Hand drawn diagrams will not be accepted. Upload\
 * the ER diagram as a separate file.\
 *\
 */\
\
 -- No START/END tags here. Your answer is a PDF diagram submitted along with\
 -- this SQL file and the PDF file for the diagram in Question 3.\
\
\
-------------------------------------------------------------------------------\
\
/*\
 * QUESTION 5 (4 points)\
 * ---------------------\
 *\
 * Provide the SQL statment that returns the first name, last name, club name\
 * and number of matches played in all tournaments for all players in the\
 * database. (note: Use the cartesian product, we are not using joins, yet.\
 * Always test your queries with sample data.)\
 *\
 */\
\
-- START ANSWER 5 --\
\
SELECT first_name, last_name, name AS club_name, matches_played\
FROM (SELECT first_name, last_name, club_id, COUNT (*) AS matches_played\
  FROM players as P, matches as M\
  WHERE P.player_id = M.player_id_1 or P.player_id = M.player_id_2\
  GROUP BY player_id) AS players_games, chess_clubs AS C\
WHERE players_games.club_id = C.club_id;\
\
\
-- END ANSWER 5 --\
\
\
-------------------------------------------------------------------------------\
}