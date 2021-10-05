#!/bin/bash
#SBATCH --job-name=fastqc_oran
#SBATCH --mem 10GB
#SBATCH --cpus-per-task=8

path_data=/shared/projects/oran_lake_meta/data
path_output=/shared/projects/oran_lake_meta/results/fastqc

#initialisation du module du core cluster
module load fastqc/0.11.9
#commande fastqc
fastqc --threads $SLURM_CPUS_PER_TASK ${path_data}/1-5-combined_R1_001.fastq.gz ${path_data}/1-5-combined_R2_001.fastq.gz ${path_data}/6-12-combined_R1_001.fastq.gz ${path_data}/6-12-combined_R2_001.fastq.gz --outdir ${path_output} 

#fermeture du module
module unload fastqc/0.11.9
