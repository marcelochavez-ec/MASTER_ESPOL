library(shiny)
library(shinythemes)

# Definir UI
ui <- fluidPage(
  theme = shinytheme("cosmo"),
  tags$head(
    tags$style(
      HTML(
        "
        .banner {
          width: 100%;
          text-align: center;
        }
        
        .banner img {
          width: 100%;
          height: 1%;
          max-width: 100%;
        }
        "
      )
    )
  ),
  div(
    class = "banner",
    img(src = "banner.png")
  ),
  navbarPage(
    "Software Exploratorio de Datos",
    tabPanel("Inicio", h2("Página de Inicio")),
    tabPanel("Exploratorio", h2("Página Exploratorio")),
    tabPanel("Reportes",
             sidebarLayout(
               sidebarPanel(
                 h3("Selecciona un reporte"),
                 selectInput("reporte", "Reportes disponibles",
                             choices = c("Reporte 1", "Reporte 2", "Reporte 3"),
                             selected = "Reporte 1")
               ),
               mainPanel(
                 h3("Vista previa del reporte"),
                 uiOutput("output_reporte")
               )
             )
    ),
    tabPanel("Geovisor", h2("Página Geovisor"))
  )
)

# Definir server
server <- function(input, output) {
  output$output_reporte <- renderUI({
    # Aquí puedes agregar el código para mostrar el reporte seleccionado
    # usando la función renderUI y el archivo R Markdown correspondiente.
    # Por ejemplo:
    if (input$reporte == "Reporte 1") {
      includeMarkdown("reporte1.Rmd")
    } else if (input$reporte == "Reporte 2") {
      includeMarkdown("reporte2.Rmd")
    } else if (input$reporte == "Reporte 3") {
      includeMarkdown("reporte3.Rmd")
    }
  })
}

# Ejecutar la aplicación
shinyApp(ui, server)
