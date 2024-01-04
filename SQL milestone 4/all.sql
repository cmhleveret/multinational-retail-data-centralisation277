-- SELECT * from dim_store_details

--need to fix this error with contient names
-- SELECT continent 
--     FROM
--         dim_store_details
--     WHERE 
--         continent LIKE 'eeE%'

-- UPDATE dim_store_details
-- SET continent = 'Europe'
-- WHERE continent LIKE 'eeE%'

-- SELECT continent 
--     FROM
--         dim_store_details
--     WHERE 
--         continent LIKE 'eeA%'

-- UPDATE dim_store_details
-- SET continent = 'America'
-- WHERE continent LIKE 'eeA%'

SELECT country_code, 
       COUNT(country_code) AS total_number_country_code
FROM 
    dim_store_details
GROUP BY 
    country_code
ORDER BY
    total_number_country_code DESC
LIMIT 
    5;

-- SELECT * from dim_store_details

SELECT locality, 
       COUNT(locality) AS total_number_locality
FROM 
    dim_store_details
GROUP BY 
    locality
ORDER BY
    total_number_locality DESC
LIMIT 
    10;

3

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

SELECT 
country_code, 
SUM(staff_numbers)
FROM dim_store_details
GROUP BY country_code
ORDER BY SUM(staff_numbers) DESC

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

WITH DateDifferences AS (
    SELECT 
        EXTRACT(YEAR FROM date_time) AS year,
        date_time,
        LEAD(date_time) OVER (PARTITION BY EXTRACT(YEAR FROM date_time) ORDER BY date_time) AS next_date_time,
        LEAD(date_time) OVER (PARTITION BY EXTRACT(YEAR FROM date_time) ORDER BY date_time) - date_time AS time_diff
    FROM dim_date_times
    JOIN orders_table ON dim_date_times.date_uuid = orders_table.date_uuid
)
SELECT 
    year,
    AVG(time_diff) AS average_time_between_sales
FROM DateDifferences
WHERE next_date_time IS NOT NULL
GROUP BY year
ORDER BY AVG(time_diff) DESC;


