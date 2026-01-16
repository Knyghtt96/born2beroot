#!/bin/bash

arch=$(uname -a)

cpuphy=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)

cpuvir=$(nproc)

memused=$(free -m | awk '/Mem:/ {print $3}')
memtotal=$(free -m | awk '/Mem:/ {print $2}')
mempercent=$(free -m | awk '/Mem:/ {printf "%.2f", $3/$2*100}')
memstat="${memused}/${memtotal}MB (${mempercent}%)"

diskuse=$(df -BG / | tail -n 1 | awk '{print $3}' | tr -d G)
disktot=$(df -BG / | tail -n 1 | awk '{print $2}' | tr -d G)
diskpercent=$(df -h / | tail -n 1 | awk '{print $5}')

diskstat="${diskuse}/${disktot}GB (${diskpercent})"

cputot=$(mpstat 1 1 | awk '/Average:/ {printf "%.1f", 100 - $12}')

boot=$(who -b | awk '{print $3 " " $4}')

lvm=$(cat /etc/fstab | grep /dev/mapper | wc -l)

wall "
#Architecture: $arch
#CPU Physical: $cpuphy
#vCPU:$cpuvir
#Memory Usage: $memstat
#Disk Usage: $diskstat
#CPU load: $cputot%
#Last boot:$boot
#LVM use:$lvm
#Connections TCP:
#User log:
#Network:
#Sudo:
"

#https://42-cursus.gitbook.io/guide/1-rank-01/born2beroot/p2p-evaluation-questions
#https://www.gosquared.com/blog/vi-linux-terminal-help-sheet
#https://github.com/chlimous/42-born2beroot_guide/blob/main/monitoring.sh
#https://github.com/chlimous/42-born2beroot_guide?tab=readme-ov-file
