cd=("H:/DL_new_PAPER/December/workingModelDec/trial")
trainSetNC = CSV.read("myTrainNC.csv");


trainSetNC1 = copy(trainSetNC);
trainSetNC2 = copy(trainSetNC);
trainSetNC3 = copy(trainSetNC);
trainSetNC4 = copy(trainSetNC);

# NOTE:IMPORTANT >>> need to add this line before : responseVar = parse("whatever...")

function designMatrix(data, responseVar)
   obs, varLength = size(data)
   varNames = names(data)
   appendData = delete!(data,responseVar)
   predictorVars = varNames[varNames.!=responseVar]
   formula1 = Formula(responseVar, Expr(:call, :+, predictorVars...))
   designMatrix = [ones(obs) appendData]
end





# inputs : responseVar, data,and the excluded variable for the next model
    responseVariable = parse("KWH")
function giveMeTheCcdf(data,responseVariable,excludedVariables)

    responseVar = trainSetNC2[responseVariable]
    numObsFull, numVarsFull = size(trainSetNC2)
    variableNamesFull = names(trainSetNC2)
    modelFullDesignMatrix = Array(designMatrix(trainSetNC1,responseVariable))
    dependentVarsFull = variableNamesFull[variableNamesFull.!=responseVariable]
    modelFormulaFull = Formula(responseVariable, Expr(:call, :+ , dependentVarsFull...))
    modelFull = fit(LinearModel, modelFormulaFull, trainSetNC)
    betaFull = coef(modelFull)
    ssrModelFull = betaFull'*modelFullDesignMatrix'*responseVar
    mseModelFull = (responseVar'*responseVar-ssrModelFull)/(numObsFull-numVarsFull)


    data2= delete!(trainSetNC3,excludedVariables)
    numObsPart, numVarsPart = size(data2)
    variableNamesPart = names(data2)
    dependentVarsPart = variableNamesPart[variableNamesPart.!=responseVariable]
    modelFormulaPart = Formula(responseVariable, Expr(:call, :+ , dependentVarsPart...))
    modelPart = fit(LinearModel, modelFormulaPart, trainSetNC3)
    betaPart = coef(modelPart)
    modelPartDesignMatrix = Array(designMatrix(trainSetNC3,responseVariable) )
    ssrModelPart = betaPart'*modelPartDesignMatrix'*responseVar
    mseModelPart = (responseVar'*responseVar-ssrModelPart)/(numObsPart-numVarsPart)

    varDiff = numVarsFull - numVarsPart
    ssrDiff  = ssrModelFull - ssrModelPart
    f0Stat = (ssrDiff/varDiff)/mseModelFull
    distH0=FDist(varDiff, numObsFull-numVarsFull)
    ccdf(distH0,f0Stat)
end
