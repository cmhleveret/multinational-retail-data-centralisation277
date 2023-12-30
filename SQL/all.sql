

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

    SELECT * FROM dim_products

-- The product_price column has a £ which we need to remove

-- UPDATE dim_products
-- SET product_price = TRIM('£' FROM product_price);

-- ALTER TABLE dim_products ADD COLUMN weight_class VARCHAR(255);

-- UPDATE dim_products
-- SET weight_class = 'Light'
-- WHERE weight_kg < 2;

-- UPDATE dim_products
-- SET weight_class = 'Mid_Sized'
-- WHERE weight_kg >= 2 AND weight_kg < 40;

-- UPDATE dim_products
-- SET weight_class = 'Heavy'
-- WHERE weight_kg >= 40 AND weight_kg < 140;

-- UPDATE dim_products
-- SET weight_class = 'Truck_Required'
-- WHERE weight_kg >= 140;

--A better way to write the above

-- UPDATE dim_products
-- SET weight_class = CASE
--     WHEN weight_kg < 2 THEN 'Light'
--     WHEN weight_kg >= 2 AND weight_kg < 40 THEN 'Mid_Sized'
--     WHEN weight_kg >= 40 AND weight_kg < 140 THEN 'Heavy'
--     WHEN weight_kg >= 140 THEN 'Truck_Required'
--     ELSE weight_class -- Keeps the current value if none of the above conditions are met
-- END;

-- DO $$
-- DECLARE
--     max_length INT;
-- BEGIN
--     SELECT INTO max_length MAX(LENGTH(CAST(weight_class AS TEXT))) FROM dim_products;
--     EXECUTE 'ALTER TABLE dim_products ALTER COLUMN weight_class TYPE VARCHAR(' || max_length || ')';
-- END $$;

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

    --ADDING PRIMARY KEYS
-- SELECT * FROM orders_table

--update dim users with primary key
-- SELECT * FROM dim_users

--check all values are unique and non null
-- SELECT user_uuid, COUNT(*) 
-- FROM dim_users 
-- GROUP BY user_uuid 
-- HAVING COUNT(*) > 1;

-- SELECT COUNT(*) 
-- FROM dim_users
-- WHERE user_uuid IS NULL;

-- ALTER TABLE dim_users
-- ADD PRIMARY KEY (user_uuid);

-- SELECT card_number FROM dim_card_details

-- check all values are unique and non null
-- SELECT card_number, COUNT(*) 
-- FROM dim_card_details 
-- GROUP BY card_number 
-- HAVING COUNT(*) > 1;

-- SELECT COUNT(*) 
-- FROM dim_card_details
-- WHERE card_number IS NULL;

-- ALTER TABLE dim_card_details
-- ADD PRIMARY KEY (card_number);

-- SELECT * FROM dim_date_times

-- check all values are unique and non null
-- SELECT date_uuid, COUNT(*) 
-- FROM dim_date_times 
-- GROUP BY date_uuid 
-- HAVING COUNT(*) > 1;

-- SELECT COUNT(*) 
-- FROM dim_date_times
-- WHERE date_uuid IS NULL;

-- ALTER TABLE dim_date_times
-- ADD PRIMARY KEY (date_uuid);

-- SELECT * FROM dim_products

-- check all values are unique and non null
-- SELECT product_code, COUNT(*) 
-- FROM dim_products
-- GROUP BY product_code 
-- HAVING COUNT(*) > 1;

-- SELECT COUNT(*) 
-- FROM dim_products
-- WHERE product_code IS NULL;

-- ALTER TABLE dim_products
-- ADD PRIMARY KEY (product_code);

-- SELECT * FROM dim_store_details

-- check all values are unique and non null
-- SELECT store_code, COUNT(*) 
-- FROM dim_store_details
-- GROUP BY store_code
-- HAVING COUNT(*) > 1;

-- SELECT COUNT(*) 
-- FROM dim_store_details
-- WHERE store_code IS NULL;

ALTER TABLE dim_store_details
ADD PRIMARY KEY (store_code);

--ADDing Foreign keys to the orders table

SELECT * FROM orders_table

-- SELECT * FROM dim_card_details

--identify values that arent in the primary key table
-- SELECT DISTINCT card_number 
-- FROM orders_table 
-- WHERE card_number NOT IN (SELECT card_number FROM dim_card_details);

-- DELETE FROM orders_table
-- WHERE card_number NOT IN (SELECT card_number FROM dim_card_details);

-- SELECT DISTINCT card_number 
-- FROM orders_table 
-- WHERE card_number NOT IN (SELECT card_number FROM dim_card_details);

--SET foreign key
-- ALTER TABLE orders_table
-- ADD CONSTRAINT foreign_key_card_number
-- FOREIGN KEY (card_number) REFERENCES dim_card_details(card_number);



-- SELECT * FROM dim_date_times

--identify values that arent in the primary key table
-- SELECT DISTINCT date_uuid 
-- FROM orders_table 
-- WHERE date_uuid NOT IN (SELECT date_uuid FROM dim_date_times);

-- DELETE FROM orders_table
-- WHERE card_number NOT IN (SELECT card_number FROM dim_card_details);

--SET foreign key
-- ALTER TABLE orders_table
-- ADD CONSTRAINT foreign_key_date_uuid
-- FOREIGN KEY (date_uuid) REFERENCES dim_date_times(date_uuid);



-- SELECT * FROM dim_products

--identify values that arent in the primary key table
-- SELECT DISTINCT product_code 
-- FROM orders_table 
-- WHERE product_code NOT IN (SELECT product_code FROM dim_products);

-- DELETE FROM orders_table
-- WHERE product_code NOT IN (SELECT product_code FROM dim_products);

--SET foreign key
-- ALTER TABLE orders_table
-- ADD CONSTRAINT foreign_key_product_code
-- FOREIGN KEY (product_code) REFERENCES dim_products(product_code);


-- SELECT * FROM dim_store_details

-- identify values that arent in the primary key table
-- SELECT DISTINCT store_code
-- FROM orders_table
-- WHERE store_code NOT IN (SELECT store_code FROM dim_store_details)

-- DELETE FROM orders_table
-- WHERE store_code NOT IN (SELECT store_code FROM dim_store_details)


-- SET foreign key
-- ALTER TABLE orders_table
-- ADD CONSTRAINT foreign_key_store_code
-- FOREIGN KEY (store_code) REFERENCES dim_store_details(store_code);



-- SELECT * FROM dim_users

-- identify values that arent in the primary key table
-- SELECT DISTINCT user_uuid
-- FROM orders_table
-- WHERE user_uuid NOT IN (SELECT user_uuid FROM dim_users)

-- DELETE FROM orders_table
-- WHERE user_uuid NOT IN (SELECT user_uuid FROM dim_users)

-- SET foreign key
-- ALTER TABLE orders_table
-- ADD CONSTRAINT foreign_key_user_uuid
-- FOREIGN KEY (user_uuid) REFERENCES dim_users(user_uuid);