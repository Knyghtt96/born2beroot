#!/bin/bash

arch=$(uname -a)

cpuphy=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)

cpuvir=$(nproc)

#memfree= $(free -m | awk '$1 == "Mem:" {print $2}') #display free/unused memory
#memused= $(free -m | awk '$1 == "Mem:" {print $3}')
#memcat=  $(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')
#memstat= $(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')

memfree=$(free -m | grep Mem | awk '{print $3}')
memused=$(free -m | grep Mem | awk '{print $2}')
memtotal=$(free -m | grep Mem | awk '{print $3/$2 * 100}')
memstat="${memfree}/${memused}MB ($(printf "%.2f" $memtotal)%)"

diskuse=$(df -BG / | tail -n 1 | awk '{print $3}' | tr -d G)
disktot=$(df -BG / | tail -n 1 | awk '{print $2}' | tr -d G)
diskpercent=$(df -h / | tail -n 1 | awk '{print $5}')

diskstat="${diskuse}/${disktot}GB (${diskpercent})"

cpuusr=$(mpstat | tail -n 1 | awk '{print $4}')
cpusyst=$(mpstat | tail -n 1 | awk '{print $6}')
cputot=$(cpuusr + cpusyst)




wall "	
	#Architecture: $arch
	#CPU Physical: $cpuphy
	#vCPU:$cpuvir
	#Memmory Usage: $memstat
	#Disk Usage: $diskstat
	#CPU load: $cputot 
	#Last boot:
	#LVM use:
	#Connections TCP:
	#User log:
	#Network:
	#Sudo: 
"

#https://42-cursus.gitbook.io/guide/1-rank-01/born2beroot/p2p-evaluation-questions
#https://www.gosquared.com/blog/vi-linux-terminal-help-sheet
#https://github.com/chlimous/42-born2beroot_guide/blob/main/monitoring.sh
#https://github.com/chlimous/42-born2beroot_guide?tab=readme-ov-file
