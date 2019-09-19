using StatsBase, DataFrames, GLM, CSV, Distributions, Random

cd("H:/bigDataPaper/Sep12/DataProcessing")
df = CSV.read("recs2009_public.csv", header=true, copycols=true);

obs = nrow(df)
newDf = DataFrame()

include("contextualAggregation.jl")
include("imputation.jl")

include("categoricalArrays.jl")

include("randomisation.jl")
(trainSet,testSet,validSet) = randomise(newDf,trainProp,validProp)

include("formula.jl")
