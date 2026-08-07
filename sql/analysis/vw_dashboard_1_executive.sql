/*
=====================================================
VIEW: DASHBOARD 1 - EXECUTIVE OVERVIEW
=====================================================

Purpose:
Executive dashboard

Supports:
- KPI Total Crashes
- KPI Fatalities
- KPI Serious Injuries
- KPI Other Injuries
- Crashes by Year
- Crashes by Month
- Crashes by Day
- Severity Breakdown
- Top LGAs
- Metro vs Rural

Expected Row Count:
197,249
=====================================================
*/

DROP VIEW IF EXISTS analytics.vw_dashboard_1_executive;

CREATE VIEW analytics.vw_dashboard_1_executive AS

SELECT

    f.accident_no,

    d.full_date,
    d.year,
    d.quarter,
    d.month,
    d.month_name,
    d.day_of_week,
    d.weekend_flag,
    d.season,

    s.severity_code,
    s.severity_desc,

    l.node_id,
    l.node_type,

    l.lga_name,
    l.lga_name_all,
    l.deg_urban_name,
    l.postcode_crash,

    l.latitude,
    l.longitude,

    f.no_of_persons,
    f.no_of_vehicles,

    f.no_persons_killed,
    f.no_persons_inj_2,
    f.no_persons_inj_3,
    f.no_persons_not_inj,

    f.police_attend

FROM warehouse.fact_accident f

LEFT JOIN warehouse.dim_date d
       ON f.date_key = d.date_key

LEFT JOIN warehouse.dim_location l
       ON f.location_sk = l.location_sk

LEFT JOIN warehouse.dim_severity s
       ON f.severity_sk = s.severity_sk;

-- VERIFY ROW COUNT

SELECT COUNT(*)
FROM analytics.vw_dashboard_1_executive;

-- CHECK COLS

SELECT *
FROM analytics.vw_dashboard_1_executive;
--LIMIT 5;