# Olympic Medal Prediction
Authors: Sayanti & Aaron  
Date: 2018-11-15

#### Objective
This analysis seeks to answer the following question: What will be the country medal count for the 2020 Summer Olympics?

#### Thought.
Sport is one of the best ways to unite a country and this is the sole purpose of the modern Olympic Games which promotes peace and unity within the international community. How successful will a country be at the olympics poses an interesting challenge that we have tackled with the analysis in this repository.

#### Dependencies

`R` packages
- `tidyverse`
- `magrittr`
- `countrycode`
- `maps`

`Python` packages
- `pandas`
- `sklearn`
- `argparse`

#### Datasets (folder: data)

To conduct our analysis we used several data sources that provided information on country population, GDP, historical olympic performance, and National Olympic Committees. The table below summarizes the data used. Further details are described in the data folder.

|Data File|Source|Author|Updated|Description|
|---------|------|------|-------|-----------|
|athlete_events.csv|[kaggle.com](https://www.kaggle.com/heesoo37/120-years-of-olympic-history-athletes-and-results)|Randi H. Griffin|2018-06-15| 120 years of olympic history |
|noc_regions.csv|[kaggle.com](https://www.kaggle.com/heesoo37/120-years-of-olympic-history-athletes-and-results)|Randi H. Griffin|2018-06-15| Olympic Committee codes and the corresponding region|
|w_gdp.csv|[kaggle.com](https://www.kaggle.com/resulcaliskan/countries-gdps)|Resul Caliskan|2018-02-01| GDP data by country and year |
|WorldPopulation.csv|[kaggle.com](https://www.kaggle.com/centurion1986/countries-population)|Alexander Shakhov| 2017 | Population data by country and year|
|WEO_2020_gdp_pop_outlook.csv|[imf.org](https://www.imf.org/external/pubs/ft/weo/2018/01/weodata/index.aspx)|International Monetary Fund| 2018-04-01| World economic outlook for GDP and population in 2020 by country|


#### Analysis (folder: src)

There has been several articles and research papers investigating what influences a countries success in the olympics. This it outlined  on [Wikipedia](https://en.wikipedia.org/wiki/Olympic_medal_table#Population-size,_resources-per-person_and_multivariate_prediction_models_and_ratings). Past work suggests several strong predictors to be:  
- Population
- GDP
- Past performance
- If it is the host country.

For our analysis we explored these predictors and confirmed that they do in fact strongly influence a countries performance in the olympics. With this in mind we applied a decision tree regression model to take on the ambition goal of predicting the country medal count for the 2020 Summer Olympics in Tokyo. The table below tabulates the files in our src folder.

|File|Description|
|---|---|
|[1_data_wrangling.R]()|Tidys and Cleans our data sets to be used for EDA and prediction|
|[2_EDA.R]()| Exploratory analysis on potential features for the prediction model|
|[3_DecissionTree.py]()| Train Model and predict Medal count for 2020|
|[3b_prediction_test.py]()| Validates the prediction model for the 2016 data|  
|[4_prediction_chart.py]()| Prepares our results for the Final .Rmd report|
|[5_Final_Report]()| Final .Rmd Report summarizing analysis and results|

#### Results (docs & imgs)
