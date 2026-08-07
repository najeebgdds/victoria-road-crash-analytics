

-- Find node table cols 

SELECT COLUMN_NAME 
FROM information_schema.columns
WHERE table_schema = 'raw'
  AND table_name = 'node'
ORDER BY ordinal_position;

-- row count

SELECT COUNT(*)
FROM raw.node;

-- Validate PK node_id

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT node_id) AS distinct_nodes
FROM raw.node;
-- find Duplicate NODE_IDs

SELECT node_id,
	   COUNT(*)
FROM raw.node
GROUP BY node_id
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

-- We already know duplicates exist.

-- Step 4 — Determine if Duplicates Are Real Duplicates

--Very important.

--Check:

SELECT *
FROM raw.node
WHERE node_id = 45524;

SELECT *
FROM raw.node
WHERE node_id = 65743;

-- node_id is NOT unique in raw.node
-- so composite key (node_id + accident_no)

-- Double check
SELECT COUNT(*)
FROM (
	SELECT accident_no,node_id
	FROM raw.node
	GROUP BY accident_no,node_id
	HAVING COUNT(*) > 1
	) t;
-- we get 3086 duplicates

SELECT accident_no, node_id, COUNT(*)
FROM raw.node
GROUP BY accident_no, node_id
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

-- get where the duplicates are

-- so lets see wether the duplicates are real or not?
SELECT *
FROM raw.node
WHERE accident_no = 'T20120017480';

SELECT *
FROM raw.node
WHERE accident_no = 'T20190026107';

-- Count Distinct Nodes
SELECT COUNT(DISTINCT node_id)
FROM raw.node;

-- Node Type Distribution

SELECT
    node_type,
    COUNT(*)
FROM raw.node
GROUP BY node_type
ORDER BY COUNT(*) DESC;

--LGA Distribution

SELECT
    lga_name,
    COUNT(*)
FROM raw.node
GROUP BY lga_name
ORDER BY COUNT(*) DESC
LIMIT 20;

-- Urban/ Region Distribution

SELECT
    deg_urban_name,
    COUNT(*) AS crashes
FROM raw.node
GROUP BY deg_urban_name
ORDER BY COUNT(*) DESC;


SELECT
    lga_name_all,
    COUNT(*) AS crashes
FROM raw.node
GROUP BY lga_name_all
ORDER BY COUNT(*) DESC;


-- Postcode Distribution
SELECT
    COUNT(DISTINCT postcode_crash)
FROM raw.node;

SELECT
    postcode_crash,
    COUNT(*) AS crashes
FROM raw.node
GROUP BY postcode_crash
ORDER BY COUNT(*) DESC
LIMIT 20;


-- Node type distribution
SELECT
    node_type,
    COUNT(*)
FROM raw.node
GROUP BY node_type
ORDER BY COUNT(*) DESC;
-- Null Analysis
SELECT
    COUNT(*) FILTER (WHERE node_id IS NULL) AS node_id_nulls,
    COUNT(*) FILTER (WHERE lga_name IS NULL) AS lga_nulls,
    COUNT(*) FILTER (WHERE lga_name_all IS NULL) AS region_nulls,
    COUNT(*) FILTER (WHERE postcode_crash IS NULL) AS postcode_nulls
FROM raw.node;
SELECT
    COUNT(*) AS total_rows,
    COUNT(node_id) AS node_id_populated,
    COUNT(latitude) AS latitude_populated,
    COUNT(longitude) AS longitude_populated,
    COUNT(postcode_crash) AS postcode_populated,
    COUNT(lga_name) AS lga_populated
FROM raw.node;

-- Latitude / Longitude Null Check

SELECT
    COUNT(*) FILTER (WHERE latitude IS NULL) AS latitude_nulls,
    COUNT(*) FILTER (WHERE longitude IS NULL) AS longitude_nulls
FROM raw.node;


-- Latitude / Longitude Range Validation
/* Victoria should roughly fall within:
	Latitude:
	-39 to -34
	Longitude:
	141 to 150
*/

SELECT
    MIN(latitude),
    MAX(latitude),
    MIN(longitude),
    MAX(longitude)
FROM raw.node;

-- Accident Hotspots

SELECT
    node_id,
    COUNT(*) AS crash_count
FROM raw.node
GROUP BY node_id
ORDER BY crash_count DESC
LIMIT 20;

-- Top accidenst ocations

SELECT
    node_id,
    COUNT(DISTINCT accident_no) AS accidents_at_location
FROM raw.node
GROUP BY node_id
ORDER BY accidents_at_location DESC
LIMIT 20;


-- Nodes With Fatal Crashes
-- Join with accident table.

SELECT
    n.node_id,
    n.lga_name,
    COUNT(*) AS fatal_crashes
FROM raw.node n
JOIN raw.accident a
    ON n.accident_no = a.accident_no
WHERE a.severity = '1'
GROUP BY n.node_id, n.lga_name
ORDER BY fatal_crashes DESC
LIMIT 20;