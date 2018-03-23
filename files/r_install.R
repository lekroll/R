# Install some important R Packages
#==================================
# Version 1.01
# Author: L. E. Kroll from www.rki.de

# Technical Info
################
# This Script has to be once per Machine and R Version

# Packages
##########
install.packages("haven") # Paket um Stata Dateien zu öffnen
install.packages("dplyr") # data manipulation lib
install.packages("survey") # survey data
install.packages("tidyverse") #  tidyverse is an opinionated collection of R packages designed for data science (enthält alles wichtige)
install.packages("ggplot2") # nice plots
install.packages("gmodels") # Nice Tables
install.packages("descr") #  Descriptive Statistics
install.packages("Hmisc") # describe variables
install.packages("psych") # summary by group
install.packages("extrafont") # Use System fonts 
install.packages("RISmed") # Search PubMed
install.packages("tm") # Textmining
install.packages("SnowballC") # Textmining
install.packages("wordcloud") # Wordclouds 
install.packages("srvyr") # tidy wrapper for survey package (allways returning dataframe)
install.packages("survey") # Survey Analysis
install.packages("tableone") # First Table
install.packages("stargazer") # All Table Formats
install.packages("sjPlot") # Effect Plots
install.packages("imputeTS") # TimeSeries Imputation
install.packages("RCurl") # Download large files from online sources
install.packages("labelled") # Variable labels attribute
install.packages("leaflet") # Interactive Maps
install.packages("rdwd") # Weather Data
install.packages("rgdal") # Manipulation of spatial data
install.packages("maptools") # Manipulation of spatial data
install.packages("rgeos") # Manipulation of spatial data
install.packages("osmar") # OSM data Manipulation
                 
# Load System Fonts into R
##########################
# to apply the RKI Theme the font named ScalaSansLF needs to be installed locally, else use alternatives...
library(extrafont)
font_import(prompt = FALSE)
loadfonts() 

