library(tidyverse)
library(magrittr)
library(countrycode)
library(maps)

df_athlete <- read_csv("../data/athlete_events.csv")
df_noc <- read_csv("../data/noc_regions.csv")
df_gdp <- read_csv("../data/w_gdp.csv", skip = 3)
df_population <- read_csv("../data/WorldPopulation.csv")
df_cities <- as.tibble(world.cities)


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


# Find unique Teams, NOC, and relate them to country code
length(df_athlete %$% unique(Team))
length(df_athlete %$% unique(NOC))

df_athlete %>% 
  select(Team, NOC) %>% 
  distinct() %>% 
  group_by(NOC) %>% 
  summarize(no_of_teams = n()) %>% 
  arrange(desc(no_of_teams))


# Lets map the region to the team using the noc data. Then find and fix the missing values.
df_athlete %<>% 
  left_join(df_noc, by = "NOC")

df_athlete %>% 
  filter(is.na(region)) %>% 
  select(Team, NOC, region, notes) %>% 
  distinct()

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
  mutate(gdp_per_capita = GDP_USD/population,
         country_num = as.numeric(as.factor(country))) %>% 
  select(City, ISO3, country, country_num, year = "Year", population, 
         GDP_USD, gdp_per_capita, home_adv, tot_gold:tot_bronze)
  

# Write csv of clean data.
write_csv(df_Medals_Count, path = "../results/clean_medal_count_data.csv")



  
