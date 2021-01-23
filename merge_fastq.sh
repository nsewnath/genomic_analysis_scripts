###Merging Fastq Sequence Files###
#Neeka Sewnath
#nsewnath@ufl.edu

#The inital sed pipeline is modified to handle the names of my samples. In order to customzie it for your own
#make sure you modifiy cut and change the delimeter "_" to whatever delimeter your sample name has
#within the first sed command.

#To grab the forward and reverse reads, substitute "R1" and "R2" with unique forward and reverse
#identifiers in your sample name. 

#Fetch sample names
for h in `ls *.fastq | sed 's/_/\t/g' | cut -f1 | sed 's/\t/_/g' | sort | uniq`; do

echo ${h}

#Fetching forward reads
i=`ls ./*.fastq | grep "${h}" | grep R1 | head -1`;
echo ${i}

#Fetching reverse reads
j=`ls ./*.fastq | grep "${h}" | grep R2 | head -1`;
echo ${j}

#Merge sequences
cat ${i} ${j} > ${h}_merged.fastq


done
