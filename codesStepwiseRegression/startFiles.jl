using StatsBase, DataFrames, GLM, CSV, Distributions

#cd=("H:/DL_new_PAPER/December/workingModelDec/trial")
df = readtable("recs2009_public.csv")

newDf= DataFrame()
obs=size(df)[1];

include("contextualAggregation.jl")

varTotal = size(newDf)[2]

#include("randomisation.jl")

include("imputation.jl")
include("categoricalArrays.jl")

include("formula.jl")

#CSV.write("myTrain.csv", trainSet)

#CSV.write("myTrainNC.csv", trainSet)
#CSV.write("myTestNC.csv", testSet)
