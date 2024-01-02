
SELECT 
EXTRACT(YEAR FROM date_time) AS year, 
EXTRACT(MONTH FROM date_time) AS month, 
SUM(total_order_price)
FROM (
SELECT 
orders_with_product_details.total_order_price,
dim_date_times.date_time
FROM
    (
    SELECT orders_table.product_code, 
            orders_table.date_uuid,
            orders_table.product_quantity, 
            dim_products.product_code, 
            dim_products.product_price, 
            orders_table.product_quantity * dim_products.product_price AS total_order_price
    FROM orders_table
    JOIN dim_products
    on orders_table.product_code = dim_products.product_code
    ) AS orders_with_product_details
JOIN dim_date_times
on orders_with_product_details.date_uuid = dim_date_times.date_uuid
)
GROUP BY 
    month, year
ORDER BY SUM(total_order_price) DESC