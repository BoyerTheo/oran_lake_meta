#!/bin/bash

#SBATCH -p long
#SBATCH --job-name=bwa_oran
#SBATCH --cpus-per-task=30
#SBATCH --mem 100GB
#SBATCH -o /shared/projects/oran_lake_meta/results/final/bwa/bwa_metaspades_6_12/slurm_bwa_1.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/final/bwa/bwa_metaspades_6_12/slurm_bwa_1.%N.%j.err

module load bwa/0.7.17

##Mapping pour l'assemblage de megahit n°3

path_data=/shared/projects/oran_lake_meta/results/seqkit
path_read=/shared/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic
#path_data=/shared/projects/oran_lake_meta/results/megahit/120221_megahit_3
#path_read=/shared/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic

#cd /shared/projects/oran_lake_meta/results/bwa
cd /shared/projects/oran_lake_meta/results/final/bwa/bwa_metaspades_6_12

##Creation de l'index
bwa index -a bwtsw ${path_data}/contigs_validate_6_12_cov.fasta

#alignement
bwa mem ${path_data}/contigs_validate_6_12_cov.fasta ${path_read}/6-12-combined_1P.fq.gz ${path_read}/6-12-combined_2P.fq.gz  > aln-pe.sam

module unload bwa/0.7.17
