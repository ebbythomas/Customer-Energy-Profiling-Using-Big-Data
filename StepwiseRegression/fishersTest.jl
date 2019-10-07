function fisherTest(predVars, exclVar, nVarsF, SSRmodF)
	# Partial model - less exclVar
    predVarsP = predVars[predVars .!= exclVar]
	fmP = term(respVar) ~ sum(term.(vcat(1, predVarsP)))
	modP = fit(LinearModel, fmP, train)
	nVarsP = length(coef(modP)) - 1
    SSRmodP = sum((y_T - predict(modP, train)).^2)

	# Check if partial model is nested in full
	fStat = ( SSRmodP-SSRmodF/(nVarsF-nVarsP) ) /
			( SSRmodF/(nRows-nVarsF) )
    distH0 = FDist(nVarsF-nVarsP, nRows-nVarsF)
    ccdf(distH0, fStat)
end
