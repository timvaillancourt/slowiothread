#!/bin/bash

# Sleep 5 seconds to let toxiproxy/mysql to start up
sleep 5

# Add network delay from replica -> primary
# on mysql port
while true; do
  http_code=$(curl -w "%{http_code}" -sv -i -H 'Content-Type: application/json' -d '{
	"name": "slowreplication",
	"type": "latency",
	"attributes": {
          "latency": 100,
          "jitter": 5
        }
  }' http://toxiproxy:8474/proxies/primary/toxics)
  if [[ "${http_code}" =~ "200 OK" ]] || [[ "${http_code}" =~ "409 Conflict" ]]; then
    echo "Setup replication latency toxic"
    break
  fi
  sleep 1
done

# Start the row inserter
echo "Starting row inserter"
row-inserter
