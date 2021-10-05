#!/bin/bash
#SBATCH -p fast
#SBATCH -J seqkit_oran
#SBATCH --cpus-per-task 8
#SBATCH --mem 20GB
#SBATCH -o /shared/projects/oran_lake_meta/results/seqkit/slurm_seqkit_cov.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/seqkit/slurm_seqkit_cov.%N.%j.err

data_path=/shared/projects/oran_lake_meta/results/metaSpades/metaSpades_1_5/contigs.fasta
data_path_2=/shared/projects/oran_lake_meta/results/metaSpades/metaSpades_6_12/contigs.fasta
data_output=/shared/projects/oran_lake_meta/results/seqkit/contigs_validate_1_5_cov.fasta
data_output_2=/shared/projects/oran_lake_meta/results/seqkit/contigs_validate_6_12_cov.fasta
id_file=/shared/projects/oran_lake_meta/data/contig_rm/file_rm_1_5_cov
id_file_2=/shared/projects/oran_lake_meta/data/contig_rm/file_rm_6_12_cov


module load seqkit/0.14.0
#vire contigs coverage < 90 ou profondeur moyenne < 1 

seqkit grep -v -f $id_file $data_path -o $data_output
seqkit grep -v -f $id_file_2 $data_path_2 -o $data_output_2

module unload seqkit/0.14.0
