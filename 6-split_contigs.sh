#!/bin/bash --login
INPUT_DIRECTORY=/mnt/scratch/vascokar/cef_strains/2-Flye/ONT_2
OUTPUT_DIRECTORY=/mnt/scratch/vascokar/cef_strains/3-Contigs/ONT_2

cd $INPUT_DIRECTORY

for dir in */; # for each sample dir
do
  n=${dir%%/} # strip the directory name

cp $INPUT_DIRECTORY/${n}/assembly.fasta  $OUTPUT_DIRECTORY/${n}_assembly.fasta
cp $INPUT_DIRECTORY/${n}/assembly_info.txt  $OUTPUT_DIRECTORY/${n}_assembly_info.txt
cp $INPUT_DIRECTORY/${n}/22-plasmids/plasmids_raw.fasta  $OUTPUT_DIRECTORY/${n}_plasmids_raw.fasta
cp $INPUT_DIRECTORY/${n}/22-plasmids/polished_1.fasta  $OUTPUT_DIRECTORY/${n}_plasmids_polished.fasta
cp $INPUT_DIRECTORY/${n}/22-plasmids/contigs_stats.txt  $OUTPUT_DIRECTORY/${n}_plasmid_stats.txt

#Organize files in folders
mkdir $OUTPUT_DIRECTORY/fasta $OUTPUT_DIRECTORY/stats
mv $OUTPUT_DIRECTORY/*.fasta $OUTPUT_DIRECTORY/fasta
mv $OUTPUT_DIRECTORY/*.txt $OUTPUT_DIRECTORY/stats

#Organize sequences by type
mkdir $OUTPUT_DIRECTORY/fasta/chromosome $OUTPUT_DIRECTORY/fasta/plasmid $OUTPUT_DIRECTORY/fasta/assemblies
mv $OUTPUT_DIRECTORY/fasta/*_plasmids_* $OUTPUT_DIRECTORY/fasta/plasmid
mv $OUTPUT_DIRECTORY/fasta/*_assembly.fasta $OUTPUT_DIRECTORY/fasta/assemblies

#Split contigs into different files
cat  $OUTPUT_DIRECTORY/fasta/assemblies/${n}_assembly.fasta |\
awk '/^>/ {if(N>0) printf("\n"); printf("%s\n",$0);++N;next;} { printf("%s",$0);} END {printf("\n");}' |\
split -l 2 --additional-suffix=.fasta -  $OUTPUT_DIRECTORY/fasta/chromosome/${n}_

#Move plasmid sequences to the plasmid folder
find $OUTPUT_DIRECTORY/fasta/chromosome/ -type f -size -3M -exec mv "{}" $OUTPUT_DIRECTORY/fasta/plasmid/ \;

done
