## Customer-Energy-Profiling-Using-Big-Data

A comprehensive guide in Julia to deal with big data encountered in power systems, as well as to an initiative in facilitating customer
behavior profiling for customer participation in Electricity Markets.  
Though specifically aimed at customer energy profiling, this work addresses the data processing issues often faced in teh power systems industry.  


**DATA PROCESSING:**  
The files associated with data processing is found within the folder 'Data_Processing'.  
In data processing, we start with a 12083 X 940 raw data, where most of the variables are omitted through manual variable selection.  
The selected data is processed with a series of statistcial procedures such as  
Contextual Aggregation  
Categorical Arrays definition  
Randomisation and  
Missing value imputation  
All these procedures are performed in separate files so that users could use them as required and omit certain steps if necessary.  
The one single file **dataprocessing.jl** calls all its sub files which does,  
Contextual Aggregation - **contextualAggregation.jl**  
Categorical Arrays definition - **categoricalArrays.jl**  
Randomisation - **randomisation.jl**  
Missing value imputation - **imputation.jl**  
The resulting datasets - train set, validation set and test set are carried on to the two methods of modeling and model selection - Stepwise regression and Lasso.  

**STEPWISE REGRESSION:**  
The files associated with stepwise regressoon is found within the folder 'Stepwise_Regression'.  
Here, we identify the best 'n' variables that contribute to the customer energy consumption and predict the energy consumption based on these variables though Stepwise Regression, one of the classic methods of statistics for model selection.  
To obtain the associations between variables, we perform Fishers Exact Test - realised here as a stand alone function **fishersTest.jl**.  
The stepwiseRegression fits the model, as well as predict the observations based on a specific validation set based on the fit model.


**LASSO REGRESSION:**  
The files associated with stepwise regressoon is found within the folder 'Lasso_Regression'.  
Here as well, we identify the best 'n' variables that contribute to the customer energy consumption and predict the energy consumption based on these variables, but though Lasso, one of the recent developments in statistics for model selection.  
To obtain the associations between variables including teh categorical variables, we utilse the package **Group Lasso** within Lasso.  
The lassoRegression fits the model, as well as predict the observations based on a specific validation set based on the fit model.

**DATA FILES:**  
All the data files used in this data processing, modeling and model selection process are found within the folder 'Data_Files'.  
The files within the Data_Files are,  
**recs2009_public**: This is the compressed raw file from the Residential Energy Consumption Survey, that gives information about the customer energy usage. The Data is published by Energy Information Administration (EIA), a governmental body of the United States of America. The survey has 12083 respondents with 940 variables (588 excluding imputation flag). It is this file that is fed at the start of data processing stages.  
**trainSet.csv**: This is the train dataset that is obtained after the data processing stages. It is this dataset that is fed to train the model in both stepwise regression as well as Lasso.  
**validSet.csv**: This is the validation dataset that is obtained after the data processing stages. It is this dataset that is fed to validate the model in both stepwise regression as well as Lasso.  
**testSet.csv**: This is the test dataset that is obtained after the data processing stages. It is this dataset that is fed to test the model accuracy in both stepwise regression as well as Lasso.

**INSTRUCTIONS:**  

**Data Processing**  
1. Feed in the raw data, recs2009_public.csv  
2. Run the file **dataProcessing.jl**. This will call other files on to it.  
3. At the end of data processing, we will get three files - train set, (**trainSet.csv**) validation set (**validSet.csv**) and test set (**testSet.csv**)  

 **Stepwise Regression**  
 1. At the start of stepwise regression, we import train, validation and test sets obtained at the end of data prcessing.  
 2. Varying values of 'i' for the iteration yields different models with different number of variables.  
 3. After complete iteration so that only the most significant one variable remains in the model, we proceed towards the graph to obtain the knee point. Then the loop has to be initiated again to obtain the best variables identified at the knee point.  
 4. The association between models (variables) are found out using **fishersTest.jl**, which is called within the file.
 
  **Lasso Regression**  
 1. At the start of stepwise regression, we import train, validation and test sets obtained at the end of data prcessing.  
 2. We utilise the 'RCall' packake in Julia to import R functions directly to Julia.
 3. After complete iteration so that only the most significant one variable remains in the model, we proceed towards the graph to obtain the knee point. Then the loop has to be initiated again to obtain the best variables identified at the knee point.  
 4. The association between models (variables) are found out using **Group Lasso**.  
 5. While using RCall, remember to install the packages "gglasso" and "dplyr" at the first run.

**MORE INFORMATION/ ABOUT THE PAPER:**  
These code are developed as a part of the Paper "Customer Energy Profiling using Julia Lang with Big Data", which is submitted to XXX Journal.  
The authors request users to cite the paper as well as get back to us if you find any incompatibilities within the codes.
