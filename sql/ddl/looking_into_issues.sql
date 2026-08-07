

SELECT *
FROM warehouse.dim_date;


SELECT *
FROM warehouse.dim_severity;

SELECT *
FROM warehouse.dim_road
LIMIT 10;

SELECT *
FROM warehouse.dim_accident_type
LIMIT 10;

SELECT *
FROM warehouse.dim_location
LIMIT 10;


SELECT COUNT(*) FROM warehouse.dim_date;

SELECT COUNT(*) FROM warehouse.dim_location;

SELECT COUNT(*) FROM warehouse.dim_severity;

SELECT COUNT(*) FROM warehouse.dim_accident_type;

SELECT COUNT(*) FROM warehouse.dim_vehicle_type;

SELECT COUNT(*) FROM warehouse.dim_road_user;

SELECT COUNT(*)
FROM raw.accident;

SELECT COUNT(DISTINCT accident_no)
FROM raw.accident;

SELECT
    accident_type,
    COUNT(*)
FROM warehouse.dim_accident_type
GROUP BY accident_type
ORDER BY COUNT(*) DESC;


SELECT COUNT(*)
FROM warehouse.fact_accident;


SELECT
    accident_type,
    accident_type_desc,
    COUNT(*)
FROM warehouse.dim_accident_type
GROUP BY
    accident_type,
    accident_type_desc
HAVING COUNT(*) > 1;


SELECT
    accident_type,
    accident_type_desc,
    dca_code,
    COUNT(*)
FROM warehouse.dim_accident_type
GROUP BY
    accident_type,
    accident_type_desc,
    dca_code
HAVING COUNT(*) > 1;

SELECT
    COUNT(*) AS rows_after_join
FROM raw.accident a
LEFT JOIN warehouse.dim_accident_type at
       ON a.accident_type = at.accident_type
      AND a.accident_type_desc = at.accident_type_desc
      AND a.dca_code = at.dca_code;

SELECT COUNT(*)
FROM raw.accident;

SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'warehouse'
AND table_name = 'fact_accident'
ORDER BY ordinal_position;


SELECT
    conname,
    pg_get_constraintdef(oid)
FROM pg_constraint
WHERE conrelid = 'warehouse.fact_accident'::regclass;

SELECT
    a.accident_no,
    COUNT(*) AS rows_after_join
FROM raw.accident a

LEFT JOIN warehouse.dim_location l
       ON a.node_id = l.node_id

LEFT JOIN warehouse.dim_severity s
       ON a.severity = s.severity_code

LEFT JOIN warehouse.dim_accident_type at
       ON a.accident_type = at.accident_type
      AND a.accident_type_desc = at.accident_type_desc
      AND a.dca_code = at.dca_code

GROUP BY a.accident_no
HAVING COUNT(*) > 1
LIMIT 20;


SELECT
    node_id,
    COUNT(*)
FROM warehouse.dim_location
GROUP BY node_id
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC
LIMIT 20;


SELECT COUNT(DISTINCT node_id)
FROM raw.node;