#!/bin/bash

#SBATCH -p fast
#SBATCH --job-name=bwa_oran
#SBATCH --cpus-per-task=16
#SBATCH --mem 60GB
#SBATCH -o /shared/projects/oran_lake_meta/results/bwa/bwa_2/slurm_bam_to_sam.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/bwa/bwa_2/slurm_bam_to_sam.%N.%j.err


module load samtools/1.10

path_data=/shared/projects/oran_lake_meta/results/bwa/bwa_2

cd /shared/projects/oran_lake_meta/results/bwa/bwa_2

samtools view -b $path_data/aln-pe.sam > aln-pe.bam

module unload samtools/1.10
