import pandas as pd
import re 
import gffpandas.gffpandas as gffpd
import numpy as np
from collections import Counter 

"""
This code is made handle the attribute duplicate errors caused by running an annotation 
pipeline multiple times. Adjust file names as needed. 

Note: This only keeps the first of the duplicate sets.

"""

#-----------------------------------------------------------------------

def remove_duplicates(data_string):

    # stage one: finding the duplicates
    data_list = re.split(r';|=', data_string) 

    labels = data_list[0::2]
    labels = np.array(labels)

    repeat_counts = Counter(labels)
    repeated_list = [num for num in repeat_counts if repeat_counts[num]>1]

    if repeated_list == []:
        return data_string

    # stage two: remove the duplicates
    data_list = data_string.split(';')

    for repeat in repeated_list:
        counter = 0
        for item in data_list:
            if repeat in item:
                if counter == 0:
                    counter = counter + 1
                else: 
                    data_list.remove(item)

    # stage three: concatenate the list back into a string with ;
    return ";".join(data_list)

#-----------------------------------------------------------------------

species_name = 'Corynocarpus_laevigatus'

# read gff file
annotation = gffpd.read_gff3(species_name + '_sorted.gff')

# write annotation file as csv
annotation.to_csv(species_name + '_sorted.csv')

# read csv file as pandas dataframe
data = pd.read_csv(species_name + '_sorted.csv')

# remove duplicates (keep only first entry)
data["attributes"] = data["attributes"].apply(remove_duplicates)

# Return back to gff format, looks hacky but method validated by genometools
data.loc[0] = ["##gff-version 3" , '','','','','','','','']
data.to_csv(species_name + '_sorted_processed.gff', index = False, header = False, sep = '\t')
