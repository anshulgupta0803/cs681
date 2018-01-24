#!/bin/bash

DIR=$PWD
LOG_FILE="$DIR/vmstat.log"
PID_FILE="/tmp/vmstat.pid"

rm -f $PID_FILE
read ARRIVAL_RATE
echo "Starting process $$ for Arrival Rate $ARRIVAL_RATE" >> $LOG_FILE
echo "$$,$ARRIVAL_RATE,$(date +%s)" > $PID_FILE
rm -f "Server_$ARRIVAL_RATE.log" 2> /dev/null
sleep 3
exec vmstat 1 > "Server_$ARRIVAL_RATE.log"

