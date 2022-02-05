# Script for converting *.sra files to *.fastq files using fastq-dump
# Neeka Sewnath
# nsewnath@ufl.edu

# Note: requires fastq-dump within the sra-toolkit
# https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit

filepath=path_to_sra
output_path=output_path

for h in `ls "$filepath"*.sra | sed 's/\./\t/g' | cut -f1 | sed 's/\t/_/g' | sort | uniq`; do

echo ${h}.sra

# Add fastq-dump code with your customized arguments
fastq-dump --gzip --skip-technical --readids --read-filter pass --dumpbase --split-3 --clip ${h} --outdir ${output_path}

done

