dfNames = names(newDf)
responseVar = Meta.parse("KWH")
predictorVars = dfNames[dfNames .!= responseVar]
fm = Formula(responseVar, Expr(:call, :+, predictorVars...)) #works but has warning