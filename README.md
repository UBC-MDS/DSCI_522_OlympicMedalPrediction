# Olympic Medal Prediction
**Date: 2018-11-15**  

**Authors:**

|Name| Github|
|---|---|
|Sayanti Ghosh|[Sayanti86](https://github.com/Sayanti86)|
|Aaron Quinton| [aaronquinton](https://github.com/aaronquinton)|  


#### Objective
This analysis seeks to answer the following predictive question: **What will be the country medal count for the 2020 Summer Olympics?**

Our motivation behind this question is simple. We believe sport is one of the best ways to unite a country and that this is the sole purpose of the modern Olympic Games. These games promote peace and unity within the international community and we felt was an exciting topic to consider. How successful will a country be at the olympics poses an interesting challenge that we have tackled with the analysis in this repository.

#### Dependencies

R packages: `tidyverse`,`magrittr`,`countrycode`,`maps`  
Python packages: `pandas`,`sklearn`,`argparse`

#### Datasets (folder: data)

To conduct our analysis we used several data sources that provided information on country population, GDP, historical olympic performance, and the National Olympic Committees. The table below summarizes the data used. Further details are described in the data folder.

|Data File|Source|Author|Updated|Description|
|---------|------|------|-------|-----------|
|athlete_events.csv|[kaggle.com](https://www.kaggle.com/heesoo37/120-years-of-olympic-history-athletes-and-results)|Randi H. Griffin|2018-06-15| 120 years of olympic history |
|noc_regions.csv|[kaggle.com](https://www.kaggle.com/heesoo37/120-years-of-olympic-history-athletes-and-results)|Randi H. Griffin|2018-06-15| Olympic Committee codes and the corresponding region|
|w_gdp.csv|[kaggle.com](https://www.kaggle.com/resulcaliskan/countries-gdps)|Resul Caliskan|2018-02-01| GDP data by country and year |
|WorldPopulation.csv|[kaggle.com](https://www.kaggle.com/centurion1986/countries-population)|Alexander Shakhov| 2017 | Population data by country and year|
|WEO_2020_gdp_pop_outlook.csv|[imf.org](https://www.imf.org/external/pubs/ft/weo/2018/01/weodata/index.aspx)|International Monetary Fund| 2018-04-01| World economic outlook for GDP and population in 2020 by country|
<br>

#### Analysis (folder: src)

There has been several articles and research papers investigating what influences a countries success in the olympics. This is outlined on [Wikipedia](https://en.wikipedia.org/wiki/Olympic_medal_table#Population-size,_resources-per-person_and_multivariate_prediction_models_and_ratings) and here it suggests several strong predictors to be:  
- Population
- GDP
- Past performance
- If it is the host country.

For our analysis we explored these predictors and confirmed that they do in fact strongly influence a countries performance in the olympics. With this in mind we applied a decision tree regression model to take on the ambitious goal of predicting the country medal count for the 2020 Summer Olympics in Tokyo. The table below tabulates the analysis files in our src folder.

|File|Description|
|---|---|
|[1_data_wrangling.R](https://github.com/UBC-MDS/DSCI_522_OlympicMedalPrediction/blob/master/src/1_data_wrangling.R)|Tidys and Cleans our data sets to be used for EDA and prediction|
|[2_EDA.R](https://github.com/UBC-MDS/DSCI_522_OlympicMedalPrediction/blob/master/src/2_EDA.R)| Exploratory analysis on potential features for the prediction model|
|[3_DecissionTree.py](https://github.com/UBC-MDS/DSCI_522_OlympicMedalPrediction/blob/master/src/3_DecissionTree.py)| Train Model and predict Medal count for 2020|
|[3b_ReportY2016.py](https://github.com/UBC-MDS/DSCI_522_OlympicMedalPrediction/blob/master/src/3b_ReportY2016.py)| Validates the prediction model for the 2016 data|  
|[4_prediction_chart.R](https://github.com/UBC-MDS/DSCI_522_OlympicMedalPrediction/blob/master/src/4_prediction_chart.R)| Prepares our results for the Final .Rmd report|
|[5_final_Report.Rmd](https://github.com/UBC-MDS/DSCI_522_OlympicMedalPrediction/blob/master/src/5_final_report.Rmd)| Final .Rmd Report summarizing analysis and results|
<br>

#### Results (folder: docs, results, imgs)

The following tables describe the output files generated and used in our analysis as well as for the final report.

*docs:*

|File|Description|
|---|---|
|[Final_Report.pdf](https://github.com/UBC-MDS/DSCI_522_OlympicMedalPrediction/blob/master/docs/Final_Report.pdf)| The Final Report rendered from the R Markdown to a pdf |
<br>


*results:*

|File|Description|
|---|---|
|clean_medal_count_data.csv| Wrangled raw data to be used in EDA and prediction Model|
|tokyo_2020_test_data.csv| Feature data used for the 2020 olympics Medal count prediction|
|report_2016.csv| 2016 Medal predictions for all countries using trained Model. Used to validate model accuracy|
|prediction_output.csv| Medal count predictions for the 2020 Olympics|
|summary_2016.csv|Nicely formatted 2016 prediction data used in Final Report R Markdown|
|summary.csv| Nicely formatted 2020 prediction data used in Final Report R Markdown|
<br>

*imgs:*

All of the images have been used in the final report to illustrate glimpses of the raw data and describe relevant correlations for our features.
