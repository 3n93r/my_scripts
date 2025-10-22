#!/bin/bash

#taking input
read -p "please enter the script name (at least the part of it that you remember): " wrd

#counting the number of times the word was repeated
count=$(grep -c "$wrd" /usr/share/nmap/scripts/script.db)
if (( $count > 1 ));then
echo "the word '$wrd' can is found in $count lines"
fi

#printing out the lines that has the word for reference 
if grep -q "$wrd" /usr/share/nmap/scripts/script.db;then
grep --color=always "$wrd" /usr/share/nmap/scripts/script.db
else
echo "we did not find $wrd"
fi