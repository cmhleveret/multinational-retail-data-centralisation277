

SELECT  
store_type,
numbers_of_sales,
-- total_numbers_of_sales,
CAST(numbers_of_sales AS FLOAT) / total_numbers_of_sales * 100 AS "percentage_total(%)"
FROM
(
    -- SUM(COUNT(store_type)) OVER () AS total_numbers_of_sales uses a window function to sum the counts of sales across all store types. The OVER () clause specifies that the window function applies to all rows in the result set, which effectively calculates the total count of sales.
    SELECT   
        store_type, 
       COUNT(store_type) AS numbers_of_sales,
       SUM(COUNT(store_type)) OVER () AS total_numbers_of_sales
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
    ) AS total
GROUP BY store_type
)
ORDER BY "percentage_total(%)" DESC

