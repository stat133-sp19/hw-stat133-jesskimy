#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(reshape)
library(ggplot2)


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Investing and Savings Modalities"),
   
   # Sidebar with a slider input for number of bins 
   fluidRow(
     column(4,
         sliderInput("initial",
                     "Initial Amount:",
                     min = 0,
                     max = 100000,
                     value = 1000,
                     step = 500),
         sliderInput("contrib",
                     "Annual Contribution:",
                     min = 0,
                     max = 50000,
                     value = 2000,
                     step = 500)
     ),
         column(4,
                sliderInput("rr",
                            "Return Rate (in %):",
                            min = 0,
                            max = 20,
                            value = 5,
                            step = 0.1),
                sliderInput("gr",
                            "Growth Rate:",
                            min = 0,
                            max = 20,
                            value = 2,
                            step = 0.1)
         ),
          column(4,
                 sliderInput("years",
                             "Years:",
                             min = 0,
                             max = 50,
                             value = 20,
                             step = 1),
                  selectInput("facet",
                              "Facet?",
                              choices = c("No", "Yes"))
          ),
          mainPanel(
            h3("Timelines"),
            plotOutput("plot"),
            h3("Balances"),
            verbatimTextOutput("tbl")
          )
))

# Define server logic required to draw a histogram

server <- function(input, output) {
  #functions
  future_value <- function(amount = 100, rate = 0.05, years = 1) {
    fv <- amount*((1+rate)^years)
    return(fv)
  }
  annuity <- function(contrib = 200, rate = 0.05, years = 1) {
    fva <- contrib*((((1+rate)^years)-1)/rate)
    return(fva)
  }
  growing_annuity <- function(contrib = 200, rate = 0.05, growth = 0.03, years = 1) {
    fvga <- contrib * (((1+rate)^years - (1+growth)^years)/(rate - growth))
    return(fvga)
  }
  
output$tbl <- renderPrint({
  amount <- input$initial
  contrib <- input$contrib
  rate <- input$rr/100
  growth <- input$gr/100
  year <- c()
  years <- input$years
  no_contrib <- c()
  fixed_contrib <- c()
  growing_contrib <- c()
  for(i in 0:years) {
    year[i + 1] <- i
    no_contrib[i+1] <- future_value(amount, rate, i)
    fixed_contrib[i+1] <- no_contrib[i+1] + annuity(contrib, rate, i)
    growing_contrib[i+1] <- no_contrib[i+1] + growing_annuity(contrib, rate, growth, i)
  }
  modalities <- data.frame(year, no_contrib, fixed_contrib, growing_contrib)
  print(modalities)
})

output$plot <- renderPlot({
  amount <- input$initial
  contrib <- input$contrib
  rate <- input$rr/100
  growth <- input$gr/100
  year <- c()
  years <- input$years
  no_contrib <- c()
  fixed_contrib <- c()
  growing_contrib <- c()
  for(i in 0:years) {
    year[i + 1] <- i
    no_contrib[i+1] <- future_value(amount, rate, i)
    fixed_contrib[i+1] <- no_contrib[i+1] + annuity(contrib, rate, i)
    growing_contrib[i+1] <- no_contrib[i+1] + growing_annuity(contrib, rate, growth, i)
  }
  modalities <- data.frame(year, no_contrib, fixed_contrib, growing_contrib)
  nonfacet <- ggplot(data = modalities) +
    geom_line((aes(x = year, y = no_contrib, color = "no_contrib"))) +
    geom_line((aes(x = year, y = fixed_contrib, color = "fixed_contrib"))) +
    geom_line((aes(x = year, y = growing_contrib, color = "growing_contrib"))) +
    xlab("Year") + ylab("Future Value ($)") + ggtitle("Future Value of Different Investment Modes")
  
  faceted <- melt(modalities, id=c("year"))
  facet <- ggplot(data = faceted, aes(x = year, y = value, color = variable,fill = variable,group=variable) ) +
    geom_area(alpha = 0.5) +
    facet_wrap(~ variable) + xlab("year") + ylab("balance") + ggtitle("Future Value of Different Investment Modes (Separated)")
  
  if (input$facet=="No") {
    nonfacet
  } else {
    facet
  }
})
}

# Run the application 
shinyApp(ui = ui, server = server)