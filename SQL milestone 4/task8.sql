-- SELECT * FROM dim_store_details
-- SELECT * FROM orders_table
-- SELECT * FROM dim_products

SELECT 
SUM(orders_with_product_details.total_order_price),
dim_store_details.store_type, 
dim_store_details.country_code
FROM
(
SELECT orders_table.product_code, 
            orders_table.date_uuid,
            orders_table.store_code,
            orders_table.product_quantity, 
            dim_products.product_code, 
            dim_products.product_price, 
            orders_table.product_quantity * dim_products.product_price AS total_order_price
    FROM orders_table
    JOIN dim_products
on orders_table.product_code = dim_products.product_code
) AS orders_with_product_details
JOIN dim_store_details
on dim_store_details.store_code = orders_with_product_details.store_code
-- where must be before group by
WHERE country_code = 'DE'
GROUP BY store_type, country_code
ORDER BY SUM(orders_with_product_details.total_order_price) ASC
