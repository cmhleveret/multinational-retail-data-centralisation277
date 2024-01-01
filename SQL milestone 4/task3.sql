-- SELECT * FROM orders_table
-- SELECT * FROM dim_date_times

SELECT month, 
       COUNT(month) AS sales_per_month,
        SUM(product_quantity) AS product_quantity_per_month
FROM 
    (
    SELECT orders_table.date_uuid, orders_table.product_quantity, dim_date_times.date_uuid, dim_date_times.month FROM orders_table
    JOIN dim_date_times
    on orders_table.date_uuid = dim_date_times.date_uuid
    )
GROUP BY 
    month
ORDER BY month DESC


-- WHERE country = 'United Kingdom'

