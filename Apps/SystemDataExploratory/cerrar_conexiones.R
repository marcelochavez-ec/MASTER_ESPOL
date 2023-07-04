library(shiny)
library(RPostgreSQL)

# Crear una conexión a la base de datos PostgreSQL
con <- dbConnect(PostgreSQL(), dbname = "prac_diabetes", host = "localhost",
                 port = 5432, user = "postgres", password = "marce")

# Función para cerrar todas las conexiones a la base de datos PostgreSQL
killDbConnections <- function() {
  all_cons <- dbListConnections(con)
  for (conn in all_cons) {
    dbDisconnect(conn)
  }
  print(paste(length(all_cons), " connections killed."))
}

# Definir la UI
ui <- fluidPage(
  titlePanel("Consultas a una BDD en PostgreSQL"),
  # Resto de tu interfaz de usuario
)

# Definir el servidor
server <- function(input, output, session) {
  # Resto de tu lógica de servidor
  
  # Cerrar todas las conexiones al detener la aplicación
  onStop(function() {
    killDbConnections()
  })
}

# Ejecutar la aplicación Shiny
shinyApp(ui = ui, server = server)