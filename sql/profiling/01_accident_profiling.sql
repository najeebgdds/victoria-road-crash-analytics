

/*
=====================================================
ACCIDENT TABLE PROFILING
=====================================================
Purpose:
Profile crash records and assess:

1. Data quality
2. Primary key validation
3. Severity distribution
4. Time-based trends
5. Crash type patterns
6. Road geometry patterns
7. Geographic distributions

Key Findings:

- 197,249 accident records
- accident_no is unique
- Majority are Other Injury crashes
- Friday is the highest crash day
- Afternoon is the highest crash period
- Vehicle-to-vehicle collisions dominate
- Rear-end collisions are the most common DCA
- Melbourne Urban contains most crashes

Business Value:

This profiling identifies temporal, geographic,
and behavioural crash patterns that will support:

- Tableau dashboard development
- Hotspot identification
- Severity analysis
- Road safety insights

=====================================================
*/

-- ==========================================
-- TABLE ROW COUNTS
-- ==========================================

SELECT 'accident' AS table_name, COUNT(*) AS row_count
FROM raw.accident

UNION ALL

SELECT 'node', COUNT(*)
FROM raw.node

UNION ALL

SELECT 'person', COUNT(*)
FROM raw.person

UNION ALL

SELECT 'vehicle', COUNT(*)
FROM raw.vehicle;


-- Primary Key Validation
-- Must be truley unique

SELECT COUNT(*) AS total_rows,
	COUNT(DISTINCT accident_no) AS distinct_accident
FROM raw.accident;	

-- ==========================================
-- ACCIDENT TABLE - NULL ANALYSIS
-- ==========================================

SELECT COUNT(*) AS null_accident_no
FROM raw.accident
WHERE accident_no IS NULL;

SELECT COUNT(*) AS null_node_id
FROM raw.accident
WHERE node_id IS NULL;

SELECT COUNT(*) AS null_severity
FROM raw.accident
WHERE severity IS NULL;

SELECT COUNT(*) AS null_people_killed
FROM raw.accident
WHERE no_persons_killed IS NULL;

SELECT COUNT(*) AS null_speed_zone
FROM raw.accident
WHERE speed_zone IS NULL;

SELECT COUNT(*) AS null_dca_code
FROM raw.accident
WHERE dca_code IS NULL;


-- Duplicate Analysis

SELECT accident_no,count(*)
FROM raw.accident
GROUP BY accident_no
HAVING COUNT(*) > 1;

-- Candidate Key Validation
-- give us uniquness of key

SELECT COUNT(*) AS total_rows,
COUNT(DISTINCT accident_no) AS total_accidents
FROM raw.accident;


-- ==========================================
-- NODE TABLE - NULL ANALYSIS
-- ==========================================

SELECT node_id,COUNT(*)
FROM raw.node
GROUP BY node_id
HAVING COUNT(*) > 1;

-- got duplicates 
-- means one node_id can be assigned to more than 1 accidents
-- so we need composite PK for node table
-- for further checks

SELECT *
FROM raw.node
WHERE node_id = 45524;


SELECT COUNT(*)
FROM (
    SELECT accident_no,
           COUNT(*)
    FROM raw.node
    GROUP BY accident_no
    HAVING COUNT(*) > 1
) t;

-- 3,086 node_id values appearing more than once
-- so node_id is definitely not unique in the raw data.
--  see in details in node table profiling

SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT node_id) AS distinct_nodes
FROM raw.node;

/* 200,259 - 141,661
=
58,598

There are 58,598 additional records caused by NODE_ID reuse.
This confirms beyond doubt.
node_id is not unique in the source data.
node_id cannot be the primary key of the raw.node table.
The documentation is misleading or outdated.
node_id is a location identifier, not an accident identifier.
*/

-- Null check
SELECT
    COUNT(*) AS total_rows,
    COUNT(accident_no) AS accident_no_not_null,
    COUNT(node_id) AS node_id_not_null,
    COUNT(severity) AS severity_not_null,
    COUNT(speed_zone) AS speed_zone_not_null,
    COUNT(no_persons_killed) AS killed_not_null
FROM raw.accident;

-- Severity Distribution

SELECT
    severity,
    COUNT(*) AS crashes
FROM raw.accident
GROUP BY severity
ORDER BY crashes DESC;

-- Fatal crashes
SELECT
    COUNT(*) AS fatal_crashes
FROM raw.accident
WHERE no_persons_killed > 0;

-- Top speed zones
SELECT
    speed_zone,
    COUNT(*) AS crashes
FROM raw.accident
GROUP BY speed_zone
ORDER BY crashes DESC
LIMIT 10;

-- Accident years
SELECT
    EXTRACT(YEAR FROM accident_date::DATE) AS crash_year,
    COUNT(*) AS crashes
FROM raw.accident
GROUP BY crash_year
ORDER BY crash_year;

-- accident months

SELECT
    EXTRACT(MONTH FROM accident_date::date) AS crash_month,
    COUNT(*) AS crashes
FROM raw.accident
GROUP BY crash_month
ORDER BY crash_month DESC;


/*SELECT accident_date
FROM raw.accident
LIMIT 10;*/

-- Vehicle Analysis

SELECT
    vehicle_type,
    vehicle_type_desc,
    COUNT(*) AS vehicles
FROM raw.vehicle
GROUP BY vehicle_type,
         vehicle_type_desc
ORDER BY vehicles DESC;

-- fatal fix

SELECT
    no_persons_killed,
    COUNT(*) AS crashes
FROM raw.accident
GROUP BY no_persons_killed
ORDER BY no_persons_killed;

SELECT
    severity,
    no_persons_killed,
    COUNT(*)
FROM raw.accident
GROUP BY severity,
         no_persons_killed
ORDER BY severity,
         no_persons_killed;

-- severity table

SELECT
    severity,
    COUNT(*)
FROM raw.accident
GROUP BY severity
ORDER BY severity;

SELECT DISTINCT severity
FROM raw.accident
ORDER BY severity;


SELECT
    inj_level_desc,
    COUNT(*) AS persons
FROM raw.person
GROUP BY inj_level_desc
ORDER BY persons DESC;

-- lets see the four records in severity 4
SELECT *
FROM raw.accident
WHERE severity = '4';


SELECT COUNT(*)
FROM raw.accident
WHERE severity = '1'
  AND no_persons_killed = 0;

SELECT
    accident_no,
    accident_date,
    severity,
    no_persons_killed,
    no_persons_inj_2,
    no_persons_inj_3
FROM raw.accident
WHERE severity = '1'
  AND no_persons_killed = 0
LIMIT 20;


SELECT
    severity,
    SUM(no_persons_killed) AS total_killed
FROM raw.accident
GROUP BY severity
ORDER BY severity;

SELECT COUNT(*)
FROM raw.accident
WHERE severity = '1';

-- verify data and data types
SELECT
    MIN(no_persons_killed),
    MAX(no_persons_killed),
    AVG(no_persons_killed)
FROM raw.accident;

SELECT
    no_persons_killed,
    COUNT(*)
FROM raw.accident
GROUP BY no_persons_killed
ORDER BY no_persons_killed;

SELECT
    SUM(no_persons_inj_2) AS serious_injuries,
    SUM(no_persons_inj_3) AS other_injuries,
    SUM(no_persons_not_inj) AS not_injured
FROM raw.accident;

/*
=====================================================
ACCIDENT TABLE - ADVANCED PROFILING
=====================================================
*/

-- Severity by Year

SELECT
	EXTRACT (YEAR FROM accident_date :: date) AS crash_year,
	--EXTRACT (MONTH FROM accident_date :: date) AS crash_month,
	severity,
	COUNT(*) AS crashes
FROM raw.accident
GROUP BY 1,2
ORDER BY 1,2 DESC;

-- Fatalaty by year

SELECT
    EXTRACT (YEAR FROM accident_date :: date) AS crash_year,
	SUM(no_persons_killed) as fatalities
FROM raw.accident
GROUP BY 1; -- crash_year
ORDER BY 1 DESC;

-- Day of Week
SELECT
    day_week_desc,
    COUNT(*) AS crashes
FROM raw.accident
GROUP BY day_week_desc
ORDER BY crashes DESC;

-- Time of Day

SELECT
CASE
    WHEN accident_time::time BETWEEN '06:00' AND '11:59:59'
        THEN 'Morning'
    WHEN accident_time::time BETWEEN '12:00' AND '17:59:59'
        THEN 'Afternoon'
    WHEN accident_time::time BETWEEN '18:00' AND '23:59:59'
        THEN 'Evening'
    ELSE 'Night'
END AS time_period,
COUNT(*) AS crashes
FROM raw.accident
GROUP BY 1
ORDER BY crashes DESC;


-- Collision Type

SELECT
    accident_type_desc,
    COUNT(*) AS crashes
FROM raw.accident
GROUP BY 1
ORDER BY crashes DESC;

-- Top DCA Codes
SELECT
    dca_desc,
    COUNT(*) AS crashes
FROM raw.accident
GROUP BY dca_desc
ORDER BY crashes DESC
LIMIT 20;

-- Severity vs Intersection
-- This one will later combine nicely with NODE.

SELECT
    light_condition,
    severity,
    COUNT(*)
FROM raw.accident
GROUP BY 1,2
ORDER BY 1,2;

-- Intersection Analysis

SELECT
    road_geometry_desc,
    COUNT(*) AS crashes
FROM raw.accident
GROUP BY road_geometry_desc
ORDER BY crashes DESC;

-- Road Type Analysis
SELECT
    road_geometry_desc,
    COUNT(*) AS crashes
FROM raw.accident
GROUP BY road_geometry_desc
ORDER BY crashes DESC;

-- Light conditions

SELECT
    light_condition,
    COUNT(*) AS crashes
FROM raw.accident
GROUP BY light_condition
ORDER BY crashes DESC;

-- Weekend vs Weekday
SELECT
    CASE
        WHEN day_week_desc IN ('Saturday','Sunday')
            THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_group,
    COUNT(*) AS crashes
FROM raw.accident
GROUP BY day_group;

-- Top LGA Crash Hotspots
-- Since we discovered duplicate accident_no rows in NODE, use DISTINCT first:

SELECT
    n.lga_name,
    COUNT(*) AS crashes
FROM raw.accident a
JOIN (
    SELECT DISTINCT accident_no, lga_name
    FROM raw.node
) n
ON a.accident_no = n.accident_no
GROUP BY n.lga_name
ORDER BY crashes DESC
LIMIT 20;


-- Top Postcode Hotspots
-- Again use DISTINCT:

SELECT
    n.postcode_crash,
    COUNT(*) AS crashes
FROM raw.accident a
JOIN (
    SELECT DISTINCT accident_no, postcode_crash
    FROM raw.node
) n
ON a.accident_no = n.accident_no
GROUP BY n.postcode_crash
ORDER BY crashes DESC
LIMIT 20;


-- 
SELECT
    n.deg_urban_name,
    COUNT(*) AS crashes
FROM raw.accident a
JOIN (
    SELECT DISTINCT accident_no, deg_urban_name
    FROM raw.node
) n
ON a.accident_no = n.accident_no
GROUP BY n.deg_urban_name
ORDER BY crashes DESC;















