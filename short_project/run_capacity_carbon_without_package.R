###
# Script by Florian Vetsch
# 
# R version 4.3.0 (2023-04-21 ucrt) -- "Already Tomorrow"
# Platform: x86_64-w64-mingw32/x64 (64-bit)
###



# Set up ------------------------------------------------------------------
rm(list=ls())

# try to unload packages to make sure ecoservR package not loaded

# # Unload add-on packages
# names_add_on_packages <- names(sessionInfo()$otherPkgs)
# if (! is.null(names_add_on_packages)){
#   invisible(lapply(paste0("package:", names_add_on_packages),   
#                    detach,
#                    character.only = TRUE, unload = TRUE)
#             )
# }
# # check loaded packages
# (.packages())

library(sf)
library(sp)
library(raster)
library(fasterize)
library(dplyr)
library(kableExtra)



# projectLog object: 
# list with some parameters (file paths, default values for some model parameters, etc.)
# projectLog <- list(title = "Your_Project_Title", projpath = ".")

projectLog <- list(
  title = "Abernethy", #"BeinnEighe", 
  projpath = "./Abernethy") # where you want outputs saved (a subfolder will be created in there)


runtitle = "no_package_run"  # a title for the specific model run

myres = 10 # desired output resolution, we usually use 10m



# Load data ---------------------------------------------------------------

mm <- st_read("./Abernethy/habitat_map.gpkg") # basemap
studyArea <- st_read("./Abernethy/boundary.gpkg") # boundary of focal area

# Reading in the EcoServR internal look-up tables
# the csv gives an error
# hab_lookup <- read.csv("./hab_lookup_tables/hab_lookup.csv", header=FALSE)

# the following files are without change taken from the package GitHub page
load(file='./hab_lookup_tables/hab_lookup.rda')

source("./fun_project_management.R")
source("./fun_cleaning.R")

# this file could be replaced with e.g. capacity_carbon_florian.R
source("./capacity_carbon.R")

capacity_carbon(mm, studyArea, 
                res = myres, 
                # additional steps when using hedgerow data, needs to be supplied separately
                use_hedges = FALSE, 
                projectLog = projectLog, 
                runtitle = runtitle)
