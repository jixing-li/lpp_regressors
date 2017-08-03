# compute f0 and rms hrf regressors
# Time-stamp: <2017-06-07 14:58:18 cp983411>

# replace DOS end-of-line by unix ones
for f in prosody_lppcn?.csv; do tr  -c [a-z][0-9],. '\n' <$f >${f%.csv}_unix.csv; done

for f in prosody_lppcn?_unix.csv; do awk 'NR==1{print "onset,amplitude"}NR>1{print}' $f | cut -d, -f1,2 >f0_$f; done

for f in prosody_lppcn?_unix.csv; do awk 'NR==1{print "onset,f0,amplitude"}NR>1{print}' $f | cut -d, -f1,3 >rms_$f; done

./events2hrf.py -t 2.0 -n 283  -i f0_prosody_lppcn1_unix.csv -o 1_f0_reg.csv
./events2hrf.py -t 2.0 -n 322  -i f0_prosody_lppcn2_unix.csv -o 2_f0_reg.csv
./events2hrf.py -t 2.0 -n 322  -i f0_prosody_lppcn3_unix.csv -o 3_f0_reg.csv
./events2hrf.py -t 2.0 -n 307  -i f0_prosody_lppcn4_unix.csv -o 4_f0_reg.csv
./events2hrf.py -t 2.0 -n 293  -i f0_prosody_lppcn5_unix.csv -o 5_f0_reg.csv
./events2hrf.py -t 2.0 -n 392  -i f0_prosody_lppcn6_unix.csv -o 6_f0_reg.csv
./events2hrf.py -t 2.0 -n 364  -i f0_prosody_lppcn7_unix.csv -o 7_f0_reg.csv
./events2hrf.py -t 2.0 -n 293  -i f0_prosody_lppcn8_unix.csv -o 8_f0_reg.csv
./events2hrf.py -t 2.0 -n 401  -i f0_prosody_lppcn9_unix.csv -o 9_f0_reg.csv

./events2hrf.py -t 2.0 -n 283  -i rms_prosody_lppcn1_unix.csv -o 1_rms_reg.csv
./events2hrf.py -t 2.0 -n 322  -i rms_prosody_lppcn2_unix.csv -o 2_rms_reg.csv
./events2hrf.py -t 2.0 -n 322  -i rms_prosody_lppcn3_unix.csv -o 3_rms_reg.csv
./events2hrf.py -t 2.0 -n 307  -i rms_prosody_lppcn4_unix.csv -o 4_rms_reg.csv
./events2hrf.py -t 2.0 -n 293  -i rms_prosody_lppcn5_unix.csv -o 5_rms_reg.csv
./events2hrf.py -t 2.0 -n 392  -i rms_prosody_lppcn6_unix.csv -o 6_rms_reg.csv
./events2hrf.py -t 2.0 -n 364  -i rms_prosody_lppcn7_unix.csv -o 7_rms_reg.csv
./events2hrf.py -t 2.0 -n 293  -i rms_prosody_lppcn8_unix.csv -o 8_rms_reg.csv
./events2hrf.py -t 2.0 -n 401  -i rms_prosody_lppcn9_unix.csv -o 9_rms_reg.csv
