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
library(ggplot2)

function(input, output, session) {
  
  # Pretty names for readability
  pretty_names <- c(
    total_income = "Total Income",
    total_dti = "Debt-to-Income Ratio",
    loan_amount = "Loan Amount",
    term36 = "36 Month Term",
    term60 = "60 Month Term",
    credit_history_years = "Credit History (Years)",
    delinq_2y = "Delinquencies (2 Years)",
    months_since_last_delinq = "Months Since Last Delinquency",
    months_since_90d_late = "Months Since 90+ Day Late",
    num_historical_failed_to_pay = "Historical Failures",
    inquiries_last_12m = "Credit Inquiries (12M)",
    credit_utilization = "Credit Utilization",
    total_credit_lines = "Total Credit Lines",
    open_credit_lines = "Open Credit Lines",
    emp_length = "Employment Length",
    homeownershipRENT = "Homeownership: Rent",
    homeownershipOWN = "Homeownership: Own",
    application_typejoint = "Joint Application"
  )
  
  # Reactive borrower data
  borrower_data <- reactive({
    tibble(
      total_income = as.numeric(input$total_income),
      total_dti = as.numeric(input$total_dti),
      loan_amount = as.numeric(input$loan_amount),
      term = factor(as.numeric(input$term), levels = levels(credit_model$term)),
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
      homeownership = factor(input$homeownership, levels = levels(credit_model$homeownership)),
      application_type = factor(input$application_type, levels = levels(credit_model$application_type))
    )
  })
  
  # PD prediction
  pd_value <- reactive({
    req(borrower_data())
    as.numeric(predict(credit_model_lr, newdata = borrower_data(), type = "response"))
  })
  
  output$pd_box <- renderValueBox({
    valueBox(
      paste0(round(pd_value() * 100, 1), "%"),
      "Predicted Probability of Default",
      color = "blue"
    )
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
  
  # Top 5 Risk Drivers
  explain_table <- reactive({
    X_new <- model.matrix(delete.response(terms(credit_model_lr)), borrower_data())
    betas <- coef(credit_model_lr)
    contrib <- X_new[1, ] * betas
    
    tibble(
      feature = names(contrib),
      contribution = as.numeric(contrib)
    ) |>
      filter(feature != "(Intercept)") |>
      mutate(
        Risk_Factor = pretty_names[feature],
        Risk_Factor = ifelse(is.na(Risk_Factor), feature, Risk_Factor),
        Direction = ifelse(contribution > 0, "↑ Increases Risk", "↓ Decreases Risk"),
        Impact_Strength = case_when(
          abs(contribution) > 1 ~ "Very Strong",
          abs(contribution) > 0.5 ~ "Strong",
          abs(contribution) > 0.2 ~ "Moderate",
          TRUE ~ "Mild"
        )
      ) |>
      arrange(desc(abs(contribution))) |>
      slice_head(n = 5) |>
      select(Risk_Factor, contribution, Direction, Impact_Strength)
  })
  
  output$explain_table <- renderTable({
    explain_table() |>
      rename(
        "Risk Factor" = Risk_Factor,
        "Log-Odds Impact" = contribution,
        "Effect Direction" = Direction,
        "Impact Strength" = Impact_Strength
      )
  })
  
  # Waterfall chart for top 5 contributors
  output$waterfall_plot <- renderPlot({
    df <- explain_table() %>%
      mutate(
        feature = factor(Risk_Factor, levels = Risk_Factor),
        end = cumsum(contribution),
        start = lag(end, default = 0),
        direction = ifelse(contribution > 0, "Increase", "Decrease")
      )
    
    ggplot(df, aes(x = feature, ymin = start, ymax = end, fill = direction)) +
      geom_rect(aes(xmin = as.numeric(feature) - 0.4,
                    xmax = as.numeric(feature) + 0.4,
                    ymin = start,
                    ymax = end)) +
      geom_hline(yintercept = 0, linetype = "dashed") +
      scale_fill_manual(values = c("Increase" = "red", "Decrease" = "green")) +
      labs(
        x = "Risk Factor",
        y = "Contribution to Log-Odds",
        title = "Top 5 Risk Driver Effects"
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
}
