using StatsBase, DataFrames, GLM, CSV, Distributions, Random

cd(raw"C:/Users/Ebby/Desktop/Aug19Codes/DataProcessing")
df = CSV.read("recs2009_public.csv", header=true, copycols=true);
obs = size(df)[1]
newDf = DataFrame()

include("contextualAggregation.jl")

include("imputation.jl")
include("categoricalArrays.jl")
include("randomisation.jl")

include("formula.jl")
