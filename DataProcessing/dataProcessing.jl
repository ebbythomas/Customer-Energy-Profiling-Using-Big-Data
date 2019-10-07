using StatsBase, DataFrames, GLM, CSV, Distributions, Random#, Plots; pyplot()

cd("H:/GitHub")
df = CSV.read("recs2009_public.csv", header=true, copycols=true);

select!(df, Symbol.(CSV.read("myColsInclude.csv", header=false)[!,1]))
obs = nrow(df)

include("contextAgg.jl")
colNeg2 = [:ROOFTYPE, :PRKGPLC1, :BEDROOMS, :DEFROST, :SIZRFRI1, :NUMFREEZ, :HEATROOM, :ACROOMS, :USECENAC, :PROTHERMAC, :USECFAN]
csvAggregation(df)
neg2Replace(df, colNeg2)
aggregateCustom(df)

select!(df, Not(Symbol.(CSV.read("myColsDelete.csv")[!,1])))

include("imputation.jl")
colsToImpute = [:WALLTYPE, :ROOFTYPE, :BEDROOMS, :TYPERFR1, :AGERFRI1, :TVTYPE1]
imputation(df, colsToImpute)

include("randomization.jl")
trainProp = 0.75
validProp = 0.25
randomize(df, trainProp, validProp) #about 1 minute to run to here

# making columns categorical should be done in the stepwise regression part
include("stepReg.jl")
