library(shiny)
library(tidyverse)
library(glue)
library(DT)
library(lubridate)


credit_raw <- read_csv("data/loans_full_schema.csv") 

#I need to create a clean binary outcome
credit <- credit_raw |>
  mutate(
    default = case_when(
      loan_status %in% c("Charged Off", 
                        "Default",
                        "Late (31-120 days)",
                        "Late (16-30 days)") ~ 1,
      loan_status %in% c("Fully Paid",
                         "Current",
                         "In Grace Period") ~ 0,
      TRUE ~ NA_real_
    )
  ) |>
  filter(!is.na(default))

credit |>
  distinct(loan_status) |>
  pull()

credit_model = readRDS("credit_model_RDS")

credit_model_lr = readRDS("credit_model_lr_RDS")

