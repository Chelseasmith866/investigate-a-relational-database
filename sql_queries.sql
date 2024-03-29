QUESTION 1:

SELECT category.name category, film.title, COUNT(inventory.inventory_id) total_rentals
FROM inventory
JOIN rental
ON rental.inventory_id = inventory.inventory_id
JOIN film
ON inventory.film_id = film.film_id
JOIN film_category
ON film.film_id = film_category.film_id
JOIN category
ON film_category.category_id = category.category_id
WHERE name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 10;


QUESTION 2:

SELECT  name, title, rental_duration,
NTILE(4) OVER (PARTITION BY rental_duration) AS standard_quartile
FROM
(SELECT name, title, rental_duration
FROM category
JOIN film_category
ON category.category_id = film_category.category_id
JOIN film
ON film_category.film_id = film.film_id
WHERE name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')) T1
ORDER BY title
LIMIT 10;


QUESTION 3:

SELECT name,
NTILE(4) OVER (PARTITION BY rental_duration) AS standard_quartile, COUNT(title)
FROM
(SELECT name, title, rental_duration
FROM category
JOIN film_category
ON category.category_id = film_category.category_id
JOIN film
ON film_category.film_id = film.film_id
WHERE name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')) T1
GROUP BY name, t1.rental_duration
ORDER BY name;


QUESTION 4:

SELECT store_id, rental_month, rental_year, COUNT(rental_id)
FROM
(SELECT store_id, rental_id,
DATE_PART('year', rental_date) rental_year,
DATE_PART('month', rental_date) rental_month
FROM inventory
JOIN rental
ON inventory.inventory_id = rental.inventory_id)sub
GROUP BY sub.store_id, sub.rental_month, sub.rental_year
ORDER BY count DESC;
