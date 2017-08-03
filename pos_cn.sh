#!/bin/bash
awk -F, '{print $1}' lpp_cn_regressors.csv > lpp_cn_word.csv 

# POS tagging using Standford tagger
cd /Applications/stanford-postagger-full-2016-10-31
java -cp "*" edu.stanford.nlp.tagger.maxent.MaxentTagger -model models/chinese-distsim.tagger \
-textFile /Users/Jixing/BoxSync/Study/Cornell/Dissertation/Analysis/lpp_cn/lpp_cn_word.csv \
-outputFormat tsv -outputFile /Users/Jixing/BoxSync/Study/Cornell/Dissertation/Analysis/lpp_cn/lpp_cn_wordpos.csv

cd /Users/Jixing/BoxSync/Study/Cornell/Dissertation/Analysis/lpp_cn/

# remove blank lines and extract pos onlu
awk 'NF>0 {print $2}' lpp_cn_wordpos.csv > lpp_cn_pos.csv

# combine POS to regressors
# mark nouns, verbs, adjectives and adverbs as 1, else as 0.
# c.f. Xia 2000, The Part-Of-Speech Tagging Guidelines for the Penn Chinese Treebank (3.0), p.5
paste -d ',' lpp_cn_regressors.csv lpp_cn_pos.csv \
| awk -F, -v OFS=',' '$6 ~/^V|^N|AD/ {print $0,1;next}{print $0,0}' lpp_cn_regressors.csv \
> tmp && mv tmp lpp_cn_regressors.csv

# remove intermediate files
rm lpp_cn_word.csv
rm lpp_cn_wordpos.csv
rm lpp_cn_pos.csv
