library(shiny)

# Define UI for application that draws scatter plot with regression line
shinyUI(fluidPage(

    # Application title
    titlePanel("Flight Arrival Delay Predictor"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("DepartureDelay",
                        "Delay(Minutes):",
                        min = 1,
                        max = 2500,
                        value = 1),
    # Numeric Input for distance of flight
            numericInput('Distance', 'Flight Distance(Miles)', min = 10, 
                         max = 5000, step = 20, value = 1000),
    # Numeric Input for time of flight
            numericInput('AirTime', 'Projected Flight Time(Minutes)', value = 60,
                         min = 10, max = 1100, step = 10),
    # Output arrival delay
            h4('Expected Arrival Delay(Minutes)'),
            verbatimTextOutput('prediction')
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("sPlot")
        )
    )
))
