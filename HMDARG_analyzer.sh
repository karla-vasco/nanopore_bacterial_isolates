#!/bin/bash --login
 
########## Define Resources Needed with SBATCH Lines ##########
#SBATCH --job-name=hmdarg_analyzer  # give your job a name for easier identification (same as -J)
#SBATCH --time=168:00:00        # limit of wall clock time - how long will the job take to run? (same as -t)
#SBATCH --ntasks=8           # number of tasks - how many tasks (nodes) does your job require? (same as -n)
#SBATCH --cpus-per-task=4    # number of CPUs (or cores) per task (same as -c)
#SBATCH --mem=50G             # memory required per node - amount of memory (in bytes)
#SBATCH --output=/mnt/scratch/vascokar/cef_strains/eofiles/hmdarg_analyzer.%j.out #Standard output
#SBATCH --error=/mnt/scratch/vascokar/cef_strains/eofiles/hmdarg_analyzer.%j.err #Standard error log

########## Diplay the job context ######
echo Job: $SLUM_JOB_NAME with ID $SLURM_JOB_ID
echo Running on host `hostname`
echo Job started at `date '+%T %a %d %b %Y'`
echo Directory is `pwd`
echo Using $SLURM_NTASKS processors across $SLURM_NNODES nodes

######### Assign path variables ########

RESITOMEANALYZER_DIRECTORY=/mnt/home/vascokar/mastitis_study/bin/resistomeanalyzer
DATABASE_PATH=/mnt/scratch/vascokar/cef_strains/HMDARG/arg_v5_linear.fasta
ANNOTATION_PATH=/mnt/scratch/vascokar/cef_strains/HMDARG/annotations_hmd-arg.csv
INPUT_DIRECTORY=/mnt/scratch/vascokar/cef_strains/HMDARG/plasmid
OUTPUT_DIRECTORY=/mnt/scratch/vascokar/cef_strains/HMDARG/plasmid/analyzer

########## Modules to Load ##########
module purge
module load GCC/10.2.0

########## Code to Run ###########
cd $INPUT_DIRECTORY

for f in *_hmdarg_matches.sam # for each sample f
do
  n=${f%%_hmdarg_matches.sam} # strip part of file name

cd $RESITOMEANALYZER_DIRECTORY

./resistome \
-ref_fp $DATABASE_PATH \
-annot_fp $ANNOTATION_PATH \
-sam_fp $INPUT_DIRECTORY/${n}_hmdarg_matches.sam \
-gene_fp $OUTPUT_DIRECTORY/${n}_hmdarg_gene.tsv \
-group_fp $OUTPUT_DIRECTORY/${n}_hmdarg_mobility.tsv \
-mech_fp $OUTPUT_DIRECTORY/${n}_hmdarg_mech.tsv \
-class_fp $OUTPUT_DIRECTORY/${n}_hmdarg_class.tsv \
-t 80

done

##### Final time stamp ######
echo Job finished at `date '+%T %a %d %b %Y'`
