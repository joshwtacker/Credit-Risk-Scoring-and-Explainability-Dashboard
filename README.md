# Credit-Risk-Scoring-and-Explainability-Dashboard

## Executive Summary
The goal of this project is to develop an interactive R Shiny app that predicts the probability of default (PD) for consumer credit accounts while emphasizing model interpretability and transparency. The project is inspired by real-world credit risk modeling practices used in large financial institutions and is designed to align with regulatory and business expectations.

### The final deliverables will include:
A fully functional Shiny application
A reproducible analysis workflow hosted on GitHub
A presentation summarizing the analytical process, findings, and business implications
Motivation
I chose this project because I wanted to allow for a diverse portfolio and learn more about credit risk. This project will serve as a major portfolio piece demonstrating applied data science, statistical modeling, and communication skills.


### Data Question
The analysis will be guided by the following questions:
1. Which borrower characteristics are most predictive of credit default?
2. How effectively can a logistic regression model distinguish between default and non-default accounts?
3. How do predicted default probabilities vary across defined risk bands (low, medium, high)?
4. How each individual's status of different variables can affect their approval?
	 	 	 	
### Minimum Viable Product (MVP)
The Minimum Viable Product for this project is a complete, working R Shiny application that demonstrates end-to-end credit risk modeling using a single, interpretable model.
The MVP will include:
- A cleaned and prepared version of the UCI Credit Card Default dataset
- A logistic regression model predicting probability of default (PD)
- Evaluation of model performance using ROC curve, AUC, and KS statistic
- A Shiny interface with a borrower input form
- Real-time PD prediction for hypothetical borrowers
- Risk band classification (Low / Medium / High)
- At least one model interpretability visualization explaining individual predictions


### Schedule (through 2/21/2026)
Get the Data (01/23/2026)
Clean & Explore the Data (02/05/2026)
Create Presentation and Shiny App (02/15/2026)
Internal Demos (2/17/2026)
Midcourse Project Presentations (2/21/2026)


### Data Sources
The primary dataset for this project will be the UCI Credit Card Default Dataset, a publicly available academic dataset. The dataset contains anonymized borrower characteristics and credit behavior variables suitable for modeling default risk.
The dataset does not contain personally identifiable information (PII) in the final deliverables.

### Known Issues and Challenges
Some issues that I will run into are below:
Handling missing and inconsistent values
Recoding categorical variables into analysis-ready formats
Feature engineering (e.g., utilization ratios, income and balance transformations)
Creating a binary default target variable
Splitting data into training and testing sets
.
