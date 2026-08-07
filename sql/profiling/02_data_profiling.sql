
/* Understanding the database structure
Building a data dictionary
Checking available columns
Discovering tables
*/

SELECT COLUMN_NAME
FROM information_schema.columns
WHERE table_schema = 'raw';
