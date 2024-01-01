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