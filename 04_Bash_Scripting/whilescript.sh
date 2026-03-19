#!/bin/bash

SERVERS=("web1" "web2" "db1")

i=0
while [ $i -lt ${#SERVERS[@]} ]
do
    echo ${SERVERS[$i]}
    ((i++))
done

echo "Loop finished."
