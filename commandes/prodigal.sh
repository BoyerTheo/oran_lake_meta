#!/bin/bash
#SBATCH -p fast 
#SBATCH --job-name=prodigal_oran
#SBATCH --cpus-per-task=20
#SBATCH --mem 40GB
#SBATCH -o /shared/projects/oran_lake_meta/results/prodigal/1_5_sample/slurm_prodigal.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/prodigal/1_5_sample/slurm_prodigal.%N.%j.err

path_output=/shared/projects/oran_lake_meta/results/prodigal/1_5_sample/
path_data=/shared/projects/oran_lake_meta/data

module load prodigal/2.6.3 

prodigal -i ${path_data}/bacteria_seq.fasta -p meta -f gff -a ${path_output}/bacteria/bacteria_prot.faa -o ${path_output}/bacteria/bacteria_gene.gff 
prodigal -i ${path_data}/archaea_seq.fasta  -p meta -f gff -a ${path_output}/archaea/archaea_prot.faa -o ${path_output}/archaea/archaea_gene.gff

module unload prodigal/2.6.3
