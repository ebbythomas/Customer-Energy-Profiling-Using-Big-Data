colsCat = [:WALLTYPE;:ROOFTYPE;:PRKGPLC1;:STOVENFUEL;:DEFROST;:TOASTER;:FUELFOOD;:COFFEE;:TYPERFR1;:TREESHAD;:TVTYPE1;:INTERNET;:WELLPUMP;:AQUARIUM;:STEREO;:MOISTURE;:FUELH2O;:PROTHERMAC;:RECBATH;:SLDDRS;:USENG;:USESOLAR;:ELWARM;:ELWATER;:ELFOOD;:EMPLOYHH;:Householder_Race;:EDUCATION;:RETIREPY;:POVERTY150]

for i in colsCat
	newDf[!,i] = CategoricalArray(newDf[!,i]) # !!!! NOTE: fix how to assign as ordinal vs categorical?
end

# Here, the variable :ELCOOL, # COOLTYPE has been deleted
