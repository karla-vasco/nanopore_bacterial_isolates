#!/bin/bash --login  

######### Assign path variables ########
INPUT_DIR=/mnt/scratch/vascokar/cef_strains/prokka
OUTPUT_DIR=/mnt/scratch/vascokar/cef_strains/Roary

module purge
module load icc/2018.1.163-GCC-6.4.0-2.28  impi/2018.1.163
module load Roary/3.12.0-Perl-5.26.1

roary -e --mafft -p 8 \
-f $OUTPUT_DIR \
$INPUT_DIR/*/*.gff
