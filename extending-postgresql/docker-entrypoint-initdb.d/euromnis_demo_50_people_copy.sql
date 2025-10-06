\c euromnis_demo

-- Table to store people data
-- Source: https://github.com/datablist/sample-csv-files
CREATE TABLE people (
	index integer,
	user_id text,
	first_name text,
	last_name text,
	sex text,
	email text,
	phone text,
	date_of_birth date,
	job_title text
);

-- Create extension to use file_fdw
CREATE EXTENSION file_fdw;

-- Create a server; can re-use for different files/programs
-- as those options are specfied on each table
CREATE SERVER file_fdw FOREIGN DATA WRAPPER file_fdw;

-- Access the people file as a foreign table
CREATE FOREIGN TABLE people_file
	(LIKE people)
	SERVER file_fdw
	OPTIONS (filename '/docker-entrypoint-initdb.d/people-2000000.csv', format 'csv', header 'true');