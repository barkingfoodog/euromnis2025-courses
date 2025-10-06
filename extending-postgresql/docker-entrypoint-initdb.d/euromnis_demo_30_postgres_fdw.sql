\c euromnis_demo

-- PostgreSQL Foreign Data Wrapper is used to query other
-- PostgreSQL databases using SQL by exposing their tables
-- as local tables 
CREATE EXTENSION postgres_fdw;

-- We will connect to the geodata database which contains
-- geographical data
CREATE SERVER geodata FOREIGN DATA WRAPPER postgres_fdw OPTIONS (dbname 'geodata');

-- We will use the postgres users for the sake of example.
-- In production, create a user with limited access and
-- use that user for best security practices
CREATE USER MAPPING FOR postgres SERVER geodata;

-- We will make a local schema called geo to contain
-- our foreign tables. Querying (and inserting/updating/deleting)
-- into these database will actually modify the table in the
-- geodata database
CREATE SCHEMA geo;

-- Import all tables from the geo schema in geodata into
-- the local geo schema. Organizing tables by schema is
-- an easy way to import foreign tables without needing
-- to maintain their definition here
IMPORT FOREIGN SCHEMA geo FROM SERVER geodata INTO geo;