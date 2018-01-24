#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: ./collect_data.sh ARRIVAL_RATE [true]"
	exit
fi

ARRIVAL_RATE=$1
GENERATE_DATA=0
if [ "$2" == "true" ]; then
	GENERATE_DATA=1
fi

cd Client_$ARRIVAL_RATE/logs/*

if [ $GENERATE_DATA -eq 1 ]; then
	/usr/lib/tsung/bin/tsung_stats.pl
fi
SESSION_LINE_NO=$(grep -n "session" report.html | cut -d':' -f1)
THROUGHPUT_LINE_NO=$(expr $SESSION_LINE_NO + 4)
RESPONSE_TIME_LINE_NO=$(expr $SESSION_LINE_NO + 5)
FINISH_USERS_COUNT_LINE_NO=$(expr $(grep -n "finish_users_count" report.html | cut -d':' -f1) + 1)
RESPONSE_200_COUNT_LINE_NO=$(expr $(grep -n "200</td>" report.html | cut -d':' -f1) + 3)

THROUGHPUT=$(cat report.html | sed -n $THROUGHPUT_LINE_NO's|<td class="stats">||p' | awk '{print $1}')
RESPONSE_TIME=$(cat report.html | sed -n $RESPONSE_TIME_LINE_NO's|<td class="stats">||p' | awk '{print $1}')

FINISH_USERS_COUNT=$(cat report.html | sed -n $FINISH_USERS_COUNT_LINE_NO's|<td class="stats">||p' | awk '{print $1}')
RESPONSE_200_COUNT=$(cat report.html | sed -n $RESPONSE_200_COUNT_LINE_NO's|<td class="stats">||p' | sed 's|</td>||g' |awk '{print $1}')
FRACTION_DROPPED_REQUESTS=$(echo "($FINISH_USERS_COUNT - $RESPONSE_200_COUNT) / $FINISH_USERS_COUNT" | bc -l)

echo -e "$ARRIVAL_RATE\t$THROUGHPUT\t$RESPONSE_TIME\t$FRACTION_DROPPED_REQUESTS"

