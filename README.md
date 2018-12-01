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
R version 3.5.1  
R packages: `tidyverse v1.2.1`,`magrittr v1.5`,`countrycode v1.1.0`,`maps v3.3.0`  

Python Version 3.6.5  
Python packages: `pandas v0.23.0`,`sklearn v0.19.1`,`argparse v1.1`


#### Usage

To conduct the analysis, the scripts in the src folder are run sequentially as tabulated in the src README.md. Detailed instruction are captured in the [Makefile](). The following input at the command line navigated at the root directory can be run to generate the results: `make all`



#### Datasets (folder: data)

To conduct our analysis we used several data sources that provided information on country population, GDP, historical olympic performance, and the National Olympic Committees. Glimpses of the .csv files and further details can be found in the data folder.


#### Analysis (folder: src)

There has been several articles and research papers investigating what influences a countries success in the olympics. This is outlined on [Wikipedia](https://en.wikipedia.org/wiki/Olympic_medal_table#Population-size,_resources-per-person_and_multivariate_prediction_models_and_ratings) and here it suggests several strong predictors to be:  
- Population
- GDP
- Past performance
- If it is the host country.

For our analysis we explored these predictors and confirmed that they do in fact strongly influence a countries performance in the olympics. With this in mind we applied a decision tree regression model to take on the ambitious goal of predicting the country medal count for the 2020 Summer Olympics in Tokyo. For further details on the scripts used in the analysis see the src folder.


#### Results (folder: docs, results, imgs)

The docs, results, and imgs folder contain the outputs of our analysis which include wrangled data, visualizations and prediction outputs. Our final report has been prepared as a pdf and is linked below. For more information see the respective folders.

*docs:*

|File|Description|
|---|---|
|[Final_Report.pdf](https://github.com/UBC-MDS/DSCI_522_OlympicMedalPrediction/blob/master/docs/Final_Report.pdf)| The Final Report rendered from the R Markdown to a pdf |
<br>
