cat git.csv |grep "^\"https:" |awk -F'\",\"' '{ print $29 }'>actions.csv
Rscript actions.R
