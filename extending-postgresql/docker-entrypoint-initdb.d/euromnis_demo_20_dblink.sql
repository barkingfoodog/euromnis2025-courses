\c euromnis_demo

-- Create a schema to contain the extension
CREATE SCHEMA dblink;

-- Create the extension (this must be compiled on the server first)
CREATE EXTENSION dblink WITH SCHEMA dblink;