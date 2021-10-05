#!/bin/bash

#SBATCH -p long
#SBATCH --job-name=squeeze_meta_oran
#SBATCH --cpus-per-task=40
#SBATCH --mem 245GB
#SBATCH -o /shared/projects/oran_lake_meta/results/squeezemeta/slurm_sqm_6_12.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/squeezemeta/slurm_sqm_6_12.%N.%j.err

project_name=oran_lake #pas besoin en séquentiel
path_reads=/shared/ifbstor1/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic
path_data=/shared/projects/oran_lake_meta/results/squeezemeta/sample_file_2.txt

module load squeezemeta/1.4.0beta1 

#Script :
cd /shared/projects/oran_lake_meta/results/squeezemeta/
SqueezeMeta.pl -m sequential -s $path_data -f $path_reads --euk --D --singletons -t $SLURM_CPUS_PER_TASK -b 20

module unload squeezemeta/1.4.0beta1 
