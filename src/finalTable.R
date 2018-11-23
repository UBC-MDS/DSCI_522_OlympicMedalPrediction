
#! /usr/bin/env Rscript 
# finalTable.R
#
# this script creates the final table with medal count of gold,  
# silver , bronze  for specific countries. 
# a
#
# Usage: Rscript finalTable.R prediction_output.csv output_file.png

# read in command line arguments

library(knitr)
library(kableExtra)
library(tidyverse)

args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_file <- args[2]


main <- function(){ 
  # read in data
  data <- read.csv(input_file)
  
  #Chart preparation
  prediction_chart <- ddply(data, ~ country, summarize, 
                            Gold=sum(predictions_gold),
                            Silver=sum(predictions_silver),
                            Bronze=sum(predictions_bronze),
                            Total = sum(Gold,Silver,Bronze))
  
  kable(prediction_chart)
  
  table<- prediction_chart %>%
    kable() %>%
    kable_styling(c("striped", "bordered",font_size = 11))%>%
    row_spec(0, bold = T, color = "white",background="darkred")
  
  table
  
}

# call main function
main()