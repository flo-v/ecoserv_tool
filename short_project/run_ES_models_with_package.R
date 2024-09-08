#############################################
## Run ES models                          ###
## NatureScot - Abernethy sample          ###
## Sandra Angers-Blondin                  ###
## 17-07-2024                             ###
## adapted by Florian Vetsch 07-2024      ###
#############################################

# R version 4.3.0 (2023-04-21 ucrt) -- "Already Tomorrow"
# Platform: x86_64-w64-mingw32/x64 (64-bit)


# ABOUT -------------------------------------------------------------------

# This script is to demonstrate how to run ecoservR ES models on a basemap.
# The basemap is already provided, it was run for Abernethy National Nature Reserve (+5km buffer).

rm(list=ls())

# # Unload add-on packages
# names_add_on_packages <- names(sessionInfo()$otherPkgs)
# if (! is.null(names_add_on_packages)){
#   invisible(lapply(paste0("package:", names_add_on_packages),   
#                    detach,
#                    character.only = TRUE, unload = TRUE)
#   )
# }
# # check loaded packages
# (.packages())



library(sf)
library(dplyr)
library(raster)
library(ecoservR)
# library(ecoservRextras)



# Set up ------------------------------------------------------------------
# adapt paths where necessary

# projectLog object: 
# list with some parameters (file paths, default values for some model parameters, etc.)
# projectLog <- list(title = "Your_Project_Title", projpath = ".")

projectLog <- list(
   title = "Abernethy", #"BeinnEighe", 
   projpath = "./Abernethy") # where you want outputs saved (a subfolder will be created in there)


runtitle = "standard_run"  # a title for the specific model run

myres = 10 # desired output resolution, we usually use 10m



# Load data ---------------------------------------------------------------
# a basemap and boundry (both .gpkg files) are prerequisites to run ES models 
mm <- st_read("./Abernethy/habitat_map.gpkg") # basemap
studyArea <- st_read("./Abernethy/boundary.gpkg") # boundary of focal area

# dtm_path <- "" # folder containing DTM 

# Run models --------------------------------------------------------------

# These maps will be saved in your working directory, in a folder called 
# services_Abernethy_test (or services_[whatever you set runtitle to])

# The models usually save a score raster and a rescaled (0-100) raster. 
# We tend to keep only the raw scores and rescale them when needed to whatever 
# extent we are working on. (We often need to work in chunks and combine results
# afterward- scaling by chunk wouldn't be appropriate.)


# run model:
# capacity_carbon(mm, studyArea, res = 10, use_hedges = FALSE,
#                 projectLog = projectLog, runtitle = "title_for_this_model_run")

# mm: basemap object
# studyArea: boundary of focal area
# res: resolution of the raster
# runtitle: model run title, part of file name in addition to project title of project log.


capacity_carbon(mm, studyArea, 
                res = myres, 
                # additional steps when using hedgerow data, needs to be supplied separately
                use_hedges = FALSE, 
                projectLog = projectLog, 
                runtitle = runtitle)

# you can simplify the calls as they have defaults to find parameters in your environment.
capacity_air_purif(mm, studyArea, myres)

# capacity_flood_reg(mm, studyArea, 
#                    DTM = dtm_path) # requires a DTM, remind Sandra to provide one


capacity_noise_reg(mm, studyArea, myres)


capacity_climate_reg(mm, studyArea, myres)
