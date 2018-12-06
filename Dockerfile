# Docker file for olympic_medals
# Aaron Quinton, Sayanti Ghosh, Nov. 2018

# use rocker/tidyverse as the base image and
FROM rocker/tidyverse

# then install the country code package
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  && install2.r --error \
    --deps TRUE \
    countrycode \
    # maps \
    magrittr \
    plyr

RUN R -e "install.packages('kableExtra')"

# install python 3
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

# get python package dependencies
RUN apt-get install -y python3-tk

# install numpy, pandas & sklearn
RUN pip3 install numpy
RUN pip3 install pandas
RUN pip3 install sklearn
RUN apt-get update && \
    pip3 install matplotlib && \
    rm -rf /var/lib/apt/lists/*
