#!/bin/bash

DISKS=`df --output=source,target,pcent | awk '$3 > 90'`
if [[ `echo "$DISKS"| wc -l` > 1 ]]; then
  mailx -s "Disk threshold - Above 90%" <email> test <<EOF
Threshold reached for the following disks 
$DISKS
EOF
fi

CPU=`mpstat | awk '$13 < 5'`
if [[ `echo "$CPU"| wc -l` > 3 ]]; then
  mailx -s "CPU threshold - Above 95%" <email> test <<EOF
CPU Threshold Reached. Current Usage is $CPU
EOF
fi

MEM=`echo "scale = 2; 1464488 / 3964956 * 100" | bc`
if [[ $MEM > 95 ]]; then
  mailx -s "Memory threshold - Total available less than 5%" <email> test <<EOF
Memory Threshold Reached. Available is $MEM % of total memory.
EOF
fi
