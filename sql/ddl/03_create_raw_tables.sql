
/*
Project: Victoria Road Crash Analytics
Author: Najeeb Ullah
Database: victoria_crash_dw

Purpose:
Create raw layer tables for source data ingestion.
*/


-- Create accident table (1)

-- DROP TABLE IF EXISTS raw.accident;

CREATE TABLE raw.accident (
	accident_no VARCHAR(20) PRIMARY KEY,
	accident_date TEXT,
	accident_time TEXT,
	accident_type TEXT,
	accident_type_desc TEXT,
	day_of_week TEXT,
	day_week_desc TEXT,
	dca_code TEXT,
    dca_desc TEXT,
    light_condition TEXT,
    node_id INTEGER,
    no_of_vehicles INTEGER,
    no_of_persons INTEGER,
    no_persons_killed INTEGER,
    no_persons_inj_2 INTEGER,
    no_persons_inj_3 INTEGER,
    no_persons_not_inj INTEGER,
    police_attend TEXT,
    road_geometry TEXT,
    road_geometry_desc TEXT,
    severity TEXT,
    speed_zone TEXT,
    rma TEXT
);

-- verify the above created table

SELECT *
FROM information_schema.tables
WHERE table_schema = 'raw';

-- Another useful query

SELECT schemaname,
       tablename
FROM pg_tables
WHERE schemaname = 'raw';

-- Table 2 node

--DROP TABLE IF EXISTS raw.node;

CREATE TABLE raw.node (
    accident_no VARCHAR(20),
    node_id INTEGER,
    node_type TEXT,
    amg_x NUMERIC,
    amg_y NUMERIC,
    lga_name TEXT,
    lga_name_all TEXT,
    deg_urban_name TEXT,
    latitude NUMERIC,
    longitude NUMERIC,
    postcode_crash TEXT
);

-- verify the above created table

SELECT *
FROM information_schema.tables
WHERE table_schema = 'raw';


-- Table 3 person 

--DROP TABLE IF EXISTS raw.person;

CREATE TABLE raw.person (
    accident_no VARCHAR(20),
    person_id VARCHAR(20),
    vehicle_id VARCHAR(20),
    sex TEXT,
    age_group TEXT,
    inj_level TEXT,
    inj_level_desc TEXT,
    seating_position TEXT,
    helmet_belt_worn TEXT,
    road_user_type TEXT,
    road_user_type_desc TEXT,
    licence_state TEXT,
    taken_hospital TEXT,
    ejected_code TEXT
);

-- Verify the above table 
SELECT schemaname,
       tablename
FROM pg_tables
WHERE schemaname = 'raw';


-- Table 4 vehicle
-- imp for our comercial vehicle analysis

--DROP TABLE IF EXISTS raw.vehicle;

CREATE TABLE raw.vehicle (
    accident_no VARCHAR(20),
    vehicle_id VARCHAR(20),
    vehicle_year_manuf INTEGER,
    vehicle_dca_code TEXT,
    initial_direction TEXT,
    road_surface_type TEXT,
    road_surface_type_desc TEXT,
    reg_state TEXT,
    vehicle_body_style TEXT,
    vehicle_make TEXT,
    vehicle_model TEXT,
    vehicle_power INTEGER,
    vehicle_type TEXT,
    vehicle_type_desc TEXT,
    vehicle_weight INTEGER,
    construction_type TEXT,
    fuel_type TEXT,
    no_of_wheels INTEGER,
    no_of_cylinders INTEGER,
    seating_capacity INTEGER,
    tare_weight INTEGER,
    total_no_occupants INTEGER,
    carry_capacity INTEGER,
    cubic_capacity INTEGER,
    final_direction TEXT,
    driver_intent TEXT,
    vehicle_movement TEXT,
    trailer_type TEXT,
    vehicle_colour_1 TEXT,
    vehicle_colour_2 TEXT,
    caught_fire TEXT,
    initial_impact TEXT,
    lamps TEXT,
    level_of_damage TEXT,
    towed_away_flag TEXT,
    traffic_control TEXT,
    traffic_control_desc TEXT
);


-- Verify the above created table now

SELECT schemaname,
       tablename
FROM pg_tables
WHERE schemaname = 'raw'
ORDER BY tablename;