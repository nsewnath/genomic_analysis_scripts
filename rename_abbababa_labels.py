#!/usr/bin/env python

"""
Quickly change label names in ANGSD abbababa output 

Neeka Sewnath
nsewnath@ufl.edu

Takes in two input files: ANGSD abbababa output (after jackknife.R) and 
relabel file containing two columns: "old_id" and "new_id" 

Outputs relabelled ingroup and outgroup
"""

#===========================================================================================================================================

import argparse
import sys
import csv
import pandas as pd

#===========================================================================================================================================

try:
    warnings.filterwarnings('ignore')
except:
    pass

#===========================================================================================================================================

def get_args():
    """Get command-line arguments"""

    parser = argparse.ArgumentParser(
        description='ABBABABBA Relabeller',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('-f',
                        '--file',
                        help='CSV abbababa input file',
                        metavar='FILE',
                        type=argparse.FileType('rt'))

    parser.add_argument('-l',
                        '--labels',
                        help = 'CSV label file',
                        metavar = 'labels',
                        type = argparse.FileType('r'))       

    parser.add_argument('-o',
                        '--output',
                        help='Name of output file',
                        metavar='output',
                        type=str)

    return parser.parse_args()

#===========================================================================================================================================

def label_rename(label): 
    """
    Renames trait names with trait dictionary
    """

    label_dict = labels.set_index("old_id")["new_id"].to_dict()

    if label in label_dict.keys():
        return label_dict[label]

#===========================================================================================================================================
def main():

    global labels 

    # Fetch arguments 
    args = get_args()
    data = pd.read_csv(args.file)
    output = args.output
    output_name = output + ".csv"
    labels_file = pd.read_csv(args.labels)

    # Set dictionary template
    labels = labels_file
    
    # Rename each of the ingroup and outgroup columns of the dataframe 
    data['H1'] = data['H1'].apply(label_rename)
    data['H2'] = data['H2'].apply(label_rename)
    data['H3'] = data['H3'].apply(label_rename)

    # Create output file 
    data.to_csv(output_name)

#===========================================================================================================================================

if __name__ == '__main__':
    main()