#!/bin/bash --login
INPUT_DIR=/mnt/home/vascokar/cef_strains/20210421_gDNA_ONT_2/fastq_pass
OUTPUT_DIR=/mnt/home/vascokar/cef_strains/20210421_gDNA_ONT_2/fastq_pass/cat_fastq

cd $INPUT_DIR
for dir in */; # for each sample dir
do
  n=${dir%%/} # strip the directory name
cat $INPUT_DIR/${n}/*fastq.gz > $OUTPUT_DIR/${n}.fastq.gz
done
