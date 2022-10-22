* Set working directory 
cd "/home/jmquintero925/Applied-Macro/Homework02"
* Open log 
log using log/clean_hdma, replace
* Import datafor 2020
import delimited "Data/2020_public_lar.csv", varnames(1) colrange(3:23) clear 
keep derived_msa_md action_taken loan_purpose combined_loan_to_value_ratio
destring combined_loan_to_value_ratio, replace force
* Clean data 
keep if action_taken==1
gen year = 2020
sum
* Creat var for counting 
gen n_ref 	= inlist(loan_purpose,31,32)
gen n_cashRef 	= loan_purpose==32	
* Collapse data frame 
collapse (mean) loan2val_m = combined_loan_to_value_ratio ///
	 (median)  loan2val_p50 = combined_loan_to_value_ratio ///
	 (sum) n_ref n_cashRef, by(derived_msa_md year)
* Save temp data frame
save Data/temp.dta, replace 
* Import datafor 2021
import delimited "Data/2021_public_lar.csv", varnames(1) colrange(3:23) clear
keep derived_msa_md action_taken loan_purpose combined_loan_to_value_ratio
destring combined_loan_to_value_ratio, replace force
* Clean data 
keep if action_taken==1
gen year = 2021
* Creat var for counting 
gen n_ref 	= inlist(loan_purpose,31,32)
gen n_cashRef 	= loan_purpose==32	
* Collapse data frame 
collapse (mean) loan2val_m = combined_loan_to_value_ratio ///
	 (median)  loan2val_p50 = combined_loan_to_value_ratio ///
	 (sum) n_ref n_cashRef, by(derived_msa_md year)

* Append with 2020
append using Data/temp
* Erase temp 
erase Data/temp.dta  
log close 	 
* Save data frame
save Data/hdma_collapsed.dta, replace 	 
	 
	 
