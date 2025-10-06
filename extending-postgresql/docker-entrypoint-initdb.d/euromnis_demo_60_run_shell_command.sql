\c euromnis_demo

CREATE OR REPLACE FUNCTION public.run_shell_command(command text, OUT output text, OUT resultcode integer)
RETURNS record AS
$BODY$
	DECLARE
		command_string text := '';
	BEGIN
		command_string := 'result=$(' || command || E' 2>&1); echo $?; echo "${result}" | awk ''{gsub(/\\r/,"\\\\r")}1''';

		CREATE TEMPORARY TABLE command_output(output_text text);

		EXECUTE 'COPY command_output FROM PROGRAM ' || quote_literal(command_string);

		SELECT output_text FROM command_output LIMIT 1 INTO resultcode;

		WITH results AS (
			SELECT
				output_text
			FROM command_output
			OFFSET 1
		) SELECT
			string_agg(output_text, E'\n')
		FROM results
		INTO output;

		DROP TABLE command_output;
	END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;