#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: ./utilization_httperf.sh ARRIVAL_RATE"
	exit
fi

ARRIVAL_RATE=$1
LOG_FILE="Server_$ARRIVAL_RATE.log"

UTILIZATION=`awk '
		BEGIN {
			n = 0
			idle_time = 0
		}
		{
			if ($1 != "procs" && $1 != "r") {
				idle_time += $15
				n++
			}
		}
		END {
			print (100 - (idle_time / n)) / 100
		}
	' $LOG_FILE`
echo $ARRIVAL_RATE,$UTILIZATION

