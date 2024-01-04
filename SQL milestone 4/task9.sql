


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


