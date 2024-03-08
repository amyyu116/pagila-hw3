/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */

SELECT DISTINCT a.actor_id, a.first_name, a.last_name, 
	ranked_films.film_id, ranked_films.title, 
	ranked_films.rank, ranked_films.revenue 
FROM actor a
LEFT JOIN LATERAL (
	SELECT f.film_id, f.title,
       		RANK () OVER (ORDER BY SUM(payment.amount) DESC, f.title) "rank", SUM(payment.amount) AS revenue
	FROM film f
	JOIN film_actor fa using (film_id)
	JOIN inventory USING (film_id)
	JOIN rental USING (inventory_id)
	JOIN payment USING (rental_id)
	WHERE fa.actor_id = a.actor_id
	GROUP BY f.film_id
	ORDER BY "rank" ASC
	LIMIT 3
) 
AS ranked_films ON TRUE
ORDER BY a.actor_id, ranked_films.rank;

