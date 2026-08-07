
-- Check before uploading csv files

SELECT version();

-- Table 1 accident

SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'raw'
  AND table_name = 'accident'
ORDER BY ordinal_position;


-- Table 2 node

SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'raw'
  AND table_name = 'node'
ORDER BY ordinal_position;

-- Table 3 peson

SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'raw'
  AND table_name = 'person'
ORDER BY ordinal_position;

-- Table 4 vehicle

SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'raw'
  AND table_name = 'vehicle'
ORDER BY ordinal_position;