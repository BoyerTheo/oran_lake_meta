#!/bin/bash
#SBATCH -p fast
#SBATCH --job-name=megan_oran
#SBATCH --cpus-per-task=20
#SBATCH --mem 100GB
#SBATCH -o /shared/projects/oran_lake_meta/results/megan/slurm_megan.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/megan/slurm_megan.%N.%j.err

path_data=/shared/projects/oran_lake_meta/results/diamond/
path_output=/shared/projects/oran_lake_meta/results/megan/
path_db=/shared/projects/oran_lake_meta/results/megan

module load megan/6.21.2

daa-meganizer -i ${path_data}/diamond_sample_output.daa --longReads --lcaAlgorithm longReads --mapDB $path_db/megan-map-Jan2021.db -t $SLURM_CPUS_PER_TASK

module unload megan/6.21.2
