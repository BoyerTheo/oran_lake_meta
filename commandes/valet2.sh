#!/bin/bash
#SBATCH -t 3-00:00
#SBATCH -p bigmem 
#SBATCH --job-name=valet_oran
#SBATCH --cpus-per-task=30
#SBATCH --mem 350GB
#SBATCH -o /shared/projects/oran_lake_meta/results/valet/slurm_valet2_metaspades.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/valet/slurm_valet2_metaspades.%N.%j.err

path_to_data=/shared/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic
##assembly => contigs sup 1000pb
path_assembly=/shared/projects/oran_lake_meta/results/seqkit/
path_output=/shared/projects/oran_lake_meta/results/valet/metaSpades

#chargement du module megahit
module load valet/1.0


#commandes
valet.py -a $path_assembly/metaspades_contig_sup_1000.fasta -1 $path_to_data/1-5-combined_1P.fq.gz -2 $path_to_data/1-5-combined_2P.fq.gz -o $path_output -p $SLURM_CPUS_PER_TASK -q --skip-reapr 

#$SLURM_MEM_PER_NODE

module unload valet/1.0
