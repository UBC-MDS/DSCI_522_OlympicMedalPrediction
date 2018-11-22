#!/usr/bin/env python

#!/usr/bin/env python
# coding: utf-8

#!/usr/bin/env python
# ???_clean.csv
# Sayanti Ghosh, Nov 2018
#
# This script reads wrangles data and fits DecissionTreeClassifier model to predeict the
# Olympic Medal count for 2020 Summer. The model uses Features : ....
#
#
# Dependencies: argparse, pandas, numpy , sklearn
#
# Usage: python DecissionTreeClassifier.py ???_clean.csv out_file.csv

# import libraries
import argparse
import pandas as pd
import numpy as np
from sklearn import tree
from sklearn import preprocessing
from sklearn.model_selection import train_test_split


# read in command line arguments
parser = argparse.ArgumentParser()
parser.add_argument('input_file')
parser.add_argument('out_file')
args = parser.parse_args()

def main():
    clean_data = pd.read_csv(args.input_file)
    # Building Features , excluding NOC , Games , Season.
    feature_cols = ['Age','Height','Weight','Team_number','Sport_number',
                    'Year','Event_number','sex_number','City_number']

    X = clean_data.loc[:, feature_cols]
    y = clean_data.Medal

    # shuffles and then splits
    Xtrain, Xtest, ytrain, ytest = train_test_split(X,y,test_size=0.2)

    #Model DecisionTreeClassifier() as our target is string.
    model = tree.DecisionTreeClassifier()

    # Fit a model on training data set
    model.fit(Xtrain, ytrain)

    #Prediction on test :
    predict= model.predict(Xtest)
    #Test score
    print("TestScore",model.score(Xtest, ytest))

    #Predict on test dataset .
    predictions = model.predict(X)

    pred_dict = clean_data.copy()
    pred_dict['prediction'] = predictions
    pd.DataFrame(pred_dict)

    #Write csv of wrangled data.
    pred_dict.to_csv(args.out_file)

# call main function
if __name__ == "__main__":
    main()
