#!/bin/bash

#SBATCH -p long
#SBATCH --job-name=bwa_oran
#SBATCH --cpus-per-task=30
#SBATCH --mem 100GB
#SBATCH -o /shared/projects/oran_lake_meta/results/final/bwa/bwa_metaspades_1_5/slurm_bwa_1.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/final/bwa/bwa_metaspades_1_5/slurm_bwa_1.%N.%j.err

module load bwa/0.7.17

##Mapping pour l'assemblage de megahit n°3

path_data=/shared/projects/oran_lake_meta/results/seqkit
path_read=/shared/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic
#path_data=/shared/projects/oran_lake_meta/results/megahit/120221_megahit_3
#path_read=/shared/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic

#cd /shared/projects/oran_lake_meta/results/bwa
cd /shared/projects/oran_lake_meta/results/final/bwa/bwa_metaspades_1_5

##Creation de l'index
bwa index -a bwtsw ${path_data}/contigs_validate_1_5_cov.fasta

#alignement
bwa mem ${path_data}/contigs_validate_1_5_cov.fasta ${path_read}/1-5-combined_1P.fq.gz ${path_read}/1-5-combined_2P.fq.gz  > 1-5-aln-cov.sam

module unload bwa/0.7.17
