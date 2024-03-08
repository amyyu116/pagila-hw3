/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customer c
LEFT JOIN LATERAL (
        SELECT film.film_id, rental.rental_date, rental.customer_id
        FROM film
        JOIN inventory USING (film_id)
        JOIN rental USING (inventory_id)
	JOIN film_category USING (film_id)
	JOIN category USING (category_id)
        WHERE rental.customer_id = c.customer_id AND category.name = 'Action'
        ORDER BY rental.rental_date DESC
        LIMIT 5
) AS recent_films ON TRUE
GROUP BY c.customer_id
HAVING COUNT(*) >= 4
ORDER BY c.customer_id;
