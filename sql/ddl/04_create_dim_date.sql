

/*
=====================================================
CREATE DIM_DATE
=====================================================
scource : accident
Purpose:

Trends
Monthly analysis
Seasonal analysis
Year-over-year reporting
*/

DROP TABLE IF EXISTS warehouse.dim_date;

-- Create dim_date

CREATE TABLE warehouse.dim_date
(
    date_key        INTEGER PRIMARY KEY,
    full_date       DATE,
    year            INTEGER,
    quarter         INTEGER,
    month           INTEGER,
    month_name      VARCHAR(20),
    day             INTEGER,
    day_of_week     VARCHAR(20),
    weekend_flag    VARCHAR(10),
    season          VARCHAR(10)
);


/*
=====================================================
LOAD DIM_DATE
=====================================================
*/

INSERT INTO warehouse.dim_date
(
    date_key,
    full_date,
    year,
    quarter,
    month,
    month_name,
    day,
    day_of_week,
    weekend_flag,
    season
)
SELECT DISTINCT

    TO_CHAR(accident_date::date,'YYYYMMDD')::INTEGER AS date_key,

    accident_date::date,

    EXTRACT(YEAR FROM accident_date::date),

    EXTRACT(QUARTER FROM accident_date::date),

    EXTRACT(MONTH FROM accident_date::date),

    TO_CHAR(accident_date::date,'Month'),

    EXTRACT(DAY FROM accident_date::date),

    day_week_desc,

    CASE
        WHEN day_week_desc IN ('Saturday','Sunday')
            THEN 'Weekend'
        ELSE 'Weekday'
    END,

    CASE
        WHEN EXTRACT(MONTH FROM accident_date::date) IN (12,1,2)
            THEN 'Summer'
        WHEN EXTRACT(MONTH FROM accident_date::date) IN (3,4,5)
            THEN 'Autumn'
        WHEN EXTRACT(MONTH FROM accident_date::date) IN (6,7,8)
            THEN 'Winter'
        ELSE 'Spring'
    END

FROM raw.accident;



-- Verify
SELECT COUNT(*)
FROM warehouse.dim_date;




