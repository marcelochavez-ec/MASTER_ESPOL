library(shiny)
library(RPostgreSQL)

library(base)

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
  sidebarLayout(
    sidebarPanel(
      selectInput("esquema", "Seleccionar esquema:", choices = NULL),
      selectInput("tabla", "Seleccionar tabla:", choices = NULL),
      selectInput("variable", "Seleccionar variable:", choices = NULL, multiple = TRUE)
    ),
    mainPanel(
      # Agrega aquí la salida o gráfico que desees mostrar
    )
  )
)

# Definir el servidor
server <- function(input, output, session) {
  
  # Cargar la lista de esquemas
  esquemas <- reactive({
    esquemas <- dbGetQuery(con, "SELECT schema_name 
                                 FROM information_schema.schemata
                                 WHERE schema_name NOT LIKE 'pg_%' AND schema_name != 'information_schema'")
    esquemas$schema_name
  })
  
  # Actualizar las opciones del primer filtro
  observe({
    updateSelectInput(session, "esquema", choices = esquemas())
  })
  
  # Actualizar las opciones del segundo filtro
  observeEvent(input$esquema, {
    tablas <- dbGetQuery(con, paste("SELECT table_name 
                                    FROM information_schema.tables
                                    WHERE table_schema = '", input$esquema, "'"))
    if (nrow(tablas) == 0) {
      tablas <- data.frame(table_name = "No se encontraron tablas en el esquema seleccionado")
    }
    updateSelectInput(session, "tabla", choices = tablas$table_name)
  })
  
  # Actualizar las opciones del tercer filtro
  observeEvent(input$tabla, {
    variables <- dbGetQuery(con, paste("SELECT column_name 
                                       FROM information_schema.columns 
                                       WHERE table_schema = '", input$esquema, "' 
                                       AND table_name = '", input$tabla, "'"))
    updateSelectInput(session, "variable", choices = variables$column_name)
  })
  
  # Agrega aquí la lógica para generar el gráfico o realizar las consultas
  
  # Cerrar todas las conexiones al detener la aplicación
  onStop(function() {
    dbDisconnect(con)
  })
}

# Ejecutar la aplicación Shiny
shinyApp(ui = ui, server = server)
