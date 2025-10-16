#!/bin/bash

int=0
val=""
str=""
PS3="Enter the number to select the scan type: "

select opt in -sC -sV -sX -sS -sU -A -sA exit; do
((int++))

case $opt in
"-sC")
val="-sC"
;;
"-sV")
val="-sV"
;;
"-sX")
val="-sX"
;;
"-sS")
val="-sS"
;;
"-sU")
val="-sU"
;;
"-A")
val="-A"
;;
"-sA")
val="-sA"
;;

"exit")
echo "okay the selection will end here and the slected options are: $str "
break
;;
*)
echo "select correct option"
;;
esac

if (( $int==1 )); then
        str="$val"
        echo -e "loop $int:\nstr=>$str \n"
        continue
else
        if [[ $str == *"$val"* ]];then
                echo "this option is already used"
                echo -e "loop $int:\nstr=>$str \n"
                continue
        else
                str="$str $val"
        fi
fi

echo -e "loop $int:\nstr=>$str \n"
done

#echo -e "the selection is done lets check out if it works as intended \n"
sleep 1

#Tip=10.150.150.11
#exit
#nmap $str $Tip

reg="^([0-9]{2,3}\.){3}[0-9]{2,3}$"

while true; do
read -p "enter the ip address: " Tip
echo -e "\e[1;31mInfo:\e[0m\e[31m\nIP=$Tip\nsource=PawnTillDawn\nselected flags: $str\e[0m\n"
sleep 1
if [[ $Tip =~ $reg ]]; then
echo -e "\e[1;33mnmap $str $Tip\e[0m"
nmap $str $Tip | tail -n +4
break
else
echo -e "that is the \e[1;31mwrong\e[0m ip"
fi
echo ""
sleep 1
done