-- SELECT * FROM dim_products

-- ALTER TABLE dim_products ADD COLUMN product_price_temp FLOAT;
-- UPDATE dim_products SET product_price_temp  = CAST(product_price AS FLOAT);
-- ALTER TABLE dim_products DROP COLUMN product_price;
-- ALTER TABLE dim_products RENAME COLUMN product_price_temp TO product_price;

-- ALTER TABLE dim_products
--     ALTER COLUMN weight_kg TYPE FLOAT

-- DO $$
-- DECLARE
--     max_length INT;
-- BEGIN
--     SELECT INTO max_length MAX(LENGTH(CAST(product_code AS TEXT))) FROM dim_products;
--     EXECUTE 'ALTER TABLE dim_products ALTER COLUMN product_code TYPE VARCHAR(' || max_length || ')';
-- END $$;

-- DO $$
-- DECLARE
--     max_length INT;
-- BEGIN
--     SELECT INTO max_length MAX(LENGTH(CAST("EAN" AS TEXT))) FROM dim_products;
--     EXECUTE 'ALTER TABLE dim_products ALTER COLUMN "EAN" TYPE VARCHAR(' || max_length || ')';
-- END $$;

-- ALTER TABLE dim_products
--     ALTER COLUMN date_added TYPE DATE

-- ALTER TABLE dim_products
--     ALTER COLUMN uuid TYPE UUID USING (uuid::uuid);

-- ALTER TABLE dim_products
--     ALTER COLUMN still_available TYPE BOOL

-- ALTER TABLE dim_products ADD COLUMN still_available BOOL;

-- UPDATE dim_products
-- SET still_available = CASE
--     WHEN removed = 'Removed' THEN false
--     WHEN removed = 'Still_avaliable' THEN true
--     ELSE still_available -- Keeps the current value if none of the above conditions are met
-- END;

-- DO $$
-- DECLARE
--     max_length INT;
-- BEGIN
--     SELECT INTO max_length MAX(LENGTH(CAST(weight_class AS TEXT))) FROM dim_products;
--     EXECUTE 'ALTER TABLE dim_products ALTER COLUMN weight_class TYPE VARCHAR(' || max_length || ')';
-- END $$;

SELECT 
    column_name, 
    data_type 
FROM 
    information_schema.columns 
WHERE 
    table_name = 'dim_products' 
    AND column_name IN ('product_price', 'weight_kg', 'EAN', 'product_code', 'date_added', 'uuid', 'still_available', 'weight_class');

