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
#	Usage:
#	./scripts/make-po-files.sh
#
#
#	Vars
#
	BASE="/home/sea/prjs/tui"
	DEST="$BASE/locale/Anticipate-po-files"
#
#	Functions
#
	getpo() { # ITEM
	#
	#
		xgettext --debug -kMSG_TR --from-code=CP850 -kgettext -L Shell -o "$DEST/$1.po"  "bin/$1"
		#case $1 in
		#tuirc)		;;
		#*)	xgettext --debug -kMSG_TR -kgettext -L Shell -o "$DEST/$1.po"  "bin/$1"	;;
		#esac
	}
#
#	Action
#
	cd "$BASE"
	mkdir -p "$DEST"
	
	if [ -z "$1" ]
	then	# Ask for every file
		for task in $(cd $BASE/bin;ls);do
			tui-yesno "Do \"$task\"?" && getpo "$task"
		done
	else	# Do just this one
		for a in "${@}";do
			getpo "$a"
		done
	fi


exit $?

for d in bin #man
do 	[ -d "$d.po" ] || mkdir "$d.po"
	for f in ./$d/*
	do	xgettext --extract-all --strict --debug -L Shell -o "$PWD/$d.po/${f##*/}.po" "$f"
	done
done
