library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  
  data <- read.csv("data.csv")
  mod <- lm(Co2 ~ Engine.Capacity + Fuel.Type, data = data)
  fuelTypes <- unique(data$Fuel.Type)
  
  output$choose_fuelType <- renderUI({
    selectInput("fueltype", "Fuel Type", as.list(fuelTypes))
  })
  
  output$modelplot <- renderPlot({
    if(is.null(input$fueltype))
      return()
    qplot(Engine.Capacity, Co2, data = data, color = Fuel.Type) + 
      geom_smooth(method = "lm") +
      geom_hline(yintercept = prediction()) +
      geom_vline(xintercept = input$capacity)
  })
  
  prediction <- reactive({
    if(is.null(input$fueltype))
      return()
    fuel <- input$fueltype
    capacity <- input$capacity
    pred <- predict(mod, newdata = data.frame(Engine.Capacity = capacity, Fuel.Type = fuel))
    round(pred, 4)
  })
  
  output$co2_value <- renderText({
    paste("Predicted Co2 g/km:", prediction(), sep = " ")
  })
  
})
