#!/bin/bash
#SBATCH --job-name=fastqc_oran
#SBATCH --cpus-per-task=8

path_data=/shared/projects/oran_lake_meta/results/trimmomatic/110221_trimmomatic_2
path_output=/shared/projects/oran_lake_meta/results/fastqc/fastqc_after_trim

#initialisation du module du core cluster
module load fastqc/0.11.9
#commande fastqc
fastqc --threads $SLURM_CPUS_PER_TASK ${path_data}/1-5-combined_1P.fq.gz ${path_data}/1-5-combined_2P.fq.gz ${path_data}/6-12-combined_1P.fq.gz ${path_data}/6-12-combined_2P.fq.gz --outdir ${path_output} 

#fermeture du module
module unload fastqc/0.11.9
