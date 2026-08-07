

DROP VIEW IF EXISTS warehouse.vw_commercial_road_vehicle_analysis;

CREATE VIEW warehouse.vw_commercial_road_vehicle_analysis AS

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

    /* Vehicle */
    v.vehicle_id,
    v.vehicle_type_desc,
    v.vehicle_make,
    v.vehicle_model,
    v.vehicle_year_manuf,
    v.vehicle_body_style,
    v.vehicle_weight,
    v.vehicle_power,
    v.fuel_type,
    v.construction_type,
    v.no_of_wheels,
    v.no_of_cylinders,
    v.seating_capacity,
    v.total_no_occupants,
    v.carry_capacity,
    v.cubic_capacity,
    v.driver_intent,
    v.vehicle_movement,
    v.trailer_type,
    v.caught_fire,
    v.level_of_damage,
    v.towed_away_flag,
    v.traffic_control_desc,

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

INNER JOIN raw.vehicle v
ON f.accident_no = v.accident_no

WHERE v.vehicle_type_desc IN (

'Bus/Coach',
'Mini Bus(9-13 seats)',
'Light Commercial Vehicle (Rigid) <= 4.5 Tonnes GVM',
'Heavy Vehicle (Rigid) > 4.5 Tonnes',
'Panel Van',
'Prime Mover - Single Trailer',
'Prime Mover (No of Trailers Unknown)',
'Prime Mover B-Double',
'Prime Mover B-Triple',
'Prime Mover Only',
'Rigid Truck(Weight Unknown)',
'Taxi'

);

-- Row Count

SELECT COUNT(*)
FROM warehouse.vw_commercial_road_vehicle_analysis;

-- Vehicle distribution

SELECT vehicle_type_desc,
COUNT(*) AS crashes
FROM warehouse.vw_commercial_road_vehicle_analysis
GROUP BY vehicle_type_desc
ORDER BY crashes DESC;

-- Preview
SELECT *
FROM warehouse.vw_commercial_road_vehicle_analysis;
--LIMIT 10;