/*
=====================================================
CREATE DIM_ROAD
=====================================================
SCOURCE : raw.accident
Purpose:
Road design analysis
Speed zone analysis
*/

DROP TABLE IF EXISTS warehouse.dim_road;


-- CREATE

CREATE TABLE warehouse.dim_road
(
    road_sk SERIAL PRIMARY KEY,

    road_geometry VARCHAR(20),
    road_geometry_desc VARCHAR(100),

    speed_zone VARCHAR(10)
);


/*
=====================================================
LOAD DIM_ROAD
=====================================================
*/

INSERT INTO warehouse.dim_road
(
    road_geometry,
    road_geometry_desc,
    speed_zone
)
SELECT DISTINCT
    road_geometry,
    road_geometry_desc,
    speed_zone
FROM raw.accident;

-- VERIFY
SELECT COUNT(*)
FROM warehouse.dim_road;