#!/bin/bash

echo -e -n  "Enter the date on which the payment was made \e[1;31m(in dd/mm/yyyy format eg-> 21/09/2123): \e[0m"
read inp

cln=$(echo "$inp" | tr ' :/-' ' ')
read dt mnt yr <<< "$cln"

if (( $yr%4 == 0  && ( $yr%100 != 0 || $yr%400 == 0 ) ));then ly=1; else ly=0; fi

read -p "enter the validity days: " dy

mn_l=("jan" "feb" "mar" "apr" "may" "Jun" "jul" "aug" "sep" "oct" "nov" "dec")

nm=$mnt
i=0

if [[ $nm == 1 || $nm == 3 || $nm == 5 || $nm == 7 || $nm == 8 || $nm == 10 || $nm == 12 ]];then d_lmt=31
elif [[ $nm == 4 || $nm == 6 || $nm == 9 || $nm == 11  ]];then d_lmt=30; elif [[ $nm == 2 ]]; then
if [[ $ly == 0 ]];then d_lmt=28; else d_lmt=29; fi
fi

if (( dt > 1 )); then
((rdy=d_lmt-dt)) #we are counting the remaining days in the month after paying the bill in that month
fi

if (( dt > 1 ));then ((dy=dy-rdy)); ((nm++)); fi

while true; do

((i++))
if [[ $nm == 1 || $nm == 3 || $nm == 5 || $nm == 7 || $nm == 8 || $nm == 10 || $nm == 12 ]];then d_lmt=31
elif [[ $nm == 4 || $nm == 6 || $nm == 9 || $nm == 11  ]];then d_lmt=30; elif [[ $nm == 2 ]]; then
if [[ $ly == 0 ]];then d_lmt=28; else d_lmt=29; fi
fi

((dy=dy-d_lmt))
if (( $dy <= 31 ));then
((i++))
break
fi

((nm++))

if (( $nm > 12 ));then nm=1; ((yr++))
if (( $yr%4 == 0  && ( $yr%100 != 0 || $yr%400 == 0 ) ));then ly=1; else ly=0; fi
fi
done  #the while loop is ending here

((Nnm=nm))
echo -n -e "Due date is \e[1;31m$dy-$Nnm-$yr OR \e[0m"
echo -e "in Months \e[1;31m$dy-${mn_l[$Nnm]}-$yr \e[0m"
 