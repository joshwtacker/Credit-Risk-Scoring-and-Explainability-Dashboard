#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tidyverse)

library(shiny)

ui <- fluidPage(
  titlePanel("Credit Risk Assessment"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("total_income", "Total Income", value = 75000, min = 0),
      numericInput("total_dti", "Total DTI (%)", value = 15, min = 0),
      numericInput("loan_amount", "Loan Amount", value = 15000, min = 0),
      numericInput("credit_history_years", "Credit History (years)", value = 10, min = 0),
      numericInput("delinq_2y", "Delinquencies in Last 2 Years", value = 0, min = 0),
      numericInput("months_since_last_delinq", "Months Since Last Delinquency", value = 999, min = 0),
      numericInput("months_since_90d_late", "Months Since 90-day Late", value = 999, min = 0),
      numericInput("num_historical_failed_to_pay", "Historical Failed Payments", value = 0, min = 0),
      numericInput("inquiries_last_12m", "Credit Inquiries Last 12 Months", value = 1, min = 0),
      numericInput("credit_utilization", "Credit Utilization (%)", value = 30, min = 0, max = 100),
      numericInput("total_credit_lines", "Total Credit Lines", value = 15, min = 0),
      numericInput("open_credit_lines", "Open Credit Lines", value = 10, min = 0),
      numericInput("emp_length", "Employment Length (years)", value = 5, min = 0),
      selectInput("term", "Loan Term", choices = c(36, 60)),
      selectInput("homeownership", "Homeownership", choices = c("MORTGAGE", "OWN", "RENT")),
      selectInput("application_type", "Application Type", choices = c("individual", "joint"))
    ),
    
    mainPanel(
      h3("Predicted Probability of Default"),
      textOutput("pd_box"),
      h3("Risk Band"),
      textOutput("risk_box"),
      h3("Underwriting Decision"),
      textOutput("decision_box"),
      h3("Top 5 Risk Drivers"),
      tableOutput("explain_table")
    )
  )
)
