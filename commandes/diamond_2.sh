#!/bin/bash

#SBATCH -p fast
#SBATCH --job-name=diamond_oran
#SBATCH --cpus-per-task=40
#SBATCH --mem 245GB
#SBATCH -o /shared/projects/oran_lake_meta/results/prodigal/1_5_sample/bacteria/slurm_diamond.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/prodigal/1_5_sample/bacteria/slurm_diamond.%N.%j.err


path_data=/shared/projects/oran_lake_meta/results/prodigal/1_5_sample/bacteria/bacteria_prot.faa
path_read=/shared/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic
path_output=/shared/projects/oran_lake_meta/results/prodigal/1_5_sample/bacteria/
path_db=/shared/bank/nr/nr_2020-7-19/diamond/nr.dmnd

module load diamond/0.9.36

diamond blastp -d ${path_db} -q ${path_data} -e 0.0001 -k 20 --threads $SLURM_CPUS_PER_TASK --out ${path_output}/diamond_output.daa --outfmt 100

module unload diamond/0.9.36
