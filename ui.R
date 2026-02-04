#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      selectInput("hist_variable",
                  "Select Variable to Display:",
                  choices = c(
                    "Current",
                    "Fully Paid",
                    "In Grace Period",
                    "Late (31-120 days)",
                    "Charged Off",
                    "Late (16-30 days)" 
                  )),
      selectInput("loan_status",
                  "Select a status",
                  choices = c("All",
                              credit |>
                                distinct(loan_status) |>
                                pull() |>
                                sort()
                  )
                  
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      fluidRow(
        plotOutput("boxplot")
      ),
      fluidRow(
        verbatimTextOutput("linearregression")
      ),
      fluidRow(
        column(
          width = 8,
          plotOutput("distPlot")
        ),
        column(
          width = 4,
          plotOutput("barPlot")
        )
      ),
      fluidRow(
        dataTableOutput("selectedTable")
      )
    )
  )
)