function imputation(df, impCols)
   varTotal = ncol(df)
   for i in impCols
      vals = setdiff(df[!,i], 0)
      proportions = [ count( x->(x==i), df[!,i]) for i in impCols ] # verify via sum(proportions.*possibleValues) == sum(df[c])
      weightVals = Weights(proportions)

      for j in 1:obs
      	if df[j, i] == 0
      		df[j, i] = sample(vals, weightVals)
      	end
      end
   end
end
