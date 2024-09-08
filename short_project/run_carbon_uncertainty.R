
# annotated/adapted by Florian Vetsch as part of an internship with NatureScot's
# Donya Davidson 01.07.2024 - 10.08.2024.

# Set up ------------------------------------------------------------------
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
# 
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


runtitle = "uncertainty_variab"  # a title for the specific model run

myres = 10 # desired output resolution, we usually use 10m



# Load data ---------------------------------------------------------------

mm <- st_read("./Abernethy/habitat_map.gpkg") # basemap
studyArea <- st_read("./Abernethy/boundary.gpkg") # boundary of focal area

# Reading in the EcoServR internal look-up tables
# the csv gives an error
# hab_lookup <- read.csv("./hab_lookup_tables/hab_lookup.csv", header=FALSE)

# the following files are without change taken from the package GitHub page
load(file='./hab_lookup_tables/hab_lookup.rda')

source("./capacity_carbon_uncertainty.R")
source("./fun_project_management.R")
source("./fun_cleaning.R")


### adapt the hab_lookup table to incorporate made up uncertainties ###
hab_lookup <- hab_lookup[c("Ph1code", "TotCarb")]

# Set a seed for reproducibility
set.seed(123)

# Randomly assign each row to one of the three groups
group_assignment <- base::sample(1:3, nrow(hab_lookup), replace = TRUE)

# Create the 'TotCarb_variability' list column based on group membership
TotCarb_variability <-
  base::mapply(
    function(TotCarb, group) {
      if (group == 1) {
        c(0.9 * TotCarb, TotCarb, 1.1 * TotCarb)
      } else if (group == 2) {
        c(0.5 * TotCarb, TotCarb, 1.5 * TotCarb)
      } else if (group == 3) {
        (c(0.1 * TotCarb, TotCarb, 1.9 * TotCarb))
      }
    },
    hab_lookup$TotCarb, 
    group_assignment, 
    SIMPLIFY = FALSE
  )

hab_lookup$TotCarb_variability <- I(TotCarb_variability)

# like this new entries can be set:
# hab_lookup$TotCarb_variability[1] <- list(c(20.2,202,383.8,400,380))
# hab_lookup$TotCarb_variability[2] <- list(c(27.3))

### end of made up uncertainties ###


# this is one way of saving list column data frames as .csv files
# Apply row-wise operation to transform list columns into concatenated strings
# hab_lookup_base <- hab_lookup
# 
# # Check each column, unlist and collapse if it's a list
# for (col in seq_along(hab_lookup_base)) {
#   if (is.list(hab_lookup_base[[col]])) {
#     hab_lookup_base[[col]] <- sapply(hab_lookup_base[[col]], function(x) paste(unlist(x), collapse = '|'))
#   }
# }
# 
# # Write the result to a CSV file
# write.csv(hab_lookup_base, './hab_lookup_tables/hab_lookup_uncertainty.csv', row.names = FALSE)


capacity_carbon_uncertainty(mm, 
                            studyArea,
                            res = myres,
                            use_hedges = FALSE, 
                            projectLog = projectLog,
                            runtitle = runtitle,
                            predict = 'low')






























