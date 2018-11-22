# DSCI_522_OlympicMedalPrediction
This analysis seeks to predict the medal count of each country for the 2020 Summer Olympics

### Title: Olympic Medal Prediction
Authors: Sayanti & Aaron  
Date: 2018-11-15

#### Question
Question type: Predictive  
What is the medal count of each country for the 2020 Summer Olympics if the same countries participate in each sport?

#### Thought.
We believe sport is one of the best way which unite a country and this is the sole purpose of the modern Olympic Games which promotes peace and unity within the international community through the medium of sports. The idea of this project occured when we tried to use athelet profile in machine learning context to measure their performance . However , we realised performance measurement of athelets has direct impact in number of medals a country wins for specific sports. Eventually , our interest in predicting next Summer Olympic medal count inspired us for this analysis.

#### Dataset
The dataset includes 120 years of olympic history and was composed by Randi H Griffin and updated as of 2018-06-15.
It can be found on [kaggle - athlete_events.csv](https://www.kaggle.com/heesoo37/120-years-of-olympic-history-athletes-and-results)

#### Glimpse of raw data 

![](raw_data.png)

#### Dependencies 

R , Python

#### Plan of Action
Our data has athelet physical profile , along with thoer country , sport , medal win , event in which they participitated . As we want to achieve the total medal count for each country for the specific sport and event ; our target is medal (Gold, Silver,Bronze) . As the prediction target is non-numerical so we will analyze the data using classification with a decision tree. 

As we are targeting 2020 Summer Olymipic our data will be wrnagled and cleaned to fit the requirement of our model. Events of Summer will only be considerd. Our feature selection will be done after the EDA result . 

Features for our model : 
Target : 

We will convert all string features to integers/factors for our classifier model. The data will be splitted to train vs test in 80-20 ratio.

The results will be summarized in a table with country, gold, silver, and bronze as column headers. The specific country and medal count values will be tabulated in each row. Additionaly this can be visualized with a columnn plot to compare country medal counts. Another visualization will be the a flow chart of the top of our decision tree.  

