#!/bin/bash
#SBATCH -p bigmem 
#SBATCH --mem 600GB
#SBATCH --cpus-per-task=30
#SBATCH --job-name=metaspades_oran
#SBATCH -o /shared/projects/oran_lake_meta/results/metaSpades/metaSpades_1_5_default/slurm_metaSpades_default.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/metaSpades/metaSpades_1_5_default/slurm_metaSpades_default.%N.%j.err


path_to_data=/shared/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic
path_output_metaSpades=/shared/projects/oran_lake_meta/results/metaSpades/metaSpades_1_5_default
#path_output_quast=${path_output_metaSpades}/quast


module load spades/3.14.1

#MetaSpades Sans params
#spades.py --meta --only-assembler -1 ${path_to_data}/1-5-combined_1P.fq.gz -2 ${path_to_data}/1-5-combined_2P.fq.gz -t #$SLURM_CPUS_PER_TASK -m $SLURM_MEM_PER_NODE -o ${path_output_metaSpades}/

spades.py --restart-from k55 -o ${path_output_metaSpades}/

module unload spades/3.14.1


