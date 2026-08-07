

-- Create Schemas

CREATE SCHEMA raw;
CREATE SCHEMA staging;
CREATE SCHEMA warehouse;

-- Verify the above 

SELECT schema_name
FROM information_schema.schemata
WHERE schema_name IN ('raw','staging','warehouse');


