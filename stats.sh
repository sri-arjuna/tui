#!/bin/bash
#
#	Vars
#
	LINER="########################################"
	COMMENTS=0
	LINES=0
	BLANKS=0
#
#	Action
#
	echo "$LINER"
	echo -e "\tProject stats for \"$(basename $PWD)\""
# Size
	echo "$LINER"
	for DIR in * ; do [ -d "$DIR" ] && LIST+=" $DIR" ; done
	du $LIST  | awk '{print $1" kb\tin "$2;SUM=SUM+$1} END {print NR" folders with a total of "SUM" kbytes"}'
# Files
	echo "$LINER"
	FILES=$(find|grep -ve ".git" -ve ".jpg"| wc -l)
	echo "Spread across $FILES files, there are:"
# Lines
	for F in $(find|grep -ve ".git" -ve ".jpg")
	do	[ -f "$F" ] && \
			COMMENTS=$(( $COMMENTS + $(grep ^"#" "$F" | wc -l) )) && \
			LINES=$(( $LINES + $(cat "$F" | wc -l) )) && \
			BLANKS=$(( $BLANKS + $(grep ^[[:space:]]$ "$F" | wc -l) ))
	done
	echo -e "Lines Total: \t\t $LINES"
	echo -e "Comment lines: \t\t $COMMENTS"
	echo -e "Blank lines: \t\t $BLANKS"
	echo -e "Avrg lines p. file: \t $(( $LINES / $FILES ))"
	