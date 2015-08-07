#xgettext --extract-all --strict --debug -L Shell -o "./po/$1.po" "bin/$1"
xgettext --debug -kMSG_TR -kgettext -L Shell -o "./po/$1.po" "bin/$1"
exit $?

for d in bin #man
do 	[ -d "$d.po" ] || mkdir "$d.po"
	for f in ./$d/*
	do	xgettext --extract-all --strict --debug -L Shell -o "$PWD/$d.po/${f##*/}.po" "$f"
	done
done
