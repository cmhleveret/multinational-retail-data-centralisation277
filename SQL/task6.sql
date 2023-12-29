-- SELECT * FROM dim_date_times

-- DO $$
-- DECLARE
--     max_length INT;
-- BEGIN
--     SELECT INTO max_length MAX(LENGTH(CAST(month AS TEXT))) FROM dim_date_times;
--     EXECUTE 'ALTER TABLE dim_date_times ALTER COLUMN month TYPE VARCHAR(' || max_length || ')';
-- END $$;

-- DO $$
-- DECLARE
--     max_length INT;
-- BEGIN
--     SELECT INTO max_length MAX(LENGTH(CAST(year AS TEXT))) FROM dim_date_times;
--     EXECUTE 'ALTER TABLE dim_date_times ALTER COLUMN year TYPE VARCHAR(' || max_length || ')';
-- END $$;

-- DO $$
-- DECLARE
--     max_length INT;
-- BEGIN
--     SELECT INTO max_length MAX(LENGTH(CAST(day AS TEXT))) FROM dim_date_times;
--     EXECUTE 'ALTER TABLE dim_date_times ALTER COLUMN day TYPE VARCHAR(' || max_length || ')';
-- END $$;

-- DO $$
-- DECLARE
--     max_length INT;
-- BEGIN
--     SELECT INTO max_length MAX(LENGTH(CAST(time_period AS TEXT))) FROM dim_date_times;
--     EXECUTE 'ALTER TABLE dim_date_times ALTER COLUMN time_period TYPE VARCHAR(' || max_length || ')';
-- END $$;

-- DELETE FROM dim_date_times
-- WHERE LENGTH(date_uuid) < 36;

-- ALTER TABLE dim_date_times
--     ALTER COLUMN date_uuid TYPE UUID USING (date_uuid::uuid);

SELECT 
    column_name, 
    data_type 
FROM 
    information_schema.columns 
WHERE 
    table_name = 'dim_date_times' 
    AND column_name IN ('month', 'year', 'day', 'time_period', 'date_uuid');