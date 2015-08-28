#!/bin/bash

# log number of playing audio streams

# seconds to wait between checks
waittime="10"

#------------------------------

mkdir -p logs
last_status=""
while true
do
	nstreams=$(pacmd list-sink-inputs|grep -c "state: RUNNING")

	# write log line iff number of streams changed
	if [[ "$last_status" != "$nstreams" ]]; then
		# number of seconds elapsed since Jan 1, 1970 0:00 UTC
		T="$(date +%s)"
		logfile="logs/sound_$(python2.7 rewind7am.py).txt"
		echo "$T $nstreams" >> $logfile
	fi

	last_status="$nstreams" # swap
	sleep "$waittime" # sleep
done
