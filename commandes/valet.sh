#!/bin/bash
#SBATCH -p long 
#SBATCH --job-name=valet_oran
#SBATCH --cpus-per-task=28
#SBATCH --mem 150GB
#SBATCH -o /shared/projects/oran_lake_meta/results/valet/slurm_valet_megahit.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/valet/slurm_valet_megahit.%N.%j.err

path_to_data=/shared/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic
path_assembly=/shared/projects/oran_lake_meta/results/megahit/120221_megahit_3
path_output=/shared/projects/oran_lake_meta/results/valet/megahit

#chargement du module megahit
module load valet/1.0

#commandes
valet.py -a $path_assembly/final.contigs.fa -1 $path_to_data/1-5-combined_1P.fq.gz -2 $path_to_data/1-5-combined_2P.fq.gz -o $path_output -p $SLURM_CPUS_PER_TASK -q --skip-reapr 

module unload valet/1.0
