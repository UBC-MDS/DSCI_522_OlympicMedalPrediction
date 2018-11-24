#! /usr/bin/env Rscript
# 1_data_wrangling.R
#
# This script wrangles the gdp, population, athlete medals, and world projections data to prepare medal
# count tables by year and country with relevant features
#
# Usage: Rscript src/1_data_wrangling.R data/athlete_events.csv data/noc_regions.csv data/w_gdp.csv data/WorldPopulation.csv data/WEO_2020_gdp_pop_outlook.csv results/clean_medal_count_data.csv results/tokyo_2020_test_data.csv


# load libraries
library(tidyverse)
library(magrittr)
library(countrycode)
library(maps)


# Command line arguments
args <- commandArgs(trailingOnly = TRUE)
input_file1 <- args[1]
input_file2 <- args[2]
input_file3 <- args[3]
input_file4 <- args[4]
input_file5 <- args[5]
output_file1 <- args[6]
output_file2 <- args[7]


main <- function(){

df_athlete <- read_csv(input_file1)
df_noc <- read_csv(input_file2)
df_gdp <- read_csv(input_file3, skip = 3)
df_population <- read_csv(input_file4)
df_cities <- as.tibble(world.cities)
df_2020_outlook <- read_csv(input_file5)


# Tidy our gdp, population, and noc label data

df_gdp %<>%
  select( ISO3 = "Country Code",
         `1960`:`2016`) %>%
  gather(`1960`:`2016`, key = "Year", value = "GDP_USD") %>%
  mutate(Year = as.integer(Year))

df_population %<>%
  select(ISO3 = "Country Code",
         `1960`:`2016`) %>%
  gather(`1960`:`2016`, key = "Year", value = "population") %>%
  mutate(Year = as.integer(Year))

df_noc %<>%
  mutate(region = if_else(NOC == "BOL", "Bolivia", region))

df_cities %<>%
  filter(pop > 500000) %>%
  mutate(Home_ISO3 = countrycode(country.etc, "country.name", "iso3c"),
         name = case_when(
                  name == "Soul"    ~ "Seoul",
                  name == "Athens"  ~ "Athina",
                  name == "Moscow"  ~ "Moskva",
                  name == "Rome"    ~ "Roma",
                  TRUE              ~  name)) %>%
  bind_rows(tibble(Home_ISO3 = "USA", name = "Atlanta")) %>%
  select(Home_ISO3, name)

df_2020_outlook %<>%
  filter_all(all_vars(!is.na(.))) %>%
  select(ISO, category = `Subject Descriptor`, value = `2020`) %>%
  spread(key = category, value) %>%
  mutate(GDP_USD = as.numeric(`Gross domestic product, current prices`) * 1000000000,
         GDP_USD = as.numeric(GDP_USD),
         population = as.numeric(Population) * 1000000,
         population = as.numeric(population)) %>%
  filter_all(all_vars(!is.na(.))) %>%
  select(ISO, GDP_USD, population)


# Lets map the region to the team using the noc data. Then find and fix the missing values.
df_athlete %<>%
  left_join(df_noc, by = "NOC")

df_athlete %<>%
  mutate(region = case_when(
                  NOC == "SGP" ~ "Singapore",
                  is.na(region)   ~ notes,
                  TRUE            ~ region))

df_athlete %<>%
  mutate(ISO3 = countrycode(region, "country.name", "iso3c"),
         ISO3 = case_when(
                  region == "Kosovo"       ~ "XKX",
                  region == "Micronesia"   ~ "FSM",
                  TRUE                     ~ ISO3),
         country = countrycode(ISO3, "iso3c", "country.name")) %>%
  select(Name:Weight, Year:country, -notes, -region) %>%
  mutate(Gold = if_else(Medal == "Gold", 1,0),
         Silver = if_else(Medal == "Silver", 1,0),
         Bronze = if_else(Medal == "Bronze", 1,0)) %>%
  filter(Season == "Summer")


# Identified Team Sports which is needed to adjust medal count.
Team_sports <- df_athlete %>%
  group_by(Year, Event) %>%
  summarize(tot_gold = sum(Gold, na.rm = TRUE),
            tot_silver = sum(Silver, na.rm = TRUE),
            tot_bronze = sum(Bronze, na.rm = TRUE)) %>%
  filter(tot_gold > 1 | tot_silver > 1 | tot_bronze > 1) %>%
  mutate(total_medals = tot_gold + tot_silver + tot_bronze) %>%
  filter(total_medals > 4) %>%
  ungroup() %>%
  select(Event) %>%
  distinct()

# Wrangle the data to summarize medal count by country and year
# Adjust for Team sports and include pop, gdp, and home country features
df_Medals_Count <- df_athlete %>%
  group_by(ISO3, country, Event, City, Year) %>%
  summarize(tot_gold = sum(Gold, na.rm = TRUE),
            tot_silver = sum(Silver, na.rm = TRUE),
            tot_bronze = sum(Bronze, na.rm = TRUE)) %>%
  mutate(Team_sport = if_else(Event %in% Team_sports$Event, 1, 0),
         tot_gold = if_else(Team_sport == 1 & tot_gold > 1, 1, tot_gold),
         tot_silver = if_else(Team_sport == 1 & tot_silver > 1, 1, tot_silver),
         tot_bronze = if_else(Team_sport == 1 & tot_bronze > 1, 1, tot_bronze)) %>%
  ungroup() %>%
  group_by(ISO3, country, City, Year) %>%
  summarize(tot_gold = sum(tot_gold, na.rm = TRUE),
            tot_silver = sum(tot_silver, na.rm = TRUE),
            tot_bronze = sum(tot_bronze, na.rm = TRUE)) %>%
  ungroup() %>%
  left_join(df_population, by = c("ISO3", "Year")) %>%
  left_join(df_gdp, by = c("ISO3", "Year")) %>%
  filter_all(all_vars(!is.na(.))) %>%
  left_join(df_cities, by = c("City" = "name")) %>%
  mutate(home_adv = if_else(Home_ISO3 == ISO3, 1, 0)) %>%
  mutate(gdp_per_capita = as.integer(GDP_USD/population),
         country_num = as.numeric(as.factor(country))) %>%
  select(City, ISO3, country, country_num, year = "Year", population,
         GDP_USD, gdp_per_capita, home_adv, tot_gold:tot_bronze)


# Create a new feature using lag to capture previous performance
df_Medals_Count <- df_Medals_Count %>%
  group_by(country) %>%
  arrange(country,year) %>%
  mutate(tot_medals = tot_gold + tot_silver + tot_bronze,
         last_medals = lag(tot_medals, n = 1),
         secondLast_medals = lag(tot_medals, n = 2)) %>%
  filter_all(all_vars(!is.na(.)))

df_2020_tokyo_test <- df_Medals_Count %>%
  filter(year == 2016) %>%
  mutate(secondLast_medals = last_medals,
         last_medals = tot_medals,
         home_adv = if_else(country == "Japan", 1,0)) %>%
  select(ISO3, country, country_num, home_adv, last_medals, secondLast_medals) %>%
  left_join(df_2020_outlook, by = c("ISO3" = "ISO")) %>%
  filter_all(all_vars(!is.na(.)))


# Write csv of clean data.
write_csv(df_Medals_Count, path = output_file1)
write_csv(df_2020_tokyo_test, path = output_file2)

}

main()
