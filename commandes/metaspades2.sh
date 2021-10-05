#!/bin/bash
#SBATCH -p bigmem
#SBATCH --mem 350GB
#SBATCH --job-name=metaspades2_oran
#SBATCH --cpus-per-task=30
#SBATCH -o /shared/projects/oran_lake_meta/results/metaSpades/metaSpades_6_12/slurm_metaSpades_6_12_resume.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/metaSpades/metaSpades_6_12/slurm_metaSpades_6_12_resume.%N.%j.err


path_to_data=/shared/projects/oran_lake_meta/results/trimmomatic/120221_trimmomatic
path_output_metaSpades=/shared/projects/oran_lake_meta/results/metaSpades/metaSpades_1_5-27-97
#path_output_quast=${path_output_metaSpades}/quast


module load spades/3.14.1

#MetaSpades params equivalent k_min = 27; k_max = 127; step = 10
spades.py --meta --only-assembler -1 ${path_to_data}/1-5-combined_1P.fq.gz -2 ${path_to_data}/1-5-combined_2P.fq.gz -t $SLURM_CPUS_PER_TASK -m $SLURM_MEM_PER_NODE -k 27,37,47,57,67,77,87,97 -o ${path_output_metaSpades} 

#spades.py --restart-from k65 -o ${path_output_metaSpades}/

module unload spades/3.14.1

