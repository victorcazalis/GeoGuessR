
setwd("C:/Victor_local/GeoGuessR")



### Required libraries
library(devtools)
library(ggplot2)
library(dplyr)
library(plyr)
library(stringi)
library(sf)
library(gridExtra)

#install_github("baptiste/ggflags")
library(ggflags)


# Find the path to store results in config
folder_results<-"C:/Victor_local"


### Call hidden functions (e.g. to store results, to clean names...)
source("GGR_Hidden_functions.R")



### Call guess functions
source("GGR_capitals.R")
source("GGR_countries_shape.R")
source("GGR_countries_localisation.R")
source("GGR_flags.R")
source("GGR_RandomGame.R")


### Call plot results function
source("GGR_plot_results.R")




### TO PLAY
# Either call one of these functions to play a specific game
GGR_flags()
GGR_capitals()
GGR_countries_shape()
GGR_countries_localisation()


# Or call this function to play all games (or select the ones you want to play)
GGR_RandomGame(GAMES=c("flags", "capitals", "countries_shape", "countries_localisation"))

# Check your results
GGR_plot_results()




