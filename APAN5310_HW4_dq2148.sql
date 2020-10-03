-- APAN 5310: SQL & RELATIONAL DATABASES SUMMER 2020 (F2F)

   -------------------------------------------------------------------------
   --                                                                     --
   --                            HONOR CODE                               --
   --                                                                     --
   --  I affirm that I will not plagiarize, use unauthorized materials,   --
   --  or give or receive illegitimate help on assignments, papers, or    --
   --  examinations. I will also uphold equity and honesty in the         --
   --  evaluation of my work and the work of others. I do so to sustain   --
   --  a community built around this Code of Honor.                       --
   --                                                                     --
   -------------------------------------------------------------------------

/*
 *    You are responsible for submitting your own, original work. We are
 *    obligated to report incidents of academic dishonesty as per the
 *    Student Conduct and Community Standards.
 */


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


-- HOMEWORK ASSIGNMENT 4 (DUE 6/30/2019, 11:59 pm EST)

/*
 *  NOTES:
 *
 *    - Type your SQL statements between the START and END tags for each
 *      question. Do not alter this template .sql file in any way other than
 *      adding your answers. Do not delete the START/END tags. The .sql file
 *      you submit will be validated before grading and will not be graded if
 *      it fails validation due to any alteration of the commented sections.
 *
 *    - Our course is using PostgreSQL. We grade your assignments in PostgreSQL.
 *      You risk losing points if you prepare your SQL queries for a different
 *      database system (MySQL, MS SQL Server, Oracle, etc).
 *
 *    - It is highly recommended that you insert additional, appropriate data
 *      to test the results of your queries. You do not need to include your
 *      sample data in your answers.
 *
 *    - Make sure you test each one of your answers. If a query returns an
 *      error it will earn no points.
 *
 *    - In your CREATE TABLE statements you must provide data types,
 *      primary/foreign keys and integrity constraints (if applicable).
 *
 *    - You may expand your answers in as many lines as you need between the
 *      START/END tags.
 *
 */



-------------------------------------------------------------------------------



/*
 * QUESTION 1 (11 points: 1 point for each old table, 2.5 points for each new
 *             table plus 1 point for correct order of execution)
 * ----------------------------------------------------------------------------
 *
 * For this assignment, you are asked to extend the design of the simplified
 * database of chess tournaments privided in the previous assignment by adding
 * a few tables. You must provide the SQL statements that create ALL tables, not
 * only the additional.Implement integrity constraints (primary/foreign keys,
 * NOT NULL, CHECK) as needed as well as reasonable cascading actions.
 * Note: since underlining is not supported in this file format, primary keys
 * for each relation below are shown within '*'.
 *
 *   matches (*tournament_id*, *player_id_1*, *player_id_2*, *match_start*, result)
 *   organizers (*organizer_id*, club_id, person_in_charge, details)
 *   players (*player_id*, club_id, first_name, last_name, email, ranking, phone_number, join_date)
 *   chess_clubs (*club_id*, name, street, city, established)
 *   tournaments (*tournament_id*, organizer_id, name, start_date, end_date, details)
 *   sponsors (*sponsor_id*, name, phone_number, email, details)
 *   tournament_sponsors (*tournament_id*, *sponsor_id*, contribution)
 *
 * Additional details about the database: Tournaments may have one or more
 * sponsors. The database must store the total amount of the contribution of
 * each sponsor for a given tournament.
 *
 * Type the CREATE TABLE statements in the order they have to be executed so
 * that there is no error in PostgreSQL. Expand the space between the START/END
 * tags to fit all of your CREATE TABLE statements.
 *
 * IMPORTANT: Make sure to implement the schema with **exactly** the provided
 *            relation and attribute names. Do not rename relations or
 *            attributes, either by accident (typos) or on purpose. Doing so
 *            will greatly impact the grading process. Do not provide any code
 *            beyond what we ask for.
 *
 *
 * Attribute Descriptions:
 * -----------------------
 *
 * matches
 * -------
 *  tournament_id: unique identifier for tournaments (PK)
 *  player_id_1: unique identifier for player 1 (PK)
 *  player_id_2: unique identifier for player 2 (PK)
 *  match_start: date and time of the start of the match between the two players (PK)
 *  result: the result of the match (Win, Loss, Draw) for player 1
 *
 * organizers
 * ----------
 *  organizer_id: unique identifier for organizers (PK)
 *  club_id: unique identifier for chess clubs
 *  person_in_charge: the full name of the lead organizer
 *  details: some additional details for the organizer
 *
 * players
 * -------
 *  player_id: unique identifier for players (PK)
 *  club_id: unique identifier for chess clubs
 *  first_name: the first name of the chess player
 *  last_name: the last name of the player
 *  email: the email address of the player
 *  ranking: the ranking of the player (i.e. Master, Grandmaster, etc.)
 *  phone_number: the phone number of the player (US format only)
 *  join_date: date when the player joined the club
 *
 * chess_clubs
 * -----------
 *  club_id: unique identifier for chess clubs (PK)
 *  name: the name of the club
 *  street: the street address of the club
 *  city: the city where the club is located in (assume USA clubs only)
 *  established: date when the club was established
 *
 * tournaments
 * -----------
 *  tournament_id: unique identifier for tournaments (PK)
 *  organizer_id: unique identifier for organizers
 *  name: name for the tournament
 *  start_date: the start date for the tournament
 *  end_date: the end date for the tournament
 *  details: some additional details for the tournament
 *
 * sponsors
 * --------
 *  sponsor_id: unique identifier for sponsors (PK)
 *  name: the full name of the sponsor or company name
 *  phone_number: the phone number of the sponsor (US format only)
 *  email: the email address of the sponsor
 *  details: some additional details for the sponsor
 *
 * tournament_sponsors
 * -------------------
 *  tournament_id: unique identifier for tournaments (PK)
 *  sponsor_id: unique identifier for sponsors (PK)
 *  contribution: the total amount contributed (US Dollars)
 *
 */

-- START ANSWER 1 --


CREATE TABLE chess_clubs(
	club_id varchar(20),
	name varchar(50) NOT NULL,
	street text,
	city varchar(20),
	established date,
	PRIMARY KEY (club_id));


CREATE TABLE players(
	player_id varchar(20),
	club_id varchar(20),
	first_name varchar(20),
	last_name varchar(20),
	email varchar(50),
	ranking varchar(50),
	phone_number varchar(15),
	join_date date,
	PRIMARY KEY (player_id),
	FOREIGN KEY (club_id) REFERENCES chess_clubs);


CREATE TABLE organizers(
	organizer_id varchar(20),
	club_id varchar(20),
	person_in_charge varchar(20) NOT NULL,
	details text,
	PRIMARY KEY (organizer_id),
	FOREIGN KEY (club_id) REFERENCES chess_clubs);


CREATE TABLE tournaments(
	tournament_id varchar(20),
	organizer_id varchar(20),
	name varchar(50) NOT NULL,
	start_date date,
	end_date date,
	details text,
	PRIMARY KEY (tournament_id),
	FOREIGN KEY (organizer_id) REFERENCES organizers);



CREATE TABLE sponsors(
	sponsor_id varchar(20),
	name varchar(50),
	phone_number varchar(15),
	email varchar(50),
	details text,
	PRIMARY KEY (sponsor_id));



CREATE TABLE tournament_sponsors(
	tournament_id varchar(20),
	sponsor_id varchar(20),
	contribution int,
	PRIMARY KEY (tournament_id, sponsor_id),
	FOREIGN KEY (tournament_id) REFERENCES tournaments,
	FOREIGN KEY (sponsor_id) REFERENCES sponsors);


CREATE TABLE matches(
	tournament_id varchar(20),
	player_id_1 varchar(20),
	player_id_2 varchar(20),
	match_start timestamp,
	result varchar(20),
	PRIMARY KEY (tournament_id, player_id_1, player_id_2,match_start),
	FOREIGN KEY (tournament_id) REFERENCES tournaments,
	FOREIGN KEY (player_id_1) REFERENCES players(player_id),
	FOREIGN KEY (player_id_2) REFERENCES players(player_id));


-- END ANSWER 1 --

-------------------------------------------------------------------------------

/*
 * QUESTION 2 (4 points)
 * ---------------------
 *
 * Provide detailed reasoning on your selection of each one of the data types
 * above as well as your implementation of any/all integrity constraints. Include
 * any additional assumptions you made beyond the provided schema description.
 * Explain relationships and cardinalities. Type your answers as plain text
 * within the START/END tags. Expand your answer in as many lines as you need.
 *
 * We will check for reasonable data types based on the answers shown above. We
 * will also check that primary and foreign keys have been properly defined as
 * well as some basic implementation of NOT NULL, as needed. More important,
 * we want to see well-defined reasoning on the data types, integrity constraints
 * and established relationships and cardinalities. Insufficient/short answers
 * will not receive full credit.
 *
 */

-- START ANSWER 2 --

-- varchar(20) is used for all unique identifiers because the values and formats are unknown.
-- varchar(50) is used for club name, email, and tournament name to ensure the length is enough.
-- varchar(15) is used for phone number for US format.
-- text is used for details, descriptions to make sure values can be all inserted into values.
-- time is used for start_date and end_date because only included (YYYY/MM/DD).
-- timestamp is used for match_start so that it includes HH:MM:SS as well.
-- int is used for contribution since it is the amount of US Dollars.


-- END ANSWER 2 --

-------------------------------------------------------------------------------

/*
 * QUESTION 3 (6 points)
 * ---------------------
 *
 * Draw the ER diagram for the schema detailed in Question 1 using the same
 * notation as in Chapter 6 of your textbook, also the notation we presented
 * in the slides and lecture for this module. Pay close attention in properly
 * defining relationships and cardinalities. You may draw the ER diagram in
 * any software you prefer, Lucidchart is recommended. Hand drawn diagrams will
 * not be accepted. Upload the ER diagram as a separate file.
 *
 */

-- No START/END tags here. Your answer is a PDF diagram submitted along with
-- this SQL file.


-------------------------------------------------------------------------------

/*
 * QUESTION 4 (2 points)
 * ---------------------
 *
 * Draw the ER diagram for the schema detailed in Question 1 using Engineering
 * notation. Pay close attention in properly defining relationships and
 * cardinalities. You may draw the ER diagram in any software you prefer,
 * Lucidchart is recommended. Hand drawn diagrams will not be accepted. Upload
 * the ER diagram as a separate file.
 *
 */

 -- No START/END tags here. Your answer is a PDF diagram submitted along with
 -- this SQL file and the PDF file for the diagram in Question 3.


-------------------------------------------------------------------------------

/*
 * QUESTION 5 (6 points)
 * ---------------------
 *
 * Provide the SQL statement that returns the year and total sponsor contributions
 * accross all tournaments held in year. Order by descending year.
 *
 */

-- START ANSWER 5 --

SELECT EXTRACT(YEAR FROM t.start_date) AS year, SUM(ts.contribution) AS total_contributions
FROM tournaments AS t NATURAL JOIN tournament_sponsors AS ts
GROUP BY year
ORDER BY year DESC;

-- END ANSWER 5 --


-------------------------------------------------------------------------------

/*
 * QUESTION 6 (6 points)
 * ---------------------
 *
 * Provide the SQL statement that returns the full player name (concatenated
 * first and last name with a space in between), club name and total number
 * of games played. Order by descending number of games.
 *
 */

-- START ANSWER 6 --

SELECT CONCAT(p.first_name,' ',p.last_name)as player_name, cc.name as club_name, COUNT(m.tournament_id) AS total_games_played
FROM players AS p 
LEFT JOIN matches AS m
ON p.player_id = m.player_id_1 OR p.player_id = m.player_id_2 
LEFT JOIN chess_clubs AS cc
ON p.club_id = cc.club_id
GROUP BY p.first_name, p.last_name, p.ranking, cc.name
ORDER BY COUNT(m.tournament_id) DESC;

-- END ANSWER 6 --


-------------------------------------------------------------------------------

/*
 * QUESTION 7 (6 points)
 * ---------------------
 *
 * Provide the SQL statement that returns the club name and total number of
 * members in that club who are Masters.
 *
 */

-- START ANSWER 7 --

SELECT cc.name AS club_name, COUNT(p.player_id) AS total_numbers_of_Masters
FROM chess_clubs AS cc, players AS p
WHERE p.club_id=cc.club_id AND p.ranking = 'Master'
GROUP BY cc.name;

-- END ANSWER 7 --


-------------------------------------------------------------------------------

/*
 * QUESTION 8 (6 points)
 * ---------------------
 *
 * Provide the SQL statement that returns the tournament name, the year (year
 * only, not full date) and total number of matches of the top 5 tournaments
 * with the most matches played.
 *
 */

-- START ANSWER 8 --

SELECT t.name, EXTRACT(YEAR FROM t.start_date) AS year, COUNT(t.name) AS total_number
FROM tournaments AS t 
LEFT JOIN matches AS m 
ON t.tournament_id = m.tournament_id
GROUP BY year, t.name
ORDER BY total_number DESC
FETCH FIRST 5 rows only;

-- END ANSWER 8 --


-------------------------------------------------------------------------------

/*
 * QUESTION 9 (6 points)
 * ---------------------
 *
 * Provide the SQL statement that returns the first name, last name, ranking
 * (i.e. Master, Grandmaster, etc.) and club name of all players who have
 * never participated in a tournament.
 *
 */

-- START ANSWER 9 --

SELECT p.first_name,p.last_name, p.ranking, cc.name
FROM players AS p 
LEFT JOIN matches AS m
ON p.player_id = m.player_id_1 OR p.player_id = m.player_id_2 
LEFT JOIN chess_clubs AS cc
ON p.club_id = cc.club_id 
WHERE tournament_id is NULL

-- END ANSWER 9 --


-------------------------------------------------------------------------------

/*
 * QUESTION 10 (6 points)
 * ----------------------
 *
 * Provide the SQL statement that returns the tournament name, the year (year
 * only, not full date) and total amount of contributions of the tournament(s)
 * with the most sponsor contributions.
 *
 */

-- START ANSWER 10 --

SELECT t.name, EXTRACT(YEAR FROM t.start_date) AS year, SUM(ts.contribution) AS total_contributions
FROM tournaments AS t NATURAL JOIN tournament_sponsors AS ts
GROUP BY t.name, t.start_date
ORDER BY SUM(ts.contribution) DESC
FETCH FIRST 1 rows only;

-- END ANSWER 10 --


-------------------------------------------------------------------------------

/*
 * BONUS QUESTION (10 points: all or nothing, no partial credit)
 * -------------------------------------------------------------
 *
 * Provide the SQL statement that returns the first name, last name, ranking
 * (i.e. Master, Grandmaster, etc.) and win-to-loss ratio of all players. The
 * win-to-loss ratio is the total number of wins divided by the total number of
 * losses for a player. Order by descending win-to-loss ratio.
 *
 */

-- START ANSWER --



-- END ANSWER --


-------------------------------------------------------------------------------
