

use Data/hdma_collapsed.dta, clear 	 
* Merge with Census data
merge m:1 cbsacode using Data/census.dta, assert(2 3) keep(3) nogen
* Merge with 
merge 1:1 cbsa year using Data/zillow_prices.dta, assert(1 2 3) keep(1 3) nogen

* Compute the refinancing and cash out propensity by MSA and year
gen n_ref_pct =  n_ref/nHouse_ownocc_mort
la var n_ref_pct "Mortgages Refinanced (%) (Total)"
gen n_cashRef_pct =  n_cashRef/nHouse_ownocc_mort
la var n_cashRef_pct "Mortgages Refinanced (%) (Cash-Out)"
* Save data
save full_data.dta, replace

