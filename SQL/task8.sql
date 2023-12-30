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