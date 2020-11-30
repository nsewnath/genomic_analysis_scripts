#Calculating Average E-Scores (Assess DNA Quality)

#Neeka Sewnath
#nsewnath@ufl.edu


#Fetch trimmed fasta files
for h in `ls ./trimmed_reads2.0_fasta/ | sort | uniq`; do
echo ${h}

#Run blastn and generate an output file with sequence ID and evalues
blastn -query ${h}_indexed -db reference -outfmt 10 |sed 's/,/\t/g'|cut -f1,2,11|sed 's/\t/:/g'|sort -u -t : -k1,1|uniq  >  ${h}_eval_w_ID 
echo blast finished

#Isolate e-values
cut -f3 -d ':' ${h}_eval_w_ID > ${h}_e-values
echo isolation finished

#Get the total number of reads in the output file
total_length=`grep -c ">" ${h}_indexed`
echo Total length is:
echo ${total_length}

#For every value less than 2e-5, store in good array
mapfile -t result < <(awk '{if($1<2e-5)print$1}' ${h}_e-values )

#Get count of good e-values
good_count=${#result[@]}
echo Good Count is:
echo ${good_count}

#Divide bad evalues by total length
echo Good Count Amount / Total Number of Reads
echo "scale=2 ; ${good_count}/${total_length}" | bc 

done








