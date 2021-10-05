#!/bin/bash

#SBATCH -p fast
#SBATCH --job-name=bwa_oran
#SBATCH --cpus-per-task=30
#SBATCH --mem 100GB
#SBATCH -o /shared/projects/oran_lake_meta/results/bwa/bwa_metaSpades_1_5/slurm_bwa_coverage.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/bwa/bwa_metaSpades_1_5/slurm_bwa_coverage.%N.%j.err


module load samtools/1.10

path_bam_file=/shared/projects/oran_lake_meta/results/bwa/bwa_metaSpades_6_12/

cd $path_bam_file

samtools sort -o ${path_bam_file}/mapping_sorted_6_12.bam -@ $SLURM_CPUS_PER_TASK ${path_bam_file}/mapping_6_12.bam
samtools coverage ${path_bam_file}/mapping_sorted_6_12.bam > mapping_6_12_coverage.tsv

module unload samtools/1.10
