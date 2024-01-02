SELECT 
country_code, 
SUM(staff_numbers)
FROM dim_store_details
GROUP BY country_code
ORDER BY SUM(staff_numbers) DESC