
-- GETTING VIEWS FROM VIEWS TABLE 

COPY (SELECT * FROM analytics.vw_crash_overview)
TO 'C:\\Users\\yoga\\Desktop\\Portfolios\\VicCrash\\exports\\vw_crash_overview.csv'
WITH (FORMAT CSV, HEADER TRUE);

COPY (SELECT * FROM analytics.vw_severity_trends)
TO 'C:\\Users\\yoga\\Desktop\\Portfolios\\VicCrash\\exports\\vw_severity_trends.csv'
WITH (FORMAT CSV, HEADER TRUE);

COPY (SELECT * FROM analytics.vw_location_analysis)
TO 'C:\\Users\\yoga\\Desktop\\Portfolios\\VicCrash\\exports\\vw_location_analysis.csv'
WITH (FORMAT CSV, HEADER TRUE);

COPY (SELECT * FROM analytics.vw_accident_types)
TO 'C:\\Users\\yoga\\Desktop\\Portfolios\\VicCrash\\exports\\vw_accident_types.csv'
WITH (FORMAT CSV, HEADER TRUE);

COPY (SELECT * FROM analytics.vw_person_analysis)
TO 'C:\\Users\\yoga\\Desktop\\Portfolios\\VicCrash\\exports\\vw_person_analysis.csv'
WITH (FORMAT CSV, HEADER TRUE);

COPY (SELECT * FROM analytics.vw_commercial_vehicle_analysis)
TO 'C:\\Users\\yoga\\Desktop\\Portfolios\\VicCrash\\exports\\vw_commercial_vehicle_analysis.csv'
WITH (FORMAT CSV, HEADER TRUE);