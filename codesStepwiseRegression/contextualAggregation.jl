
#YearMade
newDf[:YEARMADERANGE] = df[:YEARMADERANGE]
#Kept as Ordinal, because 8 represents the newest house, and is the best..!

#for walltype, deleting categories 5,6,8,9
newDf[:WALLTYPE] = df[:WALLTYPE]
for i=1:obs
	if newDf[:WALLTYPE][i]==5 || newDf[:WALLTYPE][i]==6 || newDf[:WALLTYPE][i]==8 || newDf[:WALLTYPE][i]==9
	   df[:WALLTYPE][i]=0
    elseif newDf[:WALLTYPE][i]==7
	   df[:WALLTYPE][i]=5#QQQQ instead use something like weighted imputation of setdiff("data",[5,6,8,9])
   end
end
#now impute all the zero values.

#rooftype
# changed -2 to 0.
newDf[:ROOFTYPE]=df[:ROOFTYPE]
for i=1:obs
	if df[:ROOFTYPE][i]==-2
	   df[:ROOFTYPE][i]=0
   end
end
# -2 has been changed to 0 here., however, 0 doesnt mean anything (but whats the cae for apartments)
#impute all  0.

#bedrooms
newDf[:BEDROOMS] = df[:BEDROOMS]
for i=1:obs
	if newDf[:BEDROOMS][i]==-2
	   newDf[:BEDROOMS][i]=0
###########################
   end
end
#All -2 has been changed to 0. However, not sure what "0" means for a bedroom..!
# Impute all zeros.
#Then has to be treated as Ordinal variables



#Number of full bathrooms and half bathrooms :- Variable name changed in the new one
newDf[:NCOMBATH] = df[:NCOMBATH]
newDf[:NHAFBATH] = df[:NHAFBATH]
# These are treated as Ordinal variables..


#attached garage
newDf[:PRKGPLC1]=df[:PRKGPLC1]
for i=1:obs
	if newDf[:PRKGPLC1][i]==-2
	   newDf[:PRKGPLC1][i]=0
   end
end
# DO NOT impute the zeros..!
#seen as categorical variables


#stovefuel was adjusted so that there is only two values - either 0 or 1..!
newDf[:STOVENFUEL]=df[:STOVENFUEL]
for i=1:obs
	if newDf[:STOVENFUEL][i] != 5
	   newDf[:STOVENFUEL][i]=0
   else  newDf[:STOVENFUEL][i]=1
   end
end
# Do not impute 0.
# seen as categorical variables


# ovenuse frequency of ovenuse
# Here, 0 and -2 is treated as same...
# Plus, to treat this as Ordinal, oven use per week is cosidered.



newDf[:OVENUSE]=df[:OVENUSE]
for i=1:obs
	if newDf[:OVENUSE][i]==-2
	   newDf[:OVENUSE][i]=0
   elseif newDf[:OVENUSE][i]==1
          newDf[:OVENUSE][i]=28
   elseif newDf[:OVENUSE][i]==2
          newDf[:OVENUSE][i]=16
   elseif newDf[:OVENUSE][i]==3
          newDf[:OVENUSE][i]=9
   elseif newDf[:OVENUSE][i]==4
          newDf[:OVENUSE][i]=6
   elseif newDf[:OVENUSE][i]==5
          newDf[:OVENUSE][i]=3
   elseif newDf[:OVENUSE][i]==6
          newDf[:OVENUSE][i]=1
   end
end
# No imputation required


#AMTMICRO : microwave frequency used
newDf[:AMTMICRO] = df[:AMTMICRO]
for i=1:obs
	if newDf[:AMTMICRO][i]==-2
	   newDf[:AMTMICRO][i]=0
   elseif newDf[:AMTMICRO][i]==1
	       newDf[:AMTMICRO][i]=4
   elseif newDf[:AMTMICRO][i]==2
          newDf[:AMTMICRO][i]=3
   elseif newDf[:AMTMICRO][i]==3
          newDf[:AMTMICRO][i]=2
   elseif newDf[:AMTMICRO][i]==4
          newDf[:AMTMICRO][i]=1
   end
end
#no need to be imputed as all -2 go to 0.
# Converted to Ordinal variables

#MW used for defrosting>
newDf[:DEFROST]=df[:DEFROST]
for i=1:obs
	if newDf[:DEFROST][i]==-2
	   newDf[:DEFROST][i]=0
   end
end
# no need to be imputed..!
# categorical variable


#no change in the toaster, Categorical
newDf[:TOASTER] = df[:TOASTER]

#Number of meals cooked put in weeks :- Ordinal
newDf[:NUMMEAL] = df[:NUMMEAL]
for i=1:obs
	if newDf[:NUMMEAL][i]==1
	   newDf[:NUMMEAL][i]=18
   elseif newDf[:NUMMEAL][i]==2
	       newDf[:NUMMEAL][i]=10
   elseif newDf[:NUMMEAL][i]==3
          newDf[:NUMMEAL][i]=7
   elseif newDf[:NUMMEAL][i]==4
          newDf[:NUMMEAL][i]=5
   elseif newDf[:NUMMEAL][i]==5
          newDf[:NUMMEAL][i]=3
   elseif newDf[:NUMMEAL][i]==6
          newDf[:NUMMEAL][i]=1
   end
end
#Kept as Ordinal

#Fuel used for cooking - electricity or not
newDf[:FUELFOOD]=df[:FUELFOOD]
for i=1:obs
	if newDf[:FUELFOOD][i]==1 || newDf[:FUELFOOD][i]==2 || newDf[:FUELFOOD][i]==21 || newDf[:FUELFOOD][i]==-2
	   newDf[:FUELFOOD][i]=0
   else  newDf[:FUELFOOD][i]=1
   end
end
# No imputation required for the zeros
#Categorical variable

#Coffee maker used - no change needed, Categorical
newDf[:COFFEE]=df[:COFFEE]

#Numfridge : just Ordinal. No change required..!
newDf[:NUMFRIG]=df[:NUMFRIG]

#typefridge1, Categorical
newDf[:TYPERFR1]=df[:TYPERFR1]
for i=1:obs
	if newDf[:TYPERFR1][i]==3 || newDf[:TYPERFR1][i]==4 || newDf[:TYPERFR1][i]==-2
	   newDf[:TYPERFR1][i]=0
    elseif newDf[:TYPERFR1][i]==5
	   newDf[:TYPERFR1][i]=2
    elseif newDf[:TYPERFR1][i]==21
       newDf[:TYPERFR1][i]=3
    elseif newDf[:TYPERFR1][i]==22
       newDf[:TYPERFR1][i]=4
    elseif newDf[:TYPERFR1][i]==23
       newDf[:TYPERFR1][i]=5
    end
end
#Impute all the zeros (3 and 4 have very less entries. So did in this way.!)


#sizeFridge -2 has been converted to 0.
newDf[:SIZRFRI1]=df[:SIZRFRI1]
for i=1:obs
	if newDf[:SIZRFRI1][i]==-2
	   newDf[:SIZRFRI1][i]=0
   end
end
# Seens as Ordinal, No need to be imputed


#frostFree deleted..!

#ageFridge
newDf[:AGERFRI1]=df[:AGERFRI1]
for i=1:obs
	if newDf[:AGERFRI1][i]==-2
	   newDf[:AGERFRI1][i]=0
   elseif newDf[:AGERFRI1][i]==1
          newDf[:AGERFRI1][i]=2
   elseif newDf[:AGERFRI1][i]==2
          newDf[:AGERFRI1][i]=3
   elseif newDf[:AGERFRI1][i]==3
          newDf[:AGERFRI1][i]=7
   elseif newDf[:AGERFRI1][i]==41
          newDf[:AGERFRI1][i]=12
   elseif newDf[:AGERFRI1][i]==42
          newDf[:AGERFRI1][i]=17
   elseif newDf[:AGERFRI1][i]==5
          newDf[:AGERFRI1][i]=22
   end
end
# Impute all the 0s.. (has 19%)


#numberSepFreezerUsed
newDf[:NUMFREEZ]=df[:NUMFREEZ]
for i=1:obs
	if newDf[:NUMFREEZ][i]==-2
	   newDf[:NUMFREEZ][i]=0
   end
end
#ordinal variables..! No further Change required


#DWuseFrequency Did convert this to times per week (same as cloth washing)
newDf[:DWASHUSE]=df[:DWASHUSE]
for i=1:obs
  if newDf[:DWASHUSE][i]==-2
     newDf[:DWASHUSE][i]=0
  elseif newDf[:DWASHUSE][i]==11
         newDf[:DWASHUSE][i]=1
  elseif newDf[:DWASHUSE][i]==12
         newDf[:DWASHUSE][i]=2
  elseif newDf[:DWASHUSE][i]==13
         newDf[:DWASHUSE][i]=3
  elseif newDf[:DWASHUSE][i]==20
         newDf[:DWASHUSE][i]=5
  elseif newDf[:DWASHUSE][i]==30
         newDf[:DWASHUSE][i]=8
   end
end
#No imputation required. Here 0 means noDW or DW never used. Ordinal variable

#frontLoad and topLoad not used..!

#CWuseFrequency # washing done per week
newDf[:WASHLOAD]=df[:WASHLOAD]
for i=1:obs
  if newDf[:WASHLOAD][i]==-2
     newDf[:WASHLOAD][i]=0
  elseif newDf[:WASHLOAD][i]==2
         newDf[:WASHLOAD][i]=3
  elseif newDf[:WASHLOAD][i]==2
         newDf[:WASHLOAD][i]=3
  elseif newDf[:WASHLOAD][i]==3
         newDf[:WASHLOAD][i]=7
  elseif newDf[:WASHLOAD][i]==4
         newDf[:WASHLOAD][i]=13
  elseif newDf[:WASHLOAD][i]==5
         newDf[:WASHLOAD][i]=16
   end
end
#No imputation required. Here 0 means no CW or CW never used.. Ordinal Variable


#drierFrequency :- Ordinal Variable
newDf[:DRYRUSE]=df[:DRYRUSE]
for i=1:obs
  if newDf[:DRYRUSE][i]==-2
     newDf[:DRYRUSE][i]=0
  elseif newDf[:DRYRUSE][i]==1
         newDf[:DRYRUSE][i]=3
  elseif newDf[:DRYRUSE][i]==3
         newDf[:DRYRUSE][i]=1
   end
end
#No imputation required. Here 0 means no Drier or  a Drier  never used..
# This can be used as Ordinal NOW as they are in teh increasing order.

#tvcolour : Nothing to be dome as they are in ordinal variable.
newDf[:TVCOLOR]=df[:TVCOLOR]

#tvSize
newDf[:TVSIZE1]=df[:TVSIZE1]
for i=1:obs
  if newDf[:TVSIZE1][i]==-2
     newDf[:TVSIZE1][i]=0
   end
end
# This can be treated as Ordinal. No imputation required..!


#tvType
newDf[:TVTYPE1]=df[:TVTYPE1]
for i=1:obs
  if newDf[:TVTYPE1][i]==-2
     newDf[:TVTYPE1][i]=0
   end
end
#0 needs to be imputed here..!


#tvWeekdays hours per day
newDf[:TVONWD1]=df[:TVONWD1]
for i=1:obs
  if newDf[:TVONWD1][i]==-2
     newDf[:TVONWD1][i]=0
  elseif newDf[:TVONWD1][i]==3
         newDf[:TVONWD1][i]=4
  elseif newDf[:TVONWD1][i]==4
         newDf[:TVONWD1][i]=8
  elseif newDf[:TVONWD1][i]==5
         newDf[:TVONWD1][i]=12
   end
end
# Seen as ordinal, No need to be imputed here..!

#tvWeekEnds
newDf[:TVONWE1]=df[:TVONWE1]
for i=1:obs
  if newDf[:TVONWE1][i]==-2
     newDf[:TVONWE1][i]=0
  elseif newDf[:TVONWE1][i]==3
         newDf[:TVONWE1][i]=4
  elseif newDf[:TVONWE1][i]==4
         newDf[:TVONWE1][i]=8
  elseif newDf[:TVONWE1][i]==5
         newDf[:TVONWE1][i]=12
   end
end
# Treated as ordinal ; No change required, no imputation.!

#numberComputers = Ordinal variables
newDf[:NUMPC]=df[:NUMPC]

#timeOnCOMPUTER this has been treated as ORDINAL
# Computer usage is given as daily usage/ not weekly..!
newDf[:TIMEON1]=df[:TIMEON1]
for i=1:obs
  if newDf[:TIMEON1][i]==-2
     newDf[:TIMEON1][i]=0
  elseif newDf[:TIMEON1][i]==3
         newDf[:TIMEON1][i]=5
  elseif newDf[:TIMEON1][i]==4
         newDf[:TIMEON1][i]=8
  elseif newDf[:TIMEON1][i]==5
         newDf[:TIMEON1][i]=10
   end
end
# No needed to be imputed, also ordinal variables

#timeOn COmputer 2 ; Ordinal
newDf[:TIMEON2]=df[:TIMEON2]
for i=1:obs
  if newDf[:TIMEON2][i]==-2
     newDf[:TIMEON2][i]=0
  elseif newDf[:TIMEON2][i]==3
         newDf[:TIMEON2][i]=5
  elseif newDf[:TIMEON2][i]==4
         newDf[:TIMEON2][i]=8
  elseif newDf[:TIMEON2][i]==5
         newDf[:TIMEON2][i]=10
   end
end
#taken as ordinal, nothing to change

#timeOnComputer3   ; Ordinal
newDf[:TIMEON3]=df[:TIMEON3]
for i=1:obs
  if newDf[:TIMEON3][i]==-2
     newDf[:TIMEON3][i]=0
  elseif newDf[:TIMEON3][i]==3
         newDf[:TIMEON3][i]=5
  elseif newDf[:TIMEON3][i]==4
         newDf[:TIMEON3][i]=8
  elseif newDf[:TIMEON3][i]==5
         newDf[:TIMEON3][i]=10
   end
end

#Internet yesorNO. Categorical
newDf[:INTERNET]=df[:INTERNET]
for i=1:obs
  if newDf[:INTERNET][i]==-2
     newDf[:INTERNET][i]=0
   end
end

#wellpump
newDf[:WELLPUMP]=df[:WELLPUMP]
for i=1:obs
  if newDf[:WELLPUMP][i]==-2
     newDf[:WELLPUMP][i]=0
   end
end

#heated aquarium
newDf[:AQUARIUM]=df[:AQUARIUM]
for i=1:obs
  if newDf[:AQUARIUM][i]==-2
     newDf[:AQUARIUM][i]=0
   end
end

#stereoYESorNO
newDf[:STEREO]=df[:STEREO]
for i=1:obs
  if newDf[:STEREO][i]==-2
     newDf[:STEREO][i]=0
   end
end
#Treat as categorical variables..

#electricalDevices :
newDf[:BATTOOLS]=df[:BATTOOLS]
for i=1:obs
  if newDf[:BATTOOLS][i]==1
     newDf[:BATTOOLS][i]=2
  elseif newDf[:BATTOOLS][i]==2
         newDf[:BATTOOLS][i]=6
  elseif newDf[:BATTOOLS][i]==3
         newDf[:BATTOOLS][i]=10
   end
end
#Ordinal variables ; nothing to be changed

#rooms heated.
newDf[:HEATROOM]=df[:HEATROOM]
for i=1:obs
  if newDf[:HEATROOM][i]==-2
     newDf[:HEATROOM][i]=0
   end
end
# Number of heated is in Ordinal Variables, so no change required

#humidifier used - no change required | use as it is.. ; Categorical
newDf[:MOISTURE]=df[:MOISTURE]

#type of water heater fuel - only electricity used ; Categorical
newDf[:FUELH2O]=df[:FUELH2O]
for i=1:obs
  if newDf[:FUELH2O][i]==5
     newDf[:FUELH2O][i]=1
  else   newDf[:FUELH2O][i]=0
   end
end


#ACtype used
# newDf[:COOLTYPE]=df[:COOLTYPE]
# for i=1:obs
#   if newDf[:COOLTYPE][i]==-2
#      newDf[:COOLTYPE][i]=0
#    end
# end
#take this as categorical variable.. No imputation required

#numberofRooms
newDf[:ACROOMS]=df[:ACROOMS]
for i=1:obs
  if newDf[:ACROOMS][i]==-2
     newDf[:ACROOMS][i]=0
   end
end
#this is kept as an ordinal variable. No imputation required

#frequency of AC usage
newDf[:USECENAC]=df[:USECENAC]
for i=1:obs
  if newDf[:USECENAC][i]==-2
     newDf[:USECENAC][i]=0
   end
end
#this is kept as an ordinal variable. No imputation required

#programmable thermostat used
newDf[:PROTHERMAC]=df[:PROTHERMAC]
for i=1:obs
  if newDf[:PROTHERMAC][i]==-2
     newDf[:PROTHERMAC][i]=0
   end
end
#can be traeted as categorical variables. No imputation required

# 558:- number of ceiling fans, no need to do anything.
newDf[:NUMCFAN]=df[:NUMCFAN]

#use of ceiling fans -2 means NA and 4 means never used.
newDf[:USECFAN]=df[:USECFAN]
for i=1:obs
  if newDf[:USECFAN][i]==-2 || newDf[:USECFAN][i]==4
     newDf[:USECFAN][i] = 0
   end
end
#Can be seen as Ordinal. No need to be imputed.!

#trees shading - nothing to be changed, Categorical
newDf[:TREESHAD]=df[:TREESHAD]

#hot water tubs used :- Nothing to be changed
newDf[:RECBATH]=df[:RECBATH]

#Complete Lights
light1 = df[:LGT12];light2=df[:LGT4];light3=df[:LGT1];
newDf[:LIGHTS] = light1*12+light2*8+light3*2.5
# this is the total Light Hours in the house..!!!
# Can be treated as Ordinal.

#sliding door :- No need of any change.
newDf[:SLDDRS]=df[:SLDDRS]
#Can be treated as Categorical

#no.of windows:
newDf[:WINDOWS]=df[:WINDOWS]
for i=1:obs
  if newDf[:WINDOWS][i]==10
     newDf[:WINDOWS][i]=2
  elseif newDf[:WINDOWS][i]==20
         newDf[:WINDOWS][i]=4
  elseif newDf[:WINDOWS][i]==30
         newDf[:WINDOWS][i]=7
  elseif newDf[:WINDOWS][i]==41
         newDf[:WINDOWS][i]=12
  elseif newDf[:WINDOWS][i]==42
         newDf[:WINDOWS][i]=18
  elseif newDf[:WINDOWS][i]==50
         newDf[:WINDOWS][i]=22
  elseif newDf[:WINDOWS][i]==60
         newDf[:WINDOWS][i]=30
   end
end
#Can be treated as Ordinal.

#level of insulation :- nothing to be changed..!
newDf[:ADQINSUL]=df[:ADQINSUL]
for i=1:obs
  if newDf[:ADQINSUL][i]==1
     newDf[:ADQINSUL][i]=4
  elseif newDf[:ADQINSUL][i]==2
         newDf[:ADQINSUL][i]=3
  elseif newDf[:ADQINSUL][i]==3
         newDf[:ADQINSUL][i]=2
  elseif newDf[:ADQINSUL][i]==4
         newDf[:ADQINSUL][i]=1
   end
end
# Now this can be treated as Ordinal..!

#Do they use Natural gas?
newDf[:USENG]=df[:USENG]
# No change required, they need to be treated as categorical

#Do they use Solar?
newDf[:USESOLAR]=df[:USESOLAR]
# No change required, they need to be treated as categorical

#Do they use electricity for water heating?
newDf[:ELWARM]=df[:ELWARM]
# No change required, they need to be treated as categorical

#Do they use electricity for cooling?
#################NOTE NOTE NOTE NOTE NOTE NOTE #################################
# newDf[:ELCOOL]=df[:ELCOOL]
#################NOTE NOTE NOTE NOTE NOTE NOTE #################################
# No change required, they need to be treated as categorical

#Do they use electricity for waterheating?
newDf[:ELWATER]=df[:ELWATER]
# No change required, they need to be treated as categorical

#Do they use electricity for cooking?
newDf[:ELFOOD]=df[:ELFOOD]
# No change required, they need to be treated as categorical

#employemrnt status :-  though the job of all the households are not asked, still this is a point we have..!
newDf[:EMPLOYHH]=df[:EMPLOYHH]
# keep this as Cat variables. No other changes to be made...

#Householder race
newDf[:Householder_Race]=df[:Householder_Race]
# Householder_race Starts from 1 instead of Zero. This creates problem in the section of
# finding out startPVal :endPVal. So they need to be converted to the base of ZERO.
for i = 1:obs
	if   newDf[:Householder_Race][i]==7
	     newDf[:Householder_Race][i]=0
    end
end

# keep this as Cat variables. No other changes to be made...

#Highest educaiton completed by the HH. Though it is asked for only one person, we assume that this is proportional
newDf[:EDUCATION]=df[:EDUCATION]
# keep this as Cat variables. No other changes to be made...

#Number of Households
newDf[:NHSLDMEM]=df[:NHSLDMEM]
# keep this as Ordinal variables. No other changes to be made...














age= DataFrame()
age[:HHAGE]=df[:HHAGE]
age[:AGEHHMEMCAT2]=df[:AGEHHMEMCAT2]
age[:AGEHHMEMCAT3]=df[:AGEHHMEMCAT3]
age[:AGEHHMEMCAT4]=df[:AGEHHMEMCAT4]
age[:AGEHHMEMCAT5]=df[:AGEHHMEMCAT5]
age[:AGEHHMEMCAT6]=df[:AGEHHMEMCAT6]
age[:AGEHHMEMCAT7]=df[:AGEHHMEMCAT7]
age[:AGEHHMEMCAT8]=df[:AGEHHMEMCAT8]
age[:AGEHHMEMCAT9]=df[:AGEHHMEMCAT9]
age[:AGEHHMEMCAT10]=df[:AGEHHMEMCAT10]
col=size(age)[2]

for j=1:col
   for i=1:obs
     if age[j][i]==1
        age[j][i]=3
     elseif age[j][i]==2
            age[j][i]=8
     elseif age[j][i]==3
            age[j][i]=13
     elseif age[j][i]==4
            age[j][i]=18
     elseif age[j][i]==5
            age[j][i]=23
     elseif age[j][i]==6
            age[j][i]=28
     elseif age[j][i]==7
            age[j][i]=33
     elseif age[j][i]==8
            age[j][i]=38
     elseif age[j][i]==9
            age[j][i]=43
     elseif age[j][i]==10
            age[j][i]=48
     elseif age[j][i]==11
            age[j][i]=53
     elseif age[j][i]==12
            age[j][i]=58
     elseif age[j][i]==13
            age[j][i]=63
     elseif age[j][i]==14
            age[j][i]=68
     elseif age[j][i]==15
            age[j][i]=73
     elseif age[j][i]==16
            age[j][i]=78
     elseif age[j][i]==17
            age[j][i]=83
     elseif age[j][i]==18
            age[j][i]=88
     elseif age[j][i]==-2
            age[j][i]=0
      end
   end
end






############### no need of spread bcoz more than 2700 have just one Household in their House.##########
#age= Array(age)
#spread=zeros(12083,1)
#for i=1:12083
#spread[i] = maximum(age[i,:]) #-minimum(setdiff(age[i,:],0))
#end

#spreaddd = zeros(12083,1)
#for i=1:12083
#spreaddd[i] = minimum(setdiff(age[i,:],0))
#end


 newDf[:MEANAGE]=(age[:HHAGE]+age[:AGEHHMEMCAT2]+age[:AGEHHMEMCAT3]+age[:AGEHHMEMCAT4]
 +age[:AGEHHMEMCAT5]+age[:AGEHHMEMCAT6]+age[:AGEHHMEMCAT7]+age[:AGEHHMEMCAT8]+age[:AGEHHMEMCAT9]
 +age[:AGEHHMEMCAT10])./newDf[:NHSLDMEM]













#retirement income : nothing to be changed
newDf[:RETIREPY]=df[:RETIREPY]
# keep this as Cat variables. No other changes to be made...

#income : nothing to be changed
newDf[:MONEYPY]=df[:MONEYPY]
for i=1:obs
  if newDf[:MONEYPY][i]==1
     newDf[:MONEYPY][i]=2000
  elseif newDf[:MONEYPY][i]==2
         newDf[:MONEYPY][i]=3750
  elseif newDf[:MONEYPY][i]==3
         newDf[:MONEYPY][i]=6250
  elseif newDf[:MONEYPY][i]==4
         newDf[:MONEYPY][i]=8750
  elseif newDf[:MONEYPY][i]==5
         newDf[:MONEYPY][i]=12500
  elseif newDf[:MONEYPY][i]==6
         newDf[:MONEYPY][i]=17500
  elseif newDf[:MONEYPY][i]==7
         newDf[:MONEYPY][i]=22500
  elseif newDf[:MONEYPY][i]==8
         newDf[:MONEYPY][i]=27500
  elseif newDf[:MONEYPY][i]==9
         newDf[:MONEYPY][i]=32500
  elseif newDf[:MONEYPY][i]==10
         newDf[:MONEYPY][i]=37500
  elseif newDf[:MONEYPY][i]==11
         newDf[:MONEYPY][i]=42500
  elseif newDf[:MONEYPY][i]==12
         newDf[:MONEYPY][i]=47500
  elseif newDf[:MONEYPY][i]==13
         newDf[:MONEYPY][i]=52500
  elseif newDf[:MONEYPY][i]==14
         newDf[:MONEYPY][i]=57500
  elseif newDf[:MONEYPY][i]==15
         newDf[:MONEYPY][i]=62500
  elseif newDf[:MONEYPY][i]==16
         newDf[:MONEYPY][i]=67500
  elseif newDf[:MONEYPY][i]==17
         newDf[:MONEYPY][i]=72500
  elseif newDf[:MONEYPY][i]==18
         newDf[:MONEYPY][i]=77500
  elseif newDf[:MONEYPY][i]==19
         newDf[:MONEYPY][i]=82500
  elseif newDf[:MONEYPY][i]==20
         newDf[:MONEYPY][i]=87500
  elseif newDf[:MONEYPY][i]==21
         newDf[:MONEYPY][i]=92500
  elseif newDf[:MONEYPY][i]==22
         newDf[:MONEYPY][i]=97500
  elseif newDf[:MONEYPY][i]==23
         newDf[:MONEYPY][i]=110000
  elseif newDf[:MONEYPY][i]==24
         newDf[:MONEYPY][i]=130000
   end
end
# keep this as Ordinal variables. No other changes to be made...






#poverty line :-Nothing to be changed.!
newDf[:POVERTY150]=df[:POVERTY150]
#Nothing to be changed ; Consider this as Categorical variables.

#total household area :- Nothing to be changed.!
newDf[:TOTSQFT]=df[:TOTSQFT]
#Consider this as Ordinal variables.

#total household area that is heated :- Nothinf to be changed..!!
newDf[:TOTHSQFT]=df[:TOTHSQFT]
#Consider this as Ordinal variables.

#total household area that is cooled :- Nothinf to be changed..!!
newDf[:TOTCSQFT]=df[:TOTCSQFT]
#Consider this as Ordinal variables.

#the RESPONSE....!!!!!!!!!!!!!!!!!!!!!
newDf[:KWH]=df[:KWH]
#the RESPONSE....!!!!!!!!!!!!!!!!!!!!

# Wweather Sheilding Factor : no need to be changed.!
newDf[:WSF]=df[:WSF]
# No need of change.. Treated as ordinal...!!!!
