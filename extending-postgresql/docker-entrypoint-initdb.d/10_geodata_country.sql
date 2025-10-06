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

-- Add the earthdistance contrib module
-- CASCADE to get the dependent module cube
CREATE EXTENSION earthdistance CASCADE;

-- Add a function to get the distance between two countries in meters
CREATE FUNCTION geo.country_distance (source_country text, destination_country text) 
	RETURNS float8 AS
$$
	DECLARE
		source_ll earth;
		destination_ll earth;
	BEGIN
		-- Get the coordinate of the source country as earth
		SELECT
			ll_to_earth(
				geo.country.latitude,
				geo.country.longitude
			)
		FROM geo.country
		WHERE
			geo.country.country = source_country
		INTO source_ll;

		-- Bail if we can't find the source country
		IF NOT FOUND THEN
			RAISE 'Country % not found', source_country;
		END IF;

		-- Get the coordinate of the destination country as earth
		SELECT
			ll_to_earth(
				geo.country.latitude,
				geo.country.longitude
			)
		FROM geo.country
		WHERE
			geo.country.country = destination_country
		INTO destination_ll;

		-- Bail if we can't find the destination country
		IF NOT FOUND THEN
			RAISE 'Country % not found', destination_country;
		END IF;

		-- Return the distance
		RETURN earth_distance(source_ll, destination_ll);
	END;
$$ LANGUAGE plpgsql;