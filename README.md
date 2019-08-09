## Customer-Energy-Profiling-Using-Big-Data
A comprehensive guide to deal with big data encountered in power systems, as well as to an initiative in facilitating customer
behavior profiling for customer participation in Electricity Markets.  



**Stepwise Regression:**  

Through these codes, we have been able to identify the best 'n' variables that contribute to the customer energy consumption and predict the energy consumption based on these variables.

The description of the code files are:  
**loadForecasting.jl:**   The main Julia file. The user may run just this file.   
**categoricalArrays.jl:** The file where Categorical columns are identified and set different from that of teh numerical columns  
**contextualAggregation.jl:** The file in which contextual aggregation is done (with normalisation as required). This part can seldom be automated in a standard data processing procedure.  
**formula.jl:**           The file where the formula update is done for every successive iteration of the Julia Regression model.   
**imputation.jl:**        The file where the imputtaion of the missing values are done.  
**fishersTestXle.jl:**    The function that performs Fishers Exact Test. Upon giving two sets of variables - Categorical or Numerical, this function provides the p-value between these sets,
  which could form the basis of finding out the significance of selected variables to a model.  
**startFiles.jl:**        These are the colleciton of the above files. Just saves some space while you perform the loadForecasting.jl.  

**Prior to Stepwise Regression:**
For the stepwise regression, the codes incorporated here works on Julia, and utilizes packages of DataFrames, CSV, StatsBase, DIstributions and GLM.  


**Lasso Regression:**  

Through these codes, we have been able to identify the best 'n' variables that contribute to the customer energy consumption and predict the energy consumption based on these variables.
Teh description of the code files are:  
**loadForecastingLasso.jl:** The Julia file that performs feature selection.

**Prior to Lasso:**
For the Lasso regression, the codes incorporated here works on Julia, and utilizes package of RCall that is used to call R functions to Julia.  
  While using RCall, remember to install the packages "gglasso" and "dplyr" at the first run.

**About the Paper:**  
These codes are developed as a part of the Paper "Customer Energy Profiling using Julia Lang with Big Data", which is submitted to XXX Journal.  
Please go through the paper for more clarity. We request users to cite the paper as well as get back to us if you find any incompatibilities within the codes.
