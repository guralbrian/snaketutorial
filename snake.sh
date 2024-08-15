#!/bin/bash

#SBATCH --job-name=snakemake_job
#SBATCH --time=240
#SBATCH --mem=1000

# Load your R and Python modules
module load r r/4.3.1
module load python/3.9.6

snakemake -j 36 --latency-wait 60 --cluster "sbatch --mem=16gb -N 1 -n 1 -o ./.slurmlogs/%j.out" 

snakemake --rulegraph | dot -Tsvg > dag.svg