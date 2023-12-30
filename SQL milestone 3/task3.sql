-- SELECT * FROM dim_store_details

-- ALTER TABLE dim_store_details ADD COLUMN longitude_new FLOAT;
-- UPDATE dim_store_details SET longitude_new = CAST(longitude AS FLOAT);
-- ALTER TABLE dim_store_details DROP COLUMN longitude;
-- ALTER TABLE dim_store_details RENAME COLUMN longitude_new TO longitude;

-- ALTER TABLE dim_store_details
--     ALTER COLUMN locality TYPE VARCHAR(255)

-- DO $$
-- DECLARE
--     max_length INT;
-- BEGIN
--     SELECT INTO max_length MAX(LENGTH(CAST(store_code AS TEXT))) FROM dim_store_details;
--     EXECUTE 'ALTER TABLE dim_store_details ALTER COLUMN store_code TYPE VARCHAR(' || max_length || ')';
-- END $$;

-- ALTER TABLE dim_store_details
--     ALTER COLUMN staff_numbers TYPE SMALLINT

-- ALTER TABLE dim_store_details
--     ALTER COLUMN opening_date TYPE DATE

-- ALTER TABLE dim_store_details
--     ALTER COLUMN store_type TYPE VARCHAR(255)

-- ALTER TABLE dim_store_details
--     ALTER COLUMN latitude TYPE FLOAT

-- ALTER TABLE dim_store_details ADD COLUMN latitude_new FLOAT;
-- UPDATE dim_store_details SET latitude_new = CAST(longitude AS FLOAT);
-- ALTER TABLE dim_store_details DROP COLUMN latitude;
-- ALTER TABLE dim_store_details RENAME COLUMN latitude_new TO latitude;

-- DO $$
-- DECLARE
--     max_length INT;
-- BEGIN
--     SELECT INTO max_length MAX(LENGTH(CAST(country_code AS TEXT))) FROM dim_store_details;
--     EXECUTE 'ALTER TABLE dim_store_details ALTER COLUMN country_code TYPE VARCHAR(' || max_length || ')';
-- END $$;

-- ALTER TABLE dim_store_details
--     ALTER COLUMN continent TYPE VARCHAR(255)

-- DELETE FROM table_name WHERE column_name IS NULL;

SELECT 
    column_name, 
    data_type 
FROM 
    information_schema.columns 
WHERE 
    table_name = 'dim_store_details' 
    AND column_name IN ('longitude', 'locality', 'store_code', 'staff_numbers', 'opening_date', 'store_type', 'latitude', 'country_code', 'continent', 'longitude_new');