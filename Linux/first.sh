#!/bin/bash
echo "1.1.1"
ps -eu $(whoami) | wc -l
echo "1.1.2"
grep 'cpu ' /proc/stat | awk '{usage=100-($5)*100/($1+$2+$3+$4+$5+$6+$7+$8)} END {print usage "%"}'
echo "1.1.3"
grep 'MemTotal' /proc/meminfo | awk '{memory = $2 /1024} END {print memory "Mb"}'
echo "1.1.4"
netstat -tuln | grep "LISTEN"| awk '{print $4}' | grep -c ":90*"
echo "1.1.5"

echo "1.1.6"
df  -lk | awk '{total+=$2} END {print total "Kb"}'
echo "1.1.7"
df -k | awk '{total+=$2} END {print total "Kb"}'