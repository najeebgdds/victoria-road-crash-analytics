/*
=====================================================
CREATE DIM_ROAD_USER
=====================================================
SCOURCE : RAW.PERSON
Purpose:
Human impact analysis
*/

DROP TABLE IF EXISTS warehouse.dim_road_user;

-- CREATE

CREATE TABLE warehouse.dim_road_user
(
    road_user_sk SERIAL PRIMARY KEY,

    road_user_type VARCHAR(20) UNIQUE,
    road_user_type_desc VARCHAR(100)
);

/*
=====================================================
LOAD DIM_ROAD_USER
=====================================================
*/

INSERT INTO warehouse.dim_road_user
(
    road_user_type,
    road_user_type_desc
)
SELECT DISTINCT
    road_user_type,
    road_user_type_desc
FROM raw.person;

-- verify
SELECT COUNT(*)
FROM warehouse.dim_road_user;