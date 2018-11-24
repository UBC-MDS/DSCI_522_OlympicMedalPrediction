#! /usr/bin/env Rscript
# EDA.R
#
# This script produces exploratory data analysis figures of our wrangled data
# 
# Usage: Rscript src/EDA.R results/clean_medal_count_data.csv 1_pop_corr.png 2_gdp_corr.png 3_home_adv.png 4_historical_corr.png

# load libraries
library(tidyverse)

# Command line arguments
args <- commandArgs(trailingOnly = TRUE)
input_file1 <- args[1]
output_file1 <- args[2]
output_file2 <- args[3]
output_file3 <- args[4]
output_file4 <- args[5]

main <- function(){

df_EDA <- read_csv(input_file1)
 
df_EDA <- df_EDA %>% 
  mutate(home_adv = as.factor(home_adv))

# Build Plots on all the planned features for our model

fig_pop_correl <- df_EDA %>% 
  filter(year == 2016) %>% 
  ggplot(aes(y = tot_medals, x = population)) +
    scale_x_log10() +
    geom_point(alpha = 0.5) +
    labs(title = "Figure 1. Population Correlation in 2016",
         x = "Population",
         y = "Total Medals")

ggsave(output_file1, path = "./imgs", plot = fig_pop_correl)


fig_correl_gdp <- df_EDA %>% 
  filter(year == 2016) %>% 
  ggplot(aes(y = tot_medals, x = GDP_USD)) +
  scale_x_log10() +
  geom_point(alpha = 0.5) +
  labs(title = "Figure 2. GDP Correlation in 2016",
       x = "GDP",
       y = "Total Medals")

ggsave(output_file2, path = "./imgs", fig_correl_gdp)


home_countries <- df_EDA %>% 
  filter(home_adv == 1) %>% 
  select(country) %>% 
  distinct()

fig_home_adv <- df_EDA %>% 
  filter(country %in% home_countries$country) %>% 
  ggplot(aes(x = fct_reorder(country,tot_medals), y = tot_medals, col = home_adv)) +
    geom_point() +
    coord_flip() +
    labs(title = "Figure 3. Summer Olympics Home Country Advantage",
         y = "Total Medals",
         x = "Country") +
    guides(col = guide_legend(title = "Home\nAdvantage"))

ggsave(output_file3, path = "./imgs", plot = fig_home_adv)


fig_correl_pastperform <- df_EDA %>% 
  select(tot_medals, `Last Olympics` = last_medals, 
         `2nd Last Olympics` = secondLast_medals) %>% 
  gather(`Last Olympics`, `2nd Last Olympics`, 
         key = "Time_Frame", value = "Past_Performance") %>% 
  ggplot(aes(x = Past_Performance, y = tot_medals, col = Time_Frame)) +
    geom_point(alpha = 0.75) +
    labs(title = "Figure 4. Past Performance Correlation",
         x = "Total Medals in Prior Olympics",
         y = "Total Medals in Present Olympics") +
  guides(col = guide_legend(title = "Time Frame"))

ggsave(output_file4, path = "./imgs", plot = fig_correl_pastperform)
}

main()
