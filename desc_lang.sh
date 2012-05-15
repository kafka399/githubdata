cat git.csv |grep "^\"https:" |awk -F'\",\"' '{ print $1,";" $5,";" $17 }'|sort -r| uniq|sed 's/\"//1'>tmp.txt

cat tmp.txt|tr '[A-Z]' '[a-z]' |awk -F\; '$3 ~/^c\+\+/'|cut -d";" -f2|grep [A-Za-Z0-9]|tr -d '[:punct:]' >out2.txt
./extractKeywords |sort -k2n,2 |tail -n100>cpp.csv

cat tmp.txt|tr '[A-Z]' '[a-z]' |awk -F\; '$3 ~/^javascript/'|cut -d";" -f2|grep [A-Za-Z0-9]|tr -d '[:punct:]' >out2.txt
./extractKeywords |sort -k2n,2 |tail -n100>javascript.csv

cat tmp.txt|tr '[A-Z]' '[a-z]' |awk -F\; '$3 ~/^java$/'|cut -d";" -f2|grep [A-Za-Z0-9]|tr -d '[:punct:]' >out2.txt
./extractKeywords |sort -k2n,2 |tail -n100>java.csv

cat tmp.txt|tr '[A-Z]' '[a-z]' |awk -F\; '$3 ~/^python$/'|cut -d";" -f2|grep [A-Za-Z0-9]|tr -d '[:punct:]' >out2.txt
./extractKeywords |sort -k2n,2 |tail -n100>python.csv

cat tmp.txt|tr '[A-Z]' '[a-z]' |awk -F\; '$3 ~/^r$/'|cut -d";" -f2|grep [A-Za-Z0-9]|tr -d '[:punct:]' >out2.txt
./extractKeywords |sort -k2n,2 |tail -n100>r.csv

cat tmp.txt|tr '[A-Z]' '[a-z]' |awk -F\; '$3 ~/^ruby/'|cut -d";" -f2|grep [A-Za-Z0-9]|tr -d '[:punct:]' >out2.txt
./extractKeywords |sort -k2n,2 |tail -n100>ruby.csv

cat tmp.txt|tr '[A-Z]' '[a-z]' |awk -F\; '$3 ~/^php/'|cut -d";" -f2|grep [A-Za-Z0-9]|tr -d '[:punct:]' >out2.txt
./extractKeywords |sort -k2n,2 |tail -n100>php.csv

cat tmp.txt|tr '[A-Z]' '[a-z]' |awk -F\; '$3 ~/^shell/'|cut -d";" -f2|grep [A-Za-Z0-9]|tr -d '[:punct:]' >out2.txt
./extractKeywords |sort -k2n,2 |tail -n100>shell.csv

