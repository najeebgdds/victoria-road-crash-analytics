
/*
=====================================================
CREATE DIM_ACCIDENT_TYPE
=====================================================
scource : raw.accident
Purpose:
Rear End
Right Through
Cross Traffic
Pedestrian Strike

*/

DROP TABLE IF EXISTS warehouse.dim_accident_type;

-- CREATE

CREATE TABLE warehouse.dim_accident_type
(
    accident_type_sk SERIAL PRIMARY KEY,

    accident_type VARCHAR(20),
    accident_type_desc VARCHAR(100),

    dca_code VARCHAR(20),
    dca_desc VARCHAR(250)
);


/*
=====================================================
LOAD DIM_ACCIDENT_TYPE
=====================================================
*/

INSERT INTO warehouse.dim_accident_type
(
    accident_type,
    accident_type_desc,
    dca_code,
    dca_desc
)
SELECT DISTINCT
    accident_type,
    accident_type_desc,
    dca_code,
    dca_desc
FROM raw.accident;

-- VERIFY

SELECT COUNT(*)
FROM warehouse.dim_accident_type;