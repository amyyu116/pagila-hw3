/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
SELECT DISTINCT  a1.first_name || ' ' || a1.last_name AS "Actor Name"
FROM actor a1
JOIN film_actor fa1 ON fa1.actor_id = a1.actor_id
JOIN film f ON f.film_id = fa1.film_id
JOIN film_actor fa2 ON fa2.film_id = f.film_id
JOIN actor a2 ON a2.actor_id = fa2.actor_id
WHERE a1.actor_id NOT IN (
SELECT DISTINCT a2.actor_id
FROM actor a1
JOIN film_actor fa1 ON (a1.actor_id = fa1.actor_id)
JOIN film f1 ON (fa1.film_id = f1.film_id)
JOIN film_actor fa2 ON (f1.film_id = fa2.film_id)
JOIN actor a2 ON (fa2.actor_id = a2.actor_id)
WHERE a1.first_name || ' ' || a1.last_name = 'RUSSELL BACALL'
)
ORDER BY "Actor Name";
