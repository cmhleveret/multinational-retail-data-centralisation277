-- SELECT * FROM orders_table
-- SELECT * FROM dim_date_times
-- SELECT * FROM dim_store_details

-- SELECT month, 
--        COUNT(month) AS sales_per_month,
--         SUM(product_quantity) AS product_quantity_per_month
-- FROM 
--     (
--     SELECT orders_table.date_uuid, orders_table.product_quantity, dim_date_times.date_uuid, dim_date_times.month FROM orders_table
--     JOIN dim_date_times
--     on orders_table.date_uuid = dim_date_times.date_uuid
--     )
-- GROUP BY 
--     month
-- ORDER BY month DESC

SELECT   
CASE 
-- <> is a comparison operator that means "not equal to." So this condition checks if the store_type column does not equal the text 'Web Portal'.
    WHEN store_type <> 'Web Portal' THEN 'Offline' 
    ELSE 'Web' 
  END AS location, 
       COUNT(store_type) AS numbers_of_sales,
        SUM(product_quantity) AS product_quantity_count
FROM 
    (
        SELECT dim_store_details.store_code, dim_store_details.store_type, orders_with_store_detials.store_code, orders_with_store_detials.product_quantity
        FROM(
            SELECT orders_table.date_uuid, orders_table.store_code, orders_table.product_quantity, dim_date_times.date_uuid, dim_date_times.month 
            FROM orders_table
            JOIN dim_date_times
            on orders_table.date_uuid = dim_date_times.date_uuid
        ) AS orders_with_store_detials
        JOIN dim_store_details
        on dim_store_details.store_code = orders_with_store_detials.store_code
    )
GROUP BY 
CASE 
    WHEN store_type <> 'Web Portal' THEN 'Offline' 
    ELSE 'Web' 
  END

