#!/bin/bash
#SBATCH -p fast 
#SBATCH --job-name=kraken2_oran
#SBATCH --cpus-per-task=40
#SBATCH --mem 245GB
#SBATCH -o /shared/projects/oran_lake_meta/results/kraken2/metaSpades_report_6_12/slurm_kraken2_metaS.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/kraken2/metaSpades_report_6_12/slurm_kraken2_metaS.%N.%j.err

dbname=/shared/bank/nt/nt_2021-01-29/kraken2
path_to_data=/shared/projects/oran_lake_meta/results/metaSpades/metaSpades_1_5
path_output=/shared/projects/oran_lake_meta/results/kraken2/metaSpades_report_1_5

#chargement du module kraken2
module load kraken2/2.0.9beta 


#commandes 
kraken2 --db $dbname --threads $SLURM_CPUS_PER_TASK ${path_to_data}/contigs.fasta > kraken_seq_assignation_1_5_2.tsv

#fermeture module kraken2
module unload kraken2/2.0.9beta


