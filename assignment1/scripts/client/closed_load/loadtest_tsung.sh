#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: ./loadtest_tsung.sh ARRIVAL_RATE"
	exit
fi

SERVER="bernoulli"
ARRIVAL_RATE=$1 # requests / sec

rm -rf "Client_$ARRIVAL_RATE" 2> /dev/null
echo "Arrival Rate: $ARRIVAL_RATE"
echo $ARRIVAL_RATE | nc $SERVER 7777

mkdir Client_$ARRIVAL_RATE
cd Client_$ARRIVAL_RATE
mkdir logs
sed 's/RATE/'$ARRIVAL_RATE'/g' ../tsung.xml > tsung$ARRIVAL_RATE.xml
tsung -f tsung$ARRIVAL_RATE.xml -l logs start

nc $SERVER 8888
cd ..
