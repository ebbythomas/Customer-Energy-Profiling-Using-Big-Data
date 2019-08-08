cd=("C:/Users/Ebby")
include("startFiles.jl")

trainSetNC = CSV.read("myTrainNC.csv");
trainSetNC1 = copy(trainSetNC);
trainSetNC2 = copy(trainSetNC);
trainSet = copy(trainSetNC);
testSet = CSV.read("myTestNC.csv")
validSet = CSV.read("myValid.csv")


thresh = 0.001
catValCheck = .000000000000000000000000000000000000000001
#pMax = (1,1) #initialization - assume that we can eliminate at least one variable

#model = glm(fm,trainSet,Normal(),IdentityLink())
model = fit(LinearModel, fm, trainSet)
modelNC = fit(LinearModel, fm, trainSetNC)

predictModel1 = predict(model, validSet)
actualEnergy1 = Array(validSet[:KWH])
actualMean1 = mean(actualEnergy1)
firstOne1 = sum((actualEnergy1.-actualMean1).^2)
secondOne1 = sum((predictModel1.- actualMean1).^2)
rSquaredZero = secondOne1/firstOne1
stdErrValZero = std((predictModel1 - actualEnergy1).^2)


#hell = zeros(150,1)
#for k in 1:2
modelSize = 100
sumSquares = zeros(70,1)
rSquared = zeros(100,1)
stdErrVal = zeros(100,1)
#while modelSize >30
# i=48 for best 20 avriables
# i=38 for best 30 variables
# i=58 for best 10 variables
# i=65, for best 5 variables
# i=66, for best 4 variables
# i=67, for best 1 variables  | for i=40, we get the knee point

for i in 1:39  # This has 28 variablres retained in the system. This is found to be the knee point
      pReal= coeftable(model).cols[4]
      pVals=[pReal[i].v for i in 1:length(pReal)]
      pMaxVal, pMaxIndex = findmax(pVals) #second value is index
      modelNames = parse.(coefnames(model.mf))

      if pMaxIndex == 1 #ie as long as the intercept does not have highest pVal
		  pVals1=pVals[2:end]
		  pMaxVal1, pMaxIndex1 = findmax(pVals1)
		  modelNames = parse.(coefnames(model.mf))
		  	if 	(typeof(modelNames[pMaxIndex1+1]) == Symbol) #+1 is aded as the intercept is also added on to the calculation in model
		  		d = modelNames[pMaxIndex1+1]
		  		predictorVars = predictorVars[ predictorVars .!=  d ]
			else
                   nameStringArray = coefnames(model.mf);
                   a = parse.(coefnames(model.mf))[pMaxIndex1+1]
                   symbolToDelete = a.args[1]
                   include("fishersTestXle.jl")
                   responseVariable = parse("KWH")
                   deleteVars = symbolToDelete
                   catVal = giveMeTheCcdf(df,responseVariable,deleteVars)
                    if catVal>catValCheck
                         predictorVars = predictorVars[ predictorVars .!=  symbolToDelete ]
                    end

			end

      else

            if (typeof(modelNames[pMaxIndex]) == Symbol)	#ie, if its NOT Categorical
				c=modelNames[pMaxIndex]
				predictorVars = predictorVars[ predictorVars .!=  c ]

            else			# if its an Expr (ie, CategoricalArray)
               nameStringArray = coefnames(model.mf);
               a = parse.(coefnames(model.mf))[pMaxIndex]
               symbolToDelete = a.args[1]
               include("fishersTestXle.jl")
               responseVariable = parse("KWH")
               deleteVars = symbolToDelete
               catVal = giveMeTheCcdf(df,responseVariable,deleteVars)
                if catVal>catValCheck
                     predictorVars = predictorVars[ predictorVars .!=  symbolToDelete ]
                end
      		end
      end


      fm = Formula(responseVar, Expr(:call, :+, predictorVars...))
      #model = glm(fm,trainSet,Normal(),IdentityLink())
      model = fit(LinearModel, fm, trainSet)




      modelSize = size(predictorVars)
      predictModelNames = parse.(coefnames(model.mf))
      global predictModel = predict(model, validSet)
      global actualEnergy = validSet[:KWH]


      actualMean = mean(actualEnergy)
      firstOne = sum((actualEnergy - actualMean).^2)
      secondOne = sum((predictModel - actualMean).^2)
      rSquared[i] = secondOne/firstOne
      stdErrVal[i] = std((predictModel - actualEnergy).^2)
end


actualEnergyTestSet =Array(testSet[:KWH])
predictEnergyTest =  predict(model, testSet)
stdErrTest = std((actualEnergyTestSet - predictEnergyTest).^2)  # This is the one we want

predictEnergyTest = DataFrame(predictEnergyTest)
actualEnergyTestSet = DataFrame(actualEnergyTestSet)
CSV.write("predictedtestEnergyDataset.csv",predictEnergyTest)
CSV.write("actualTestEnergyDataset",actualEnergyTestSet)



rSquaredVal = DataFrame([rSquaredZero;rSquared])
CSV.write("rSquaredVal.csv",rSquaredVal)
stdErrValDat = DataFrame([stdErrValZero;stdErrVal])
CSV.write("stdDevValStepWise.csv",stdErrValDat)


#NOTE look at the predict function with the given number of variables.
#NOTE Look at the accuracy and see if its getting better..?
#NOTE Look at the RSquared as well.
#NOTE RSquared= (ObsActual - ObsPredict)^2




# a = Array{Int}(newDfNC[:WALLTYPE])
# b = Array{Int}(unique(newDfNC[:WALLTYPE]))
# pCounts = counts(a,0:maximum(b))


####### Rough hacky code that could be useful later
# # also can use "parse.coeftable(model).rownms"
# parse.coefnames(model.mf)
# coefnames(model.mf)



########################### <<<<<<<<<<<<<<<< NOTE >>>>>>>>>>>>>>>> #######################
# check = df[:ELCOOL]
# one = Array{Int}(df[:ELCOOL])
# countEntry = counts(one,0:1)
# ifany = obs- (countEntry[1]+countEntry[2])
########################### <<<<<<<<<<<<<<<< NOTE >>>>>>>>>>>>>>>> #######################


#signout>>>>>>>>>  may9afterMeeting

a=20
b=30
while a>0
    b=b+a
    a=a-1
end
