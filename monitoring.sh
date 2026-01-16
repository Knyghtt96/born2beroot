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

lvm=$(lsblk | grep -q "lvm" && echo "yes" || echo "no")

tcp=$(ss -t state established | tail -n +2 | wc -l)

ulog=$(users | wc -w)

ip=$(hostname -I | awk '{print $1}')
mac=$(ip link show | awk '/ether/ {print $2}')

sudo=$(grep "COMMAND=" /var/log/sudo/sudo.log | wc -l)

wall "
#Architecture: $arch
#CPU Physical: $cpuphy
#vCPU: $cpuvir
#Memory Usage: $memstat
#Disk Usage: $diskstat
#CPU load: $cputot%
#Last boot: $boot
#LVM use: $lvm
#Connections TCP: $tcp ESTABLISHED
#User log: $ulog
#Network: IP $ip (MAC $mac)
#Sudo: $sudo
"
