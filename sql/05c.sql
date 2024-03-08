/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMP,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */

SELECT film.title
FROM film
JOIN film_actor USING (film_id)
JOIN actor USING (actor_id)
LEFT JOIN 
(SELECT actor.actor_id, film.title 
FROM actor
JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
WHERE 
	film.title = 'ACADEMY DINOSAUR' OR
	film.title = 'AGENT TRUMAN' OR
	film.title = 'AMERICAN CIRCUS'
ORDER BY actor.actor_id) as id_list on id_list.actor_id = actor.actor_id
WHERE id_list is NOT NULL
GROUP BY film.title
HAVING count(*) >= 3
ORDER BY film.title;
