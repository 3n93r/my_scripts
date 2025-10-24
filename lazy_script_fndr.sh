#!/bin/bash

echo -e "\e[1;31mNMAP Output \e[0m"
echo '' > ser_identify_file.txt #holds the nmap scan result
echo '' > service_lst.txt #holds the list of services that are open (found from the nmap scan result)
echo '' > tempo_file.txt #a temp file to hold the lines that have names similar to the names of open service

read -p "Enter the IP address: " ip
if [[ ! $ip =~ ([0-9]{1,3}\.){3}([0-9]{1,3}) ]];then
#have to write a script to check for correct ip address
echo "please enter the correct ip"
exit
fi

nmap $ip -o ser_identify_file.txt

#filtering the open services and dumping it in the service_lst file
cat ser_identify_file.txt |  awk '{if(NR>5) print $3}' > service_lst.txt

cnt=0 #this is to just coung the services which has the nse scripts found
while read -r lin;do        #first while loop

if [[ $lin != 'unknown' && $lin != "" ]];then
((cnt++))
if [[ $(cat /usr/share/nmap/scripts/script.db | grep -q "$lin"; echo $?) -eq 0 ]]; then #the echo$? might have not been required but thts okay
echo -e "found \e[1;31m$lin\e[0m in the db"

grep $lin /usr/share/nmap/scripts/script.db > tempo_file.txt  #this file changes to each service in each loop

while read -r tp;do #second while loop
for wrds in $tp;do
if [[ "$wrds" =~ ([a-z0-9]*-?)*(\.nse) ]];then
cln=${wrds#\"}
cln=${cln%\,}
cln=${cln%\"}
echo -e "Got the script ->\e[1;31m$cln\e[0m"
fi
done #end of for loop

done < tempo_file.txt #end of second while loop
echo -e "\n\n"
fi

fi
done < service_lst.txt #end of first while loop


echo -e "there are \e[1;31m$cnt\e[0m known services"

#the search looks like the search made is rigid and if it does not find the nse script 
#with full name with the service it will not print it out 
