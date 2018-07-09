#!/bin/sh

if [ $# -eq 1 ]; then
	if [ $1 = "start" ]; then
	    burncpu &
	elif [ $1 = "stop"]; then
	   pkill burncpu
	fi
fi

