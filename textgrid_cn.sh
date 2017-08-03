#!/bin/bash
# Input: 9 textgrid fiels
# Output: lpp_cn_regressors.csv with word, onset, offset and section number

# check file type: 
# file -I s*_pad.TextGrid

# remove lines where word="sil"
for s in 1 2 3 4 5 6 7 8 9; do  
 iconv -f utf-16 -t utf-8 s${s}_pad.TextGrid | awk -f textgrid.awk | awk -F, -v OFS="," '$1!="sil" {print $0,'${s}'}' > s${s}.csv 
done

# concatenate the 9 sections & change decimal to .3%f
cat s{1..9}.csv | awk -F, '{printf "%s,%.3f,%.3f,%d\n", $1,$2,$3,$4}' > lpp_cn_regressors.csv

# remove intermediate files
rm s{1..9}.csv

