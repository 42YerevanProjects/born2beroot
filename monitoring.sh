# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: shovsepy <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/06/03 17:41:07 by shovsepy          #+#    #+#              #
#    Updated: 2021/06/03 17:41:13 by shovsepy         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

#Make sure to install sysstat via `sudo apt install sysstat`
#Make sure to install bc via `sudo apt install bc`
#Make sure to write the path to the sudo log files you created in last line instead of `/var/log/sudo/sudo_logs`

THREADS=$(lscpu | egrep 'Thread|Core|Socket|^CPU' | awk '{if(NR == 3) print $NF}')
CORES=$(lscpu | egrep 'Thread|Core|Socket|^CPU' | awk '{if(NR == 4) print $NF}')
SOCKETS=$(lscpu | egrep 'Thread|Core|Socket|^CPU' | awk '{if(NR == 5) print $NF}')

TOTAL_MEMORY=$(vmstat -s | awk '{if(NR == 1) print$1}')
USED_MEMORY=$(vmstat -s | awk '{if(NR == 2) print$1}')
USED_MEMORY_PERCENT=$(expr $USED_MEMORY \* 100 / $TOTAL_MEMORY)

CPU_IDLE=$(mpstat | awk 'END{print $NF}')

TOTAL_DISK_SIZE=$(df -h --total --output=size| awk 'END{print$NF}')
USED_DISK_SIZE=$(df -h --total --output=used | awk 'END{print$NF}')
USED_DISK_PERCENT=$(df -h --total | awk 'END{print$(NF - 1)}')

printf "#Architecture: `uname -a` \n"
printf "#CPU physical: `nproc` \n"
printf "#vCPU: `expr $THREADS \* $CORES \* $SOCKETS` \n"
printf "#Memory Usage: `expr $USED_MEMORY / 1024`/`expr $TOTAL_MEMORY / 1024`MB ($UED_MEMORY_PERCENT%%) \n"
printf "#Disk Usage: $USED_DISK_SIZE/$TOTAL_DISK_SIZE ($USED_DISK_PERCENT%)\n"
printf "#CPU Load: `echo 100 - $CPU_IDLE | bc`%% \n"
printf "#Last Boot: `who -b | awk '{print $(NF - 1), $NF}'` \n"
printf "#LVM use: yes \n"
printf "#Connexions TCP: `netstat -ant | grep ESTABLISHED | wc -l` ESTABLISHED \n"
printf "#User Log: `who | wc -l` \n"
printf "#Network: IP `hostname -I` (`ip addr | grep link/ether | awk '{print $(NF -2)}'`) \n"
printf "#Sudo: `cat /var/log/sudo/sudo_logs | grep sudo | wc -l` cmd" 
