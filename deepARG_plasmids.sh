#!/bin/bash --login  

######### Assign path variables ########

INPUT_DIRECTORY=/mnt/home/vascokar/cef_strains/assemblies/plasmids
DEEPARG_DATA=/mnt/home/vascokar/mastitis_study/bin/deeparg
DEEPARG_ACTIVATE=/mnt/home/vascokar/mastitis_study/bin/env/bin/activate
OUTPUT_DIRECTORY=/mnt/scratch/vascokar/cef_strains/deepARG/plasmids

########## Modules to Load ##########

module purge
module load DIAMOND/2.0.1
module load GCCcore/9.3.0
module load Python/2.7.18

########## Code to Run ###########

source $DEEPARG_ACTIVATE

cd $INPUT_DIRECTORY

for f in *.fasta # for each sample f
do
  n=${f%%.fasta} # strip part of file name

deeparg predict \
    --model LS \
    -i $INPUT_DIRECTORY/${n}.fasta \
    -o $OUTPUT_DIRECTORY/${n}_deepARG \
    -d $DEEPARG_DATA \
    --type nucl \
    --min-prob 0.8 \
    --arg-alignment-identity 50 \
    --arg-alignment-evalue 1e-10 \
    --arg-num-alignments-per-entry 1000
done

deactivate
