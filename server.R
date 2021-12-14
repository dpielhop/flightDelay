library(tidyr)
library(dplyr)
library(ggplot2)
library(shiny)

# Read in data
df <- read.csv('~/OneDrive/Desktop/Datasets/DelayedFlights.csv') %>%
  select(ArrDelay, DepDelay, Distance, AirTime) %>%
  drop_na()

# Create multiple linear regression model
mdl <- lm(ArrDelay~DepDelay+Distance+AirTime, data = df)

# Define server logic required to draw a scatter plot with regression line
shinyServer(function(input, output) {

    output$sPlot <- renderPlot({

        # generate fitted value based on inputs from ui.R
        y <- mdl$coefficients[1] + mdl$coefficients[2]*input$DepartureDelay +
          mdl$coefficients[3]*input$Distance + mdl$coefficients[3]*input$AirTime
        
        # data frame for creating line
        fit_mdl <- data.frame(delay_fit = fitted(mdl), dd = df$DepDelay)
        
        # point to hightlight from inputs
        highlight <- data.frame(DepDelay = input$DepartureDelay, ArrDelay = y)

        # draw the regression line
        ggplot(data = df, mapping = aes(x=DepDelay, y=ArrDelay)) +
          geom_line(data = fit_mdl, aes(dd, delay_fit)) +
          geom_point(data = highlight, color = 'red', size = 8) +
          labs(x = 'Departure Delay', y = 'Arrival Delay') +
          theme_minimal()

    })
    
    output$prediction <- renderPrint({mdl$coefficients[1] + mdl$coefficients[2]*input$DepartureDelay +
        mdl$coefficients[3]*input$Distance + mdl$coefficients[3]*input$AirTime})

})
