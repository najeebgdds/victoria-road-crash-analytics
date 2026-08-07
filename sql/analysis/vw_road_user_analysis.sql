

DROP VIEW IF EXISTS warehouse.vw_road_user_analysis;

CREATE VIEW warehouse.vw_road_user_analysis AS

SELECT

    /* Accident */
    f.accident_no,

    /* Date */
    d.full_date,
    d.year,
    d.quarter,
    d.month,
    TRIM(d.month_name) AS month_name,
    d.day_of_week,
    d.weekend_flag,
    d.season,

    /* Location */
    l.lga_name,
    l.lga_name_all,
    l.deg_urban_name,
    l.postcode_crash,
    l.latitude,
    l.longitude,

    /* Severity */
    s.severity_desc,

    /* Person */
    p.person_id,
    p.vehicle_id,
    p.sex,
    p.age_group,
    p.inj_level,
    p.inj_level_desc,
    p.road_user_type,
    p.road_user_type_desc,
    p.seating_position,
    p.helmet_belt_worn,
    p.licence_state,
    p.taken_hospital,
    p.ejected_code,

    /* Crash Measures */
    f.no_of_persons,
    f.no_of_vehicles,
    f.no_persons_killed,
    f.no_persons_inj_2,
    f.no_persons_inj_3,
    f.no_persons_not_inj,
    f.police_attend

FROM warehouse.fact_accident f

INNER JOIN warehouse.dim_date d
ON f.date_key = d.date_key

INNER JOIN warehouse.dim_location l
ON f.location_sk = l.location_sk

INNER JOIN warehouse.dim_severity s
ON f.severity_sk = s.severity_sk

INNER JOIN raw.person p
ON f.accident_no = p.accident_no;


-- Row Count
SELECT COUNT(*)
FROM warehouse.vw_road_user_analysis;

-- Injury levels

SELECT
inj_level_desc,
COUNT(*) AS persons
FROM warehouse.vw_road_user_analysis
GROUP BY inj_level_desc
ORDER BY persons DESC;

-- Road user types

SELECT
road_user_type_desc,
COUNT(*) AS persons
FROM warehouse.vw_road_user_analysis
GROUP BY road_user_type_desc
ORDER BY persons DESC;


SELECT *
FROM warehouse.vw_road_user_analysis;
--LIMIT 10;


/*COPY
(
SELECT *
FROM warehouse.vw_road_user_analysis
)
TO 'C:\Users\yoga\Desktop\Portfolios\VicCrash\sql\views\New folder\vw_road_user_analysis.csv'
DELIMITER ','
CSV HEADER;*/