#!/bin/bash

#SBATCH -p bigmem 
#SBATCH --job-name=squeeze_meta_oran
#SBATCH --cpus-per-task=12
#SBATCH --mem 555
#SBATCH -o /shared/projects/oran_lake_meta/results/squeezemeta/slurm_sqm2tables.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/squeezemeta/slurm_sqm2tables.%N.%j.err


module load squeezemeta/1.4.0beta1

path="/shared/projects/oran_lake_meta/results/squeezemeta/"
sqm2tables.py --force-overwrite ${path}/sample-1-5 ${path}/table-1-5

module unload squeezemeta/1.4.0beta1
