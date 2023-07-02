library(RODBC)
library(sqldf)

# Establecer la conexión
con <- odbcConnect(dsn = "MySQLConexion_sakila", uid = "root", pwd = "marce")

#*****************
# Actividad Nro. 1
#*****************

# Carga de tablas
customer <- sqlQuery(con, "select * from customer")
rental <- sqlQuery(con, "select * from rental")
payment <- sqlQuery(con, "select * from payment")
inventory <- sqlQuery(con, "select * from inventory")
film <- sqlQuery(con, "select * from film")

#*****************
# Actividad Nro. 2
#*****************
str(customer)
glimpse(customer)

#*****************
# Actividad Nro. 3
#*****************

# Determine el listado de clientes con estado inactivo (igual a cero) 
# que están vinculados al local 2 (store_id). Muestre las primeras 10 filas.

acti_3 <- sqldf("select * from customer where active = 0 and store_id = 2")

#*****************
# Actividad Nro. 4
#*****************

acti_4 <- sqldf("select title, description
                from film
                where title like 'A%' 
                and description like '%drama%'")


#*****************
# Actividad Nro. 5
#*****************

# payment: payment_id, customer_id, rental_id, payment_date
# customer: customer_id, first_name, last_name

acti_5 <- sqldf("
select c.customer_id, 
first_name,
last_name,
r.rental_id,
payment_id,
payment_date,
amount
from customer c
inner join payment p on c.customer_id = p.customer_id
inner join rental r on r.customer_id = c.customer_id
where first_name = 'NATALIE' and last_name = 'MEYER'")

# film
# inventory
# 

acti_6 <- sqldf("
SELECT r.rental_id, f.title, f.description, f.release_year
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
WHERE f.title IN ('TRADING PINOCCHIO', 'VANILLA DAY', 'WORKER TARZAN', 'ACADEMY DINOSAUR')
ORDER BY f.title")
acti_6 <- head(acti_6, 7)

acti_7 <- sqldf("SELECT  first_name
                ,last_name
                ,title
                ,amount
                ,year(rental_date) as AÑO
                ,month(rental_date) as MES
                FROM rental r 
                INNER JOIN customer c on c.customer_id =r.customer_id 
                INNER JOIN payment p ON p.rental_id = r.rental_id
                INNER JOIN inventory i ON i.inventory_id = r.inventory_id
                INNER JOIN film f on f.film_id = i.film_id
                WHERE YEAR(rental_date) = 2005 AND MONTH(rental_date) = 6 AND amount >5")



acti_3=sqldf("select Language,count(*) from countrylanguage group by language having count(*) > 10")
act_3


customer <- sqlQuery(con, "select * from customer")
rental <- sqlQuery(con, "select * from rental")
payment <- sqlQuery(con, "select * from payment")

consulta_3 <- sqldf("SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(r.rental_id) AS rental_count,
    SUM(p.amount) AS total_amount
FROM
    customer AS c
    INNER JOIN rental AS r ON c.customer_id = r.customer_id
    INNER JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY
    c.customer_id
ORDER BY
    total_amount DESC")

query_3 <- sqldf("SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS rental_count,
    SUM(p.amount) AS total_amount
FROM
    customer AS c
    INNER JOIN rental AS r ON c.customer_id = r.customer_id
    INNER JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY
    c.customer_id
ORDER BY
    total_amount DESC")

head(query_3, 10)






