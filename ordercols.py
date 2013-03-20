#!/usr/bin/env python
import sys
import os

seq_file = sys.argv[1]
input_file = sys.argv[2]



with open(input_file, 'r') as content_file:
    content = content_file.read().search(".*")


sequence = open(pheno_file, 'r')

chunk="'{print NF}'"

awk $chunk $input_file

exit
# echo $sequence
awk -v sequence="sequence" '{print $sequence}' $input_file

for []