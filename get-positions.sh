#!/bin/bash

echo -e "Primary:\n\t$(mysql -uroot -h127.0.0.1 -uroot -P3306 -e 'show master status\G' | grep Gtid_Set)" &
echo -e "Replica:\n$(mysql -uroot -h127.0.0.1 -uroot -P3307 -e 'show slave status\G' | egrep '(Seconds|Gtid_Set|Master_Host|Master_Port)')" &

wait
