dfNames = names(newDf)
responseVar = Meta.parse("KWH")
predictorVars = dfNames[dfNames .!= responseVar]

#fm = Formula(responseVar, Expr(:call, :+, predictorVars...)) #works but has warning
fm = term(responseVar) ~ sum(term.(vcat(1, predictorVars)))
#fm = @formula(responseVar, (Expr(:call, :+, predictorVars...)))
