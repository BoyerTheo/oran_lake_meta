#!/bin/bash

#SBATCH -p long
#SBATCH --job-name=diamond_oran
#SBATCH --cpus-per-task=40
#SBATCH --mem 245GB
#SBATCH -o /shared/projects/oran_lake_meta/results/diamond/diamond_1_5/slurm_bwa.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/diamond/diamond_1_5/slurm_bwa.%N.%j.err


path_data=/shared/projects/oran_lake_meta/results/metaSpades/150221_metaSpades_2/contigs.fasta
path_read=/shared/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic
path_output=/shared/projects/oran_lake_meta/results/diamond/diamond_1_5/
path_db=/shared/bank/nr/nr_2020-7-19/diamond/nr.dmnd

module load diamond/0.9.36

diamond blastx -d ${path_db} -q ${path_data} --sensitive -F 15 --range-culling --top 10 -e 0.000001 -k 20 --threads $SLURM_CPUS_PER_TASK --out ${path_output}/diamond_output.daa --outfmt 100

module unload diamond/0.9.36
