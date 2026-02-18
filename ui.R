#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
library(shiny)
library(shinydashboard)
library(shinyWidgets)

ui <- dashboardPage(
  dashboardHeader(title = "Credit Risk Assessment"),
  
  # Sidebar
  dashboardSidebar(
    width = 400,
    
    # Row 1: Loan info
    fluidRow(
      column(
        width = 6,
        numericInputIcon(
          inputId = "total_income",
          label = "Total Income",
          value = 60000,
          min = 0,
          step = 1000,
          icon = list(NULL, icon("dollar-sign"))
        ),
        numericInput("total_dti", "Debt-to-Income Ratio (%)", 20),
        numericInputIcon(
          inputId = "loan_amount",
          label = "Loan Amount",
          value = 15000,
          min = 0,
          step = 500,
          icon = list(NULL, icon("dollar-sign"))
        )
      ),
      column(
        width = 6,
        selectInput("term", "Loan Term", choices = levels(credit_model$term)),
        numericInput("credit_history_years", "Credit History (Years)", 10),
        numericInput("delinq_2y", "Delinquencies (2 Years)", 0)
      )
    ),
    
    # Row 2: Past delinquencies
    fluidRow(
      column(
        width = 6,
        numericInput("months_since_last_delinq", "Months Since Last Delinquency", 999),
        numericInput("months_since_90d_late", "Months Since 90+ Day Late", 999),
        numericInput("num_historical_failed_to_pay", "Historical Failures", 0)
      ),
      column(
        width = 6,
        numericInput("inquiries_last_12m", "Credit Inquiries (12M)", 2),
        numericInput("credit_utilization", "Credit Utilization (%)", 30),
        numericInput("total_credit_lines", "Total Credit Lines", 10)
      )
    ),
    
    # Row 3: Credit lines & employment / factors
    fluidRow(
      column(
        width = 6,
        numericInput("open_credit_lines", "Open Credit Lines", 6),
        numericInput("emp_length", "Employment Length (Years)", 5)
      ),
      column(
        width = 6,
        selectInput("homeownership", "Homeownership", choices = levels(credit_model$homeownership)),
        selectInput("application_type", "Application Type", choices = levels(credit_model$application_type))
      )
    )
  ),
  
  # Dashboard body
  dashboardBody(
    fluidRow(
      valueBoxOutput("pd_box"),
      valueBoxOutput("risk_box"),
      valueBoxOutput("decision_box")
    ),
    
    fluidRow(
      box(
        title = "Top Risk Drivers",
        width = 12,
        tableOutput("explain_table"),
        plotOutput("waterfall_plot", height = "400px")  # Waterfall chart
      )
    )
  )
)
