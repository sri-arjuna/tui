#!/bin/bash
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
		xgettext --debug -kMSG_TR -kgettext -L Shell -o "$DEST/$1.po" "bin/$1"
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
