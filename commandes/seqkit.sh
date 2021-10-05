#!/bin/bash
#SBATCH -p fast
#SBATCH -J seqkit_oran
#SBATCH --cpus-per-task 8
#SBATCH --mem 20GB
#SBATCH -o /shared/projects/oran_lake_meta/results/seqkit/slurm_seqkit_megahit.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/seqkit/slurm_seqkit_megahit.%N.%j.err

data_path=/shared/projects/oran_lake_meta/results/megahit/120221_megahit_3/final.contigs.fa
data_output=/shared/projects/oran_lake_meta/results/seqkit

module load seqkit/0.14.0

seqkit seq -m 1000 $data_path > $data_output/megahit_contig_sup_1000.fasta 
#script python permettant de récuperer les ids à enlever
#cat ${data_output}/megahit/megahit_contig_sup_1000.fasta|seqkit grep -v -f ${data_output}/megahit/contigs_to_remove.txt > ${data_output}/megahit/contigs_validate.fasta


module unload seqkit/0.14.0
