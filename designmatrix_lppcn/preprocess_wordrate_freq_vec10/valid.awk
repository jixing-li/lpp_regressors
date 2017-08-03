# test whether all predictors have a value at this row
BEGIN { FS=","}
# has word offset
length($3) &&
# and SUBTL freq
length($5) &&
# and a vec10
length($8)


