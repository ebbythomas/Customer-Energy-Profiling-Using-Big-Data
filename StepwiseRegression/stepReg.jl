using StatsBase, DataFrames, GLM, CSV, Distributions, Random, Plots

function stepwiseRegression()
	include("fishersTest.jl")
	global respVar = Meta.parse("KWH")
	colsCat = [:WALLTYPE, :ROOFTYPE, :PRKGPLC1, :STOVENFUEL, :DEFROST, :TOASTER, :FUELFOOD, :COFFEE, :TYPERFR1, :TREESHAD, :TVTYPE1, :INTERNET, :WELLPUMP, :AQUARIUM, :STEREO, :MOISTURE, :FUELH2O, :PROTHERMAC, :RECBATH, :SLDDRS, :USENG, :USESOLAR, :ELWARM, :ELWATER, :ELFOOD, :EMPLOYHH, :Householder_Race, :EDUCATION, :RETIREPY, :POVERTY150]

	global train = CSV.read("./trainTestData/train.csv")
	valid  = CSV.read("./trainTestData/test.csv") # QQQQ change name of FILE to VALID
	categorical!(train, colsCat)
	categorical!(valid, colsCat)

	totPredVars = ncol(train)-1 # 68 predictor columns
	# length=69, from no vars eliminated (0) to only intercept (68), shifted 1 because of 1 indexing
	rSq     = zeros(totPredVars+1)
	stdErr  = zeros(totPredVars+1)
	eliVars = Array{Symbol}(undef, totPredVars)
	eliPval = zeros(totPredVars)

	global nRows = nrow(train)
	global y_T = train[:, respVar]
	y_bar_T = mean(y_T)
	SST_T = sum((y_T .- y_bar_T).^2)

	y_V = valid[:, respVar]
	y_bar_V = mean(y_V)
	SST_V = sum((y_V .- y_bar_V).^2)

	dfNames = names(train)
	# Note MUST use global keyword before and within the loop
	global predVars = dfNames[dfNames .!= respVar]

	# iterate until 1 predVar left, ie from 1 to 67, as fisher fails when it tries to remove it
	for i in 1:totPredVars-1
		# Calculate full model, ie use train to get betas
		fmF = term(respVar) ~ sum(term.(vcat(1, predVars)))
		modF = fit(LinearModel, fmF, train)
		nVarsF = length(coef(modF)) - 1
		SSRmodF = sum((y_T - predict(modF, train)).^2)

		# Use model and valid set to calc rSq and stdErr
		y_hat_V = predict(modF, valid)
		SSR_V = sum((y_V - y_hat_V).^2)
		rSq[i] = 1 - SSR_V / SST_V
		stdErr[i] = sqrt(mean((y_V - y_hat_V).^2))

		if length(predVars) == 1
			break # break if only one variable remaining, fisher test will fail otherwise
		end

		# NOTE: the single line below can be used to run stepwise regression, but
		# treating all columns as NON categorical. In this case use the
		# below to find pVals, and comment out the cat! lines above.
		# It can also be used to check functionality
		# pVals = coeftable(modF).cols[4][2:end]

		# Fisher test and partial model, use train for betas
		# QQQQ put the below line back for final categorical run:
		pVals = [ Base.invokelatest(fisherTest, predVars, p, nVarsF, SSRmodF) for p in predVars ]
		pMaxVal, pMaxIndx = findmax(pVals)
		symbToDel = predVars[pMaxIndx]
		global predVars = predVars[predVars .!= symbToDel]

		eliVars[i] = symbToDel
		eliPval[i] = pMaxVal
		println(symbToDel, " ", pMaxVal)
	end

	# run numbers on model with only one predvar and intercept
	i = 68
	fmF = term(respVar) ~ sum(term.(vcat(1, predVars))) # should only be 1 predvar
	modF = fit(LinearModel, fmF, train)
	nVarsF = length(coef(modF)) - 1
	SSRmodF = sum((y_T - predict(modF, train)).^2)
	# Use model and valid set to calc rSq and stdErr
	y_hat_V = predict(modF, valid)
	SSR_V = sum((y_V - y_hat_V).^2)
	rSq[i] = 1 - SSR_V / SST_V
	stdErr[i] = sqrt(mean((y_V - y_hat_V).^2))
	symbToDel = predVars[1]
	pMaxVal = coeftable(modF).cols[4][2]
	eliVars[i] = symbToDel
	eliPval[i] = pMaxVal
	println(symbToDel, " ", pMaxVal)

	global predVars = predVars[predVars .!= symbToDel]
	i = 69
	fmF = term(respVar) ~ sum(term.(vcat(1, predVars))) # PredVars should be empty
	modF = fit(LinearModel, fmF, valid) # QQQQ NOTE technically model fit should be on test..but then rsq!=0
	y_hat_V = coef(modF)[1] # only the intercept remains
	SSR_V = sum( (y_V .- y_hat_V).^2 )
	rSq[i] = 1 - SSR_V / SST_V
	stdErr[i] = sqrt(mean((y_V .- y_hat_V).^2))

	# Finally plot the results, from 0 removed, to only intercept (ie 68 removed)
	p1 = plot(0:totPredVars, stdErr, ylims=(4800,8800), title="standard Error")
	p2 = plot(0:totPredVars, rSq, title="R-squared value")#, ylims=(0.25, 0.65))
	plot(p1, p2, size=(800,400))
	savefig("fisherStepRegression.pdf")

	CSV.write("./results/eliminatedVariablesNonCat.csv", DataFrame(eliminatedVariables=eliVars))
	CSV.write("./results/elimPvalsNonCat.csv", DataFrame(elimPvals=eliPval))
	CSV.write("./results/rsquaredNonCat.csv", DataFrame(rsquared=rSq))
	CSV.write("./results/standErrNonCat.csv", DataFrame(standErr=stdErr))
end
stepwiseRegression()


# run on  test set at the end for final check
# CSV.write("stepFishGC.csv")
# Runtime is about 80 seconds for 62 vars... so about 50mins for 2278 total

# Our R squared and std error should all be done from VALID SET,
# the training set is used to find the pVals and eliminate variables
# (we have also confused the words test and valid...test is done at end, valid is used to get yhats as part of the stepwise process)

# NOTE CHANGE 2 VALID QQQQ get beta from train, and y_hat predictions from VALID
