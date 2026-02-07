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
library(tidyverse)

ui <- dashboardPage(
  dashboardHeader(title = "Credit Risk Assessment"),
  
  # 2-column sidebar
  dashboardSidebar(
    width = 400,
    
    # Row 1: Loan info
    fluidRow(
      column(
        width = 6,
        numericInput("total_income", "Total Income", 60000),
        numericInput("total_dti", "Debt-to-Income (%)", 20),
        numericInput("loan_amount", "Loan Amount", 15000)
      ),
      column(
        width = 6,
        selectInput("term", "Loan Term", choices = levels(credit_model$term)),
        numericInput("credit_history_years", "Credit History (Years)", 10),
        numericInput("delinq_2y", "Delinquencies (2Y)", 0)
      )
    ),
    
    # Row 2: Past delinquencies
    fluidRow(
      column(
        width = 6,
        numericInput("months_since_last_delinq", "Months Since Last Delinq", 999),
        numericInput("months_since_90d_late", "Months Since 90D Late", 999),
        numericInput("num_historical_failed_to_pay", "Historical Failures", 0)
      ),
      column(
        width = 6,
        numericInput("inquiries_last_12m", "Inquiries (12M)", 2),
        numericInput("credit_utilization", "Credit Utilization", 0.3),
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
        tableOutput("explain_table")
      )
    )
  )
)
