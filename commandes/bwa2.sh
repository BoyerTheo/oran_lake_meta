#!/bin/bash
#SBATCH -p long
#SBATCH --job-name=bwa_oran
#SBATCH --cpus-per-task=30
#SBATCH --mem 100GB
#SBATCH -o /shared/projects/oran_lake_meta/results/final/bwa/bwa_metaspades_6_12/bwa_metaSpades_6_12/slurm_bwa.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/final/bwa/bwa_metaspades_6_12/bwa_metaSpades_6_12/slurm_bwa.%N.%j.err

module load bwa/0.7.17
module load samtools/1.10
##Mapping pour l'assemblage de metaSpades dont les contigs en défauts ont été viré

path_data=/shared/projects/oran_lake_meta/results/seqkit/
path_read=/shared/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic

cd /shared/projects/oran_lake_meta/results/final/bwa/bwa_metaspades_6_12

##Creation de l'index
bwa index -a bwtsw ${path_data}/contigs_validate_6_12_cov.fasta

#alignement
bwa mem ${path_data}/contigs_validate_6_12_cov.fasta ${path_read}/6-12-combined_1P.fq.gz ${path_read}/6-12-combined_2P.fq.gz  > mapping_6_12.sam
samtools view -S -b mapping_6_12.sam > mapping_6_12.bam
samtools flagstat mapping_6_12.bam

module unload bwa/0.7.17
module unload samtools/1.10
