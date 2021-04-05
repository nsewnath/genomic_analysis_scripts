#Quickly split lines of a file into multiple, numbered files with bash loop
#Neeka Sewnath
#nsewnath@ufl.edu

###Fetch Samples###

# Add your sample path after la, use * pattern to grab multiple files
# In the second part of the pipe, switch "\." to whatever delimiter you are using in the name
# In the third part of the pipe, use cut to trim down sample name
# In the fourth part of the pipe, replace "_" with desired delimiter 

for h in `ls *.ml | sed 's/\./\t/g' | cut -f1 | sort | uniq`; do

echo ${h}

# initiate counter
counter=1

# Reach files and assign every line of file to new file
while read LINE; do echo $LINE > ${h}_${counter}.ml; counter=$((counter+1)); done < ${h}.ml

done
