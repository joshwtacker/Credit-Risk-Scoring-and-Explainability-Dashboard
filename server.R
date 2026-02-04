#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output, session){ 
  
  output$distPlot <- renderPlot({
    
    plot_data <- if (input$loan_status != "All") {
      credit |> filter(loan_status == input$loan_status)
    } else {
      credit
    }
    
    ggplot(plot_data, aes(x = annual_income)) +
      geom_histogram(bins = input$bins, fill = "blue", alpha = 0.7) +
      labs(
        title = "Distribution of Annual Income",
        x = "Annual Income",
        y = "Count"
      )
})
  
  output$barPlot <- renderPlot({
    
    if(input$loan_status != "All"){
      plot_data <- credit |> 
        filter(loan_status == input$loan_status)
    } else if(input$loan_status == 'All'){
      plot_data <- credit
    }
    
    plot_data |> 
      ggplot(aes(x = loan_status)) +
      geom_bar()
    
  })
  
  #boxplot with a trend line
  output$boxplot <- renderPlot({
    
    credit |>
      ggplot(aes(x= loan_status, y= annual_income, color = loan_status)) +
      geom_boxplot() +
      labs(x= "loan_status", y = "annual_income")
    
  })
  
  #linear regression model output
  # render text
  output$linearregression <- renderPrint({
    
    credit_glm <- glm(
      default ~
        emp_length +
        homeownership +
        annual_income +
        verified_income +
        debt_to_income +
        delinq_2y +
        inquiries_last_12m +
        total_credit_lines +
        total_credit_utilized +
        account_never_delinq_percent +
        public_record_bankrupt +
        loan_amount +
        term +
        interest_rate +
        grade +
        loan_purpose +
        application_type,
      data = credit,
      family = binomial
    )
    summary(credit_glm)
  })
  
  
}