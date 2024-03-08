/*
 * Compute the country with the most customers in it. 
 */

SELECT country.country
FROM customer
JOIN address USING (address_id)
JOIN city USING (city_id)
LEFT JOIN country ON country.country_id = city.country_id
GROUP BY country
ORDER BY COUNT(customer) DESC
LIMIT 1;
