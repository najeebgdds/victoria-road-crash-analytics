

SELECT column_name
FROM information_schema.columns
WHERE table_schema='raw'
AND table_name='accident'
ORDER BY ordinal_position;

SELECT column_name
FROM information_schema.columns
WHERE table_schema='raw'
AND table_name='person'
ORDER BY ordinal_position;

SELECT column_name
FROM information_schema.columns
WHERE table_schema='raw'
AND table_name='vehicle'
ORDER BY ordinal_position;

SELECT column_name
FROM information_schema.columns
WHERE table_schema='raw'
AND table_name='node'
ORDER BY ordinal_position;

SELECT column_name
FROM information_schema.columns
WHERE table_schema='warehouse'
AND table_name='fact_accident';


SELECT column_name
FROM information_schema.columns
WHERE table_schema='warehouse'
AND table_name='dim_location';

SELECT column_name
FROM information_schema.columns
WHERE table_schema='warehouse'
AND table_name='dim_severity';

SELECT COUNT(*)
FROM raw.person;



SELECT *
FROM warehouse.fact_accident
LIMIT 20;

-- for commercial vehicle view

SELECT DISTINCT vehicle_type_desc
FROM raw.vehicle
ORDER BY vehicle_type_desc;

SELECT
    vehicle_type_desc,
    COUNT(DISTINCT accident_no) AS crash_count
FROM raw.vehicle
GROUP BY vehicle_type_desc
ORDER BY crash_count DESC;

SELECT table_name
FROM information_schema.views
WHERE table_schema='warehouse'
ORDER BY table_name;

SELECT *
FROM warehouse.vw_crash_overview
LIMIT 5;

SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'warehouse'
AND table_name = 'vw_crash_overview'
ORDER BY ordinal_position;