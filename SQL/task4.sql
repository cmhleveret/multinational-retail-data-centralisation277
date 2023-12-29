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