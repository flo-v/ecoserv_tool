
The follwoing guides are available:

install_EcoServR_R_package.R: How to install EcoServR
run_ES_models_with_package.R: How to run ecosytem services (ES) models on provided 
                              basemap and boundry .pgkg files using the ecoservR package
run_capacity_carbon_without_package.R: Hot to run the ES carbon capacity without relying on the ecoservR package directly
run_carbon_uncertainty.R: Does the same as run_capacity_carbon_without_package.R, but with made-up, toy uncertainties                              

Further R files are:
capacity_carbon.R: The original carbon capacity ES script, that quantifies the carbon storage capacity
capacity_carbon_florian.R: A version of capacity_carbon.R adapted & commented by Florian
capacity_carbon_uncertainty.R: The carbon capacity ES script, extended to allow list-columns in the hab_lookup table. 
                               List-columns represent literature estimate distributions per habitat.
                               Also the function has an attribute called "predict" which allows the choice of prediction.
                               low, mean, high can be chosen as values (low e.g. meaning choosing the minimum value for cabron capacity in the distribution)
                               "predict" can be set to "variablity" to show the degree of variability in the distributio for the habitats on the map


R files contain only unchanged (from ecoservR package) utility functions needed for ES run without ecoservR package:
fun_project_management.R
fun_cleaning.R

The following directories contain:
Abernethy: The for the area relevant basemap and boundry .pgkg files
hab_lookup_tables: Different habitat lookup tables that contain ES estimates for the different habitats according to Phase 1 habitat survey