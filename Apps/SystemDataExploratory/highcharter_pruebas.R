library(highcharter)
library(openxlsx)
library(tidyverse)

setwd("D:/MASTER_ESPOL/Apps/SystemDataExploratory")

db_diabetes <- read.csv("db/diabetes_prediction_dataset.csv", sep = ",")

db_diabetes_box <- db_diabetes %>% 
  select(gender,bmi,HbA1c_level,blood_glucose_level) %>% 
  pivot_longer(cols = -gender, names_to = "Variables", values_to = "Valor") %>% 
  rename("Género"="gender")

hcboxplot(x = db_diabetes$age,
          name = "Length", 
          color = "#2980b9")

hcboxplot(x = db_diabetes_box$Valor, var = db_diabetes_box$Variables,
          name = "Length", color = "#2980b9") %>% 
  # hc_add_theme(hc_theme_null()) %>%
  hc_yAxis(range = c(min(db_diabetes_box$Valor), max(db_diabetes_box$Valor)), labels = list(format = "{value}k"), title = list(text = "Totales")) %>%
  hc_xAxis(range = c(min(db_diabetes_box$Valor), max(db_diabetes_box$Valor)), categories = db_diabetes_box$Variables, title = list(text = "Variables")) %>%
  hc_chart(marginRight = 100)  # Ajustar el margen derecho para mostrar completamente las etiquetas

# Establecer el rango del eje X
hc$xAxis[["categories"]] <- seq(min_value, max_value, length.out = 5) 