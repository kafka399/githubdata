cat git.csv |grep "^\"https:" |awk -F'\",\"' '{ print $1,";" $5,";" $17 }'|sort -r| uniq|sed 's/\"//1'|awk -F\; '$3 ~/^C\+\+/'|cut -d";" -f2>tmp.csv

