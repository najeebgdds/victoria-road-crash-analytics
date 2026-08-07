/*
=====================================================
CREATE DIM_VEHICLE_TYPE
=====================================================
Scource : raw.vehicle
Purpose:
Vehicle analysis
Vehicle involvement trends
*/

DROP TABLE IF EXISTS warehouse.dim_vehicle_type;

-- CREATE

CREATE TABLE warehouse.dim_vehicle_type
(
    vehicle_type_sk SERIAL PRIMARY KEY,

    vehicle_type VARCHAR(20) UNIQUE,
    vehicle_type_desc VARCHAR(100)
);


/*
=====================================================
LOAD DIM_VEHICLE_TYPE
=====================================================
*/

INSERT INTO warehouse.dim_vehicle_type
(
    vehicle_type,
    vehicle_type_desc
)
SELECT DISTINCT
    vehicle_type,
    vehicle_type_desc
FROM raw.vehicle;

-- VERIFY

SELECT COUNT(*)
FROM warehouse.dim_vehicle_type;