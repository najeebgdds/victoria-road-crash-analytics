/*
=====================================================
CREATE DIM_SEVERITY
=====================================================
Scource : raw.accident

Purpose:
Injury reporting
Fatality analysis
*/

DROP TABLE IF EXISTS warehouse.dim_severity;


-- CREATE  warehouse.dim_severity

CREATE TABLE warehouse.dim_severity
(
    severity_sk SERIAL PRIMARY KEY,

    severity_code VARCHAR(10) UNIQUE,
    severity_desc VARCHAR(50)
);

/*
=====================================================
LOAD DIM_SEVERITY
=====================================================
*/

INSERT INTO warehouse.dim_severity
(
    severity_code,
    severity_desc
)
VALUES
('1','Fatal Accident'),
('2','Serious Injury'),
('3','Other Injury'),
('4','Non Injury');

-- VERIFY
SELECT COUNT(*)
FROM warehouse.dim_severity;

