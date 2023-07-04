library(shiny)
library(RPostgreSQL)
library(highcharter)

# Crear una conexión a la base de datos PostgreSQL
con <- dbConnect(PostgreSQL(), dbname = "prac_diabetes", host = "localhost",
                 port = 5432, user = "postgres", password = "marce")

# Definir la UI
ui <- fluidPage(
  titlePanel("Selección de Schema, Tabla y Variables"),
  sidebarLayout(
    sidebarPanel(
      selectInput("selected_schema", "Seleccionar Schema:", choices = NULL),
      selectInput("selected_table", "Seleccionar Tabla:", choices = NULL),
      selectInput("selected_variable", "Seleccionar Variable:", choices = NULL)
    ),
    mainPanel(
      textOutput("mensaje")
    )
  )
)

# Definir el servidor
server <- function(input, output, session) {
  
  # Obtener la lista de schemas
  schemas <- reactive({
    query <- "SELECT schema_name FROM information_schema.schemata WHERE schema_name NOT LIKE 'pg_%' AND schema_name != 'information_schema'"
    dbGetQuery(con, query)$schema_name
  })
  
  # Actualizar las opciones del selectInput para seleccionar el schema
  observe({
    updateSelectInput(session, "selected_schema", choices = schemas())
  })
  
  # Obtener la lista de tablas para el schema seleccionado
  tables <- reactive({
    selected_schema <- input$selected_schema
    if (!is.null(selected_schema)) {
      query <- paste("SELECT table_name FROM information_schema.tables WHERE table_schema = $1")
      dbGetQuery(con, query, params = list(selected_schema))$table_name
    } else {
      character(0)
    }
  })
  
  # Actualizar las opciones del selectInput para seleccionar la tabla
  observe({
    updateSelectInput(session, "selected_table", choices = tables())
  })
  
  # Obtener la lista de variables para la tabla seleccionada
  variables <- reactive({
    selected_table <- input$selected_table
    if (!is.null(selected_table)) {
      query <- paste("SELECT column_name FROM information_schema.columns WHERE table_name = $1")
      dbGetQuery(con, query, params = list(selected_table))$column_name
    } else {
      character(0)
    }
  })
  
  # Actualizar las opciones del selectInput para seleccionar la variable
  observe({
    updateSelectInput(session, "selected_variable", choices = variables())
  })
  
  # Mostrar el mensaje de selección del schema, la tabla y la variable
  output$mensaje <- renderText({
    selected_schema <- input$selected_schema
    selected_table <- input$selected_table
    selected_variable <- input$selected_variable
    
    if (!is.null(selected_schema) && !is.null(selected_table) && !is.null(selected_variable)) {
      paste("Usted acaba de seleccionar el schema:", selected_schema,
            "la tabla:", selected_table, "y la variable:", selected_variable)
    }
  })
  
  # Cerrar la conexión a la base de datos al detener la aplicación
  onStop(function() {
    dbDisconnect(con)
  })
}

# Ejecutar la aplicación Shiny
shinyApp(ui = ui, server = server)