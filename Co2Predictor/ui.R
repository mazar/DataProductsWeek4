library(shiny)

shinyUI(fluidPage(
  
  titlePanel("CO2 Predictor"),
  
  sidebarLayout(
    sidebarPanel(
      p("Instructions: simply select Engine Fuel Type and Engine Capacity to see the Co2 emmissions."),
      uiOutput("choose_fuelType"),
      sliderInput("capacity",
                   "Engine Capacity (cc):",
                   min = 100,
                   max = 7000,
                   value = 2000)
    ),
    
    mainPanel(
      h3(textOutput("co2_value")),
      plotOutput("modelplot")
    )
  )
))
