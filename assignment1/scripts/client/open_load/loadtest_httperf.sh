#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: ./loadtest_httperf.sh ARRIVAL_RATE"
	exit
fi

SERVER="bernoulli"
SCRIPT="/loop.php"
ARRIVAL_RATE=$1 # requests / sec
DURATION=180 # seconds
NUM_CONNS=$(expr $ARRIVAL_RATE \* $DURATION)

rm -f "Client_$ARRIVAL_RATE.log" 2> /dev/null
echo "Arrival Rate: $ARRIVAL_RATE"
echo $ARRIVAL_RATE | nc $SERVER 7777
httperf --hog --server $SERVER --uri $SCRIPT --timeout 10000 --num-conns $NUM_CONNS --num-calls 1 --rate $ARRIVAL_RATE > "Client_$ARRIVAL_RATE.log"
nc $SERVER 8888

