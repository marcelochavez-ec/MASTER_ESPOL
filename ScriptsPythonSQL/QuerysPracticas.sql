-- ALTER TABLE

alter table actor 
add date_birthday date;

UPDATE actor
SET date_birthday = DATE_ADD('1980-01-01', INTERVAL FLOOR(RAND() * 11323) DAY);

SELECT first_name, last_name, email
FROM staff
WHERE address_id IS NOT NULL
UNION
SELECT address, district, postal_code
FROM address
WHERE address_id IS NOT NULL;

SELECT first_name, last_name, email
FROM staff
WHERE address_id
UNION
SELECT address, district, postal_code
FROM address
WHERE address_id;

DELETE FROM actor 
WHERE actor_id > 200;





