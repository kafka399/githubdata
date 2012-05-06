cat git.csv |grep "^\"https:"|cut -d"," -f1,3|sort|uniq|cut -d"," -f2>new_repos.csv
