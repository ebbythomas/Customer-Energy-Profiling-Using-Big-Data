Random.seed!(1);

trainProp = 0.75
validProp = 0.25 # validation will be 25% of the TEST prop (ie 25% of 1-trainProp)

trainRows = sample(1:obs, convert(Int, floor(obs*trainProp)), replace = false)
validRows = sample(setdiff(1:obs, trainRows), convert(Int, floor(obs*(1-trainProp)*validProp)), replace = false)
testRows = setdiff(1:obs, [trainRows; validRows])

trainSet = newDf[ trainRows, :];
testSet = newDf[ testRows, :];
validSet = newDf[ validRows, :];

#CSV.write("myTrainSet.csv", trainSet)
#CSV.write("myTestSet.csv", testSet)
#CSV.write("myValidSet.csv", validSet)