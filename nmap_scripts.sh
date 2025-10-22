#!/bin/bash


#incase you are checking what this script does then read the below line
#the script takes in line of sentence and break all the words spearated by space into array or words

read -p "enter a srting of sentences: " line
wl=($line)

#echo -e "\nthe first wrd was: ${wl[0]}"
#echo "the number of words in that line is: ${#wl[@]}"

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