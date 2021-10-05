#!/bin/bash
#SBATCH -p fast
#SBATCH --job-name=nonpareil_oran
#SBATCH --cpus-per-task=28
#SBATCH --mem 120GB
#SBATCH -o /shared/projects/oran_lake_meta/results/nonpareil/slurm_nonpareil_1.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/nonpareil/slurm_nonpareil_1.%N.%j.err

module load nonpareil/3.3.4

##Mapping pour l'assemblage de megahit n°3

path_data=/shared/projects/oran_lake_meta/results/megahit/120221_megahit_3
path_read=/shared/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic
path_output=/shared/projects/oran_lake_meta/results/nonpareil

nonpareil -s ${path_read}/1-5-combined_1P.fq.gz -T alignment -f fastq -b ${path_output}/ -L 95 -R $SLURM_MEM_PER_NODE -t $SLURM_CPUS_PER_TASK

module unload nonpareil/3.3.4
