\c euromnis_demo

-- Create a schema to contain the extension
CREATE SCHEMA http;

-- Create the extension (this must be compiled on the server first)
CREATE EXTENSION http WITH SCHEMA http;