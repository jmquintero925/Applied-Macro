**************************************************************
***** Applied Macro: Micro data for Macro Models   ***********
***** Author: Jose M. Quintero 		 	   ***********
***** TA: Olivia Bordeou   			   ***********
**************************************************************


* Download data 
getcensus dp04_0002 dp04_0046 dp04_0091, years(2019) sample(1) geography(metro) cachepath("/home/jmquintero925/ado/plus/g/") clear
rename dp04_0002e nHouse
rename dp04_0046e nHouse_ownocc
rename dp04_0091e nHouse_ownocc_mort
rename metropolitanstatisticalareamicro cbsacode
* Keep variables of interest
destring cbsacode, replace
keep cbsacode nHouse*
* Save data
save Data/census.dta, replace 
