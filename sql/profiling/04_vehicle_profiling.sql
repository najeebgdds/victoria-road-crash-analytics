
/* Understand the grain
 Accident 1 ---> Many Vehicles
 Accident A
 ├── Vehicle 1
 └── Vehicle 2

Accident B
 ├── Vehicle 1
 ├── Vehicle 2
 └── Vehicle 3

 Primary Key = (accident_no, vehicle_id)
 
 */


-- Find vehicle table cols 

SELECT COLUMN_NAME 
FROM information_schema.columns
WHERE table_schema = 'raw'
  AND table_name = 'vehicle'
ORDER BY ordinal_position;


-- Validate the PK

 SELECT accident_no,vehicle_id,COUNT(*)
 FROM raw.vehicle
 GROUP BY accident_no,vehicle_id
 HAVING COUNT(*) > 1;
-- 0 rows >> in favor of the hypothesis

-- Check Row Count
SELECT COUNT(*)
FROM raw.vehicle;
-- 359764 ROWS/RECORDS

-- Vehicles per Accident

SELECT vehicle_count,
       COUNT(*) AS accidents
FROM (
    SELECT accident_no,
           COUNT(*) AS vehicle_count
    FROM raw.vehicle
    GROUP BY accident_no
) x
GROUP BY vehicle_count
ORDER BY vehicle_count;

-- Check Missing Vehicle Records
-- Same logic as Person table.

SELECT COUNT(*)
FROM raw.accident a
LEFT JOIN raw.vehicle v
    ON a.accident_no = v.accident_no
WHERE v.accident_no IS NULL;

-- Data Quality Finding:
-- Only 9 accidents lack associated vehicle records.
-- Let's Investigate Those 9

SELECT a.accident_no,
	   a.accident_date,
	   a.accident_type_desc,
	   a.severity
FROM raw.accident a
LEFT JOIN raw.vehicle v
	 ON a.accident_no = v.accident_no;

-- lets see the 9 rows now

SELECT a.accident_no,
	   a.accident_date,
	   a.accident_type_desc,
	   a.severity
FROM raw.accident a
LEFT JOIN raw.vehicle v
	 ON a.accident_no = v.accident_no
WHERE v.accident_no IS NULL;	

-- different accident types  and i ll docoment it


-- Vehicle Type Distribution

SELECT vehicle_type,
	   COUNT(*) AS vehicles
FROM raw.vehicle
GROUP BY vehicle_type
ORDER BY COUNT(*) DESC;

-- Vehicle Manufacture Year
SELECT MIN(vehicle_year_manuf),
       MAX(vehicle_year_manuf)
FROM raw.vehicle;


SELECT vehicle_year_manuf,
	   COUNT(*) 
FROM raw.vehicle
GROUP BY vehicle_year_manuf
ORDER BY COUNT(*) DESC;


-- Registration State

SELECT reg_state,
       COUNT(*)
FROM raw.vehicle
GROUP BY reg_state
ORDER BY COUNT(*) DESC;

-- Occupants

SELECT total_no_occupants,
       COUNT(*)
FROM raw.vehicle
GROUP BY total_no_occupants
ORDER BY total_no_occupants,COUNT(*) DESC;


-- Vehicle Make

SELECT vehicle_make,
       COUNT(*)
FROM raw.vehicle
GROUP BY vehicle_make
ORDER BY COUNT(*) DESC
LIMIT 20;



