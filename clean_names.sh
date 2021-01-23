
#Quickly rename messy file names using sed pipeline
#Neeka Sewnath
#nsewnath@bear.flmnh.ufl.edu

#### Fetch samples #### 
# Add your sample path after ls, use * pattern to grab multiple files
# In the second part of the pipe, switch "\." to whatever delimiter you are using in the name
# In the third part of the pipe, use cut to trim down sample name
# In the fourth part of the pipe, replace "_" with desired delimiter
 
for h in `ls *indel | sed 's/\./\t/g' | cut -f1 | sed 's/\t/_/g' | sort | uniq`; do

echo ${h}

# Uncomment if you would like to rename the files. Change suffix to whatever matches your old sample name.

#mv ${h}.bam.rg_gatk_removedup_indel ${h}.bam 

# Uncomment if you would like to make renamed copies. Change suffix to whatever matches your old sample name.

cp ${h}.bam.rg_gatk_removedup_indel ${h}.bam
 
done





