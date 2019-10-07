# Created the CSV files and shorten dictionary replacement to the lines below
function csvAggregation(df)
	csvList = filter(x->occursin(".csv", x), readdir("./contextAggCSVs"))
	dfList = [CSV.read("./contextAggCSVs/"*x, header=false) for x in csvList]
	for (i, mDf) in enumerate(dfList)
	    col = Symbol(split(csvList[i],".")[1])
	    d = Dict(mDf[:,1] .=> mDf[:,2])
	    replace!( df[!, col], d...)
	end
end

# Shortened column replacements of -2 with 0 down to the 6 following lines...
function neg2Replace(df, cols)
	for i in cols
	    replace!(df[!,i], -2=>0)
	end
end

# Shortened remaining context agg down to 8 lines...
function aggregateCustom(df)
	ageAllDict = Dict(1=>3,2=>8,3=>13,4=>18,5=>23,6=>28,7=>33,8=>38,9=>43,10=>48,11=>53,12=>58,13=>63,14=>68,15=>73,16=>78,17=>83,18=>88,-2=>0);
	aColStr = [ Symbol("AGEHHMEMCAT"*string(i)) for i in 2:10 ]
	df[!, :MEANAGE] = [ (sum( [ ageAllDict[df[j, i]] for i in aColStr ] ) + df[j, :HHAGE]) / df[j, :NHSLDMEM] for j in 1:obs ]
	df[!,:LIGHTS] = df[!,:LGT12]*12 + df[!,:LGT4]*8 + df[!,:LGT1]*2.5
	replace!(df[!,:USECFAN], 4=>0)
	replace!(df[!,:Householder_Race], 7=>0)
end
