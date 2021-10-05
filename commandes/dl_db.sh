#!/bin/bash

#SBATCH -p fast
#SBATCH --job-name=dl_db_oran
#SBATCH --cpus-per-task=12
#SBATCH --mem 20GB
#SBATCH -o /shared/projects/oran_lake_meta/data/database_sq/slurm_dl_db_1.%N.%j.out
#SBATCH -e /shared/projects/oran_lake_meta/data/database_sq/slurm_dl_db_1.%N.%j.err

path_db=/shared/projects/oran_lake_meta/data/database_sq/

module load squeezemeta/1.3.1

download_databases.pl $path_db
test_install.pl

module load squeezemeta/1.3.1
