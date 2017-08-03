#!/bin/awk -f
# input: google ngram file downloaded from http://storage.googleapis.com/books/ngrams/books/datasetsv2.html
# output: csv file with 2 columns: word, total number of occurrence 
# example: awk -f googlengram.awk googlebooks-chi-sim-all-1gram-20120701-a > 1gram_a.csv
 
BEGIN { OFS="\t" }
# initialize variables word and count
NR==1 { word=$1; count=$3; next} 
# print word and its summed count when scanning the next word; delete POS information
($1==word) {count+=$3;next} {sub(/_.*/,"", word); print word,count; word=$1;count=$3}
# print the last word
END {sub(/_.*/,"", word); print word,count}


	