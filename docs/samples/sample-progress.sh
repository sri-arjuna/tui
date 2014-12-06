#!/bin/bash
# sample-progress by Simon Arjuna Erat (sea) (erat.simon@gmail.com) on 2014-05-18


[[ "$1" = "-v" ]] && \
	beVerbose=true && shift || \
	beVerbose=false
[[ "$1" = "-n" ]] && \
	doNum=true && shift || \
	doNum=false
$doNum && \
	tui-progress -r && \
	OPT="-m $(ls | wc -l)" || \
	OPT=""

for F in * ; do
	tui-progress $OPT "Working with: $F" 
	$beVerbose && printf "\n"
	sleep 0.5
done
printf "\n"