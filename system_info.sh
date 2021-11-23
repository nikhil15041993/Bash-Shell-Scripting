#!/bin/bash

mem=$(free | awk '/Mem/{printf("%.2f%"), $3/$2*100}')
cpu=$(cat /proc/stat | awk '/cpu/{printf("%.2f%\n"), ($2+$4)*100/($2+$4+$5)}' |  awk '{print $0}' | head -1)
swap=$(free | awk '/Swap/{printf("%.2f%"), $3/$2*100}')
service=$(systemctl list-units --type=service | grep -E 'apache|mysql|nginx|php' | awk ' {printf "%s ", $1}' | sed -e 's/\<service\>//g')
#disk=$(lsblk | awk ' NR == 2 {print $4}')
disk=$(df -H  | awk ' NR == 4 { print $5 }')

echo "----------------------------------------------"
echo " Running Services  $service"                         
echo "----------------------------------------------"
echo " Memory Usage $mem"
echo "----------------------------------------------"
echo " Disk Usage  $disk"
echo "----------------------------------------------"


