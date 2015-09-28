#!/bin/bash
# Copyright (c) 2013-2015 Simon Arjuna Erat (sea)  <erat.simon@gmail.com>
# All rights reserved.
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANT ABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>
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
	