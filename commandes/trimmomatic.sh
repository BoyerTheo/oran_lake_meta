#!/bin/bash
#SBATCH --job-name=trimmomatic_oran
#SBATCH --mem=20GB
#SBATCH --cpus-per-task=12
#SBATCH -n 2


path_data=/shared/projects/oran_lake_meta/data
path_output=/shared/projects/oran_lake_meta/results/trimmomatic
path_adaptor=/shared/projects/oran_lake_meta/data/illumina_adaptators/

#initialisation du module du core cluster 
module load trimmomatic/0.39

#commandes trimmomatic
trimmomatic PE -threads $SLURM_CPUS_PER_TASK -phred33 -summary ${path_output}/summary_1-5.txt ${path_data}/1-5-combined_R1_001.fastq.gz ${path_data}/1-5-combined_R2_001.fastq.gz -baseout ${path_output}/1-5-combined.fq.gz ILLUMINACLIP:${path_adaptor}/TruSeq3-PE.fa:2:30:10 TRAILING:30

trimmomatic PE -threads $SLURM_CPUS_PER_TASK -phred33 -summary ${path_output}/summary_6-12.txt ${path_data}/6-12-combined_R1_001.fastq.gz ${path_data}/6-12-combined_R2_001.fastq.gz -baseout ${path_output}/6-12-combined.fq.gz ILLUMINACLIP:${path_adaptor}/TruSeq3-PE.fa:2:30:10 TRAILING:30

#fermeture du module
module unload trimmomatic/0.39
