# example R options set globally
options(width = 60)

# example chunk options set globally
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  echo = TRUE,
  message = FALSE,
  warning = FALSE
  
  )


if (!require("pacman")) install.packages("pacman")
pacman::p_load("tidyverse", "ggplot2", "haven", "bookdown", "knitr", "kableExtra","stargazer",
               "tableone","sjPlot","sjlabelled","sjmisc","gridExtra","car", "gvlma","FSA","ggmosaic","finalfit","emmeans","parameters" )
options(stringsAsFactors=F,digits=2)
source("tablasDeArticulo_v2.R")
theme_set(theme_minimal())