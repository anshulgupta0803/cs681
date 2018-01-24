#!/bin/bash

DIR=$PWD
LOG_FILE="$DIR/vmstat.log"
PID_FILE="/tmp/vmstat.pid"

if [ -f $PID_FILE ]; then
	PID=$(cut -d, -f1 $PID_FILE)
	ARRIVAL_RATE=$(cut -d, -f2 $PID_FILE)
	START_TIME=$(cut -d, -f3 $PID_FILE)
	DURATION=$(echo "$(date +%s) - $START_TIME" | bc)
	echo "Killing process: $PID. Arrival Rate: $ARRIVAL_RATE. Duration: $DURATION seconds" >> $LOG_FILE
	kill -9 $PID
	rm -f $PID_FILE
fi

