
-- SELECT * FROM dim_users

-- ALTER TABLE dim_users
--     ALTER COLUMN first_name TYPE VARCHAR(255)

-- ALTER TABLE dim_users
--     ALTER COLUMN last_name TYPE VARCHAR(255)

-- ALTER TABLE dim_users
--     ALTER COLUMN date_of_birth TYPE DATE

-- DO $$
-- DECLARE
--     max_length INT;
-- BEGIN
--     SELECT INTO max_length MAX(LENGTH(CAST(country_code AS TEXT))) FROM dim_users;
--     EXECUTE 'ALTER TABLE dim_users ALTER COLUMN country_code TYPE VARCHAR(' || max_length || ')';
-- END $$;

-- ALTER TABLE dim_users
--     ALTER COLUMN user_uuid TYPE UUID USING (user_uuid::uuid);


-- ALTER TABLE dim_users
--     ALTER COLUMN join_date TYPE DATE

SELECT 
    column_name, 
    data_type 
FROM 
    information_schema.columns 
WHERE 
    table_name = 'dim_users' 
    AND column_name IN ('first_name', 'last_name', 'date_of_birth', 'country_code', 'user_uuid', 'join_date');

