cat git.csv |grep "^\"https:" |awk -F'\",\"' '{ print $1, $6, $15 }'|sort -r| awk '!x[$1]++'|sed 's/\"//1'>fork_watch.csv

