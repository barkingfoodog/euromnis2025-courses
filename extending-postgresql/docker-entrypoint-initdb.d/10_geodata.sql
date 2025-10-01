-- This database will contain geographical data that we can
-- query from other services.
CREATE DATABASE geodata;

\c geodata

-- Keeping everything in a single schema makes it very
-- easy to import into a remote database
CREATE SCHEMA geo;

-- Table to contain country data
CREATE TABLE geo.country (
	country text,
	latitude numeric,
	longitude numeric,
	name text
);

-- Source: https://developers.google.com/public-data/docs/canonical/countries_csv
\copy geo.country FROM /docker-entrypoint-initdb.d/countries.csv WITH CSV HEADER