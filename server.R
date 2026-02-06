#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tidyverse)
library(shinydashboard)

function(input, output, session) {
  
  # Reactive borrower data
  borrower_data <- reactive({
    tibble(
      total_income = as.numeric(input$total_income),
      total_dti = as.numeric(input$total_dti),
      loan_amount = as.numeric(input$loan_amount),
      term36 = ifelse(input$term == 36, 1, 0), #my issue is right here
      term60 = ifelse(input$term == 60, 1, 0),
      credit_history_years = as.numeric(input$credit_history_years),
      delinq_2y = as.numeric(input$delinq_2y),
      months_since_last_delinq = as.numeric(input$months_since_last_delinq),
      months_since_90d_late = as.numeric(input$months_since_90d_late),
      num_historical_failed_to_pay = as.numeric(input$num_historical_failed_to_pay),
      inquiries_last_12m = as.numeric(input$inquiries_last_12m),
      credit_utilization = as.numeric(input$credit_utilization),
      total_credit_lines = as.numeric(input$total_credit_lines),
      open_credit_lines = as.numeric(input$open_credit_lines),
      emp_length = as.numeric(input$emp_length),
      homeownershipOWN = ifelse(input$homeownership == "OWN", 1, 0),
      homeownershipRENT = ifelse(input$homeownership == "RENT", 1, 0),
      application_typejoint = ifelse(input$application_type == "joint", 1, 0)
    )
  })
  
  # PD prediction
  pd_value <- reactive({
    X_new <- model.matrix(
      delete.response(terms(credit_model_lr)),
      borrower_data()
    )
    betas <- coef(credit_model_lr)
    drop1 <- "(Intercept)" %in% names(betas)
    as.numeric(X_new %*% betas)
  })
  
  # Risk band
  risk_band <- reactive({
    case_when(
      pd_value() < 0.05 ~ "Low",
      pd_value() < 0.15 ~ "Medium",
      TRUE ~ "High"
    )
  })
  
  # Decision
  decision <- reactive({
    case_when(
      risk_band() == "Low" ~ "Approve",
      risk_band() == "Medium" ~ "Review",
      TRUE ~ "Decline"
    )
  })
  
  # Top 5 risk drivers
  explain_table <- reactive({
    X_new <- model.matrix(
      delete.response(terms(credit_model_lr)),
      borrower_data()
    )
    betas <- coef(credit_model_lr)
    tibble(
      feature = colnames(X_new),
      contribution = as.numeric(X_new %*% betas)
    ) |>
      filter(feature != "(Intercept)") |>
      arrange(desc(abs(contribution))) |>
      slice_head(n = 5)
  })
  
  # Outputs
  output$pd_box <- renderValueBox({
    valueBox(
      paste0(round(pd_value() * 100, 1), "%"),
      "Predicted Probability of Default",
      color = "blue"
    )
  })
  
  output$risk_box <- renderValueBox({
    valueBox(
      risk_band(), "Risk Band",
      color = ifelse(risk_band() == "Low", "green",
                     ifelse(risk_band() == "Medium", "orange", "red"))
    )
  })
  
  output$decision_box <- renderValueBox({
    valueBox(
      decision(), "Underwriting Decision",
      color = ifelse(decision() == "Approve", "green",
                     ifelse(decision() == "Review", "orange", "red"))
    )
  })
  
  output$explain_table <- renderTable({
    explain_table() |> rename(Term = feature)
  })
  
}
