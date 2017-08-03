#!/bin/bash

IN=lpp_cn_regressors.csv

for i in 1 2 3 4 5 6 7 8 9; do
    awk -vn=$i -f section.awk $IN >section$i.csv
    awk -f valid.awk section$i.csv > section${i}_clean.csv
done

for i in 1 2 3 4 5 6 7 8 9; do
    awk -F, '{print $3, $8}' section${i}_clean.csv | awk 'BEGIN{OFS=","; print "onset,amplitude"}{print  $1 "," 1 }' > ${i}_wordrate.csv
    awk -F, '{print $3, log($5)}' section${i}_clean.csv | awk 'BEGIN{OFS=","; print "onset,amplitude"}{print $1 "," $2 }' > ${i}_freq.csv
    awk -F, '{print $3, $8}' section${i}_clean.csv  | awk 'BEGIN{OFS=","; print "onset,amplitude"}{print  $1 "," $2 }' > ${i}_vec10.csv
done

./events2hrf.py -t 2.0 -n 283 -i 1_wordrate.csv -o 1_wordrate_reg.csv
./events2hrf.py -t 2.0 -n 283 -i 1_freq.csv -o 1_freq_reg.csv
./events2hrf.py -t 2.0 -n 283 -i 1_vec10.csv -o 1_vec10_reg.csv
./events2hrf.py -t 2.0 -n 322 -i 2_wordrate.csv -o 2_wordrate_reg.csv
./events2hrf.py -t 2.0 -n 322 -i 2_freq.csv -o 2_freq_reg.csv
./events2hrf.py -t 2.0 -n 322 -i 2_vec10.csv -o 2_vec10_reg.csv
./events2hrf.py -t 2.0 -n 322 -i 3_wordrate.csv -o 3_wordrate_reg.csv
./events2hrf.py -t 2.0 -n 322 -i 3_freq.csv -o 3_freq_reg.csv
./events2hrf.py -t 2.0 -n 322 -i 3_vec10.csv -o 3_vec10_reg.csv
./events2hrf.py -t 2.0 -n 307 -i 4_wordrate.csv -o 4_wordrate_reg.csv
./events2hrf.py -t 2.0 -n 307 -i 4_freq.csv -o 4_freq_reg.csv
./events2hrf.py -t 2.0 -n 307 -i 4_vec10.csv -o 4_vec10_reg.csv
./events2hrf.py -t 2.0 -n 293 -i 5_wordrate.csv -o 5_wordrate_reg.csv
./events2hrf.py -t 2.0 -n 293 -i 5_freq.csv -o 5_freq_reg.csv
./events2hrf.py -t 2.0 -n 293 -i 5_vec10.csv -o 5_vec10_reg.csv
./events2hrf.py -t 2.0 -n 392 -i 6_wordrate.csv -o 6_wordrate_reg.csv
./events2hrf.py -t 2.0 -n 392 -i 6_freq.csv -o 6_freq_reg.csv
./events2hrf.py -t 2.0 -n 392 -i 6_vec10.csv -o 6_vec10_reg.csv
./events2hrf.py -t 2.0 -n 364 -i 7_wordrate.csv -o 7_wordrate_reg.csv
./events2hrf.py -t 2.0 -n 364 -i 7_freq.csv -o 7_freq_reg.csv
./events2hrf.py -t 2.0 -n 364 -i 7_vec10.csv -o 7_vec10_reg.csv
./events2hrf.py -t 2.0 -n 293 -i 8_wordrate.csv -o 8_wordrate_reg.csv
./events2hrf.py -t 2.0 -n 293 -i 8_freq.csv -o 8_freq_reg.csv
./events2hrf.py -t 2.0 -n 293 -i 8_vec10.csv -o 8_vec10_reg.csv
./events2hrf.py -t 2.0 -n 401 -i 9_wordrate.csv -o 9_wordrate_reg.csv
./events2hrf.py -t 2.0 -n 401 -i 9_freq.csv -o 9_freq_reg.csv
./events2hrf.py -t 2.0 -n 401 -i 9_vec10.csv -o 9_vec10_reg.csv

