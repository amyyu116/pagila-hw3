/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */
SELECT titles.title
FROM (
SELECT f2.title, fa1.actor_id, fa2.actor_id
FROM film f1
JOIN film_actor fa1 ON (f1.film_id=fa1.film_id)
JOIN film_actor fa2 ON (fa2.actor_id = fa1.actor_id)
JOIN film f2 ON (f2.film_id = fa2.film_id)
WHERE f1.title = 'AMERICAN CIRCUS' 
ORDER BY f2.title) AS titles
GROUP BY titles.title
HAVING count(*) > 1;
