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
	#
# Lines
	#for F in $(find|grep -ve ".git" -ve ".jpg")
	#do	[ -f "$F" ] && \
	#		COMMENTS=$(( $COMMENTS + $(grep ^"#" "$F" | wc -l) )) && \
	#		LINES=$(( $LINES + $(cat "$F" | wc -l) )) && \
	#		BLANKS=$(( $BLANKS + $(grep ^[[:space:]]$ "$F" | wc -l) ))
	#done
	FILES=0
	if true;then
		for F in $(find . -type d -name ".git" -prune -o -type f ! -name "*.jpg" \! -name "*.png" -print)
		do	#echo "$F"
			COMMENTS=$(( $COMMENTS + $(grep ^"#" "$F" | wc -l) )) && \
			LINES=$(( $LINES + $(cat "$F" | wc -l) )) && \
			BLANKS=$(( $BLANKS + $(grep ^[[:space:]]$ "$F" | wc -l) )) && \
			((FILES+=1))
		done
		echo "Spread across $FILES files, there are:"
	fi
	if false;then
		vals=( $( awk -v q="^#,.*,^[[:space:]]*$" '
		       BEGIN{cc=split(q,crit,",")}
		       { for(i in crit) t[i]+=($0 ~ crit[i]) }
		       END { for(i=1; i<=cc;i++) printf "%d ",t[i] }' \
		       $(find . -type f -name "*"|grep -ve jpg$ -ve png$ -ve svg$ -ve \.git) )
			)
		((COMMENTS=vals[0]))
		((LINES=vals[1]))
		((BLANKS=vals[2]))
		FILES=$(find|grep -ve ".git" -ve ".jpg"| wc -l)
		echo "Spread across $FILES files, there are:"
	fi
	echo -e "Lines Total: \t\t $LINES"
	echo -e "Comment lines: \t\t $COMMENTS"
	echo -e "Blank lines: \t\t $BLANKS"
	echo -e "Avrg lines p. file: \t $(( $LINES / $FILES ))"
	