#!/bin/bash
endpoint=127.0.0.1:9999/demo-app/version

sleepTime="${1:-3}"
counter=0
limit=${2:-10}
while [ $counter -lt $limit ]; do
	curl -I 2>/dev/null $endpoint | head -1 | grep 200 >/dev/null
	if [ $? != 0 ]; then
		echo "Invalid endpoint $endpoint"
		let "counter++"
		if [ "$counter" == $limit ]; then
			echo "We hit the limit for retries at $limit"
		fi
		sleep $sleepTime
	else
		echo "$(date)" $(curl -s $endpoint)
		sleep $sleepTime
		counter=0
	fi
done
