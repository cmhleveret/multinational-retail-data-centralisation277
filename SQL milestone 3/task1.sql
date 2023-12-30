

-- DO $$
-- DECLARE
--     max_length INT;
-- BEGIN
--     SELECT INTO max_length MAX(LENGTH(CAST(store_code AS TEXT))) FROM orders_table;
--     EXECUTE 'ALTER TABLE orders_table ALTER COLUMN store_code TYPE VARCHAR(' || max_length || ')';
-- END $$;

-- ALTER TABLE orders_table
--     ALTER COLUMN product_quantity TYPE SMALLINT;
   
-- ALTER TABLE orders_table
--     ALTER COLUMN date_uuid TYPE UUID USING (date_uuid::uuid);

-- ALTER TABLE orders_table
--     ALTER COLUMN user_uuid TYPE UUID USING (user_uuid::uuid);


SELECT 
    column_name, 
    data_type 
FROM 
    information_schema.columns 
WHERE 
    table_name = 'orders_table' 
    AND column_name IN ('card_number', 'product_quantity', 'date_uuid', 'user_uuid', 'product_code', 'store_code');

