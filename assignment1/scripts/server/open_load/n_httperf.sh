#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: ./utilization_httperf.sh ARRIVAL_RATE"
	exit
fi

ARRIVAL_RATE=$1
LOG_FILE="Server_$ARRIVAL_RATE.log"

PROCS=`awk '
		BEGIN {
			n = 0
			procs = 0
		}
		{
			if ($1 != "procs" && $1 != "r") {
				procs += $1
				n++
			}
		}
		END {
			print (procs / n)
		}
	' $LOG_FILE`
echo $ARRIVAL_RATE,$PROCS

