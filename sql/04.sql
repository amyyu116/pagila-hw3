/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */

SELECT DISTINCT actor.first_name, actor.last_name
FROM actor
JOIN film_actor USING (actor_id)
LEFT JOIN (
	SELECT film_id
	FROM film	
	JOIN film_category USING (film_id)
	JOIN category USING (category_id)
	WHERE category.name = 'Children'
) AS children_films ON film_actor.film_id = children_films.film_id
WHERE actor.actor_id NOT IN (
        SELECT actor.actor_id
        FROM film
        JOIN film_category USING (film_id)
	JOIN film_actor USING (film_id)
	JOIN actor USING (actor_id)
        JOIN category USING (category_id)
        WHERE category.name = 'Horror'
)  
ORDER BY actor.last_name, actor.first_name;
