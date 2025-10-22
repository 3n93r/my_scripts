#!/bin/bash

read -p "enter a srting of sentences: " line
wl=($line)

len=${#wl[@]}
for ((i=0;i<len;i++));do           #the loop starts here

echo -e "For '\e[1;31m${wl[$i]}\e[0m'"

wrd=${wl[$i]}

#counting the number of times the word was repeated
count=$(grep -c "$wrd" /usr/share/nmap/scripts/script.db)
if (( $count > 1 ));then
echo -e "\nthe word '\e[1;31m$wrd\e[0m'is found in \e[1;31m$count\e[0m lines"
fi

#printing out the lines that has the word for reference 
if grep -q "$wrd" /usr/share/nmap/scripts/script.db;then
grep --color=always "$wrd" /usr/share/nmap/scripts/script.db
else
echo "we did not find $wrd"
fi

echo ""
done #the looop ends here