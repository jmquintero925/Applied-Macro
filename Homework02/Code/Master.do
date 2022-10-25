**************************************************************
***** Applied Macro: Micro data for Macro Models   ***********
***** Author: Jose M. Quintero 		 	   ***********
***** TA: Olivia Bordeou   			   ***********
**************************************************************

* this is the Master Do File

* Set Directory
cd "/home/jmquintero925/Applied-Macro/Homework02/"
* Open log 
log using log/hw2, replace
* Use key for Census data
global censuskey 29fe8274c2595575c04b2320567ada96538b3660
* Run Census Data
do Code/ACS.do
* Run Zillow Prices
do Code/Zillow.do
* Run HDMA data
do Code/clean_hdma.do
*Merge data
do Code/Merge_data.do
* Close log
log close 	 
