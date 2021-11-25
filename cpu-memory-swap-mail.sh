######################################################################
# A Shell Script to Send Email Alert When Memory Gets Low            #
######################################################################


#!/bin/bash
if which mailx > /dev/null
then
echo "mailx package is exist"
elif (( $(cat /etc/*-release | grep "Red Hat" | wc -l) > 0 ))
then
yum install mailx -y > /dev/null 
else
sudo apt-get install bsd-mailx -y > /dev/null
fi



echo "-------------------------------------------" >> /tmp/cpu-mem-swap.txt
echo "   CPU(%)   Memory(%)   Swap(%)" >> /tmp/cpu-mem-swap.txt
echo "-------------------------------------------" >> /tmp/cpu-mem-swap.txt

scpu=$(cat /proc/stat|awk '/cpu/{printf("%.2f%\n"), ($2+$4)*100/($2+$4+$5)}' |  awk '{print $0}' | head -1)
smem=$(free|awk '/Mem/{printf("%.2f%"), $3/$2*100}')
sswap=$(free|awk '/Swap/{printf("%.2f%"), $3/$2*100}')
echo "$scpu         $smem          $sswap" >> /tmp/cpu-mem-swap.txt
echo "-------------------------------------------" >> /tmp/cpu-mem-swap.txt
file=/tmp/cpu-mem-swap.txt
echo "CPU and Memory Report for `date +"%B %Y"`" | mailx -s "CPU and Memory Report on `date`"  nikhilsnambiars@gmail.com < /tmp/cpu-mem-swap.txt
rm /tmp/cpu-mem-swap.txt
