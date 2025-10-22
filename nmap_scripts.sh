#!/bin/bash

read -p "please enter the script name (at least the part of it that you remember): " wrd

count=$(grep -c "$wrd" /usr/share/nmap/scripts/script.db)

if (( $count > 1 ));then
echo "the word '$wrd' can is found in $count lines"
#else
#echo "the count val is one or less than that: $count"
fi

if grep -q "$wrd" /usr/share/nmap/scripts/script.db;then
grep --color=always "$wrd" /usr/share/nmap/scripts/script.db
else
echo "we did not find $wrd"
fi