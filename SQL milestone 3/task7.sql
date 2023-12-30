-- SELECT * FROM dim_card_details

-- DO $$
-- DECLARE
--     max_length INT;
-- BEGIN
--     SELECT INTO max_length MAX(LENGTH(CAST(card_number AS TEXT))) FROM dim_card_details;
--     EXECUTE 'ALTER TABLE dim_card_details ALTER COLUMN card_number TYPE VARCHAR(' || max_length || ')';
-- END $$;

-- DO $$
-- DECLARE
--     max_length INT;
-- BEGIN
--     SELECT INTO max_length MAX(LENGTH(CAST(expiry_date AS TEXT))) FROM dim_card_details;
--     EXECUTE 'ALTER TABLE dim_card_details ALTER COLUMN expiry_date TYPE VARCHAR(' || max_length || ')';
-- END $$;

-- ALTER TABLE dim_card_details
-- ALTER COLUMN date_payment_confirmed TYPE DATE

-- ALTER TABLE dim_card_details
-- ALTER COLUMN date_payment_confirmed TYPE DATE USING to_date(date_payment_confirmed, 'YYYY-MM-DD');

-- DELETE FROM dim_card_details
-- WHERE TRY_CAST(date_payment_confirmed AS DATE) IS NULL;

SELECT 
    column_name, 
    data_type 
FROM 
    information_schema.columns 
WHERE 
    table_name = 'dim_card_details' 
    AND column_name IN ('card_number', 'expiry_date', 'date_payment_confirmed');