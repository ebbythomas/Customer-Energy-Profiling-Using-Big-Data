colsToImpute = [:WALLTYPE; :ROOFTYPE; :BEDROOMS; :TYPERFR1; :AGERFRI1; :TVTYPE1]

for i in colsToImpute
   possibleValues = setdiff(newDf[i],0)
   proportions = [ count( x->(x==i), newDf[i]) for i in possibleValues ] # can verify by checking sum(proportions.*possibleValues) == sum(df[c])
   weightVect = Weights(proportions)

   for j in 1:varTotal
   	if newDf[i][j] == 0
   		newDf[i][j] = sample(possibleValues,weightVect)
   	end
   end

end
