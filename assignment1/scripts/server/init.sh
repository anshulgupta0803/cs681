#!/bin/bash

START_PORT=7777
STOP_PORT=8888
DIR=$PWD

if [ "$1" == "bind" ]; then
	netstat -lnt | awk '{print $4}' | grep -q ":$START_PORT$"
	if [ $? -eq 1 ]; then
		socat -u tcp-l:$START_PORT,fork system:$DIR/startStats.sh &
		echo "Binding port $START_PORT for Start"
	else
		echo "Port $START_PORT already in use"
	fi
	netstat -lnt | awk '{print $4}' | grep -q ":$STOP_PORT$"
	if [ $? -eq 1 ]; then
		socat -u tcp-l:$STOP_PORT,fork system:$DIR/stopStats.sh &
		echo "Binding port $STOP_PORT for Stop"
	else
		echo "Port $STOP_PORT already in use"
	fi
elif [ "$1" == "unbind" ]; then
	killall socat
	if [ $? -ne 1 ]; then
		echo "Unbinding ports $START_PORT and $STOP_PORT"
	fi
else
	echo "Usage: ./init.sh (bind|unbind)"
fi

