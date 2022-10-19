#!/bin/sh

#SBATCH --partition=standard
#SBATCH --job-name=microdata_rocks
#SBATCH --output=slurmlogs/microdata_rocks_%j.out
#SBATCH --error=slurmlogs/microdata_rocks_%j.err
#SBATCH --time=30:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=5
#SBATCH --mem-per-cpu=10g
#SBATCH --mail-type=END,FAIL

module load R
module load gdal
module load udunits
R < 1_load.R --no-save 
