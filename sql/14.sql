/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */
/*
SELECT category.name, ranked_films.title, ranked_films.film_id, ranked_films."total rentals"
FROM category
LEFT JOIN LATERAL (
	SELECT f.film_id, f.title,
                RANK () OVER (
			PARTITION BY film_category.category_id
			ORDER BY COUNT(rental.rental_id) DESC) "rank",
		COUNT(rental.rental_id) AS "total rentals"
        FROM film f
	JOIN film_category USING (film_id)
        JOIN inventory USING (film_id)
        JOIN rental USING (inventory_id)
        WHERE film_category.category_id = category.category_id
        GROUP BY f.film_id, f.title, film_category.category_id
        ORDER BY "rank" ASC
        LIMIT 5
) AS ranked_films ON TRUE
ORDER BY category.name, ranked_films."total rentals" DESC, ranked_films.title;
*/

SELECT category.name, ranked_films.title, ranked_films."total rentals"
FROM category
LEFT JOIN LATERAL (
    SELECT top_films.title, top_films.film_id, top_films.count as "total rentals"
    FROM (
        SELECT f.title, f.film_id, COUNT(r.rental_id)
        FROM film f
        LEFT JOIN inventory i USING (film_id)
        LEFT JOIN rental r USING (inventory_id)
        GROUP BY f.title, f.film_id
        ) as top_films
    JOIN film_category fc USING (film_id)
    WHERE fc.category_id = category.category_id
    ORDER BY "total rentals" DESC, title desc
    LIMIT 5
) AS ranked_films ON true
ORDER BY category.name, ranked_films."total rentals" DESC, ranked_films.title;
