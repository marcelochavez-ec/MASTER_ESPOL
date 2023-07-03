library(RODBC)

con <- odbcConnect("sakila", uid="root", pwd="marce")

# Conexión a las tablas de datos:

df_country <- sqlQuery(con, "select * from country")
customer<-sqlQuery(con,"Select * from customer")
store<-sqlQuery(con,"Select * from store")
rental<-sqlQuery(con,"Select * from rental")
payment<-sqlQuery(con,"Select * from payment")
inventory<-sqlQuery(con,"Select * from inventory")
film<-sqlQuery(con,"Select * from film")
category <- sqlQuery(con, "select * category")

# Query 1

query_1 <- sqlQuery(con, "select * from customer where active=0 limit 10")


# Query 2

query_2 <- sqlQuery(con, "select * from film where title like 'A%' and description LIKE '%DRAMA%'")

# Query 3

query_3 <- sqlQuery(con, "select 
                    c.customer_id,
                    c.first_name,
                    c.last_name,
                    r.rental_id,
                    r.rental_date,
                    p.payment_id,
                    p.payment_date,
                    p.amount
                    from customer c
                    inner join payment p on c.customer_id = p.customer_id
                    inner join rental r on r.rental_id = p.rental_id
                    where first_name = 'NATALIE' and last_name = 'MEYER'")
 
 