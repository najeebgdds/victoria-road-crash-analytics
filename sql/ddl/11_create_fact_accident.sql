/*
=====================================================
CREATE FACT_ACCIDENT
=====================================================
Purpose:
Central fact table for crash analytics

Grain:
One row per accident
=====================================================
*/

DROP TABLE IF EXISTS warehouse.fact_accident;

CREATE TABLE warehouse.fact_accident
(
    accident_no             VARCHAR(20) PRIMARY KEY,

    date_key                INTEGER,
    location_sk             INTEGER,
    severity_sk             INTEGER,
    accident_type_sk        INTEGER,

    no_of_persons           INTEGER,
    no_of_vehicles          INTEGER,

    no_persons_killed       INTEGER,
    no_persons_inj_2        INTEGER,
    no_persons_inj_3        INTEGER,
    no_persons_not_inj      INTEGER,

    police_attend           VARCHAR(5)
);



/*
=====================================================
LOAD FACT_ACCIDENT
=====================================================
*/

INSERT INTO warehouse.fact_accident
(
    accident_no,
    date_key,
    location_sk,
    severity_sk,
    accident_type_sk,
    no_of_persons,
    no_of_vehicles,
    no_persons_killed,
    no_persons_inj_2,
    no_persons_inj_3,
    no_persons_not_inj,
    police_attend
)

SELECT

    a.accident_no,

    TO_CHAR(a.accident_date::DATE,'YYYYMMDD')::INTEGER,

    l.location_sk,

    s.severity_sk,

    at.accident_type_sk,

    a.no_of_persons,
    a.no_of_vehicles,

    a.no_persons_killed,
    a.no_persons_inj_2,
    a.no_persons_inj_3,
    a.no_persons_not_inj,

    a.police_attend

FROM raw.accident a

LEFT JOIN warehouse.dim_location l
       ON a.node_id = l.node_id

LEFT JOIN warehouse.dim_severity s
       ON a.severity = s.severity_code

LEFT JOIN warehouse.dim_accident_type at
       ON a.accident_type = at.accident_type
      AND a.accident_type_desc = at.accident_type_desc
      AND a.dca_code = at.dca_code;


-- Verification Queries

-- Row Count

SELECT COUNT(*)
FROM warehouse.fact_accident;

-- Missing Date Keys

SELECT COUNT(*)
FROM warehouse.fact_accident
WHERE date_key IS NULL;

-- Missing Location Keys

SELECT COUNT(*)
FROM warehouse.fact_accident
WHERE location_sk IS NULL;


-- Missing Severity Keys

SELECT COUNT(*)
FROM warehouse.fact_accident
WHERE severity_sk IS NULL;

-- Missing Accident Type Keys
SELECT COUNT(*)
FROM warehouse.fact_accident
WHERE accident_type_sk IS NULL;

-- Business Validation

SELECT
    SUM(no_persons_killed)      AS fatalities,
    SUM(no_persons_inj_2)       AS serious_injuries,
    SUM(no_persons_inj_3)       AS other_injuries
FROM warehouse.fact_accident;

-- run the above with slight change 

SELECT
    SUM(no_persons_killed)      AS fatalities,
    SUM(no_persons_inj_2)       AS serious_injuries,
    SUM(no_persons_inj_3)       AS other_injuries,
    SUM(no_persons_not_inj)     AS not_injured
FROM warehouse.fact_accident;