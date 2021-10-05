#!/bin/bash
#SBATCH --job-name=quast_oran
#SBATCH --cpus-per-task=20
#SBATCH --mem 80GB
#SBATCH -o /shared/projects/oran_lake_meta/results/metaSpades/metaSpades_1_5-27-97/quast/slurm.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/results/metaSpades/metaSpades_1_5-27-97/quast/slurm.%N.%j.err
_
path_to_data=/shared/projects/oran_lake_meta/results/metaSpades/metaSpades_1_5-27-97/
path_output=/shared/projects/oran_lake_meta/results/metaSpades/metaSpades_1_5-27-97/quast/

#chargement du module megahit
module load quast/5.0.2

#commande
quast ${path_to_data}/contigs.fasta -t $SLURM_CPUS_PER_TASK -o ${path_output}


#fermeture module megahit
module unload quast/5.0.2
