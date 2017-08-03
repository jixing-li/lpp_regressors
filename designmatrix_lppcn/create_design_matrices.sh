#!/bin/bash

for run in 1 2 3 4 5 6 7 8 9;
do
    for f in ${run}_wordrate_reg.csv ${run}_freq_reg.csv ${run}_vec10_reg.csv ${run}_rms_reg.csv ${run}_f0_reg.csv; do
	awk 'NR>1' $f | cut -d, -f2 >${f%.csv}_hrf.csv
    done
    paste  ${run}_wordrate_reg_hrf.csv ${run}_freq_reg_hrf.csv  ${run}_vec10_reg_hrf.csv  ${run}_rms_reg_hrf.csv ${run}_f0_reg_hrf.csv > session${run}.csv
done

