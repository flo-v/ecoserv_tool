###
# Script by Florian Vetsch
# 
# R version 4.3.0 (2023-04-21 ucrt) -- "Already Tomorrow"
# Platform: x86_64-w64-mingw32/x64 (64-bit)
###

# Download R

# Download R-tools matching to R version

# Download R Studio

# Download GEOS (needed for 'rgeos' and 'sf' R packages)

# I am using GEOS 3.11.2, GDAL 3.8.2, PROJ 9.3.1 here
# (possibly GDAL 3.8.2, PROJ 9.3.1 have to be downloaded as well)


# execute this script in a new R project
# (https://www.r-bloggers.com/2020/01/rstudio-projects-and-working-directories-a-beginners-guide/)

rm(list=ls())

install.packages('remotes') # if not installed yet
library(remotes) # functions used here come also with devtools but it has more dependencies

# packages ‘maptools’, ‘rgeos’, ‘rgdal’ are no longer on CRAN repository
# and thus need to be installed from archive
remotes::install_version("rgdal",version="1.6-7")
remotes::install_version("maptools",version="1.1-8")
remotes::install_version("rgeos",version="0.6-4")

# next do either A or B

### A) install from downloaded zip file ###
# download EcoServR package ( ecoserv_tool) from 
# https://github.com/ecoservR/ecoserv_tool?tab=readme-ov-file by clicking on 
# "Code" and then "Dowlaod zip"

# rename .zip folder to EcoServR.zip

# change path to your specific path
path_to_dowloaded_zip_package <- 
  "Your/path/to/EcoServR.zip"

remotes::install_local(path_to_dowloaded_zip_package)
### A end


### B) install directly from GitHub ###
#options(timeout=99999999999999999999) # increase timeout as the package is big
#remotes::install_github("ecoservR/ecoserv_tool")
### B end


# If Console asks the following:
# These packages have more recent versions available.
# It is recommended to update all of them.
# Enter 1 for yes

# If dialog box pops up and asks if you want to install from source, click yes

# If the install  (installation of package had non-zero exit status) 
# because dependencies (required packages) are not available
# install them from archive as the ones above (line 30)


# ! take-care the package is always called ecoservR, regardless of how .zip folder is renamed
# need to load it with the proper name:
library(ecoservR) # try if loading of package is successful

