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