#include("dataProcessing.jl")

#trainSet = CSV.read("myTrainSet.csv");
#testSet  = CSV.read("myTestSet.csv");
#validSet = CSV.read("myValidSet.csv");
trainSet1 = copy(trainSet);
trainSet2 = copy(trainSet);

thresh = 0.001
catValCheck = 10^-42

model = fit(LinearModel, fm, trainSet)
modelSize = length(coeftable(model).cols[4])
rSquared = zeros(modelSize,1)
stdErrVal = zeros(modelSize,1)

trainSetNC1 = copy(trainSet);
trainSetNC2 = copy(trainSet);
trainSetNC3 = copy(trainSet);
trainSetNC4 = copy(trainSet);

# i=67, for best 1 variables
for i in 1:5
      pReal= coeftable(model).cols[4];
      pVals=[pReal[i] for i in 1:length(pReal)];  #Aug19Corr--> pReal[i].v
      pMaxVal, pMaxIndex = findmax(pVals); #second value is index
      modelNames = Meta.parse.(coefnames(model.mf));

      if pMaxIndex == 1 #ie as long as the intercept does not have highest pVal
		  pVals1=pVals[2:end];
		  pMaxVal1, pMaxIndex1 = findmax(pVals1);
		  modelNames = Meta.parse.(coefnames(model.mf));
		  	if 	(typeof(modelNames[pMaxIndex1+1]) == Symbol); #+1 is aded as the intercept is also added on to the calculation in model
		  		d = modelNames[pMaxIndex1+1];
		  		global predictorVars = predictorVars[ predictorVars .!=  d ];
			else
                   nameStringArray = coefnames(model.mf);
                   a = Meta.parse.(coefnames(model.mf))[pMaxIndex1+1];
                   symbolToDelete = a.args[2]; ## previosuly args[1]
                   include("fishersTest.jl");
                   responseVariable = Meta.parse("KWH");
                   deleteVars = symbolToDelete;
                   catVal = giveMeTheCcdf(newDf,responseVariable,deleteVars);
                    if catVal>catValCheck;
                         predictorVars = predictorVars[ predictorVars .!=  symbolToDelete ];
                    end

			end

      else

            if (typeof(modelNames[pMaxIndex]) == Symbol);	#ie, if its NOT Categorical
				c=modelNames[pMaxIndex];
				global predictorVars = predictorVars[ predictorVars .!=  c ];

            else			# if its an Expr (ie, CategoricalArray)
               nameStringArray = coefnames(model.mf);
               a = Meta.parse.(coefnames(model.mf))[pMaxIndex];
               symbolToDelete = a.args[2];
               include("fishersTest.jl");
               responseVariable = Meta.parse("KWH");
               deleteVars = symbolToDelete;
               catVal = giveMeTheCcdf(newDf,responseVariable,deleteVars);
                if catVal>catValCheck;
                     predictorVars = predictorVars[ predictorVars .!=  symbolToDelete ];
                end
      		end
      end

	  fm = term(responseVar) ~ sum(term.(vcat(1, predictorVars)))
      global model = fit(LinearModel, fm, trainSet);

      modelSize = size(predictorVars);
      predictModelNames = Meta.parse.(coefnames(model.mf));
      global predictModel = predict(model, testSet);
      global actualEnergy = testSet[!,:KWH];

      actualMean = mean(actualEnergy);
      firstOne = sum((actualEnergy.- actualMean).^2);
      secondOne = sum((predictModel.- actualMean).^2);
      rSquared[i] = secondOne/firstOne;
      stdErrVal[i] = sqrt(mean((actualEnergy-predictModel).^2));
end

#rSquaredVal = DataFrame([rSquaredZero;rSquared])
rSquaredVal = DataFrame(rSquared)
CSV.write("rSquaredVal1.csv",rSquaredVal)
#stdErrValDat = DataFrame([stdErrValZero;stdErrVal])
stdErrValDat = DataFrame(stdErrVal)
CSV.write("stdDevValStepWise1.csv",stdErrValDat)


actualEnergyValidSet =Array(validSet[:KWH])
predictEnergyTest =  predict(model, validSet)  # Selected model
#stdErrTest = std((actualEnergyTestSet - predictEnergyTest).^2) # QQQQ Ebby to define