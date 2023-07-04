library(RPostgreSQL)
library(highcharter)

# Crear una conexión a la base de datos PostgreSQL
con <- dbConnect(PostgreSQL(), 
                 dbname = "prac_diabetes", 
                 host = "localhost",
                 port = 5432, 
                 user = "postgres", 
                 password = "marce")

schemas <- dbGetQuery(con, "SELECT schema_name FROM information_schema.schemata WHERE schema_name NOT LIKE 'pg_%' AND schema_name != 'information_schema'")
print(schemas)

# Cerrar la conexión
dbDisconnect(con)


library(RPostgreSQL)

# Crear una lista para almacenar las conexiones
conexiones <- list()

# Abrir múltiples conexiones a la base de datos PostgreSQL
con1 <- dbConnect(PostgreSQL(), dbname = "prac_diabetes", host = "localhost",
                  port = 5432, user = "postgres", password = "marce")
conexiones[[1]] <- con1

con2 <- dbConnect(PostgreSQL(), dbname = "otra_base", host = "localhost",
                  port = 5432, user = "postgres", password = "marce")
conexiones[[2]] <- con2

# Realizar operaciones en las bases de datos...

# Cerrar todas las conexiones
for (con in conexiones) {
  dbDisconnect(con)
}
