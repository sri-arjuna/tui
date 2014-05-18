#!/bin/bash -x
# sample-progress by Simon Arjuna Erat (sea) (erat.simon@gmail.com) on 2014-05-18
MAX=$(ls | wc -l)
ID=sample-progress

tui-progress -ri $ID  "Going to work with $MAX entries..." "ID=$ID"

for F in * ; do
	tui-progress -i $ID -m $MAX "Working with: $F" 
	sleep 0.5
done
