# Credit Risk Scoring and Explainability Dashboard

---

## Executive Summary

This project develops an interactive **R Shiny credit risk dashboard** that predicts the **Probability of Default (PD)** for consumer credit accounts while emphasizing **interpretability, transparency, and practical lending application**.

Inspired by real-world credit risk modeling practices used in major financial institutions, the project aligns with regulatory expectations for explainable models and responsible underwriting. The final product transforms statistical model outputs into clear, business-ready lending insights.

### Final Deliverables

- A fully functional **R Shiny application**
- A reproducible modeling workflow hosted on GitHub
- A presentation summarizing methodology, findings, and business implications

---

## 📊 Live App & Presentation

- 🔗 **Shiny App (Live Demo):**  
  https://joshwtacker.shinyapps.io/Credit-Risk-Scoring-and-Explainability-Dashboard/

- 📄 **Presentation Slides:**  
  https://docs.google.com/presentation/d/1NmSKgzRoyifHVpfTvF9-4_rpPONrolqR46Jj9-c2OVo/edit?slide=id.g3c729fdfb55_0_2424#slide=id.g3c729fdfb55_0_2424

---

## Motivation

I chose this project to strengthen my applied data science portfolio and deepen my understanding of **credit risk modeling**. This serves as a flagship portfolio piece demonstrating:

- Statistical modeling  
- Model validation and evaluation  
- Explainable AI techniques  
- Dashboard development in R Shiny  
- Business communication of quantitative results  

---

## Data Questions

This analysis is guided by the following key questions:

1. Which borrower characteristics are most predictive of credit default?
2. How effectively can a logistic regression model distinguish between default and non-default accounts?
3. How do predicted default probabilities vary across defined risk bands (Low, Medium, High)?
4. How does each individual borrower’s profile influence their predicted approval status?

---

## Data Source

The primary dataset used in this project is the **UCI Credit Card Default Dataset**.

This publicly available academic dataset includes anonymized borrower-level credit behavior variables suitable for modeling default risk.

- No personally identifiable information (PII) is included.
- Data contains demographic, financial, and delinquency history variables.

---

## Minimum Viable Product (MVP)

The MVP consists of a complete, end-to-end credit risk modeling workflow implemented in R.

### Core Components

- Cleaned and prepared dataset  
- Logistic regression model predicting Probability of Default (PD)  
- Model performance evaluation using:
  - ROC Curve  
  - AUC (Area Under the Curve)  
  - KS Statistic  
- Interactive Shiny borrower input form  
- Real-time PD prediction  
- Risk band classification (Low / Medium / High)  
- Individual-level model explainability (Top Risk Drivers)

---

## Modeling Approach

The primary model used is **logistic regression**, selected for its:

- Interpretability  
- Regulatory acceptance in financial institutions  
- Transparent coefficient-based explanation  
- Ease of communicating risk drivers to stakeholders  

The model was trained on a training dataset and evaluated on a holdout testing dataset to assess generalization performance.

---

## Key Conclusions

### 1. The Model Accurately Predicts Borrower Default Risk

The logistic regression model demonstrates strong discriminatory power, effectively distinguishing between default and non-default accounts using ROC, AUC, and KS metrics.

---

### 2. Risk Predictions Are Transparent and Fully Explainable

Because the model is logistic regression:

- Each coefficient directly reflects the directional impact on default risk.
- Individual predictions can be decomposed into feature-level contributions.
- The dashboard highlights **Top Risk Drivers** for each borrower.

This ensures interpretability consistent with real-world regulatory expectations.

---

### 3. The Dashboard Converts Model Output into Clear Lending Decisions

Raw probabilities are translated into actionable **Risk Bands**:

- **Low Risk**
- **Medium Risk**
- **High Risk**

This bridges the gap between statistical modeling and operational underwriting decisions.

---

### 4. Delinquency History and Leverage Are the Strongest Risk Drivers

The most predictive features consistently include:

- Past delinquency indicators  
- Credit utilization / leverage measures  
- Payment behavior history  

These findings align with established credit risk theory and real-world underwriting practice.

---

### 5. The Framework Enables Smarter, Data-Driven Underwriting

This system demonstrates how financial institutions can:

- Standardize credit decisions  
- Quantify borrower risk consistently  
- Reduce subjective decision-making  
- Improve portfolio risk management  

The model provides a scalable foundation for automated underwriting workflows.

---

### 6. Future Improvements

While the MVP achieves its goals, future enhancements could include:

- Gradient boosting or ensemble model comparisons  
- Cross-validation tuning  
- Probability calibration improvements  
- Automated reporting features  
- Deployment to a cloud-hosted environment  
- Bias and fairness diagnostics  

These enhancements could further improve predictive accuracy and operational efficiency.

---

## Known Challenges Addressed

- Handling missing and inconsistent values  
- Recoding categorical variables  
- Feature engineering (e.g., utilization ratios)  
- Creating a binary default target variable  
- Train/test data splitting  
- Avoiding overfitting  
- Building interpretable model explanations  

---


## Final Takeaway

This project demonstrates how statistical modeling, explainability, and interactive dashboards can be combined to create a transparent and practical credit risk decision-support tool.

The result is not just a predictive model — but a fully interpretable underwriting framework that translates data into confident lending decisions.
