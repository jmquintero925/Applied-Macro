#!/bin/bash


# create a new scratch directory for this job
SCRATCHDIR="/scratch/midway2/${USER}/BUSN33942/"
mkdir -p $SCRATCHDIR



for year in 2020 2021
do
    # First, download the zip file from HDMA
    wget https://s3.amazonaws.com/cfpb-hmda-public/prod/snapshot-data/${year}/${year}_public_lar_csv.zip -P $SCRATCHDIR
    # Then, unzip file in directory and then delete the zip file
    unzip $SCRATCHDIR/${year}_public_lar_csv.zip
    rm $SCRATCHDIR/${year}_public_lar_csv.zip
done
