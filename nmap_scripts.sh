#!/bin/bash

echo -e "\n\n\n"
#echo "hello there noting to look here, look forward to future script outputs"

#read -p "please enter the script name (at least the part of it that you remember): " wrd

wrd="anon"

count=$(grep -c "$wrd" /usr/share/nmap/scripts/script.db)

if (( $count > 1 ));then
echo "the count val is more than one: $count"
else
echo "the count val is one or less than that: $count"
fi


if grep -q "$wrd" /usr/share/nmap/scripts/script.db;then
echo "okay we found $wrd in script"
grep --color=always "$wrd" /usr/share/nmap/scripts/script.db

else
echo "we did not find $wrd"
fi


echo -e "\n\n\n"