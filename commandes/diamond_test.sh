#!/bin/bash
#SBATCH -p fast
#SBATCH --job-name=diamond_oran
#SBATCH --cpus-per-task=40
#SBATCH --mem 245GB
#SBATCH -o /shared/projects/oran_lake_meta/results/diamond/slurm_diamond_sample.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/diamond/slurm_diamond_sample.%N.%j.err


path_data=/shared/projects/oran_lake_meta/data/sample_bacteria.fasta
path_output=/shared/projects/oran_lake_meta/results/diamond/
path_db=/shared/bank/nr/nr_2020-7-19/diamond/nr.dmnd

module load diamond/0.9.36

diamond blastx -d ${path_db} -q ${path_data} --sensitive -F 15 --range-culling --top 10 -e 0.000001 --threads $SLURM_CPUS_PER_TASK --out ${path_output}/diamond_sample_output.daa --outfmt 100

module unload diamond/0.9.36
