

* Figure 1
twoway scatter n_ref_pct zIndx_g, plotregion(fcolor(white)) ///
	   graphregion(fcolor(white)) xti("Price Growth (5-year)") yti("Share Mortgages Refinanced (Total)") ///
	   legend(off) ylabel(,nogrid format(%3.2f)) xlabel(,format(%3.2f))
graph export "Figures/price_growth.pdf", replace	   	   

* Figure 2
twoway scatter n_cashRef_pct zIndx_g, plotregion(fcolor(white)) ///
	   graphregion(fcolor(white)) xti("Price Growth (5-year)") yti("Share Mortgages Refinanced (Cash Out)") ///
	   legend(off) ylabel(,nogrid format(%3.2f)) xlabel(,format(%3.2f))
graph export "Figures/price_growth2.pdf", replace

* Regressions
eststo reg1: reg n_ref_pct zIndx_g [aw=nHouse], cl(cbsacode)
eststo reg2: reg n_cashRef_pct zIndx_g [aw=nHouse], cl(cbsacode)
esttab using Tables/price_regs.tex, se replace
eststo clear

* Figure 3 
twoway scatter loan2val_m zIndx_g if loan2val_m<100, plotregion(fcolor(white)) yscale(log) ///
		graphregion(fcolor(white)) xti("Price Growth (5-year)") yti("Leverage (Mean)") ///
		legend(off) ylabel(,nogrid format(%3.2f)) xlabel(,format(%3.2f))
graph export "Figures/leverage_mean.pdf", replace	   	   
		

* Figure 4		
twoway scatter loan2val_p50 zIndx_g, plotregion(fcolor(white)) ///
	   graphregion(fcolor(white)) xti("Price Growth (5-year)") yti("Leverage (Median)") ///
	   legend(off) ylabel(,nogrid format(%3.2f)) xlabel(,format(%3.2f))
graph export "Figures/leverage_median.pdf", replace	   	   	   


*Run an OLS regression of refinancing propensities at the regional level on median leverage weighted by number of housing units.
eststo refi: reg n_ref_pct loan2val_p50 [aw=nHouse], cl(cbsacode)
eststo carefi: reg n_cashRef_pct loan2val_p50 [aw=nHouse], cl(cbsacode)
esttab using Tables/leverage_regs.tex, se replace
