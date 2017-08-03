#!/bin/bash
# Input: 9 textgrid fiels
# Output: lpp_cn_regressors.csv with word, onset, offset, section number

echo "Start working on textgrid...\n"
# check file type: 
# file -I s*_pad.TextGrid
 
# convert file encoding from utf-16 to utf-8 & remove lines where word="sil"
for s in 1 2 3 4 5 6 7 8 9; do  
 iconv -f utf-16 -t utf-8 s$s_pad.TextGrid | awk -f textgrid.awk | awk -F, -v OFS="," '$1!="sil" {print $0,'$s'}' > s$s.csv 
done 

# concatenate the 9 sections
cat s{1..9}.csv > lpp_cn_regressors.csv

# remove intermediate files
rm s{1..9}.csv

echo "Start working on word frequency...\n"
# convert the subtlex_cn excel file (download: http://crr.ugent.be/programs-data/subtitle-frequencies/subtlex-ch) to csv 
# easy_install xlsx2csv

# keep only 2 decimals for word frequency
# xlsx2csv subtlex_cn.xlsx | awk -F, '{printf "%s,%.2f\n", $1, $2}' > subtlex_cn.csv


# find subtlex+googlebook frequency for lpp_cn words; words with no frequency are marked as 0
awk -F, -v OFS=',' 'FNR==NR{a[$1]=$1;b[$1]=$2;next} ($1 in a) {print $0, b[$1];next}1' \
subtlex_cn.csv lpp_cn_regressors.csv > tmp && mv tmp lpp_cn_regressors.csv

echo "Start working on pos tagging...\n"
awk -F, '{print $1}' lpp_cn_regressors.csv > lpp_cn_word.csv 

# POS tagging using Standford tagger
cd /Applications/stanford-postagger-full-2016-10-31
java -cp "*" edu.stanford.nlp.tagger.maxent.MaxentTagger -model models/chinese-distsim.tagger \
-textFile /Users/Jixing/BoxSync/Study/Cornell/Dissertation/Analysis/lpp_cn/lpp_cn_word.csv \
-outputFormat tsv -outputFile /Users/Jixing/BoxSync/Study/Cornell/Dissertation/Analysis/lpp_cn/lpp_cn_wordpos.csv

cd /Users/Jixing/BoxSync/Study/Cornell/Dissertation/Analysis/lpp_cn/

# remove empty lines & print POS only
awk 'length($1) {print $2}' lpp_cn_wordpos.csv > lpp_cn_pos.csv

# combine POS to regressors
paste -d ',' lpp_cn_regressors.csv lpp_cn_pos.csv > tmp

# mark nouns, verbs, adjectives and adverbs as 1.
# c.f. Xia 2000, The Part-Of-Speech Tagging Guidelines for the Penn Chinese Treebank (3.0), p.5
awk -F, -v OFS=',' '$6 ~/^V|^N|AD/ {print $0,1;next}1' tmp > lpp_cn_regressors.csv

# remove intermediate files
rm lpp_cn_word.csv
rm lpp_cn_wordpos.csv
rm lpp_cn_pos.csv


