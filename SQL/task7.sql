SELECT * FROM dim_card_details

-- DO $$
-- DECLARE
--     max_length INT;
-- BEGIN
--     SELECT INTO max_length MAX(LENGTH(CAST(month AS TEXT))) FROM dim_date_times;
--     EXECUTE 'ALTER TABLE dim_date_times ALTER COLUMN month TYPE VARCHAR(' || max_length || ')';
-- END $$;


-- SELECT 
--     column_name, 
--     data_type 
-- FROM 
--     information_schema.columns 
-- WHERE 
--     table_name = 'dim_card_details' 
--     AND column_name IN ('card_number', 'expiry_date', 'date_payment_confirmed');