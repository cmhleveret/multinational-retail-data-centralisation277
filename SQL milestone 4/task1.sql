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

