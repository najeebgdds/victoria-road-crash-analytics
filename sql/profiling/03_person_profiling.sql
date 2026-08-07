
/*
=====================================================
PERSON TABLE PROFILING NOTES
=====================================================
Row Count:
- 460,459 records

Grain:
- One row per person involved in an accident

Candidate Primary Key:
- (accident_no, person_id)

Relationships:
- Many persons can belong to one accident
- accident_no links to accident table

Data Quality Findings:
- 116 accidents have no corresponding person records
- No duplicate (accident_no, person_id) combinations found

Key Distributions:
- Fatalities: 3,541
- Serious Injury: 81,873
- Other Injury: 171,026
- Not Injured: 204,019

Road User Types:
- Drivers are the largest group
- Followed by passengers, motorcyclists, bicyclists, and pedestrians

Gender:
- M: 259,149
- F: 184,815
- U: 16,460
- Blank: 35

Interesting Findings:
- Seating positions using letters (A,B,C...) largely correspond to drivers
- Numeric seating positions (01,02,03...) largely correspond to passengers
- Only 97 exceptions found

Hospital Flag:
- Large number of NULL values
- Cross-tab suggests many NULLs represent not recorded/not applicable rather than bad data

Potential Dashboard Ideas:
- Injury severity by age group
- Injury severity by road user type
- Pedestrian vs motorcyclist risk
- Hospitalisation patterns
=====================================================
*/

SELECT COLUMN_NAME
FROM information_schema.columns
WHERE table_schema = 'raw'
	AND table_name = 'person'
ORDER BY ordinal_position;	


-- Uniqueness

SELECT 
	COUNT(*) AS total_rows,
	COUNT(DISTINCT person_id) AS distinct_persons
FROM raw.person;	
-- 460459	116  >> person_id alone cant be a PK
-- lets check and find out 


SELECT person_id,
	   COUNT(*)
FROM raw.person
GROUP BY person_id
ORDER BY COUNT(*) DESC;

-- letetrs for drivers and ints for non drivers

SELECT COUNT(*)
FROM (
	SELECT accident_no,person_id
	FROM raw.person
	GROUP BY accident_no,person_id
	HAVING COUNT(*) > 1
) t;
-- got 0 means no duplication and validated
-- so hypothesis of accident_no + person_id looks good
-- PK accident_no + person_id


SELECT
    MIN(person_count) AS min_people,
    MAX(person_count) AS max_people
FROM (
    SELECT
        accident_no,
        COUNT(*) AS person_count
    FROM raw.person
    GROUP BY accident_no
) t;

/* 1	97  >> One accident can involve:
1 person 
2 people
10 people
-- even 97 people */


-- lets do further checks on other cols
-- Injurry level

SELECT
    inj_level,
    inj_level_desc,
    COUNT(*)
FROM raw.person
GROUP BY inj_level, inj_level_desc
ORDER BY inj_level DESC;

-- Road User Type

SELECT
		road_user_type,
    road_user_type_desc,
	COUNT(*)
FROM raw.person
GROUP BY road_user_type,road_user_type_desc
ORDER BY COUNT(*) DESC;


-- Gender

SELECT
	sex,
	COUNT(*)
FROM raw.person
GROUP BY sex
ORDER BY COUNT(*) DESC;


-- Age Group

SELECT
	age_group,
	COUNT(*)
FROM raw.person
GROUP BY age_group
ORDER BY COUNT(*);

-- Licence States
SELECT
	licence_state,
	COUNT(*)
FROM raw.person
GROUP BY licence_state
ORDER BY COUNT(*) DESC;

-- invistigation of licence 
--  for blanks

SELECT
    road_user_type_desc,
    COUNT(*) AS missing_licence
FROM raw.person
WHERE licence_state IS NULL
   OR licence_state = ''
GROUP BY road_user_type_desc
ORDER BY missing_licence DESC;

-- look into null values 
SELECT
	taken_hospital,
	COUNT(*)
FROM raw.person
GROUP BY taken_hospital
ORDER BY COUNT(*);

--
SELECT
    inj_level_desc,
    taken_hospital,
    COUNT(*)
FROM raw.person
GROUP BY inj_level_desc, taken_hospital
ORDER BY inj_level_desc, taken_hospital;

