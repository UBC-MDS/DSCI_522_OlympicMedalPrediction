# Make File instructions to reproduce the Olympic Medal Prediction analysis
# Authors: Sayanti Ghosh and Aaron Quinton
# Date: November 2018


all: results/clean_medal_count_data.csv results/tokyo_2020_test_data.csv imgs/1_pop_corr.png imgs/2_gdp_corr.png imgs/3_home_adv.png imgs/4_historical_corr.png results/prediction_output.csv results/report_2016.csv results/summary_2016.csv results/summary.csv docs/5_final_report.html

# Wrangle the athlete data, gdp, pop, and world outlook data to prepare for EDA and prediction
# Author: Aaron Quinton
# Updated: November 2018
results/clean_medal_count_data.csv results/tokyo_2020_test_data.csv: data/athlete_events.csv data/noc_regions.csv data/w_gdp.csv data/WorldPopulation.csv data/WEO_2020_gdp_pop_outlook.csv src/1_data_wrangling.R
	Rscript src/1_data_wrangling.R data/athlete_events.csv data/noc_regions.csv data/w_gdp.csv data/WorldPopulation.csv data/WEO_2020_gdp_pop_outlook.csv results/clean_medal_count_data.csv results/tokyo_2020_test_data.csv

# Generate exploratory data analysis images
# Author: Aaron Quinton
# Updated: November 2018
imgs/1_pop_corr.png imgs/2_gdp_corr.png imgs/3_home_adv.png imgs/4_historical_corr.png: results/clean_medal_count_data.csv src/2_EDA.R
	Rscript src/2_EDA.R results/clean_medal_count_data.csv 1_pop_corr.png 2_gdp_corr.png 3_home_adv.png 4_historical_corr.png

# Trains the model and predicts on the tokyo 2020 test data
# Author: Sayanti Ghosh
# Updated: November 2018
results/prediction_output.csv: results/clean_medal_count_data.csv src/3_DecissionTree.py
	python src/3_DecissionTree.py results/clean_medal_count_data.csv results/prediction_output.csv

# Trains the model and predicts on 2016 to be used as our test
# Author: Sayanti Ghosh
# Updated: November 2018
results/report_2016.csv: results/clean_medal_count_data.csv src/3b_ReportY2016.py
	python src/3b_ReportY2016.py results/clean_medal_count_data.csv results/report_2016.csv

# Generates the summary table for the 2016 test
# Author: Sayanti Ghosh
# Updated: November 2018
results/summary_2016.csv: results/report_2016.csv src/4_prediction_chart.R
	Rscript src/4_prediction_chart.R results/report_2016.csv results/summary_2016.csv

# Generates the summary table for the tokyo 2020
# Author: Sayanti Ghosh
# Updated: November 2018
results/summary.csv: results/prediction_output.csv src/4_prediction_chart.R
	Rscript src/4_prediction_chart.R results/prediction_output.csv results/summary.csv

# Creates the final report/figures/tables into an html file
# Author: Sayanti Ghosh and Aaron Quinton
# Updated: November 2018
docs/5_final_report.html: src/5_final_report.Rmd
	Rscript -e "rmarkdown::render('src/5_final_report.Rmd', output_dir = 'docs')"


clean :
	rm -f results/clean_medal_count_data.csv
	rm -f results/tokyo_2020_test_data.csv
	rm -f imgs/1_pop_corr.png imgs/2_gdp_corr.png imgs/3_home_adv.png imgs/4_historical_corr.png
	rm -f results/prediction_output.csv
	rm -f results/report_2016.csv
	rm -f results/summary_2016.csv
	rm -f results/summary.csv
	rm -f docs/5_final_report.html
