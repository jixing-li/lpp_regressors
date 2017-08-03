#!/bin/awk -f
# input: textgrid file (need to change encoding from utf-16 to utf-8)
# output: csv file with 3 columns: word, onset and offset
# example: awk -f texgrid.awk filename.TextGrid > filename.csv


BEGIN {FS="\n"; OFS=","; RS=":"}
NR>4 {gsub(/.*=|"|[[:space:]]/,"",$4);gsub(/.*=|[[:space:]]/,"",$2);gsub(/.*=|[[:space:]]/,"",$3);\
gsub(/" "/,"");print $4,$2,$3}




