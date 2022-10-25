**************************************************************
***** Applied Macro: Micro data for Macro Models   ***********
***** Author: Jose M. Quintero 		 	   ***********
***** TA: Olivia Bordeou   			   ***********
**************************************************************

* This do-file cleans the HDMA, while pasting de CBS area codes 



* Download matching codes so it does not drop the main areas
import excel using "https://www2.census.gov/programs-surveys/metro-micro/geographies/reference-files/2020/delineation-files/list1_2020.xls", firstrow cellrange(a3:l1919) case(lower) clear
* Clean IDs
replace metropolitandivisioncode = cbsacode if missing(metropolitandivisioncode)
rename metropolitandivisioncode derived_msa_md
* Keep IDs only 
keep derived_msa_md cbsacode
duplicates drop
* Make numeric
destring cbsacode, replace
destring derived_msa_md, replace
* Save data with IDs
save Data/cbsa2msamd.dta, replace
********************************************************************************
********************************************************************************
********************************************************************************
* Import datafor 2020 (HDMA)
import delimited "Data/2020_public_lar.csv", varnames(1) colrange(3:23) clear 
keep derived_msa_md action_taken loan_purpose combined_loan_to_value_ratio
destring combined_loan_to_value_ratio, replace force
* Clean data 
keep if action_taken==1
drop if derived_msa_md == 99999 | derived_msa_md == 0
gen year = 2020
sum
* Creat var for counting 
gen n_ref 	= inlist(loan_purpose,31,32)
gen n_cashRef 	= loan_purpose==32	
*Merge in CBSA
merge m:1 derived_msa_md using Data/cbsa2msamd.dta, assert(2 3) keep(3) nogen
* Collapse data frame 
collapse (mean) loan2val_m = combined_loan_to_value_ratio ///
	 (median)  loan2val_p50 = combined_loan_to_value_ratio ///
	 (sum) n_ref n_cashRef, by(cbsacode year)
* Save temp data frame
save Data/temp.dta, replace 
********************************************************************************
********************************************************************************
********************************************************************************
* Import datafor 2021
import delimited "Data/2021_public_lar.csv", varnames(1) colrange(3:23) clear
keep derived_msa_md action_taken loan_purpose combined_loan_to_value_ratio
destring combined_loan_to_value_ratio, replace force
* Clean data 
keep if action_taken==1
drop if derived_msa_md == 99999 | derived_msa_md == 0
gen year = 2021
* Creat var for counting 
gen n_ref 	= inlist(loan_purpose,31,32)
gen n_cashRef 	= loan_purpose==32
*Merge in CBSA
merge m:1 derived_msa_md using Data/cbsa2msamd.dta, assert(2 3) keep(3) nogen
* Collapse data frame 
collapse (mean) loan2val_m = combined_loan_to_value_ratio ///
	 (median)  loan2val_p50 = combined_loan_to_value_ratio ///
	 (sum) n_ref n_cashRef, by(cbsacode year)

* Append with 2020
append using Data/temp
* Erase temp 
erase Data/temp.dta  
* Save data frame
save Data/hdma_collapsed.dta, replace 	 
	 
	 
