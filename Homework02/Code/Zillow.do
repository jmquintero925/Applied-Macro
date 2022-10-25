**************************************************************
***** Applied Macro: Micro data for Macro Models   ***********
***** Author: Jose M. Quintero 		 	   ***********
***** TA: Olivia Bordeou   			   ***********
**************************************************************

* This do-file downloads the Prices from Zillow and cac=lculates the price growth 
* in a 5 year window for 2020 and 2021

* Import data from Zillow website 
import delimited using "https://files.zillowstatic.com/research/public_csvs/zhvi/Metro_zhvi_uc_sfrcondo_tier_0.33_0.67_sm_sa_month.csv", clear
* Get date from label (The way I do it is not smart)  
forv i = 6/278 {
    local newName = "zIndex"+string(2000+floor((`i'-5)/12))+"_"+string(mod(`i'-5,12))
    rename v`i' `newName'
}
* Drop aggregate data
drop if regiontype == "country"
* Reshape data
reshape long zIndex, i(regionid) j(date) string
* Get month and year  
gen year = substr(date,1,4)
destring year, replace
gen month = substr(date,6,.)
destring month, replace
* Correct the month of december  
replace month = 12 if month == 0
* Generate the 5 year growth 
sort regionid month year
bys regionid month: gen zIndx_g = zIndex[_n]/zIndex[_n-5]-1
sort regionid year month
order regionid year month zIndex zIndx_g
* Keep only years 2020 and 2021
keep if year>=2020
* Save data 
save Data/zillow_prices.dta, replace
********************************************************************************
********************************************************************************
********************************************************************************
* Import crosswalk 
import delimited using "https://query.data.world/s/lgudxfzytdainwzv4bcgo2fqypgpoq", clear
* Keep ID variables
keep cbsacode metroregionid_zillow
* Convert to numeric
destring cbsacode, replace force
destring metroregionid_zillow, replace force
* Drop if there is no code
drop if cbsacode==. & metroregionid_zillow==.
duplicates drop
* Save temp base 
rename metroregionid_zillow regionid
save Data/temp.dta, replace 
********************************************************************************
********************************************************************************
********************************************************************************
* Merge Zillo data with crosswalk codes
use Data/zillow_prices.dta, clear
merge m:1 regionid using Data/temp.dta, keep(2 3)
* Take averages of prices growth by year
collapse (mean) zIndx_g, by(cbsacode year)
* Save dataframe
save Data/zillow_prices.dta, replace
erase Data/temp.dta






