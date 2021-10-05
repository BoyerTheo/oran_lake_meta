#!/bin/bash
#SBATCH -p long 
#SBATCH --job-name=kraken2_oran
#SBATCH --cpus-per-task=40
#SBATCH --mem 245GB
#SBATCH -o /shared/projects/oran_lake_meta/results/kraken2/trimmed_read_report_6_12/slurm_kraken2.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/kraken2/trimmed_read_report_6_12/slurm_kraken2.%N.%j.err

dbname=/shared/bank/nt/nt_2021-01-29/kraken2
path_to_data=/shared/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic
path_output=/shared/projects/oran_lake_meta/results/kraken2/trimmed_read_report_6_12

#chargement du module megahit
module load kraken2/2.0.9beta 


#commandes 
kraken2 --db $dbname --paired --gzip-compressed --report-zero-counts --threads $SLURM_CPUS_PER_TASK --unclassified-out ${path_output}/output_unclassified_kraken#.fq --classified-out ${path_output}/output_classified_kraken#.fq --report ${path_output}/report_kraken2 ${path_to_data}/6-12-combined_1P.fq.gz ${path_to_data}/6-12-combined_2P.fq.gz --use-mpa-style

#fermeture module megahit & quast
module unload kraken2/2.0.9beta


