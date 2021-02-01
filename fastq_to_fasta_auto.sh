#Quickly convert files from .fastq to .fasta using sed pipeline
#Neeka Sewnath
#nsewnath@ufl.edu

#### Fetch samples #### 
# Add your sample path after ls, use * pattern to grab multiple files
# In the second part of the pipe, switch "\." to whatever delimiter you are using in the name
# In the third part of the pipe, use cut to trim down sample name
# In the fourth part of the pipe, replace "_" with desired delimiter

for h in `ls *.fastq | sed 's/\./\t/g' | cut -f1 | sed 's/\t/_/g' | sort | uniq`; do

echo ${h}

#Convert from fastq to fasta using sed
sed -n '1~4s/^@/>/p;2~4p' ${h}.fastq > ${h}.fasta
 
done
