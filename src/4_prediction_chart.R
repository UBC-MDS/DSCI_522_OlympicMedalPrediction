
#! /usr/bin/env Rscript
# 4_prediction_chart.R
#
# This script creates the final prediction chart with medal count of gold,
# silver , bronze  for specific countries. Along with that it gives the total medal count
# of each country.
#
# Usage: Rscript src/4_prediction_chart.R prediction_output.csv output_file.csv

#library
library(tidyverse)
library(plyr)

# read in command line arguments
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

  write_csv(prediction_chart, output_file)
}

# call main function
main()
