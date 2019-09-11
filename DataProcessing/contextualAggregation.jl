#YearMade
newDf[!,:YEARMADERANGE] = df[!,:YEARMADERANGE];

newDf[!,:WALLTYPE] = df[!,:WALLTYPE];
#now impute all the zero values.

#rooftype
newDf[!,:ROOFTYPE]=df[!,:ROOFTYPE]
for i=1:obs
	if newDf[!,:ROOFTYPE][i]==-2
	   newDf[!,:ROOFTYPE][i]=0
   end
end

#bedrooms
newDf[!,:BEDROOMS] = df[!,:BEDROOMS]
for i=1:obs
	if newDf[!,:BEDROOMS][i]==-2
	   newDf[!,:BEDROOMS][i]=0
   end
end

#Number of full bathrooms and half bathrooms :- Variable name changed in the new one
newDf[!,:NCOMBATH] = df[!,:NCOMBATH]
newDf[!,:NHAFBATH] = df[!,:NHAFBATH]

#attached garage
newDf[!,:PRKGPLC1]=df[!,:PRKGPLC1]
for i=1:obs
	if newDf[!,:PRKGPLC1][i]==-2
	   newDf[!,:PRKGPLC1][i]=0
   end
end

#stovefuel was adjusted so that there is only two values
newDf[!,:STOVENFUEL]=df[!,:STOVENFUEL]
for i=1:obs
	if newDf[!,:STOVENFUEL][i] != 5
	   newDf[!,:STOVENFUEL][i]=0
   else  newDf[!,:STOVENFUEL][i]=1
   end
end

# ovenuse frequency of ovenuse
ovenUseDict = Dict(-2=>0,0=>0,1=>1,2=>16,3=>9,4=>6,5=>3,6=>1)
newDf[!,:OVENUSE] = df[!,:OVENUSE]
for i in 1:obs
	newDf[!,:OVENUSE][i] = ovenUseDict[df[!,:OVENUSE][i]]
end

#AMTMICRO : microwave frequency used
amtMicroDict = Dict(-2=>0,1=>4,2=>3,3=>2,4=>1)
newDf[!,:AMTMICRO] = df[!,:AMTMICRO]
for i in 1:obs
	newDf[!,:AMTMICRO][i] = amtMicroDict[df[!,:AMTMICRO][i]]
end

#MW used for defrosting>
newDf[!,:DEFROST]=df[!,:DEFROST]
for i=1:obs
	if newDf[!,:DEFROST][i]==-2
	   newDf[!,:DEFROST][i]=0
   end
end

#no change in the toaster, Categorical
newDf[!,:TOASTER] = df[!,:TOASTER]

#Number of meals cooked put in weeks :- Ordinal
nummealDict = Dict(0=>0,1=>18,2=>10,3=>7,4=>5,5=>3,6=>1)
newDf[!,:NUMMEAL] = df[!,:NUMMEAL]
for i in 1:obs
	newDf[!,:NUMMEAL][i] = nummealDict[df[!,:NUMMEAL][i]]
end

#Fuel used for cooking - electricity or not
fuelfoodDict = Dict(0=>0, 1=>0,2=>0,21=>0,-2=>0,5=>1)
newDf[!,:FUELFOOD] = df[!,:FUELFOOD]
for i in 1:obs
	newDf[!,:FUELFOOD][i] = fuelfoodDict[df[!,:FUELFOOD][i]]
end

#Coffee maker used - no change needed, Categorical
newDf[!,:COFFEE]=df[!,:COFFEE]

#Number of fridge
newDf[!,:NUMFRIG]=df[!,:NUMFRIG]

#typefridge1
typefriDict = Dict(-2=>0,3=>0,4=>0,1=>1,5=>2,21=>3,22=>4,23=>5)
newDf[!,:TYPERFR1] = df[!,:TYPERFR1]
for i in 1:obs
	newDf[!,:TYPERFR1][i] = typefriDict[df[!,:TYPERFR1][i]]
end

#sizeFridge
newDf[!,:SIZRFRI1]=df[!,:SIZRFRI1]
for i=1:obs
	if newDf[!,:SIZRFRI1][i]==-2
	   newDf[!,:SIZRFRI1][i]=0
   end
end

#frostFree deleted..!

#ageFridge
agefriDict = Dict(-2=>0,1=>2,2=>3,3=>7,41=>12,42=>17,5=>22)
newDf[!,:AGERFRI1] = df[!,:AGERFRI1]
for i in 1:obs
	newDf[!,:AGERFRI1][i] = agefriDict[df[!,:AGERFRI1][i]]
end

#numberSepFreezerUsed
newDf[!,:NUMFREEZ]=df[!,:NUMFREEZ]
for i=1:obs
	if newDf[!,:NUMFREEZ][i]==-2
	   newDf[!,:NUMFREEZ][i]=0
   end
end

#DWuseFrequency Did convert this to times per week (same as cloth washing)
dwashuseDict = Dict(-2=>0,11=>1,12=>2,13=>3,20=>5,30=>8)
newDf[!,:DWASHUSE] = df[!,:DWASHUSE]
for i in 1:obs
	newDf[!,:DWASHUSE][i] = dwashuseDict[df[!,:DWASHUSE][i]]
end

#CWuseFrequency # washing done per week
washloadDict = Dict(-2=>0,1=>1,2=>3,3=>7,4=>13,5=>16)
newDf[!,:WASHLOAD] = df[!,:WASHLOAD]
for i in 1:obs
	newDf[!,:WASHLOAD][i] = washloadDict[df[!,:WASHLOAD][i]]
end

#drierFrequency :- Ordinal Variable
drieruseDict = Dict(-2=>0,1=>3,2=>2,3=>1)
newDf[!,:DRYRUSE] = df[!,:DRYRUSE]
for i in 1:obs
	newDf[!,:DRYRUSE][i] = drieruseDict[df[!,:DRYRUSE][i]]
end

#tvcolour : Nothing to be dome as they are in ordinal variable.
newDf[!,:TVCOLOR]=df[!,:TVCOLOR]

#tvSize
tvsize1Dict = Dict(-2=>0,1=>1,2=>2,3=>3)
newDf[!,:TVSIZE1] = df[!,:TVSIZE1]
for i in 1:obs
	newDf[!,:TVSIZE1][i] = tvsize1Dict[df[!,:TVSIZE1][i]]
end
# This can be treated as Ordinal. No imputation required..!

#tvType
tvtype1Dict = Dict(-2=>0,1=>1,2=>2,3=>3,4=>4,5=>5)
newDf[!,:TVTYPE1] = df[!,:TVTYPE1]
for i in 1:obs
	newDf[!,:TVTYPE1][i] = tvtype1Dict[df[!,:TVTYPE1][i]]
end

#tvWeekdays hours per day --> Both together
tvonBothDict = Dict(-2=>0,1=>1,2=>2,3=>4,4=>8,5=>12)
newDf[!,:TVONWD1] = df[!,:TVONWD1];
newDf[!,:TVONWE1] = df[!,:TVONWE1];
for i in 1:obs
	newDf[!,:TVONWD1][i] = tvonBothDict[df[!,:TVONWD1][i]];
	newDf[!,:TVONWE1][i] = tvonBothDict[df[!,:TVONWE1][i]];
end

#numberComputers = Ordinal variables
newDf[!,:NUMPC]=df[!,:NUMPC]

#timeOnCOMPUTER this has been treated as ORDINAL
compAllDict = Dict(-2=>0,1=>1,2=>2,3=>5,4=>8,5=>10)
newDf[!,:TIMEON1] = df[!,:TIMEON1];
newDf[!,:TIMEON2] = df[!,:TIMEON2];
newDf[!,:TIMEON3] = df[!,:TIMEON3];
for i in 1:obs
	newDf[!,:TIMEON1][i] = compAllDict[df[!,:TIMEON1][i]];
	newDf[!,:TIMEON2][i] = compAllDict[df[!,:TIMEON2][i]];
	newDf[!,:TIMEON3][i] = compAllDict[df[!,:TIMEON3][i]];
end

#electricalDevices :
battoolDict = Dict(0=>0,1=>2,2=>6,3=>10)
newDf[!,:BATTOOLS] = df[!,:BATTOOLS]
for i in 1:obs
	newDf[!,:BATTOOLS][i] = battoolDict[df[!,:BATTOOLS][i]]
end
#############twoStates##############
twostatesDict = Dict(-2=>0,1=>1,0=>0)
newDf[!,:INTERNET] = df[!,:INTERNET];
newDf[!,:WELLPUMP] = df[!,:WELLPUMP];
for i in 1:obs
	newDf[!,:INTERNET][i] = twostatesDict[df[!,:INTERNET][i]];
	newDf[!,:WELLPUMP][i] = twostatesDict[df[!,:WELLPUMP][i]];
end
#############twoStates##############

#heated aquarium
newDf[!,:AQUARIUM]=df[!,:AQUARIUM]

#stereoYESorNO
newDf[!,:STEREO]=df[!,:STEREO]

#rooms heated.
newDf[!,:HEATROOM]=df[!,:HEATROOM]
for i=1:obs
  if newDf[!,:HEATROOM][i]==-2
     newDf[!,:HEATROOM][i]=0
   end
end

#humidifier used - no change required | use as it is.. ; Categorical
newDf[!,:MOISTURE]=df[!,:MOISTURE]

#type of water heater fuel - only electricity used ; Categorical
fuelwaterDict = Dict(5=>1,1=>0,-2=>0,3=>0,8=>0,21=>0,7=>0,2=>0,4=>0)
newDf[!,:FUELH2O] = df[!,:FUELH2O]
for i in 1:obs
	newDf[!,:FUELH2O][i] = fuelwaterDict[df[!,:FUELH2O][i]]
end

#numberofRooms
newDf[!,:ACROOMS]=df[!,:ACROOMS]
for i=1:obs
  if newDf[!,:ACROOMS][i]==-2
     newDf[!,:ACROOMS][i]=0
   end
end
#this is kept as an ordinal variable. No imputation required

#frequency of AC usage
newDf[!,:USECENAC]=df[!,:USECENAC]
for i=1:obs
  if newDf[!,:USECENAC][i]==-2
     newDf[!,:USECENAC][i]=0
   end
end
#this is kept as an ordinal variable. No imputation required

#programmable thermostat used
newDf[!,:PROTHERMAC]=df[!,:PROTHERMAC]
for i=1:obs
  if newDf[!,:PROTHERMAC][i]==-2
     newDf[!,:PROTHERMAC][i]=0
   end
end
#can be traeted as categorical variables. No imputation required

# 558:- number of ceiling fans, no need to do anything.
newDf[!,:NUMCFAN]=df[!,:NUMCFAN]

#use of ceiling fans -2 means NA and 4 means never used.
newDf[!,:USECFAN]=df[!,:USECFAN]
for i=1:obs
  if newDf[!,:USECFAN][i]==-2 || newDf[!,:USECFAN][i]==4
     newDf[!,:USECFAN][i] = 0
   end
end
#Can be seen as Ordinal. No need to be imputed.!

#trees shading - nothing to be changed, Categorical
newDf[!,:TREESHAD]=df[!,:TREESHAD]

#hot water tubs used :- Nothing to be changed
newDf[!,:RECBATH]=df[!,:RECBATH]

#Complete Lights
light1 = df[!,:LGT12];light2=df[!,:LGT4];light3=df[!,:LGT1];
newDf[!,:LIGHTS] = light1*12+light2*8+light3*2.5
# this is the total Light Hours in the house..!!!
# Can be treated as Ordinal.

#sliding door :- No need of any change.
newDf[!,:SLDDRS]=df[!,:SLDDRS]
#Can be treated as Categorical

#no.of windows:
windowDict = Dict(0=>0,10=>2,20=>4,30=>7,41=>12,42=>18,50=>22,60=>30)
newDf[!,:WINDOWS] = df[!,:WINDOWS]
for i in 1:obs
	newDf[!,:WINDOWS][i] = windowDict[df[!,:WINDOWS][i]]
end

#level of insulation :- nothing to be changed..!
insulDict = Dict(1=>4,2=>3,3=>2,4=>1)
newDf[!,:ADQINSUL] = df[!,:ADQINSUL]
for i in 1:obs
	newDf[!,:ADQINSUL][i] = insulDict[df[!,:ADQINSUL][i]]
end

#Do they use Natural gas?
newDf[!,:USENG]=df[!,:USENG]

#Do they use Solar?
newDf[!,:USESOLAR]=df[!,:USESOLAR]

#Do they use electricity for water heating?
newDf[!,:ELWARM]=df[!,:ELWARM]

#Do they use electricity for waterheating?
newDf[!,:ELWATER]=df[!,:ELWATER]
# No change required, they need to be treated as categorical

#Do they use electricity for cooking?
newDf[!,:ELFOOD]=df[!,:ELFOOD]
# No change required, they need to be treated as categorical

#employemrnt status :-  though the job of all the households are not asked, still this is a point we have..!
newDf[!,:EMPLOYHH]=df[!,:EMPLOYHH]
# keep this as Cat variables. No other changes to be made...

#Householder race
newDf[!,:Householder_Race]=df[!,:Householder_Race]
# Householder_race Starts from 1 instead of Zero. This creates problem in the section of
for i = 1:obs
	if   newDf[!,:Householder_Race][i]==7
	     newDf[!,:Householder_Race][i]=0
    end
end

#Highest educaiton completed by the HH. Though it is asked for only one person, we assume that this is proportional
newDf[!,:EDUCATION]=df[!,:EDUCATION]
# keep this as Cat variables. No other changes to be made...

#Number of Households
newDf[!,:NHSLDMEM]=df[!,:NHSLDMEM]

# Age
age= DataFrame()
ageAllDict = Dict(1=>3,2=>8,3=>13,4=>18,5=>23,6=>28,7=>33,8=>38,9=>43,10=>48,11=>53,12=>58,13=>63,14=>68,15=>73,16=>78,17=>83,18=>88,-2=>0);
age[!,:HHAGE]=df[!,:HHAGE];
age[!,:AGEHHMEMCAT2] =df[!,:AGEHHMEMCAT2];
age[!,:AGEHHMEMCAT3] =df[!,:AGEHHMEMCAT3];
age[!,:AGEHHMEMCAT4] =df[!,:AGEHHMEMCAT4];
age[!,:AGEHHMEMCAT5] =df[!,:AGEHHMEMCAT5];
age[!,:AGEHHMEMCAT6] =df[!,:AGEHHMEMCAT6];
age[!,:AGEHHMEMCAT7] =df[!,:AGEHHMEMCAT7];
age[!,:AGEHHMEMCAT8] =df[!,:AGEHHMEMCAT8];
age[!,:AGEHHMEMCAT9] =df[!,:AGEHHMEMCAT9];
age[!,:AGEHHMEMCAT10]=df[!,:AGEHHMEMCAT10];
for i in 1:obs # HHAGE is in Numeric format..!
	age[!,:AGEHHMEMCAT2][i] =ageAllDict[df[!,:AGEHHMEMCAT2][i]];
	age[!,:AGEHHMEMCAT3][i] =ageAllDict[df[!,:AGEHHMEMCAT3][i]];
	age[!,:AGEHHMEMCAT4][i] =ageAllDict[df[!,:AGEHHMEMCAT4][i]];
	age[!,:AGEHHMEMCAT5][i] =ageAllDict[df[!,:AGEHHMEMCAT5][i]];
	age[!,:AGEHHMEMCAT6][i] =ageAllDict[df[!,:AGEHHMEMCAT6][i]];
	age[!,:AGEHHMEMCAT7][i] =ageAllDict[df[!,:AGEHHMEMCAT7][i]];
	age[!,:AGEHHMEMCAT8][i] =ageAllDict[df[!,:AGEHHMEMCAT8][i]];
	age[!,:AGEHHMEMCAT9][i] =ageAllDict[df[!,:AGEHHMEMCAT9][i]];
	age[!,:AGEHHMEMCAT10][i]=ageAllDict[df[!,:AGEHHMEMCAT10][i]];
end
newDf[!,:MEANAGE]=(age[!,:HHAGE]+age[!,:AGEHHMEMCAT2]+age[!,:AGEHHMEMCAT3]+age[!,:AGEHHMEMCAT4]
+age[!,:AGEHHMEMCAT5]+age[!,:AGEHHMEMCAT6]+age[!,:AGEHHMEMCAT7]+age[!,:AGEHHMEMCAT8]+age[!,:AGEHHMEMCAT9]
+age[!,:AGEHHMEMCAT10])./newDf[!,:NHSLDMEM];

#retirement income : nothing to be changed
newDf[!,:RETIREPY]=df[!,:RETIREPY]
# keep this as Cat variables. No other changes to be made...

#income : nothing to be changed
moneyDict = Dict(1=>2000,2=>3750,3=>6250,4=>8750,5=>12500,6=>17500,7=>22500,8=>27500,
			9=>32500,10=>37500,11=>42500,12=>47500,13=>52500,14=>57500,15=>62500,16=>67500,17=>72500,
			18=>77500,19=>82500,20=>87500,21=>92500,22=>97500,23=>110000,24=>130000)
newDf[!,:MONEYPY] = df[!,:MONEYPY];
for i in 1:obs
	newDf[!,:MONEYPY][i] = moneyDict[df[!,:MONEYPY][i]]
end

#poverty line :-Nothing to be changed.!
newDf[!,:POVERTY150]=df[!,:POVERTY150]

#total household area :- Nothing to be changed.!
newDf[!,:TOTSQFT]=df[!,:TOTSQFT]

#total household area that is heated :- Nothinf to be changed..!!
newDf[!,:TOTHSQFT]=df[!,:TOTHSQFT]

#total household area that is cooled :- Nothinf to be changed..!!
newDf[!,:TOTCSQFT]=df[!,:TOTCSQFT]

#the RESPONSE....!!!!!!!!!!!!!!!!!!!!!
newDf[!,:KWH]=df[!,:KWH]

# Wweather Sheilding Factor : no need to be changed.!
newDf[!,:WSF]=df[!,:WSF]

varTotal = size(newDf)[2];
