## Customer-Energy-Profiling-Using-Big-Data

 [Instructions](#instructions) are below.

A comprehensive guide for Power System Engineers to handle big/large datasets available to them so that these datasets provide better interpretability in applications such as demand management, asset management, ancillary services management, electricity market operations as well as with views to increase customer participation in electricity tariffing. Currently, there is a phenomenal amount of data available, however, the tools to convert such data into invaluable insights is lacking in the domain.  

The aim of this project is to improve the utilisation of data in power engineering scenario through data analytic methods. Here, statistical data processing techniques are discussed in a non-programmer perspective.  
Due to the ever increasing data availablility and higher requirement for computing speed, we rely on a relatively new tecnical computing language [Julia](https://julialang.org/), which has superior performance over the conventional environments.  

This project specifically aims to wring out the best 'n' variables that would contribute to the customer energy consumption. The energy operators/retailers, upon gathering these 'n' variables through survey systems as well as smart metering, can predict the energy consumption of a particular customer. Though this project is specifically aimed at customer energy profiling, the same can be used in various other applciations as discussed with minimal modifications to the code.  


**DATA PROCESSING:**  
The files associated with data processing are found within the folder 'DataProcessing'.  
In data processing, we start with a 12,083 x 940 raw dataset, where most of the variables are omitted through manual variable selection.  

The selected data is processed with a series of statistical procedures such as:  

* Contextual Aggregation  
* Randomisation and  
* Missing value imputation  

For contextual Aggregation, the user is required to generate the following files:-  
1. A CSV file that details all the variable names that need to be selected for the modelling, [myColsInclude.csv](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/blob/master/DataProcessing/myColsInclude.csv).  
2. A CSV file that details all the variable names that are required to be deleted after the contextual aggregation proces. These names are rising from the contextual aggregation process, and NOT all the variables that are not required for the model, [myColsDelete.csv](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/blob/master/DataProcessing/myColsDelete.csv).  
3. A folder of CSV files that details the Dictionary or the Mapping of all the variables (if required) that are included in the model, [contextAggCSVs](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/tree/master/DataProcessing/contextAggCSVs). Files are required only for variables that require mapping, and not for every single variable.  
The generation of the above mentioned CSV files are possibly the only data and user specific inputs to the functions. We have taken care to automate the rest of the process, thereby giving a generic method for data processing as well as modelling.


The single file [dataProcessing.jl](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/blob/master/DataProcessing/dataProcessing.jl) calls all its functions which perform:    
Contextual Aggregation - [contextAgg.jl](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/blob/master/DataProcessing/contextualAggregation.jl)   
Randomisation - [randomisation.jl](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/blob/master/DataProcessing/randomisation.jl)  
Missing value imputation - [imputation.jl](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/blob/master/DataProcessing/imputation.jl)  
The resulting datasets - train set, validation set and test set are carried on to the two methods of modeling and model selection - Stepwise regression and Lasso.  

**STEPWISE REGRESSION:**  
The files associated with stepwise regressoon are found within the folder 'StepwiseRegression'.  
Run the file [stepReg.jl](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/blob/master/StepwiseRegression/stepReg.jl) 
Here, we identify the best 'n' variables that contribute to the customer energy consumption and predict the energy consumption based on these variables though Stepwise Regression, one of the classic methods of statistics for model selection.  
To obtain the associations between variables, we perform Fishers Exact Test - realised here in the Julia file [fishersTest.jl](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/blob/master/StepwiseRegression/fishersTest.jl).  
The stepwiseRegression fits the model, as well as predicts the observations based on a specific validation set based on the fit model.

**LASSO REGRESSION:**  
The files associated with stepwise regressoon are found within the folder 'LassoRegression'.  
The file [lassoRegression.jl](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/blob/master/LassoRegression/lassoRegression.jl) executes the lasso regression taking in the lambda values given in the CSV file [lambdaVals.csv] (https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/blob/master/LassoRegression/lambdaVals.csv).  
Here as well, we identify the best 'n' variables that contribute to the customer energy consumption and predict the energy consumption based on these variables, but though Lasso, one of the recent developments in statistics for model selection.  
To obtain the associations between variables including the categorical variables, we utilse the package **Group Lasso** within Lasso.  
The lassoRegression fits the model, as well as predict the observations based on a specific validation set based on the fit model.

**DATA FILES:**  
All the data files used in this data processing, modeling and model selection process are found within the folder 'DataFiles'.  
The files within the Data_Files are,  
**recs2009_public**: This is the compressed raw file from the Residential Energy Consumption Survey, that gives information about the customer energy usage. The Data is published by Energy Information Administration (EIA), a governmental body of the United States of America. The survey has 12083 respondents with 940 variables (588 excluding imputation flag). It is this file that is fed at the start of data processing stages.  
**recs2009_public_codebook**: This is the CSV file that holds the codebook or the instrauciton manual for reading the data file "recs2009_public.csv". This file is available to download with the data published with the EIA.   
**trainSet.csv**: This is the train dataset that is obtained after the data processing stages. It is this dataset that is fed to train the model in both stepwise regression as well as Lasso.  
**validSet.csv**: This is the validation dataset that is obtained after the data processing stages. It is this dataset that is fed to validate the model in both stepwise regression as well as Lasso.  
**testSet.csv**: This is the test dataset that is obtained after the data processing stages. It is this dataset that is fed to test the model accuracy in both stepwise regression as well as Lasso.

---

Instructions
------------

**Data Processing**  
1. Run the file [dataProcessing.jl](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/blob/master/DataProcessing/dataProcessing.jl). This will feed in the raw data [recs2009_public](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/blob/master/DataSets/recs2009_public.7z),  as well as call all other data processing functions 
2. At the end of data processing, we will get three files - train set, (**train.csv**) validation set (**valid.csv**) and test set (**test.csv**)  
3. Note that this code block has been designed so that it is appropriate for use in a general use case. However, contextual aggregation performed in 'contextAgg.jl' file is specifically suited for the specific dataset as well as the application. This code block, henceforth will vary widely depending on the dataset encountered as well as the application.  

 **Stepwise Regression** 
 1. Run the file [stepReg](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/tree/master/StepwiseRegression).   
 2. At the start of stepwise regression, we import train, validation and test sets obtained at the end of data prcessing.  
 3. Varying values of 'i' for the iteration yields different models with different number of variables.  
 4. After complete iteration so that only the most significant one variable remains in the model, we proceed towards the graph to obtain the knee point. Then the loop has to be initiated again to obtain the best variables identified at the knee point.  
 5. The association between models (variables) are found out using [fishersTest.jl](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/blob/master/StepwiseRegression/fishersTest.jl), which is called within the file.
 
  **Lasso Regression**  
 1. Run the file [lassoRegression.jl](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/tree/master/LassoRegression). This will import the pre-determined lambda values from the file [lambdaVals.csv](https://github.com/ebbythomas/Customer-Energy-Profiling-Using-Big-Data/blob/master/LassoRegression/lambdaVals.csv).   
 2. At the start of stepwise regression, we import train, validation and test sets obtained at the end of data prcessing.  
  3. After complete iteration so that only the most significant one variable remains in the model, we proceed towards the graph to obtain the knee point. Then the loop has to be initiated again to obtain the best variables identified at the knee point.  
 4. The association between models (variables) are found out using **Group Lasso**.  
 5. While using RCall, remember to install the packages "gglasso" and "dplyr" at the first run.



More Information About the Paper
------------
These code are developed as a part of the Paper "Customer Energy Profiling using Julia Lang with Big Data", which soon will be submitted to the journal IEEE Transacrions in Big Data.  
The authors request users to cite the paper as well as get back to us if you find any incompatibilities within the codes.
