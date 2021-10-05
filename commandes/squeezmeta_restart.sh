#!/bin/bash

#SBATCH -p fast
#SBATCH --job-name=squeeze_meta_oran
#SBATCH --cpus-per-task=40
#SBATCH --mem 245GB
#SBATCH -o /shared/projects/oran_lake_meta/results/squeezemeta/slurm_sqm_restart.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/squeezemeta/slurm_sqm_restart.%N.%j.err

project_name=oran_lake #pas besoin en séquentiel
path_reads=/shared/ifbstor1/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic
path_data=/shared/projects/oran_lake_meta/results/squeezemeta/sample_file.txt

module load squeezemeta/1.4.0beta1

#Script :
cd /shared/projects/oran_lake_meta/results/squeezemeta/
restart.pl sample-6-12/ -step 13

module unload squeezemeta/1.4.0beta1
