#!/bin/bash
#SBATCH -p fast 
#SBATCH --job-name=megahit_oran
#SBATCH --cpus-per-task=28
#SBATCH --mem 128GB
#SBATCH -o /shared/projects/oran_lake_meta/results/megahit/slurm_megehit1.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/megahit/slurm_megahit1.%N.%j.err

path_to_data=/shared/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic
path_output3=/shared/projects/oran_lake_meta/results/megahit/120221_megahit_3/
path_output_quast=${path_output3}/quast/

#chargement du module megahit
module load megahit/1.2.9
module load quast/5.0.2
#commande 
#Utilisation des params utilisés dans 090221_megahit:

megahit -1 ${path_to_data}/1-5-combined_1P.fq.gz -2 ${path_to_data}/1-5-combined_1P.fq.gz -m 128 -t $SLURM_CPUS_PER_TASK --k-min=27 --k-step=10 -o ${path_output3}

#lancement de quast :

quast ${path_output3}/final.contigs.fa -t $SLURM_CPUS_PER_TASK -o ${path_output_quast}

#fermeture module megahit
module unload megahit/1.2.9
module unload quast/5.0.2
