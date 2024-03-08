/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */

SELECT country.country, SUM(payment.amount) AS total_payments 
FROM customer
JOIN payment USING (customer_id)
JOIN address USING (address_id)
JOIN city USING (city_id)
LEFT JOIN country ON country.country_id = city.country_id
GROUP BY country
ORDER BY total_payments DESC, country.country;
