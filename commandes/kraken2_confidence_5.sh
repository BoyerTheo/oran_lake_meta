#!/bin/bash
#SBATCH -p fast 
#SBATCH --job-name=kraken2_05_oran
#SBATCH --cpus-per-task=40
#SBATCH --mem 245GB
#SBATCH -o /shared/projects/oran_lake_meta/results/kraken2/confidence_scoring_test_6_12/slurm_kraken2_confidence_05.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/kraken2/confidence_scoring_test_6_12/slurm_kraken2_confidence_05.%N.%j.err

dbname=/shared/bank/nt/nt_2021-01-29/kraken2
path_to_data=/shared/projects/oran_lake_meta/results/metaSpades/metaSpades_6_12
path_output=/shared/projects/oran_lake_meta/results/kraken2/confidence_scoring_test_6_12

#chargement du module megahit
module load kraken2/2.0.9beta 

#commandes 
kraken2 --db $dbname --report-zero-counts --confidence 0.5 --threads $SLURM_CPUS_PER_TASK --report ${path_output}/report_kraken2_05 ${path_to_data}/contigs.fasta

#fermeture module megahit & quast
module unload kraken2/2.0.9beta


