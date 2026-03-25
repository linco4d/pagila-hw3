/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
WITH bacall0 AS (
    SELECT actor_id
    FROM actor
    WHERE first_name = 'RUSSELL'
      AND last_name = 'BACALL'
),
bacall1 AS (
    SELECT DISTINCT fa2.actor_id
    FROM film_actor fa1
    JOIN film_actor fa2
      ON fa1.film_id = fa2.film_id
    WHERE fa1.actor_id IN (SELECT actor_id FROM bacall0)
      AND fa2.actor_id NOT IN (SELECT actor_id FROM bacall0)
),
bacall2 AS (
    SELECT DISTINCT fa2.actor_id
    FROM film_actor fa1
    JOIN film_actor fa2
      ON fa1.film_id = fa2.film_id
    WHERE fa1.actor_id IN (SELECT actor_id FROM bacall1)
)
SELECT DISTINCT
    a.first_name || ' ' || a.last_name AS "Actor Name"
FROM actor a
JOIN bacall2 b2
  ON a.actor_id = b2.actor_id
WHERE a.actor_id NOT IN (SELECT actor_id FROM bacall0)
  AND a.actor_id NOT IN (SELECT actor_id FROM bacall1)
ORDER BY "Actor Name";
