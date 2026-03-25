/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */
SELECT
    a.first_name,
    a.last_name
FROM actor a
WHERE EXISTS (
    SELECT 1
    FROM film_actor fa
    JOIN film_category fc
      ON fa.film_id = fc.film_id
    JOIN category c
      ON fc.category_id = c.category_id
    WHERE fa.actor_id = a.actor_id
      AND c.name = 'Children'
)
AND NOT EXISTS (
    SELECT 1
    FROM film_actor fa
    JOIN film_category fc
      ON fa.film_id = fc.film_id
    JOIN category c
      ON fc.category_id = c.category_id
    WHERE fa.actor_id = a.actor_id
      AND c.name = 'Horror'
)
ORDER BY a.last_name, a.first_name;
