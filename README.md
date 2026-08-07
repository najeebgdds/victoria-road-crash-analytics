# Victoria Road Crash Analytics

An end-to-end road safety analytics project analysing Victoria crash data from 2012 to 2024 using PostgreSQL, SQL and Tableau.

## Tableau Public

[View the interactive Tableau story](https://public.tableau.com/app/profile/najeeb.ullah1185/viz/Victoria_Road_Crash_Analytics_2012_2024/RoadUserSafetyAnalysis)

## Project overview

This project transforms raw accident, location, person and vehicle data into a structured analytical warehouse and an interactive Tableau story.

The analysis focuses on:

- Crash trends over time.
- Fatalities and injury severity.
- Road-user involvement.
- Geographic concentration by LGA and postcode.
- Crash hotspots.
- Seasonal and day-of-week patterns.
- Commercial vehicle characteristics.

## Tools

- PostgreSQL.
- SQL.
- Tableau.
- GitHub.
- Python/Pandas where required for data preparation.

## Data warehouse

The solution follows a layered architecture:

```text
Raw source files
       ↓
Raw schema
       ↓
Staging schema
       ↓
Warehouse schema
       ↓
Analytical views
       ↓
Tableau dashboards
```

The warehouse uses dimensional modelling with a central accident fact table and supporting dimensions for date, location, severity, road, accident type, vehicle type and road user.

## Data quality

The source data contains:

- 197,249 accident records.
- 200,259 node records.
- 460,459 person records.
- 359,764 vehicle records.

The project includes validation of keys, duplicates, null values, relationships and data grain.

## Dashboard stories

The Tableau workbook includes:

- Victoria Road Crash Analytics.
- Fatalities.
- Geographic Crash Concentration.
- Temporal Patterns in Road Crashes.
- Road User Safety Analysis.
- Commercial Vehicle Crash Analysis.

## Key insights

The analysis identifies drivers as the largest road-user group and highlights variation in crash severity, fatalities, geographic concentration and temporal patterns across Victoria.

LGA means Local Government Area, referring to the council area in which a crash occurred, such as Melbourne, Casey, Geelong, Hume or Dandenong.

## Report

A professional project report is included in the documentation folder.

## Author

Najeeb Ullah  
Melbourne, Victoria  
