
trainSetCS = CSV.read("myTrainSet.csv");
trainSetCS1 = copy(trainSetCS);


# NOTE:IMPORTANT >>> need to add this line before : responseVar = parse("whatever...")

function designMatrix(data, responseVar)
   obs, varLength = size(data)
   varNames = names(data)
   appendData = delete!(data,responseVar)
   predictorVars = varNames[varNames.!=responseVar]
   formula1 = term(responseVar) ~ sum(term.(vcat(1, predictorVars)))
   designMatrix = [ones(obs) appendData]
end





# inputs : responseVar, data,and the excluded variable for the next model
responseVariable = Meta.parse("KWH")
function giveMeTheCcdf(data,responseVariable,excludedVariables)

    responseVar = trainSetCS[!,responseVariable]
    numObsFull, numVarsFull = size(trainSetCS)
    variableNamesFull = names(trainSetCS)
    dependentVarsFull = variableNamesFull[variableNamesFull.!=responseVariable]
	#modelFormulaFull = Formula(responseVariable, Expr(:call, :+ , dependentVarsFull...))
	modelFormulaFull = term(responseVariable) ~ sum(term.(vcat(1, dependentVarsFull)))
	modelFull = fit(LinearModel, modelFormulaFull, trainSetCS)
	modelFullDesignMatrix = Matrix(designMatrix(trainSetCS,responseVariable))
    betaFull = coef(modelFull)
    ssrModelFull = (betaFull')*(modelFullDesignMatrix')*responseVar # use copy to avoid no method for adjoint
    mseModelFull = (responseVar'*responseVar-ssrModelFull)/(numObsFull-numVarsFull)


    data2= delete!(trainSetCS1,excludedVariables)
    numObsPart, numVarsPart = size(data2)
    variableNamesPart = names(data2)
    dependentVarsPart = variableNamesPart[variableNamesPart.!=responseVariable]
    #modelFormulaPart = Formula(responseVariable, Expr(:call, :+ , dependentVarsPart...))
	modelFormulaPart = term(responseVariable) ~ sum(term.(vcat(1, dependentVarsPart)))
	modelPart = fit(LinearModel, modelFormulaPart, trainSetCS1)
    betaPart = coef(modelPart)
    modelPartDesignMatrix = Matrix(designMatrix(trainSetCS1,responseVariable))
    ssrModelPart = betaPart'*modelPartDesignMatrix'*responseVar
    mseModelPart = (responseVar'*responseVar-ssrModelPart)/(numObsPart-numVarsPart)

    varDiff = numVarsFull - numVarsPart
    ssrDiff  = ssrModelFull - ssrModelPart
    f0Stat = (ssrDiff/varDiff)/mseModelFull
    distH0=FDist(varDiff, numObsFull-numVarsFull)
    ccdf(distH0,f0Stat)
end
